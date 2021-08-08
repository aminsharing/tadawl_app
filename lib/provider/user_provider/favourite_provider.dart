import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class FavouriteProvider extends ChangeNotifier{

  FavouriteProvider(String _phone){
    print('init FavouriteProvider');
    getUserAdsFavList(_phone);
  }

  @override
  void dispose(){
    print('dispose FavouriteProvider');
    super.dispose();
  }


  final List<AdsModel> _userAdsFav = [];
  List _UserAdsFavData = [];

  void getUserAdsFavList(String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_userAdsFav.isEmpty) {
        Api().getFavAdsFunc(Phone).then((value) {
          _UserAdsFavData = value ?? [];
          _UserAdsFavData.forEach((element) {
            _userAdsFav.add(AdsModel.ads(element));
          });
          notifyListeners();
        });
      } else {
        Api().getFavAdsFunc(Phone).then((value) {
          _UserAdsFavData = value;
          _userAdsFav.clear();
          _UserAdsFavData.forEach((element) {
            _userAdsFav.add(AdsModel.ads(element));
          });
          // notifyListeners();
        });
      }
    });
  }

  void update(){
    notifyListeners();
  }

  int countUserAdsFav() {
    if (_userAdsFav.isNotEmpty) {
      return _userAdsFav.length;
    } else {
      return 0;
    }
  }

  // String getIsFav(String idDescription){
  //   String isFav;
  //   _userAdsFav.forEach((element) {
  //     if(element.idDescription == idDescription){
  //       isFav = element.isFav;
  //     }
  //   });
  //   return isFav;
  // }





  List<AdsModel> get userAdsFav => _userAdsFav;

}