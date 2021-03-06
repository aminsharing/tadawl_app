import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:tadawl_app/models/ConvModel.dart';
import 'package:tadawl_app/models/message_model.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class MsgProvider extends ChangeNotifier {
  MsgProvider(BuildContext context, String? _phone, {this.customMsg}) {
    print('init MsgProvider');
    if (customMsg != null) {
      _messageController.text = customMsg!;
      _isTyping = true;
    }
    getConvInfo(_phone).then((value) {
      getUnreadMsgs(_phone).then((value) {
        Provider.of<LocaleProvider>(context, listen: false)
            .getUnreadMsgs(_phone)
            .then((value) {
          // Provider.of<LocaleProvider>(context, listen: false).update();
        });
        Future.delayed(Duration(seconds: 1), () {
          update();
        });
      });
    });
  }

  @override
  void dispose() {
    print('dispose MsgProvider');
    deleteDir();
    _streamChatController.close();
    _scrollChatController.dispose();
    _messageController.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  final FocusNode myFocusNode = FocusNode();
  late final String? customMsg;
  String? _recAvatarUserName = 'Username';
  final StreamController<List<ConvModel>> _streamChatController =
      StreamController<List<ConvModel>>.broadcast();
  final ScrollController _scrollChatController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  bool _atBottom = false;
  final List<ConvModel> _conv = [];
  final List<ConvModel> _comment = [];
  List<File> _imagesListUpdate = [];
  IconData? _recordIcon;
  Timer? _timer;
  int _recordDuration = 0;
  String? _randomName;
  bool _isTyping = false;
  bool _isRecording = false;
  File? _voiceMsg;
  bool _noMsgs = true;
  final Record _recorder = Record();

  Future<void> getConvInfo(String? _phone) async {
    if (_phone != null) {
      _conv.clear();
      // ignore: omit_local_variable_types
      List<dynamic> value = await Api().getDiscListFunc(_phone);
      value.forEach((element) {
        _conv.add(ConvModel.fromJson(element));
      });
      Future.delayed(Duration(seconds: 3), () async {
        if (_conv.isNotEmpty) {
          _noMsgs = false;
        } else {
          _noMsgs = true;
        }
      });
      // notifyListeners();
    }
  }

  Future<void> getUnreadMsgs(String? _phone) async {
    if (_conv.isNotEmpty) {
      _conv.forEach((element) async {
        if (_phone != element.phone_user_sender) {
          await Api()
              .getUnreadMessagesByUserFunc(_phone, element.phone_user_sender)
              .then((value) {
            element.unreadMsgs = value.toString();
          });
        }
      });
    }
  }

  Future<void> setReadMsgs(String? _phone, String? _other_phone) async {
    if (_phone != null) {
      await Api().setReadMessagesFunc(_phone, _other_phone).then((value) {
        notifyListeners();
      });
    }
  }

  Future<void> deleteDir() async {
    // ignore: omit_local_variable_types
    Directory temp = await getTemporaryDirectory();
    // ignore: omit_local_variable_types
    Directory tempPath = Directory(temp.path + '/voiceChat');
    // ignore: omit_local_variable_types
    Directory tempPath2 = Directory(temp.path + '/adsCache');
    if (tempPath.existsSync()) {
      tempPath.deleteSync(recursive: true);
    }
    if (tempPath2.existsSync()) {
      tempPath2.deleteSync(recursive: true);
    }
  }

  Future<void> getCommentUser(String? phone_user, String? _phone) async {
    if (_comment.isEmpty) {
      // ignore: omit_local_variable_types
      List<dynamic> value = await Api().getComments(_phone, phone_user);
      value.forEach((element) {
        _comment.add(ConvModel.fromJson(element));
      });
      _streamChatController.add(_comment);
    } else {
      // ignore: omit_local_variable_types
      List<dynamic> value = await Api().getComments(_phone, phone_user);
      _comment.clear();
      value.forEach((element) {
        _comment.add(ConvModel.fromJson(element));
      });
      _streamChatController.add(_comment);
    }
  }

  Future<void> sendMess(
    BuildContext context,
    List<File> imagesList,
    File? voiceMsg,
    String? content,
    String phone_user,
    String _phone,
    String msgType,
    int? msgDuration,
  ) async {
    setIsTyping(false);
    print('msgDurationn: $msgDuration');
    _messageController.clear();
    _streamChatController.add([
      ..._comment,
      ConvModel(
        id_conv: '',
        phone_user_recipient: phone_user,
        phone_user_sender: _phone,
        id_comment: '',
        seen_reciever: DateTime.now().toString(),
        seen_sender: DateTime.now().toString(),
        state_conv_receiver: '1',
        state_conv_sender: '1',
        comment: content,
        timeAdded: DateTime.now().toString(),
        username: _recAvatarUserName,
        image: '',
        phone: _phone,
        voice: voiceMsg != null ? voiceMsg.path.split('/').last : '',
        msgType: msgType,
        duration: msgDuration,
        isLocal: true,
      )
    ]);
    await Api()
        .sendMessFunc(imagesList, voiceMsg, content, _phone, phone_user,
            msgType, msgDuration)
        .then((value) {
      getCommentUser(phone_user, _phone).then((value) {
        getUnreadMsgs(_phone).then((value) {
          Provider.of<LocaleProvider>(context, listen: false)
              .getUnreadMsgs(_phone)
              .then((value) {
            Provider.of<LocaleProvider>(context, listen: false).update();
          });
        });
      });
    });
    if (msgType == MessType.TEXT) {
      myFocusNode.requestFocus();
      notifyListeners();
    }
    await _scrollChatController.animateTo(0,
        duration: Duration(seconds: 2), curve: Curves.easeIn);
  }

  void setMessageController(String message) {
    _messageController.text = message;
    notifyListeners();
  }

  void scrollDownButtun() {
    Future.delayed(const Duration(seconds: 0), () {
      _scrollChatController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
    notifyListeners();
  }

  void initScrollDown() {
    // _atBottom = true;
    _scrollChatController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollChatController.offset == 0.0 &&
        !_scrollChatController.position.outOfRange) {
      _atBottom = false;
      notifyListeners();
    } else {
      if (!_atBottom) {
        _atBottom = true;
        notifyListeners();
      }
    }
  }

  void setRecAvatarUserName(String? username) {
    _recAvatarUserName = username;
    notifyListeners();
  }

  void startRecorder() async {
    await Permission.speech.request().then((value) async {
      if (value == PermissionStatus.granted) {
        var temp = await getTemporaryDirectory();
        var newDir = Directory(temp.path + '/voiceChat');
        if (!await newDir.exists()) {
          await newDir.create(recursive: true);
        }
        _randomName = '${DateTime.now().millisecondsSinceEpoch}';
        await _recorder
            .start(
          path: newDir.path + '/$randomName.m4a',
        )
            .then((value) {
          startTimer();
          _isRecording = true;
          _recordIcon = Icons.send_rounded;
          notifyListeners();
        });
      } else {
        await Fluttertoast.showToast(
            msg: '???????? ?????????? ?????????? ?????????? ?????????????? ??????????????',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0);
      }
    });
  }

  void stopRecorder(bool delete, String? phone_user, String? _phone,
      BuildContext context) async {
    if (delete) {
      await _recorder.stop().then((value) async {
        _isRecording = false;
        _recordIcon = Icons.mic;
        deleteFile('$randomName');
        stopTimer();
        notifyListeners();
      });
    } else {
      await _recorder.stop().then((value) async {
        if (_recordDuration <= 1) {
          _isRecording = false;
          _recordIcon = Icons.mic;
          deleteFile('$randomName');
          stopTimer();
          notifyListeners();
          await Fluttertoast.showToast(
              msg: '?????? ???? ???????? ?????????????? ?????????????? ???????? ???? ??????????',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 15.0);
        } else {
          var temp = await getTemporaryDirectory();
          var newDir = Directory(temp.path + '/voiceChat');
          _voiceMsg = File(newDir.path + '/$randomName.m4a');
          _isRecording = false;
          _recordIcon = Icons.mic;
          notifyListeners();
          await sendMess(
            context,
            [],
            _voiceMsg,
            null,
            phone_user!,
            _phone!,
            MessType.VOICE,
            _recordDuration,
          ).then((value) {
            _recordDuration = -1;
            stopTimer();
            notifyListeners();
          });
        }
      });
    }
  }

  void deleteFile(String path) async {
    var temp = await getTemporaryDirectory();
    try {
      var file = File('${temp.path}/voiceChat/$path.aac');
      // File file = await File(path);
      await file.delete();
    } catch (e) {
      print('$e');
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordDuration++;
      notifyListeners();
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
      _timer = null;
      _recordDuration = 0;
    }
  }

  void setIsTyping(bool val) {
    _isTyping = val;
    notifyListeners();
  }

  Future sendImages(
      String phone_user, String _phone, BuildContext context) async {
    _imagesListUpdate = [];

    await ImagePicker().pickMultiImage().then((assets) async {
      if ((assets ?? []).isNotEmpty) {
        var temp = await getTemporaryDirectory();
        var newDir = Directory(temp.path + '/adsCache');
        if (!await newDir.exists()) {
          await newDir.create(recursive: true);
        }

        // ignore: omit_local_variable_types
        for (int i = 0; i < assets!.length; i++) {
          // ignore: omit_local_variable_types
          File? _compressedImage =
              await FlutterImageCompress.compressAndGetFile(
            assets[i].path,
            '${newDir.path}/${DateTime.now().millisecondsSinceEpoch}-$i.jpeg',
            format: CompressFormat.jpeg,
          );
          if (_compressedImage != null) {
            _imagesListUpdate.add(_compressedImage);
          }
          notifyListeners();
        }
        await sendMess(context, _imagesListUpdate, null, null, phone_user,
                _phone, MessType.IMAGE, null)
            .then((value) {
          notifyListeners();
        });
      }
    });
  }

  void update() {
    notifyListeners();
  }

  String? get recAvatarUserName => _recAvatarUserName;
  StreamController<List<ConvModel>> get streamChatController =>
      _streamChatController;
  ScrollController get scrollChatController => _scrollChatController;
  TextEditingController get messageController => _messageController;
  bool get atBottom => _atBottom;
  List<ConvModel> get conv => _conv;
  List<File> get imagesListUpdate => _imagesListUpdate;
  IconData? get recordIcon => _recordIcon;
  Timer? get timer => _timer;
  int get recordDuration => _recordDuration;
  String? get randomName => _randomName;
  bool get isTyping => _isTyping;
  bool get isRecording => _isRecording;
  File? get voiceMsg => _voiceMsg;
  bool get noMsgs => _noMsgs;
}
