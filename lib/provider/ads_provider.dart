import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AdsProvider extends ChangeNotifier{
  // LocationData _currentPosition;
  // /// handle camera posisition and zoom
  // CameraPosition _currentCameraView;
  // File _video;
  // int _id_categorySearchDrawer;
  // String _currentLocationSearchDrawer;
  // // ignore: prefer_final_fields
  // bool _isClickedSearchDrawer = false;


  //
  // void setVideo(BuildContext context, File video) {
  //   _video = video;
  // }
  //
  // void setCurrentCameraView(CameraPosition val){
  //   _currentCameraView = val;
  // }

  void update(){
    notifyListeners();
  }



  // void setVideoAddAds(String video) {
  //   _videoControllerAddAds = VideoPlayerController.network(
  //       'https://tadawl.com.sa/API/assets/videos/$video');
  //   _initializeFutureVideoPlyerAdsPage = _videoControllerAddAds.initialize();
  //   _chewieControllerAdsPage = ChewieController(
  //     videoPlayerController: _videoControllerAddAds,
  //     autoPlay: true,
  //     looping: true,
  //   );
  //   //notifyListeners();
  // }


  // void updateInfoWindow(BuildContext context, GoogleMapController controller, LatLng location, double infoWindowWidth, double markerOffset) async {
  //   var screenCoordinate = await controller.getScreenCoordinate(location);
  //   var devicePixelRatio =
  //   Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
  //   var left = (screenCoordinate.x.toDouble() / devicePixelRatio) -
  //       (infoWindowWidth / 2);
  //   var top = (screenCoordinate.y.toDouble() / devicePixelRatio) - markerOffset;
  //   if (left < 0 || top < 0) {
  //     leftMargin = left;
  //     topMargin = top;
  //   } else {
  //     leftMargin = left;
  //     topMargin = top;
  //   }
  // }


  // File get video => _video;

  // int get id_categorySearchDrawer => _id_categorySearchDrawer;
  // String get currentLocationSearchDrawer => _currentLocationSearchDrawer;
  // bool get isClickedSearchDrawer => _isClickedSearchDrawer;
  /// handle camera posisition and zoom
  // CameraPosition get currentCameraView => _currentCameraView;
  // List<bool> get isSelectedMenu => _isSelectedMenu;
  // LocationData get currentPosition => _currentPosition;

// ScrollController get adPageHelperController => _adPageHelperController;
//int get idWait => _idWait;
}