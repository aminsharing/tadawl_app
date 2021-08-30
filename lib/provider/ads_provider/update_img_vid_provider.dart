import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:video_player/video_player.dart';

class UpdateImgVedProvider extends ChangeNotifier{
  final PageController _controllerImgVedUpdate = PageController();
  int _currentControllerPageImgVedUpdate = 0;
  List<File> _imagesListUpdate = [];
  File _videoUpdate;
  VideoPlayerController _videoControllerUpdate;
  final _pickerVideoUpdate = ImagePicker();





  void stopVideoAdsUpdate() {
    if(_videoControllerUpdate != null) {
      //_videoAddAds = null;
      //_video = null;
      //_videoUpdate = null;
      _videoControllerUpdate.pause();
      //_videoControllerAddAds.pause();
      //videoControllerAdsPage.pause();
    }
    //notifyListeners();
  }

  void currentControllerPageImgVedUpdateFunc(int index) {
    _currentControllerPageImgVedUpdate = index;
    notifyListeners();
  }

  Future getImagesUpdate() async {
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
    notifyListeners();
  }

  void removeImageAt(int index) {
    _imagesListUpdate.removeAt(index);
    if (_currentControllerPageImgVedUpdate != 0) {
      _currentControllerPageImgVedUpdate = index - 1;
    }
    notifyListeners();
  }

  void pausePlayVideoUpdate() {
    if (_videoControllerUpdate.value.isPlaying) {
      _videoControllerUpdate.pause();
    } else {
      _videoControllerUpdate.play();
    }
    notifyListeners();
  }

  void deleteVideoUpdate() {
    _videoUpdate = null;
    notifyListeners();
  }

  Future getVideoUpdate() async {
    var _pickedVideoUpdate = await _pickerVideoUpdate.getVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: 30),
    );
    _videoUpdate = File(_pickedVideoUpdate.path);
    _videoControllerUpdate = VideoPlayerController.file(_videoUpdate);
    _videoControllerUpdate.addListener(() {});
    await _videoControllerUpdate.setLooping(true);
    await _videoControllerUpdate.initialize();
    await _videoControllerUpdate.play();
    notifyListeners();
  }

  void updateImgVed(BuildContext context, String id_description, List<File> imagesList, File video, List<AdsModel> ads) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateImgVedFunc(
        id_description,
        imagesList,
        video,
      );
    });
    // Provider.of<MutualProvider>(context, listen: false)
    //     .getAllAdsPageInfo(context, id_description);

    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            ChangeNotifierProvider<AdPageProvider>(
              create: (_) => AdPageProvider(context, id_description, null),
              child: AdPage(ads: ads, selectedScreen: SelectedScreen.menu),
            )

        ),
      );
    });
    notifyListeners();
  }








  PageController get controllerImgVedUpdate => _controllerImgVedUpdate;
  int get currentControllerPageImgVedUpdate =>
      _currentControllerPageImgVedUpdate;
  List<File> get imagesListUpdate => _imagesListUpdate;
  File get videoUpdate => _videoUpdate;
  VideoPlayerController get videoControllerUpdate => _videoControllerUpdate;


}