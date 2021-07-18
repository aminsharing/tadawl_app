import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class SpecialOffersProvider extends ChangeNotifier{
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

  void getAdsSpecialList(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsSpecial.clear();
      Api().getadsFunc(context).then((value) {
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