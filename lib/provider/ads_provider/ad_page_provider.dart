import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/update_img_vid_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_location_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/ads/update_details.dart';
import 'package:tadawl_app/screens/ads/update_images_video.dart';
import 'package:tadawl_app/screens/ads/update_location.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:video_player/video_player.dart';

class AdPageProvider extends ChangeNotifier{
  AdPageProvider(){
    print("AdPageProvider init");
  }

  VideoPlayerController _videoControllerAdsPage;
  Future<void> _initializeFutureVideoPlyerAdsPage;
  ChewieController _chewieControllerAdsPage;
  bool _busyAdsPage = false;
  final bool _waitAdsPage = false;
  int _currentControllerPageAdsPage = 0;
  final PageController _controllerAdsPage = PageController();
  bool _is_favAdsPage;
  final List<AdsModel> _AdsUpdateLoc = [];
  List _AdsUpdateLocData = [];
  final Set<Marker> _markersUpdateLoc = {};
  final ScrollController _scrollController = ScrollController();
  int _expendedListCount = 4;

  @override
  void dispose() {
    print("AdPageProvider dispose");
    clearFav();
    if (_videoControllerAdsPage != null) {
      stopVideoAdsPage();
    }
    _scrollController.dispose();
    clearExpendedListCount();
    super.dispose();
  }

  void setExpendedListCount(int val){
    _expendedListCount = val;
    notifyListeners();
  }

  void clearExpendedListCount(){
    _expendedListCount = 4;
  }

  void choiceAction(BuildContext context, String choice, String idDescription) {
    if (choice == 'تعديل الصور والفيديو' || choice == 'Update Images and Videos') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider<UpdateImgVedProvider>(
            create: (_) => UpdateImgVedProvider(),
            child: ChangeNotifierProvider<AdPageProvider>.value(
              value: AdPageProvider(),
              child: UpdateImgVed(idDescription),
            )
          )
      ));
    }
    else if (choice == 'تعديل الموقع' || choice == 'Update Location') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider<UpdateLocationProvider>(
            create: (_) => UpdateLocationProvider(),
            child: UpdateLocation(idDescription),
          )
          ));
    }
    else if (choice == 'تعديل التفاصيل' || choice == 'Update Details') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateDetails(idDescription)));
    }
    else if (choice == 'حذف الإعلان' || choice == 'Delete Ad') {
      onDeletePressed(context, idDescription);
    }
  }

  void stopVideoAdsPage() {
    if(_videoControllerAdsPage != null) {
      //_videoAddAds = null;
      //_video = null;
      //_videoUpdate = null;
      //_videoControllerUpdate.pause();
      //_videoControllerAddAds.pause();
      _videoControllerAdsPage.pause();
    }
    //notifyListeners();
  }

  void currentControllerPageAdsPageFunc(int index) {
    _currentControllerPageAdsPage = index;
    notifyListeners();
  }

  void updateAdsAdsPage(BuildContext context, String id_ads) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _busyAdsPage = true;
      Api().updateAdsFunc(id_ads).then((value) {
        _busyAdsPage = false;
        notifyListeners();
      });
    });
  }

  void setVideoAdsPage(String video) {
    _videoControllerAdsPage = VideoPlayerController.network(
        'https://tadawl.com.sa/API/assets/videos/$video');
    _initializeFutureVideoPlyerAdsPage = _videoControllerAdsPage.initialize();
    _chewieControllerAdsPage = ChewieController(
      videoPlayerController: _videoControllerAdsPage,
      autoPlay: true,
      looping: true,
    );
    //notifyListeners();
  }



  void getAdsPageInfo(BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsUpdateLoc.clear();
      Api().getAdsPageFunc(id_description).then((value) {
        _AdsUpdateLocData = value;
        _AdsUpdateLocData.forEach((element) {
          _AdsUpdateLoc.add(AdsModel.adsUpdateLoc(element));
        });
        setMarker(context);
        notifyListeners();
      });
    });
    // notifyListeners();
  }

  void deleteVideoAdsPage() {
    _videoControllerAdsPage = null;
    notifyListeners();
  }



  void clearFav(){
    _is_favAdsPage = null;
  }

  Future<bool> onDeletePressed(BuildContext context, String idDescription) {
    if(_videoControllerAdsPage != null) {
      _videoControllerAdsPage.pause();
    }
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'أنت على وشك حذف الإعلان',
          style: CustomTextStyle(

            fontSize: 20,
            color: const Color(0xffff0000),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'هل أنت متأكد من حذف الإعلان؟',
          style: CustomTextStyle(
            fontSize: 15,
            color: const Color(0xff000000),
          ).getTextStyle(),
          textAlign: TextAlign.right,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              deleteAdsFunc(context, idDescription);
              Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Home()),
              ModalRoute.withName('/Home')
              );
            },
            child: Text(
              'نعم',
              style: CustomTextStyle(
                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text(
              'لا',
              style: CustomTextStyle(

                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
    ) ??
        false;
  }

  void changeAdsFavState(BuildContext context, int fav, String idDescription) async {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    if(locale.phone != null){
      Future.delayed(Duration(milliseconds: 0), () {
        Api().changeAdsFavStateFunc(idDescription, locale.phone).then((value) {
          _is_favAdsPage = fav == 1;
          notifyListeners();
        });
        // Provider.of<FavouriteProvider>(context, listen: false).getUserAdsFavList(Provider.of<UserMutualProvider>(context, listen: false).phone);
        // notifyListeners();
      });
    }else{
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  // void getIsFav(BuildContext context, String idDescription) {
  //   _is_favAdsPageDB = int.tryParse(Provider.of<FavouriteProvider>(context, listen: false).getIsFav(idDescription)?? '0');
  //   // notifyListeners();
  // }

  void setMarker(BuildContext context) async {
    _markersUpdateLoc.add(Marker(
      markerId: MarkerId(_AdsUpdateLoc.first.lat),
      position: LatLng(double.parse(_AdsUpdateLoc.first.lat),
          double.parse(_AdsUpdateLoc.first.lng)),
    ));
  }



  void deleteAdsFunc(BuildContext context, String idDescription) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().deleteAdsFunc(context, idDescription);
    });
  }

  void update() {
    notifyListeners();
  }



  VideoPlayerController get videoControllerAdsPage => _videoControllerAdsPage;
  ChewieController get chewieControllerAdsPage => _chewieControllerAdsPage;
  Future<void> get initializeFutureVideoPlyerAdsPage => _initializeFutureVideoPlyerAdsPage;
  bool get busyAdsPage => _busyAdsPage;
  bool get waitAdsPage => _waitAdsPage;
  int get currentControllerPageAdsPage => _currentControllerPageAdsPage;
  PageController get controllerAdsPage => _controllerAdsPage;
  bool get is_favAdsPage => _is_favAdsPage;
  List<AdsModel> get AdsUpdateLoc => _AdsUpdateLoc;
  Set<Marker> get markersUpdateLoc => _markersUpdateLoc;
  ScrollController get scrollController => _scrollController;
  int get expendedListCount => _expendedListCount;

}