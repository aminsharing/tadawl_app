import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/provider/map_provider.dart';

class UpdateMyInformationProvider extends ChangeNotifier{
  File _imageUpdateProfile;
  final _picker2 = ImagePicker();




  Future<void> getImageUpdateProfile() async {
    final _pickedFile2 = await _picker2.getImage(
      source: ImageSource.gallery,
      //maxHeight: 200,
      //maxWidth: 200,
      //imageQuality: 80,
    );
    if (_pickedFile2 != null) {
      _imageUpdateProfile = File(_pickedFile2.path);
    }
    //notifyListeners();
  }

  Future updateMyProfile(
      BuildContext context,
      String selectedMembership,
      String userName,
      String company_name,
      String office_name,
      String email,
      String personalProfile,
      String phone,
      File image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateMyProfileFunc(
          context,
          selectedMembership,
          userName,
          company_name,
          office_name,
          email,
          personalProfile,
          phone,
          image);
    });
    var userMutual = Provider.of<UserMutualProvider>(context, listen: false);
    userMutual.getAvatarList(context, phone);
    userMutual.getUserAdsList(context, phone);
    userMutual.getEstimatesInfo(context, phone);
    userMutual.getSumEstimatesInfo(context, phone);
    userMutual.checkOfficeInfo(context, phone);
    userMutual.setUserPhone(phone);

    clearUpdatingInformation();
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<MapProvider>(context, listen: false).getLocPer();
      Provider.of<MapProvider>(context, listen: false).getLoc();
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
      Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
      Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  void clearUpdatingInformation(){
    _imageUpdateProfile = null;
  }



  File get imageUpdateProfile => _imageUpdateProfile;

}