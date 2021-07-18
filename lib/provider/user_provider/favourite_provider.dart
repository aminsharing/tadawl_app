import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class FavouriteProvider extends ChangeNotifier{
  final List<AdsModel> _userAdsFav = [];
  List _UserAdsFavData = [];




  void getUserAdsFavList(BuildContext context, String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_userAdsFav.isEmpty) {
        Api().getFavAdsFunc(context, Phone).then((value) {
          _UserAdsFavData = value ?? [];
          _UserAdsFavData.forEach((element) {
            _userAdsFav.add(AdsModel(
              idDescription: element['id_description'],
              idUser: element['id_user'],
              price: element['price'],
              lat: element['lat'],
              lng: element['lng'],
              ads_city: element['ads_city'],
              ads_neighborhood: element['ads_neighborhood'],
              ads_road: element['ads_road'],
              description: element['description'],
              ads_image: element['ads_image'],
              title: element['title'],
              space: element['space'],
              idSpecial: element['id_special'],
              video: element['video'],
              timeAdded: element['timeAdded'],
              id_fav: element['id_fav'],
              isFav: element['isFav'],
              id_ads: element['id'],
              phone_faved_user: element['phone_faved_user'],
              idCategory: element['id_category'],
            ));
          });
          // TODO ADDED
          notifyListeners();
        });
      } else {
        Api().getFavAdsFunc(context, Phone).then((value) {
          _UserAdsFavData = value;
          _userAdsFav.clear();
          _UserAdsFavData.forEach((element) {
            _userAdsFav.add(AdsModel(
              idDescription: element['id_description'],
              idUser: element['id_user'],
              price: element['price'],
              lat: element['lat'],
              lng: element['lng'],
              ads_city: element['ads_city'],
              ads_neighborhood: element['ads_neighborhood'],
              ads_road: element['ads_road'],
              description: element['description'],
              ads_image: element['ads_image'],
              title: element['title'],
              space: element['space'],
              idSpecial: element['id_special'],
              video: element['video'],
              timeAdded: element['timeAdded'],
              id_fav: element['id_fav'],
              isFav: element['isFav'],
              id_ads: element['id'],
              phone_faved_user: element['phone_faved_user'],
              idCategory: element['id_category'],
            ));
          });
          // TODO ADDED
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

  String getIsFav(String idDescription){
    String isFav;
    _userAdsFav.forEach((element) {
      if(element.idDescription == idDescription){
        isFav = element.isFav;
      }
    });
    return isFav;
  }





  List<AdsModel> get userAdsFav => _userAdsFav;


}