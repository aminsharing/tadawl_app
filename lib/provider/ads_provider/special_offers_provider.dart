import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class SpecialOffersProvider extends ChangeNotifier{
  SpecialOffersProvider(BuildContext context){
    print('init SpecialOffersProvider');
    getAdsSpecialList(context);
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

  String getRadius(double val){
    if(val >= 21){
      return '0.5';
    }else if(val > 15 && val < 21){
      return '1';
    }else if(val <= 15 && val > 14){
      return '2';
    }else if(val <= 14 && val > 13){
      return '3';
    }else if(val <= 13 && val > 12){
      return '4';
    }else if(val <= 12 && val > 11){
      return '7';
    }else if(val <= 11 && val > 10){
      return '22';
    }else if(val <= 10 && val > 9){
      return '25';
    }else if(val <= 9 && val > 8){
      return '30';
    }else{
      return '0';
    }
  }

  void getAdsSpecialList(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsSpecial.clear();
      final locale = Provider.of<LocaleProvider>(context, listen: false);

      Api().getadsFunc(locale.currentArea.target, getRadius(locale.currentArea.zoom)).then((value) {
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