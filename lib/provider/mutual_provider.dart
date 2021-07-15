// import 'dart:math';
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tadawl_app/models/AdsModel.dart';
// import 'package:tadawl_app/models/BFModel.dart';
// import 'package:tadawl_app/models/QFModel.dart';
// import 'package:tadawl_app/models/UserModel.dart';
// import 'package:tadawl_app/models/views_series.dart';
// import 'package:tadawl_app/provider/ads_provider.dart';
// import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
// import 'package:tadawl_app/provider/api/ApiFunctions.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:tadawl_app/provider/user_provider.dart';
// import 'package:video_player/video_player.dart';
//
// class MutualProvider extends ChangeNotifier{
//   final List<AdsModel> _AdsPage = [];
//   List _adsPageData = [];
//   final List<AdsModel> _AdsPageImages = [];
//   List _adsPageImagesData = [];
//   final List<AdsModel> _AdsSimilar = [];
//   List _adsSimilarData = [];
//   final List<UserModel> _AdsUser = [];
//   List _adsUserData = [];
//   final List<AdsModel> _AdsVR = [];
//   List _adsVRData = [];
//   final List<BFModel> _AdsBF = [];
//   List _adsBFData = [];
//   final List<QFModel> _AdsQF = [];
//   List _adsQFData = [];
//   final List<AdsModel> _AdsNavigation = [];
//   List _adsNavigationData = [];
//   final List<ViewsSeriesModel> _AdsViews = [];
//   List _adsViewsData = [];
//   String _qrData = 'https://play.google.com/store/apps/details?id=com.tadawlapp.tadawl_app';
//   VideoPlayerController _videoControllerAdsPage;
//   Future<void> _initializeFutureVideoPlyerAdsPage;
//   ChewieController _chewieControllerAdsPage;
//   int _is_favAdsPageDB = 0;
//   double leftMargin, topMargin;
//   final Random _random = Random();
//   double _randdTop = 50;
//   double _randdLeft = 50;
//   String _idDescription;
//
//
//
//
//
//   void randomPosition(int number) {
//     var _randomLeft = _random.nextInt(number);
//     var _randomTop = _random.nextInt(number);
//     var _randLeft = _randomLeft.toDouble();
//     var _randTop = _randomTop.toDouble();
//     _randdTop = _randTop;
//     _randdLeft = _randLeft;
//     //notifyListeners();
//   }
//
//   void getAdsPageList(BuildContext context, String idDescription) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsPage.clear();
//       Api().getAdsPageFunc(context, idDescription).then((value) {
//         _adsPageData = value;
//         _adsPageData.forEach((element) {
//           _AdsPage.add(AdsModel.adsPage(element));
//         });
//         _qrData = 'https://store.tadawl.com.sa/${_AdsPage.first.idDescription}/ads';
//         if(_AdsPage.first.video.isNotEmpty) {
//           setVideoAdsPage();
//         }
//         // notifyListeners();
//       });
//     });
//   }
//
//   void getImagesAdsPageList(BuildContext context, String idDescription) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsPageImages.clear();
//       Api()
//           .getImagesAdsPageFunc(context, idDescription)
//           .then((value) {
//         _adsPageImagesData = value;
//         _adsPageImagesData.forEach((element) {
//           _AdsPageImages.add(AdsModel.adsPageImages(element));
//         });
//       });
//     });
//   }
//
//   void getSimilarAdsList(
//       BuildContext context, String idCategory, String idAds) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsSimilar.clear();
//       Api()
//           .getSimilarAdsFunc(context, idCategory, idAds)
//           .then((value) {
//         _adsSimilarData = value;
//         _adsSimilarData.forEach((element) {
//           _AdsSimilar.add(AdsModel.ads(element));
//         });
//
//         Provider.of<AdsProvider>(context, listen: false).update();
//       });
//     });
//   }
//
//
//
//   void getUserAdsPageInfo(BuildContext context, String idDescription) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsUser.clear();
//       Api().getAdsPageFunc(context, idDescription).then((value) {
//         _adsUserData = value;
//         _adsUserData.forEach((element) {
//           _AdsUser.add(UserModel.adsUser(element));
//         });
//         Provider.of<UserProvider>(context, listen: false).getEstimatesInfo(context, _AdsUser.first.phone);
//         Provider.of<UserProvider>(context, listen: false).getSumEstimatesInfo(context, _AdsUser.first.phone);
//         Provider.of<UserProvider>(context, listen: false).update();
//       });
//     });
//   }
//
//   void getAdsVRInfo(BuildContext context, String idDescription) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsVR.clear();
//       Api().getAqarVRFunc(context, idDescription).then((value) {
//         _adsVRData = value;
//         _adsVRData.forEach((element) {
//           _AdsVR.add(AdsModel.adsVR(element));
//         });
//       });
//     });
//   }
//
//   void getBFAdsPageList(BuildContext context, String idDescription) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsBF.clear();
//       Api()
//           .getBFAdsPageFunc(context, idDescription)
//           .then((value) {
//         _adsBFData = value;
//         _adsBFData.forEach((element) {
//           _AdsBF.add(BFModel.fromJson(element));
//         });
//       });
//     });
//   }
//
//   void getQFAdsPageList(BuildContext context, String idDescription) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsQF.clear();
//       Api()
//           .getQFAdsPageFunc(context, idDescription)
//           .then((value) {
//         _adsQFData = value;
//         _adsQFData.forEach((element) {
//           _AdsQF.add(QFModel.fromJson(element));
//         });
//       });
//     });
//   }
//
//   void getNavigationAdsPageList(BuildContext context) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsNavigation.clear();
//       Api().getNavigationFunc(context).then((value) {
//         _adsNavigationData = value;
//         _adsNavigationData.forEach((element) {
//           _AdsNavigation.add(AdsModel.adsNavigation(element));
//         });
//         // TODO ADDED
//         // notifyListeners();
//       });
//     });
//   }
//
//   void getViewsChartInfo(BuildContext context, String idDescription) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       _AdsViews.clear();
//       Api()
//           .getViewsChartFunc(context, idDescription)
//           .then((value) {
//         _adsViewsData = value;
//         _adsViewsData.forEach((element) {
//           _AdsViews.add(ViewsSeriesModel(
//             day: element['title'],
//             views: int.parse(element['views']),
//             barColor: charts.ColorUtil.fromDartColor(Color(0xff00cccc)),
//           ));
//         });
//       });
//     });
//   }
//
//   void setVideoAdsPage() {
//     _videoControllerAdsPage = VideoPlayerController.network(
//         'https://tadawl.com.sa/API/assets/videos/${_AdsPage.first.video}');
//     _initializeFutureVideoPlyerAdsPage = _videoControllerAdsPage.initialize();
//     _chewieControllerAdsPage = ChewieController(
//       videoPlayerController: _videoControllerAdsPage,
//       autoPlay: true,
//       looping: true,
//     );
//     //notifyListeners();
//   }
//
//   void setIdDescription(String idDescription) {
//     _idDescription = idDescription;
//     // notifyListeners();
//   }
//
//   int countAdsPageImages() {
//     if (_AdsPageImages.isNotEmpty) {
//       return _AdsPageImages.length;
//     } else {
//       return 0;
//     }
//   }
//
//   int countAdsSimilar() {
//     if (_AdsSimilar.isNotEmpty) {
//       return _AdsSimilar.length;
//     } else {
//       return 0;
//     }
//   }
//
//   void getIsFav(BuildContext context) {
//     if(_AdsPage.isNotEmpty){
//       _is_favAdsPageDB = int.tryParse(Provider.of<UserProvider>(context, listen: false).getIsFav(_AdsPage.first.idDescription)?? '0');
//       // notifyListeners();
//     }
//   }
//
//   void updateViews(BuildContext context, String idDescription) async {
//     Future.delayed(Duration(milliseconds: 0), () {
//       if (_AdsPage.isNotEmpty) {
//         var _viewsAds = double.parse(_AdsPage.first.views) + 1;
//         Api().updateViewsFunc(
//             context, _AdsPage.first.idAds, _viewsAds.toString());
//         getAdsPageList(context, idDescription);
//       }
//     });
//     //notifyListeners();
//   }
//
//
//   String get qrData => _qrData;
//   List<AdsModel> get adsPage => _AdsPage;
//   List<AdsModel> get adsPageImages => _AdsPageImages;
//   List<AdsModel> get adsSimilar => _AdsSimilar;
//   List<UserModel> get adsUser => _AdsUser;
//   List<AdsModel> get adsVR => _AdsVR;
//   List<BFModel> get adsBF => _AdsBF;
//   List<QFModel> get adsQF => _AdsQF;
//   List<AdsModel> get adsNavigation => _AdsNavigation;
//   List<ViewsSeriesModel> get adsViews => _AdsViews;
//   int get is_favAdsPageDB => _is_favAdsPageDB;
//   String get idDescription => _idDescription;
//   double get randdTop => _randdTop;
//   double get randdLeft => _randdLeft;
//
// }