// import 'package:flutter/cupertino.dart';
//
// class AdPageProvider extends ChangeNotifier{
//   int _is_favAdsPage;
//   int _expendedListCount = 4;
//
//
//
//
//   void clearFav(){
//     _is_favAdsPage = null;
//   }
//
//   void stopVideoAdsPage() {
//     if(videoControllerAdsPage != null) {
//       //_videoAddAds = null;
//       //_video = null;
//       //_videoUpdate = null;
//       //_videoControllerUpdate.pause();
//       //_videoControllerAddAds.pause();
//       videoControllerAdsPage.pause();
//     }
//     //notifyListeners();
//   }
//
//   void clearExpendedListCount(){
//     _expendedListCount = 4;
//   }
//
//   void setExpendedListCount(int val){
//     _expendedListCount = val;
//     notifyListeners();
//   }
//
//   void update(){
//     notifyListeners();
//   }
//
//
//
//   int get is_favAdsPage => _is_favAdsPage;
//   int get expendedListCount => _expendedListCount;
//
//
// }