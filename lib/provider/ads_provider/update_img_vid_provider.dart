import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';
import 'package:video_player/video_player.dart';

import 'ad_page_provider.dart';

class UpdateImgVedProvider extends ChangeNotifier{
  UpdateImgVedProvider(String video){
    if(video.isNotEmpty) {
      setVideoAdsPage(video);
    }
  }

  @override
  void dispose() {
    deleteDir();
    super.dispose();
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

  Future<void> deleteDir() async{
    // ignore: omit_local_variable_types
    Directory temp = await getTemporaryDirectory();
    // ignore: omit_local_variable_types
    Directory tempPath = Directory(temp.path + '/adsCache');
    if(tempPath.existsSync()){
      tempPath.deleteSync(recursive: true);
    }
  }

  Future getImagesUpdate(BuildContext context) async {
    _imagesListUpdate = [];

    await ImagePicker().pickMultiImage().then((assets) async{
      if((assets??[]).isNotEmpty) {
        var temp = await getTemporaryDirectory();
        var newDir = Directory(temp.path + '/adsCache');
        if(!await newDir.exists()){
          await newDir.create(recursive: true);
        }

        // ignore: omit_local_variable_types
        for (int i = 0; i < assets!.length; i++){
          // ignore: omit_local_variable_types
          File? _compressedImage = await FlutterImageCompress.compressAndGetFile(
            assets[i].path,
            '${newDir.path}/${DateTime.now().millisecondsSinceEpoch}-$i.jpeg',
            format: CompressFormat.jpeg,
          );
          if(_compressedImage != null) {
            _imagesListUpdate.add(_compressedImage);
          }
          notifyListeners();
        }
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
          AdPageHelper(ads: ads, index: index, selectedScreen: SelectedScreen.menu,)
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