import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/BFModel.dart';
import 'package:tadawl_app/models/QFModel.dart';
import 'package:tadawl_app/models/UserModel.dart';
import 'package:tadawl_app/models/views_series.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class MutualProvider extends ChangeNotifier{
  MutualProvider(){
    print('init MutualProvider');
  }

  @override
  void dispose(){
    print('dispose MutualProvider');
    super.dispose();
  }

  AdsModel _AdsPage;
  final List<AdsModel> _AdsPageImages = [];
  List _adsPageImagesData = [];
  final List<AdsModel> _AdsSimilar = [];
  List _adsSimilarData = [];
  UserModel _AdsUser;
  final List<AdsModel> _AdsVR = [];
  List _adsVRData = [];
  final List<BFModel> _AdsBF = [];
  List _adsBFData = [];
  final List<QFModel> _AdsQF = [];
  List _adsQFData = [];
  final List<AdsModel> _AdsNavigation = [];
  List _adsNavigationData = [];
  final List<ViewsSeriesModel> _AdsViews = [];
  List _adsViewsData = [];
  String _qrData = 'https://play.google.com/store/apps/details?id=com.tadawlapp.tadawl_app';
  double leftMargin, topMargin;
  String _idDescription;
  int _number;
  bool _busy = false;
  bool _is_favAdsPageDB = false;




  Future<bool> updateAds(BuildContext context, String id_ads) async {
    return Future.delayed(Duration(milliseconds: 0), () {
      return Api().updateAdsFunc(id_ads).then((value) {
        _busy = false;
        return true;
      });
    });
  }

  void setNumber(int i) {
    _number = i;
    _busy = true;
    notifyListeners();
  }

  void sendEstimate(BuildContext context, String phone, String phoneEstimated, String rating, String comment, String idDescription) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().sendEstimateFunc(phone, phoneEstimated, rating, comment);
    });
    getAllAdsPageSendEs(context, idDescription);
    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdPage()),
      );
    });
  }

  void getAdsPageList(BuildContext context, String idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      getFavStatus(context);
      Api().getAdsPageFunc(idDescription).then((value) {
        _AdsPage = AdsModel.adsPage(value);
        _qrData = 'https://tadawl-store.com/${_AdsPage.idAds}/ads';
        if((_AdsPage.video??'').isNotEmpty) {
          Provider.of<AdPageProvider>(context, listen: false).
          setVideoAdsPage(_AdsPage.video);
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

  void getImagesAdsPageList(BuildContext context, String idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsPageImages.clear();
      Api().getImagesAdsPageFunc(idDescription)
          .then((value) {
        _adsPageImagesData = value;
        _adsPageImagesData.forEach((element) {
          _AdsPageImages.add(AdsModel.adsPageImages(element));
        });
        notifyListeners();
      });
    });
  }

  void getSimilarAdsList(BuildContext context, String idCategory, String idAds) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsSimilar.clear();
      Api().getSimilarAdsFunc(idCategory, idAds)
          .then((value) {
        _adsSimilarData = value;
        _adsSimilarData.forEach((element) {
          _AdsSimilar.add(AdsModel.ads(element));
        });

        // Provider.of<AdsProvider>(context, listen: false).update();
        notifyListeners();
      });
    });
  }

  void getUserAdsPageInfo(BuildContext context, String idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().getAdsPageFunc(idDescription).then((value) {
        _AdsUser = UserModel.adsUser(value);
      });
    });
  }

  void getAdsVRInfo(BuildContext context, String idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsVR.clear();
      Api().getAqarVRFunc(idDescription).then((value) {
        _adsVRData = value;
        _adsVRData.forEach((element) {
          _AdsVR.add(AdsModel.adsVR(element));
        });
        notifyListeners();
      });
    });
  }

  void getBFAdsPageList(BuildContext context, String idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsBF.clear();
      Api().getBFAdsPageFunc(idDescription)
          .then((value) {
        _adsBFData = value;
        _adsBFData.forEach((element) {
          _AdsBF.add(BFModel.fromJson(element));
        });
        notifyListeners();
      });
    });
  }

  void getQFAdsPageList(BuildContext context, String idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsQF.clear();
      Api()
          .getQFAdsPageFunc(idDescription)
          .then((value) {
        _adsQFData = value;
        _adsQFData.forEach((element) {
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
        _adsNavigationData.forEach((element) {
          _AdsNavigation.add(AdsModel.adsNavigation(element));
        });
        notifyListeners();
      });
    });
  }

  void getViewsChartInfo(BuildContext context, String idDescription) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsViews.clear();
      Api()
          .getViewsChartFunc(idDescription)
          .then((value) {
        _adsViewsData = value;
        _adsViewsData.forEach((element) {
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

  void setIdDescription(String idDescription) {
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
        var _viewsAds = double.parse(_AdsPage.views) + 1;
        Api().updateViewsFunc(
            _AdsPage.idAds, _viewsAds.toString());
        getAdsPageList(context, idDescription);
      }
    });
    //notifyListeners();
  }

  void getAllAdsPageInfo(BuildContext context, String idDescription){
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
  AdsModel get adsPage => _AdsPage;
  List<AdsModel> get adsPageImages => _AdsPageImages;
  List<AdsModel> get adsSimilar => _AdsSimilar;
  UserModel get adsUser => _AdsUser;
  List<AdsModel> get adsVR => _AdsVR;
  List<BFModel> get adsBF => _AdsBF;
  List<QFModel> get adsQF => _AdsQF;
  List<AdsModel> get adsNavigation => _AdsNavigation;
  List<ViewsSeriesModel> get adsViews => _AdsViews;
  String get idDescription => _idDescription;
  bool get busy => _busy;
  int get number => _number;
  bool get is_favAdsPageDB => _is_favAdsPageDB;
}