import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class SpecialOffersProvider extends ChangeNotifier{
  SpecialOffersProvider(){
    print('init SpecialOffersProvider');
    getAdsSpecialList();
  }

  @override
  void dispose() {
    print('dispose SpecialOffersProvider');
    super.dispose();
  }

  final List<AdsModel> _AdsSpecial = [];
  List _AdsSpecialData = [];
  bool _wait = false;


  int countAdsSpecial() {
    if (_AdsSpecial.isNotEmpty) {
      return _AdsSpecial.length;
    } else {
      return 0;
    }
  }

  void setWaitState(bool wait) {
    _wait = wait;
  }

  void getAdsSpecialList() {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsSpecial.clear();
      Api().getadsFunc().then((value) {
        _AdsSpecialData = value;
        _AdsSpecialData.forEach((element) {
          if (element['id_special'] == '1') {
            _AdsSpecial.add(AdsModel.ads(element));
          }
        });
        notifyListeners();
      });
    });
  }


  List<AdsModel> get adsSpecial => _AdsSpecial;
  bool get wait => _wait;



}