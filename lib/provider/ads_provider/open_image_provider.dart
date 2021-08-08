import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class OpenImageProvider extends ChangeNotifier{
  OpenImageProvider(String idDescription){
    print('init OpenImageProvider');
    getImagesAdsPageInfo(idDescription);
  }

  @override
  void dispose() {
    print('dispose OpenImageProvider');
    super.dispose();
  }

  final List<AdsModel> _image = [];
  List _imageData = [];

  void getImagesAdsPageInfo(String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _image.clear();
      Api()
          .getImagesAdsPageFunc(id_description)
          .then((value) {
        _imageData = value;
        _imageData.forEach((element) {
          _image.add(AdsModel.adsImage(element));
        });
        notifyListeners();
      });
    });
  }

  List<AdsModel> get image => _image;
}