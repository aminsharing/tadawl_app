import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/ads_provider/special_offers_provider.dart';
import 'package:tadawl_app/provider/ads_provider/today_ads_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_img_vid_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_location_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/favourite_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/favourite.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/my_ads.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/screens/ads/menu.dart';
import 'package:tadawl_app/screens/ads/special_offers.dart';
import 'package:tadawl_app/screens/ads/today_ads.dart';
import 'package:tadawl_app/screens/ads/update_details.dart';
import 'package:tadawl_app/screens/ads/update_images_video.dart';
import 'package:tadawl_app/screens/ads/update_location.dart';
import 'package:video_player/video_player.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tadawl_app/models/BFModel.dart';
import 'package:tadawl_app/models/QFModel.dart';
import 'package:tadawl_app/models/UserModel.dart';
import 'package:tadawl_app/models/views_series.dart';

class AdPageProvider extends ChangeNotifier{
  AdPageProvider(BuildContext context, String? idDescription, String? idCategory){
    print('init AdPageProvider');
    getAllAdsPageInfo(context, idDescription);
    if(idCategory != null) {
      getSimilarAdsList(context, idCategory, idDescription);
    }
  }

  VideoPlayerController? _videoControllerAdsPage;
  Future<void>? _initializeFutureVideoPlyerAdsPage;
  ChewieController? _chewieControllerAdsPage;
  bool _busyAdsPage = false;
  final bool _waitAdsPage = false;
  int _currentControllerPageAdsPage = 0;
  final PageController _controllerAdsPage = PageController();
  bool? _is_favAdsPage;
  AdsModel? _AdsUpdateLoc;
  final Set<Marker> _markersUpdateLoc = {};
  final ScrollController _scrollController = ScrollController();
  int _expendedListCount = 4;


  @override
  void dispose() {
    print('dispose AdPageProvider');

    clearFav();
    if (_videoControllerAdsPage != null) {
      stopVideoAdsPage();
      _videoControllerAdsPage!.dispose();
    }
    if(_chewieControllerAdsPage != null){
      _chewieControllerAdsPage!.dispose();
    }
    _controllerAdsPage.dispose();
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

  void choiceAction(BuildContext context, String choice, String? idDescription, List<AdsModel?> ads, int index, SelectedScreen selectedScreen) {
    if (choice == 'تعديل الصور والفيديو' || choice == 'Update Images and Videos') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage!.pause();
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider<UpdateImgVedProvider>(
            create: (_) => UpdateImgVedProvider(_AdsPage!.video??''),
            child: UpdateImgVed(idDescription, ads: ads, adsPageImages: _AdsPageImages, index: index,)
          )
      ));
    }
    else if (choice == 'تعديل الموقع' || choice == 'Update Location') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage!.pause();
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider<UpdateLocationProvider>(
            create: (_) => UpdateLocationProvider(),
            child: UpdateLocation(
              idDescription,
              ads: ads,
              index: index,
              lat: _AdsPage!.lat,
              lng: _AdsPage!.lng,
              ads_city: _AdsPage!.ads_city,
              ads_neighborhood: _AdsPage!.ads_neighborhood,
            ),
          )
          ));
    }
    else if (choice == 'تعديل التفاصيل' || choice == 'Update Details') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage!.pause();
      }
      Navigator.pushReplacement(
          context,
            MaterialPageRoute(
                builder: (context) =>
                    UpdateDetails(
                      idDescription,
                      ads: ads,
                      adsBF: _AdsBF,
                      adsQF: _AdsQF,
                      adsPage: _AdsPage,
                      index: index,
                )
            )
      );
    }
    else if (choice == 'حذف الإعلان' || choice == 'Delete Ad') {
      final _locale = Provider.of<LocaleProvider>(context, listen: false);
      final _phone = _locale.phone;
      onDeletePressed(context, idDescription).then((value) async{
        Navigator.pop(context);
        if(selectedScreen == SelectedScreen.menu){
          _locale.setCurrentPage(4);
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<MenuProvider>(
                      create: (_) => MenuProvider(),
                      child: ChangeNotifierProvider<SearchDrawerProvider>(
                        create: (_) => SearchDrawerProvider(),
                        child: Menu(),
                      ),
                    ),
              )
          );
        }else if (selectedScreen == SelectedScreen.mainPage){
          _locale.setCurrentPage(0);
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MainPage(),
              )
          );
        }else if (selectedScreen == SelectedScreen.myAds){
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<MyAccountProvider>(
                      create: (_) => MyAccountProvider(_phone),
                      child: MyAds(),
                    ),
              )
          );
        }else if (selectedScreen == SelectedScreen.todayAds){
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<TodayAdsProvider>(
                      create: (_) => TodayAdsProvider(context),
                      child: TodayAds(),
                    ),
              )
          );
        }else if (selectedScreen == SelectedScreen.adSpecial){
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<SpecialOffersProvider>(
                      create: (_) => SpecialOffersProvider(context),
                      child: SpecialOffers(),
                    ),
              )
          );
        }else if (selectedScreen == SelectedScreen.favorite){
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<FavouriteProvider>(
                      create: (_) => FavouriteProvider(_phone),
                      child: Favourite(),
                    ),
              )
          );
        }
      });
    }
  }

  void stopVideoAdsPage() {
    if(_videoControllerAdsPage != null) {
      //_videoAddAds = null;
      //_video = null;
      //_videoUpdate = null;
      //_videoControllerUpdate.pause();
      //_videoControllerAddAds.pause();
      _videoControllerAdsPage!.pause();
    }
    //notifyListeners();
  }

  void currentControllerPageAdsPageFunc(int index) {
    _currentControllerPageAdsPage = index;
    notifyListeners();
  }

  Future<bool> updateAdsAdsPage(BuildContext context, String? id_ads) async {
    return await Api().updateAdsFunc(id_ads);
  }

  void setVideoAdsPage(String? video) {
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



  void getAdsPageInfo(BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().getAdsPageFunc(id_description).then((value) {
        _AdsUpdateLoc = AdsModel.adsUpdateLoc(value);
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

  Future<bool?> onDeletePressed(BuildContext context, String? idDescription) {
    if(_videoControllerAdsPage != null) {
      _videoControllerAdsPage!.pause();
    }
    return showDialog<bool>(
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
              deleteAdsFunc(context, idDescription).then((value) {
                Navigator.of(context).pop(true);
              });
              // Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);

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
    );
  }

  void changeAdsFavState(BuildContext context, int fav, String? idDescription) async {
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
      markerId: MarkerId(_AdsUpdateLoc!.lat!),
      position: LatLng(double.parse(_AdsUpdateLoc!.lat!),
          double.parse(_AdsUpdateLoc!.lng!)),
    ));
  }



  Future<void> deleteAdsFunc(BuildContext context, String? idDescription) async {
    return Api().deleteAdsFunc(context, idDescription);
  }



  void update() {
    notifyListeners();
  }


  /// Mutual Provider
  ///
  AdsModel? _AdsPage;
  final List<AdsModel> _AdsPageImages = [];
  List? _adsPageImagesData = [];
  final List<AdsModel> _AdsSimilar = [];
  List? _adsSimilarData = [];
  UserModel? _AdsUser;
  final List<AdsModel> _AdsVR = [];
  List? _adsVRData = [];
  final List<BFModel> _AdsBF = [];
  List? _adsBFData = [];
  final List<QFModel> _AdsQF = [];
  List? _adsQFData = [];
  List<AdsModel> _AdsNavigation = [];
  List? _adsNavigationData = [];
  final List<ViewsSeriesModel> _AdsViews = [];
  List? _adsViewsData = [];
  String _qrData = 'https://play.google.com/store/apps/details?id=com.tadawlapp.tadawl_app';
  double? leftMargin, topMargin;
  String? _idDescription;


  bool? _is_favAdsPageDB = false;








  void sendEstimate(BuildContext context, String? phone, String? phoneEstimated, String? rating, String? comment, String? idDescription, List<AdsModel> _userAds) async {
    await Api().sendEstimateFunc(phone, phoneEstimated, rating, comment).then((value) async{
      await Provider.of<MyAccountProvider>(context, listen: false).getEstimatesInfo(phoneEstimated).then((value) async{
        await Provider.of<MyAccountProvider>(context, listen: false).getSumEstimatesInfo(phoneEstimated).then((value) {
          notifyListeners();
        });
      });
    });
  }

  void getAdsPageList(BuildContext context, String? idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      getFavStatus(context);
      Api().getAdsPageFunc(idDescription).then((value) {
        _AdsPage = AdsModel.adsPage(value);
        _qrData = 'https://tadawl-store.com/${_AdsPage!.idAds}/ads';
        if((_AdsPage!.video??'').isNotEmpty) {
          setVideoAdsPage(_AdsPage!.video);
        }
        notifyListeners();
      });
    });
  }

  void getFavStatus(BuildContext context) async{
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    if(locale.phone != null){
      await Api().getFavStatusFunc(locale.phone, _idDescription).then((value) {
        _is_favAdsPageDB = value;
      });
    }
  }

  void getImagesAdsPageList(BuildContext context, String? idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsPageImages.clear();
      Api().getImagesAdsPageFunc(idDescription)
          .then((value) {
        _adsPageImagesData = value;
        _adsPageImagesData!.forEach((element) {
          _AdsPageImages.add(AdsModel.adsPageImages(element));
          print("getImagesAdsPageFunc Images: ${element['ads_image']}");
        });

        notifyListeners();
      });
    });
  }

  void getSimilarAdsList(BuildContext context, String idCategory, String? idAds) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsSimilar.clear();
      Api().getSimilarAdsFunc(idCategory, idAds)
          .then((value) {
        _adsSimilarData = value;
        _adsSimilarData!.forEach((element) {
          _AdsSimilar.add(AdsModel.ads(element));
        });

        // Provider.of<AdsProvider>(context, listen: false).update();
        notifyListeners();
      });
    });
  }

  void getUserAdsPageInfo(BuildContext context, String? idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().getAdsPageFunc(idDescription).then((value) {
        _AdsUser = UserModel.adsUser(value);
      });
    });
  }

  void getAdsVRInfo(BuildContext context, String? idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsVR.clear();
      Api().getAqarVRFunc(idDescription).then((value) {
        _adsVRData = value;
        _adsVRData!.forEach((element) {
          _AdsVR.add(AdsModel.adsVR(element));
        });
        notifyListeners();
      });
    });
  }

  void getBFAdsPageList(BuildContext context, String? idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsBF.clear();
      Api().getBFAdsPageFunc(idDescription)
          .then((value) {
        _adsBFData = value;
        _adsBFData!.forEach((element) {
          _AdsBF.add(BFModel.fromJson(element));
        });
        notifyListeners();
      });
    });
  }

  void getQFAdsPageList(BuildContext context, String? idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsQF.clear();
      Api()
          .getQFAdsPageFunc(idDescription)
          .then((value) {
        _adsQFData = value;
        _adsQFData!.forEach((element) {
          _AdsQF.add(QFModel.fromJson(element));
        });
        notifyListeners();
      });
    });
  }

  void getNavigationAdsPageList(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsNavigation.clear();
      Api().getNavigationFunc().then((value) {
        _adsNavigationData = value;
        _adsNavigationData!.forEach((element) {
          _AdsNavigation.add(AdsModel.adsNavigation(element));
        });

        // ignore: omit_local_variable_types
        final List<AdsModel> _specialAds = <AdsModel>[];
        _AdsNavigation.forEach((element) {
          if(element.idSpecial == '1'){
            _specialAds.add(element);
          }
        });
        _specialAds.forEach((element) {
          _AdsNavigation.remove(element);
        });
        _AdsNavigation.sort((a, b) {
          return a.timeUpdated!.compareTo(b.timeUpdated!);
        });
        _AdsNavigation = [..._specialAds, ..._AdsNavigation.reversed.toList()];
        notifyListeners();
      });
    });
  }

  void getViewsChartInfo(BuildContext context, String? idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsViews.clear();
      Api()
          .getViewsChartFunc(idDescription)
          .then((value) {
        _adsViewsData = value;
        _adsViewsData!.forEach((element) {
          _AdsViews.add(ViewsSeriesModel(
            day: element['title'],
            views: int.parse(element['views']),
            barColor: charts.ColorUtil.fromDartColor(Color(0xff00cccc)),
          ));
        });
        notifyListeners();
      });
    });
  }

  void setIdDescription(String? idDescription) {
    _idDescription = idDescription;
    // notifyListeners();
  }

  int countAdsPageImages() {
    if (_AdsPageImages.isNotEmpty) {
      return _AdsPageImages.length;
    } else {
      return 0;
    }
  }

  int countAdsSimilar() {
    if (_AdsSimilar.isNotEmpty) {
      return _AdsSimilar.length;
    } else {
      return 0;
    }
  }

  void updateViews(BuildContext context, String idDescription) async {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_AdsPage != null) {
        var _viewsAds = double.parse(_AdsPage!.views!) + 1;
        Api().updateViewsFunc(
            _AdsPage!.idAds, _viewsAds.toString());
        getAdsPageList(context, idDescription);
      }
    });
    //notifyListeners();
  }

  void getAllAdsPageInfo(BuildContext context, String? idDescription){
    getAdsPageList(context, idDescription);
    getImagesAdsPageList(context, idDescription);
    getUserAdsPageInfo(context, idDescription);
    getAdsVRInfo(context, idDescription);
    getBFAdsPageList(context, idDescription);
    getQFAdsPageList(context, idDescription);
    getViewsChartInfo(context, idDescription);
    getNavigationAdsPageList(context);
    setIdDescription(idDescription);
  }

  void getAllAdsPageSendEs(BuildContext context, String idDescription){
    getAdsPageList(context, idDescription);
    getImagesAdsPageList(context, idDescription);
    getUserAdsPageInfo(context, idDescription);
    getAdsVRInfo(context, idDescription);
    setIdDescription(idDescription);
  }

  void clearAdsUser(){
    _AdsUser = null;
  }



  String get qrData => _qrData;
  AdsModel? get adsPage => _AdsPage;
  List<AdsModel> get adsPageImages => _AdsPageImages;
  List<AdsModel> get adsSimilar => _AdsSimilar;
  UserModel? get adsUser => _AdsUser;
  List<AdsModel> get adsVR => _AdsVR;
  List<BFModel> get adsBF => _AdsBF;
  List<QFModel> get adsQF => _AdsQF;
  List<AdsModel> get adsNavigation => _AdsNavigation;
  List<ViewsSeriesModel> get adsViews => _AdsViews;
  String? get idDescription => _idDescription;


  bool? get is_favAdsPageDB => _is_favAdsPageDB;


  VideoPlayerController? get videoControllerAdsPage => _videoControllerAdsPage;
  ChewieController? get chewieControllerAdsPage => _chewieControllerAdsPage;
  Future<void>? get initializeFutureVideoPlyerAdsPage => _initializeFutureVideoPlyerAdsPage;
  bool get busyAdsPage => _busyAdsPage;
  set busyAdsPage(bool val) {
    _busyAdsPage = val;
    notifyListeners();
  }
  bool get waitAdsPage => _waitAdsPage;
  int get currentControllerPageAdsPage => _currentControllerPageAdsPage;
  PageController get controllerAdsPage => _controllerAdsPage;
  bool? get is_favAdsPage => _is_favAdsPage;
  AdsModel? get AdsUpdateLoc => _AdsUpdateLoc;
  Set<Marker> get markersUpdateLoc => _markersUpdateLoc;
  ScrollController get scrollController => _scrollController;
  int get expendedListCount => _expendedListCount;


}
enum SelectedScreen{
  menu,
  myAds,
  mainPage,
  todayAds,
  favorite,
  adSpecial,
  none
}