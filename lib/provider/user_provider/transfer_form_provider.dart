import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/general/home.dart';

class TransferFormProvider extends ChangeNotifier{
  TransferFormProvider(){
    print('init TransferFormProvider');
  }

  @override
  void dispose() {
    print('dispose TransferFormProvider');
    super.dispose();
  }

  final List<bool> _isSelected2 = List.generate(3, (_) => false);
  int _selectedNav2;
  int _radioValue1 = -1;
  File _imageInvoice;
  bool _Accepted = false;
  String _fullName, _reason, _refrencedNumber;
  final _picker3 = ImagePicker();


  void setFullName(String fullName) {
    _fullName = fullName;
    notifyListeners();
  }

  void updateTransferChoice(int index) {
    for (var buttonIndex3 = 0;
    buttonIndex3 < _isSelected2.length;
    buttonIndex3++) {
      if (buttonIndex3 == index) {
        _isSelected2[buttonIndex3] = true;
        _selectedNav2 = buttonIndex3;
      } else {
        _isSelected2[buttonIndex3] = false;
      }
    }

    notifyListeners();
  }

  void handleRadioValueChange1(int value) {
    _radioValue1 = value;
    notifyListeners();
  }

  void setReason(String reason) {
    _reason = reason;
    notifyListeners();
  }

  void setRefrencedNumber(String refrencedNumber) {
    _refrencedNumber = refrencedNumber;
    notifyListeners();
  }

  void deleteImageInvoice() {
    _imageInvoice = null;
    notifyListeners();
  }

  Future<void> getImageInvoice() async {
    final _pickedFile3 = await _picker3.getImage(
      source: ImageSource.gallery,
    );
    if (_pickedFile3 != null) {
      _imageInvoice = File(_pickedFile3.path);
    } else {}
    notifyListeners();
  }

  void updateAccepted(bool Accepted) {
    _Accepted = Accepted;
    notifyListeners();
  }

  Future<void> sendTransfer(
      BuildContext context,
      String phone,
      String fullName,
      String reason,
      String refrencedNumber,
      String radioValue1,
      File imageInvoice) async {
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
              (route) => false
      );
    });
  }


  List<bool> get isSelected2 => _isSelected2;
  int get selectedNav2 => _selectedNav2;
  int get radioValue1 => _radioValue1;
  File get imageInvoice => _imageInvoice;
  bool get Accepted => _Accepted;
  String get fullName => _fullName;
  String get reason => _reason;
  String get refrencedNumber => _refrencedNumber;


}