import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:just_audio/just_audio.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound/public/flutter_sound_player.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:tadawl_app/models/ConvModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
// import 'package:audioplayers/audioplayers.dart';

class MsgProvider extends ChangeNotifier{
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _msgController = TextEditingController();

  String _recAvatarUserName = 'Username';
  final StreamController _streamChatController = StreamController.broadcast();
  final ScrollController _scrollChatController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  bool _atBottom = false;
  final List<ConvModel> _conv = [];
  List _ConvData = [];
  final List<ConvModel> _comment = [];
  List _CommentData = [];
  AudioPlayer _player;
  List<File> _imagesListUpdate = [];

  // FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  // FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  // AudioPlayer _audioPlayer = AudioPlayer();
  IconData _recordIcon;
  Timer _timer;
  int _recordLengthMin = 0;
  int _recordLengthSec = 0;
  String _randomName;
  bool _isTyping = false;
  bool _isRecording = false;
  File _voiceMsg;
  int _unreadMsgs = 0;



  void getConvInfo(BuildContext context, String _phone) async {
    if(_phone != null) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (_conv.isEmpty) {
          Api().getDiscListFunc(context, _phone).then((value) {
            _ConvData = value ?? [];
            _ConvData.forEach((element) {
              _conv.add(ConvModel.fromJson(element));
              // _conv.add(ConvModel(
              //   id_conv: element['id_conv'],
              //   phone_user_recipient: element['phone_user_recipient'],
              //   phone_user_sender: element['phone_user_sender'],
              //   id_comment: element['id_comment'],
              //   seen_reciever: element['seen_reciever'],
              //   seen_sender: element['seen_sender'],
              //   state_conv_receiver: element['state_conv_receiver'],
              //   state_conv_sender: element['state_conv_sender'],
              //   comment: element['comment'],
              //   timeAdded: element['timeAdded'],
              //   username: element['username'],
              //   image: element['image'],
              //   phone: element['phone'],
              // ));
            });
            // notifyListeners();
          });
        }
        else {
          Api().getDiscListFunc(context, _phone).then((value) {
            _ConvData = value;
            _conv.clear();
            _ConvData.forEach((element) {
              _conv.add(ConvModel.fromJson(element));
              // _conv.add(ConvModel(
              //   id_conv: element['id_conv'],
              //   phone_user_recipient: element['phone_user_recipient'],
              //   phone_user_sender: element['phone_user_sender'],
              //   id_comment: element['id_comment'],
              //   seen_reciever: element['seen_reciever'],
              //   seen_sender: element['seen_sender'],
              //   state_conv_receiver: element['state_conv_receiver'],
              //   state_conv_sender: element['state_conv_sender'],
              //   comment: element['comment'],
              //   timeAdded: element['timeAdded'],
              //   username: element['username'],
              //   image: element['image'],
              //   phone: element['phone'],
              // ));
            });
            // notifyListeners();
          });
        }
      });
    }
  }

  void getUnreadMsgs(BuildContext context, String _phone, {String other_phone}) {
    if(_phone != null) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api().getUnreadMessagesFunc(context, _phone).then((value) {
          _unreadMsgs = 0;
          if(other_phone != null){
            if(_conv.isNotEmpty){
              _conv.forEach((element) {
                if(element.phone_user_recipient == _phone && element.phone_user_sender == other_phone){
                  element.unreadMsgs = (value??0).toString();
                }
              });
            }
          }
          _unreadMsgs = value;
          // notifyListeners();
        });
      });
    }
  }

  void setReadMsgs(BuildContext context, String _phone, String _other_phone, String unreadMsgs) {
    if(_phone != null) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api().setReadMessagesFunc(context, _phone, _other_phone).then((value) {
          notifyListeners();
        });
      });
    }
  }

  Future getCommentUser(BuildContext context, String phone_user, String _phone) async {

    Future.delayed(Duration(milliseconds: 0), () {
      if (_comment.isEmpty) {
        Api().getComments(context, _phone, phone_user).then((
            value) {

          _CommentData = value;
          _CommentData.forEach((element) {
            _comment.add(ConvModel(
              id_conv: element['id_conv'],
              phone_user_recipient: element['phone_user_recipient'],
              phone_user_sender: element['phone_user_sender'],
              id_comment: element['id_comment'],
              seen_reciever: element['seen_reciever'],
              seen_sender: element['seen_sender'],
              state_conv_receiver: element['state_conv_receiver'],
              state_conv_sender: element['state_conv_sender'],
              comment: element['comment'],
              timeAdded: element['timeAdded'],
              username: element['username'],
              image: element['image'],
              phone: element['phone'],
            ));
          });

          // if(_streamChatSubscription.isPaused) {
          //   _streamChatSubscription.resume();
          //   _streamChatController.add(value);
          //  } else {
          _streamChatController.add(value);
          //  }
          // notifyListeners();
        });
      } else {
        Api().getComments(context, _phone, phone_user).then((
            value) {

          _CommentData = value;
          _comment.clear();
          _CommentData.forEach((element) {
            _comment.add(ConvModel(
              id_conv: element['id_conv'],
              phone_user_recipient: element['phone_user_recipient'],
              phone_user_sender: element['phone_user_sender'],
              id_comment: element['id_comment'],
              seen_reciever: element['seen_reciever'],
              seen_sender: element['seen_sender'],
              state_conv_receiver: element['state_conv_receiver'],
              state_conv_sender: element['state_conv_sender'],
              comment: element['comment'],
              timeAdded: element['timeAdded'],
              username: element['username'],
              image: element['image'],
              phone: element['phone'],
            ));
          });
          //  if(_streamChatSubscription.isPaused) {
          //   _streamChatSubscription.resume();
          //   _streamChatController.add(value);
          //  } else {
          _streamChatController.add(value);
          //  }
          // notifyListeners();
        });
      }
    });
  }

  Future<void> sendMess(
      BuildContext context,List<File> imagesList, File voiceMsg, String content, String phone_user, String _phone, String msgType) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().sendMessFunc(context, imagesList, voiceMsg, content, _phone, phone_user, msgType);
    });
    _messageController.clear();
    Provider.of<MsgProvider>(context, listen: false).setIsTyping(false);
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(seconds: 2), () {
      _scrollChatController.animateTo(0,
          duration: Duration(seconds: 2), curve: Curves.easeIn);
    });

    notifyListeners();
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
    // if (_scrollChatController.position.atEdge) {
    //   _scrollChatController.addListener(() {
    //     if (_scrollChatController.position.atEdge) {
    //       if (_scrollChatController.position.pixels == 0) {
    //         // You're at the top.
    //       } else {
    //         _atBottom = true;
    //       }
    //     }
    //   });
    // }
    notifyListeners();
  }

  void initScrollDown(){
    // _atBottom = true;
    _scrollChatController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollChatController.offset == 0.0 && !_scrollChatController.position.outOfRange) {
      _atBottom = false;
      notifyListeners();
    }else{
      if(!_atBottom){
        _atBottom = true;
        notifyListeners();
      }
    }
  }

  void setRecAvatarUserName(String username) {
    _recAvatarUserName = username;
    notifyListeners();
  }

  int countConvs() {
    if (_conv.isNotEmpty) {
      return _conv.length;
    } else {
      return 0;
    }
  }

  /// Record start fun
  void startRecorder() async{
    var statuses = await [
      Permission.storage,
      Permission.speech,
    ].request();

    if(await statuses[1].isGranted){
      var temp = await getTemporaryDirectory();
      var newDir = Directory(temp.path + '/voiceChat');
      if(!await newDir.exists()){
        await newDir.create(recursive: true);
      }else{
        _randomName = '${DateTime.now().millisecondsSinceEpoch}';
        await Record.start(
          path: newDir.path + '/$randomName.m4a',
        ).then((value) {
          _isRecording = true;
          _recordIcon = Icons.send_rounded;
          notifyListeners();
        });
        startTimer();
      }
    }
  }

  /// Record stop fun
  void stopRecorder(bool delete, String phone_user, String _phone, BuildContext context) async{
    if(delete){
      await Record.stop().then((value) async{
        _isRecording = false;
        _recordIcon = Icons.mic;
        deleteFile('$randomName');
        notifyListeners();
      });

      // await _mRecorder.stopRecorder().then((value) {
      //   _isRecordIcon = Icons.mic;
      //   deleteFile('$randomName');
      //   notifyListeners();
      // });
    }else{
      await Record.stop().then((value) async{
        var temp = await getTemporaryDirectory();
        var newDir = Directory(temp.path + '/voiceChat');
        _voiceMsg = await File(newDir.path + '/$randomName.m4a');
        await sendMess(
            context,
            [],
            _voiceMsg,
            null,
            phone_user,
            _phone,
            MessType.VOICE
        ).then((value) {
          notifyListeners();
        });
        _isRecording = false;
        _recordIcon = Icons.mic;
        notifyListeners();
      });
      // await _mRecorder.stopRecorder().then((value) {
      //   _isRecordIcon = Icons.mic;
      //   notifyListeners();
      // });
    }
    stopTimer();
  }

  void setUrlToPlay(String url, AudioPlayer player){
    _player = player;
    _player.setUrl('https://tadawl.com.sa/API/assets/voices/$url');
  }

  void play(AudioPlayer player) async {
    _player = player;
    if(_player.playing){
      await _player.stop();
    }
    await _player.play().then((value) {
      notifyListeners();
    });
  }

  void stop(int index, AudioPlayer player) async{
    _player = player;
    if (_player != null) {
      await _player.stop().then((value) {
        notifyListeners();
      });
    }
  }

  void deleteFile(String path) async{
    var temp = await getTemporaryDirectory();
    try{
      var file = await File('${temp.path}/voiceChat/$path.aac');
      // File file = await File(path);
      await file.delete();
    }catch(e){
      print('$e');
    }
  }

  void startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(recordLengthSec >= 59){
        _recordLengthMin++;
        _recordLengthSec = -1;
      }
      _recordLengthSec++;
      notifyListeners();
    });
  }

  void stopTimer(){
    if(timer != null){
      timer.cancel();
      _timer = null;
      _recordLengthSec = 0;
      _recordLengthMin = 0;
    }
  }

  void setIsTyping(bool val) {
    _isTyping = val;
    notifyListeners();
  }

  Future sendImages(String phone_user, String _phone, BuildContext context) async {
    _imagesListUpdate = [];

    var resultList = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
      materialOptions: MaterialOptions(
        actionBarColor: '#00cccc',
        actionBarTitle: 'تداول العقاري',
        allViewTitle: 'كل الصور',
        useDetailsView: true,
        selectCircleStrokeColor: '#00cccc',
      ),
    );
    for (var x = 0; x < resultList.length; x++) {
      var image =
      await FlutterAbsolutePath.getAbsolutePath(resultList[x].identifier);
      _imagesListUpdate.add(File(image));
    }
    await sendMess(
        context,
        _imagesListUpdate,
        null,
        null,
        phone_user,
        _phone,
        MessType.IMAGE
    ).then((value) {
      notifyListeners();
    });
  }
  void update() {
    notifyListeners();
  }

  String get recAvatarUserName => _recAvatarUserName;
  StreamController get streamChatController => _streamChatController;
  ScrollController get scrollChatController => _scrollChatController;
  TextEditingController get messageController => _messageController;
  bool get atBottom => _atBottom;
  List<ConvModel> get conv => _conv;
  List<File> get imagesListUpdate => _imagesListUpdate;

  IconData get recordIcon => _recordIcon;
  Timer get timer => _timer;
  int get recordLengthMin => _recordLengthMin;
  int get recordLengthSec => _recordLengthSec;
  String get randomName => _randomName;
  bool get isTyping => _isTyping;
  bool get isRecording => _isRecording;
  TextEditingController get msgController => _msgController;
  File get voiceMsg => _voiceMsg;
  int get unreadMsgs => _unreadMsgs;






}