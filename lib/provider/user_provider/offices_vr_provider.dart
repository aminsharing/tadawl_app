import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/real_estate_offices.dart';


class OfficesVRProvider extends ChangeNotifier{
  int _currentStageOfficeVR;
  File _imageOfficeVR;
  int _buttonClicked;
  String _CRNumber, _officeName;
  final _picker = ImagePicker();





  void setButtonClicked(int state) {
    _buttonClicked = state;
    notifyListeners();
  }

  void setOfficeName(String officeName) {
    _officeName = officeName;
    notifyListeners();
  }

  void setCRNumber(String CRNumber) {
    _CRNumber = CRNumber;
    notifyListeners();
  }

  void setCurrentStageOfficeVR(int stage) {
    _currentStageOfficeVR = stage;
    notifyListeners();
  }

  Future<void> getImageOfficesVR() async {
    final _pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (_pickedFile != null) {
      _imageOfficeVR = File(_pickedFile.path);
      notifyListeners();
    } else {}
  }

  Future<void> sendOfficesVRInfo(
      BuildContext context,
      String phone,
      String CRNumber,
      String officeName,
      String office_cordinates_lat,
      String office_cordinates_lng,
      File image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().sendOfficesVRInfo(context, phone, CRNumber, officeName,
          office_cordinates_lat, office_cordinates_lng, image);
    });

    var userMutual = Provider.of<UserMutualProvider>(context, listen: false);

    userMutual.getAvatarList(context, phone);
    userMutual.getUserAdsList(context, phone);
    userMutual.getEstimatesInfo(context, phone);
    userMutual.getSumEstimatesInfo(context, phone);
    userMutual.checkOfficeInfo(context, phone);
    userMutual.setUserPhone(phone);

    Future.delayed(Duration(seconds: 0), () {
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(2);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RealEstateOffices()),
      );
    });
  }




  int get currentStageOfficeVR => _currentStageOfficeVR;
  File get imageOfficeVR => _imageOfficeVR;
  int get buttonClicked => _buttonClicked;
  String get CRNumber => _CRNumber;
  String get officeName => _officeName;







}