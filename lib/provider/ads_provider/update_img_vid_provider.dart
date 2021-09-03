import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as picker;
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';
import 'package:video_player/video_player.dart';

class UpdateImgVedProvider extends ChangeNotifier{
  UpdateImgVedProvider(String video){
    if(video.isNotEmpty) {
      setVideoAdsPage(video);
    }
  }



  final PageController _controllerImgVedUpdate = PageController();
  int _currentControllerPageImgVedUpdate = 0;
  List<File> _imagesListUpdate = [];
  File? _videoUpdate;
  VideoPlayerController? _videoControllerUpdate;
  final _pickerVideoUpdate = ImagePicker();
  final List<String?> _DeletedImageNames = [];
  VideoPlayerController? _videoControllerAdsPage;
  ChewieController? _chewieControllerAdsPage;
  Future<void>? _initializeFutureVideoPlyerAdsPage;
  bool _isSending = false;


  set isSending(bool val){
    _isSending = val;
    notifyListeners();
  }

  void stopVideoAdsUpdate() {
    if(_videoControllerUpdate != null) {
      //_videoAddAds = null;
      //_video = null;
      //_videoUpdate = null;
      _videoControllerUpdate!.pause();
      //_videoControllerAddAds.pause();
      //videoControllerAdsPage.pause();
    }
    //notifyListeners();
  }

  void currentControllerPageImgVedUpdateFunc(int index) {
    _currentControllerPageImgVedUpdate = index;
    notifyListeners();
  }

  Future getImagesUpdate(BuildContext context) async {
    _imagesListUpdate = [];

    await picker.AssetPicker.pickAssets(
        context,
        maxAssets: 10,
        textDelegate: picker.ArabicTextDelegate()
    ).then((List<picker.AssetEntity>? assets) {
      if(assets != null) {
        assets.forEach((element) {
          element.file.then((value) {
            print(value!.path);
            _imagesListUpdate.add(value);
            notifyListeners();
          });
        });
      }
    });

    // await MultiImagePicker.pickImages(
    //   maxImages: 10,
    //   enableCamera: true,
    //   materialOptions: MaterialOptions(
    //     actionBarColor: '#00cccc',
    //     actionBarTitle: 'تداول العقاري',
    //     allViewTitle: 'كل الصور',
    //     useDetailsView: true,
    //     selectCircleStrokeColor: '#00cccc',
    //   ),
    // ).then((value) async{
    //   for (var x = 0; x < value.length; x++) {
    //     // var image =
    //     //     await FlutterAbsolutePath.getAbsolutePath(value[x].identifier);
    //     // _imagesListUpdate.add(File(image));
    //   }
    //   notifyListeners();
    // });
  }

  void removeImageAt(int index) {
    _imagesListUpdate.removeAt(index);
    if (_currentControllerPageImgVedUpdate != 0) {
      _currentControllerPageImgVedUpdate = index - 1;
    }
    notifyListeners();
  }

  void pausePlayVideoUpdate() {
    if (_videoControllerUpdate!.value.isPlaying) {
      _videoControllerUpdate!.pause();
    } else {
      _videoControllerUpdate!.play();
    }
    notifyListeners();
  }

  void deleteVideoUpdate() {
    _videoUpdate = null;
    notifyListeners();
  }

  Future getVideoUpdate() async {
    var _pickedVideoUpdate = await (_pickerVideoUpdate.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: 30),
    ) as FutureOr<PickedFile>);
    _videoUpdate = File(_pickedVideoUpdate.path);
    _videoControllerUpdate = VideoPlayerController.file(_videoUpdate!);
    _videoControllerUpdate!.addListener(() {});
    await _videoControllerUpdate!.setLooping(true);
    await _videoControllerUpdate!.initialize();
    await _videoControllerUpdate!.play();
    notifyListeners();
  }

  void addToDeleteList(String? imageName) {
    _DeletedImageNames.add(imageName);
  }

  void updateImgVed(BuildContext context, String id_description, List<File> imagesList, File? video, List<AdsModel?> ads, int index) async {
    await Api().updateImgVedFunc(
        id_description,
        imagesList,
        video,
        _DeletedImageNames
    );
    // Provider.of<MutualProvider>(context, listen: false)
    //     .getAllAdsPageInfo(context, id_description);

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>
          AdPageHelper(ads: ads, index: index,)
      ),
    );
    notifyListeners();
  }

  void update() {notifyListeners();}

  void setVideoAdsPage(String video) {
    _videoControllerAdsPage = VideoPlayerController.network(
        'https://tadawl-store.com/API/assets/videos/$video');
    _initializeFutureVideoPlyerAdsPage = _videoControllerAdsPage!.initialize();
    _chewieControllerAdsPage = ChewieController(
      videoPlayerController: _videoControllerAdsPage!,
      autoPlay: true,
      looping: true,
    );
    //notifyListeners();
  }




  PageController get controllerImgVedUpdate => _controllerImgVedUpdate;
  int get currentControllerPageImgVedUpdate =>
      _currentControllerPageImgVedUpdate;
  List<File> get imagesListUpdate => _imagesListUpdate;
  File? get videoUpdate => _videoUpdate;
  VideoPlayerController? get videoControllerUpdate => _videoControllerUpdate;
  VideoPlayerController? get videoControllerAdsPage => _videoControllerAdsPage;
  ChewieController? get chewieControllerAdsPage => _chewieControllerAdsPage;
  Future<void>? get initializeFutureVideoPlyerAdsPage => _initializeFutureVideoPlyerAdsPage;
  bool get isSending => _isSending;

}