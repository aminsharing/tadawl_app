import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class AqarVRProvider extends ChangeNotifier{
  AqarVRProvider(){
    print('init AqarVRProvider');
  }
  @override
  void dispose() {
    print('dispose AqarVRProvider');
    super.dispose();
  }

  File? _imageAqarVR;
  int? _buttonClickedAqarVR;
  final _picker3 = ImagePicker();
  final List<bool> _list_id_type = List.generate(3, (_) => false);
  String? _identity_number, _saq_number, _identity_type;


  Future<void> getImageAqarVR() async {
    final _pickedFile3 = await _picker3.pickImage(
      source: ImageSource.gallery,
    );
    if (_pickedFile3 != null) {
      _imageAqarVR = File(_pickedFile3.path);
    } else {}
    notifyListeners();
  }

  void setButtonClickedAqarVR(int? buttonClickedAqarVR) {
    _buttonClickedAqarVR = buttonClickedAqarVR;
    notifyListeners();
  }

  void setIdentityNumber(String? id) {
    _identity_number = id;
    notifyListeners();
  }

  void setSaqNumber(String? saqNumber) {
    _saq_number = saqNumber;
    notifyListeners();
  }

  void updateIdentityType(int index) {
    for (var buttonIndex4 = 0;
    buttonIndex4 < _list_id_type.length;
    buttonIndex4++) {
      if (buttonIndex4 == index) {
        _list_id_type[buttonIndex4] = true;
        _identity_type = (buttonIndex4 + 1).toString();
      } else {
        _list_id_type[buttonIndex4] = false;
      }
    }
    notifyListeners();
  }

  Future sendInfoAqarVR(
      BuildContext context,
      String? identity_number,
      String? saq_number,
      String? identity_type,
      String? id_description,
      File? image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().sendInfoAqarVRFunc(identity_number!, saq_number!,
          identity_type!, id_description!, image!);
    });

    Provider.of<AdPageProvider>(context, listen: false)
        .getAllAdsPageInfo(context, id_description);

    Navigator.pop(context);

    // Future.delayed(Duration(seconds: 0), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => AdPage()),
    //   );
    // });
  }


  File? get imageAqarVR => _imageAqarVR;
  int? get buttonClickedAqarVR => _buttonClickedAqarVR;
  String? get identity_number => _identity_number;
  String? get saq_number => _saq_number;
  String? get identity_type => _identity_type;
  List<bool> get list_id_type => _list_id_type;
}