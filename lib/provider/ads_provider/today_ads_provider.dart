import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class TodayAdsProvider extends ChangeNotifier{

  TodayAdsProvider(){
    print('init TodayAdsProvider');
    initStateSelected();
    getTodayAdsList();
  }

  @override
  void dispose() {
    print('dispose TodayAdsProvider');
    super.dispose();
  }

  final List<bool> _isSelected5 = List.generate(4, (_) => false);
  int _filterCity;
  final List<AdsModel> _TodayAds = [];
  List _TodayAdsData = [];
  int _countAdsRiyadh = 0;
  int _countAdsMekkah = 0;
  int _countAdsDammam = 0;
  int _countAdsRest = 0;

  int countTodayAds() {
    if (_TodayAds.isNotEmpty) {
      return _TodayAds.length;
    } else {
      return 0;
    }
  }

  void updateSelected5(int index) {
    for (var buttonIndex5 = 0;
    buttonIndex5 < _isSelected5.length;
    buttonIndex5++) {
      if (buttonIndex5 == index) {
        _isSelected5[buttonIndex5] = true;
        getTodayAdsList();
        _filterCity = buttonIndex5 + 1;
      } else {
        _isSelected5[buttonIndex5] = false;
      }
    }
    notifyListeners();
  }

  void initStateSelected() {
    _isSelected5[0] = true;
  }

  void getTodayAdsList() {
    Future.delayed(Duration(milliseconds: 0), () {
      _TodayAds.clear();
      Api().getadsFunc().then((value) {
        _TodayAdsData = value;
        _TodayAdsData.forEach((element) {
          var now = DateTime.now();
          var adsDateTime = DateTime.parse(element['timeAdded']);
          var def = now.difference(adsDateTime).inDays;
          if (def <= 1) {
            _TodayAds.add(AdsModel.ads(element));
          }
        });
        for(var i = 0; i < _TodayAds.length; i++) {
          if(_TodayAds[i].ads_city == 'الرياض') {
            _countAdsRiyadh += 1;
          } else if(_TodayAds[i].ads_city == 'مكة') {
            _countAdsMekkah += 1;
          } else if(_TodayAds[i].ads_city == 'الدمام') {
            _countAdsDammam += 1;
          } else if(_TodayAds[i].ads_city != 'الدمام' && _TodayAds[i].ads_city == 'مكة' && _TodayAds[i].ads_city == 'الرياض') {
            _countAdsRest += 1;
          }
        }
        notifyListeners();
      });
    });
  }










  List<bool> get isSelected5 => _isSelected5;
  int get filterCity => _filterCity;
  List<AdsModel> get todayAds => _TodayAds;
  int get countAdsRiyadh => _countAdsRiyadh;
  int get countAdsMekkah => _countAdsMekkah;
  int get countAdsDammam => _countAdsDammam;
  int get countAdsRest => _countAdsRest;







}