import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePhoneProvider extends ChangeNotifier{
  String _newPhone;
  String _currentPhone;
  String _newAccountPhone;


  void setNewPhone(String val) {
    _newPhone = filterPhone(val);
    notifyListeners();
  }

  void saveSession(String phone) async {
    var p = await SharedPreferences.getInstance();
    await p.setString('token', phone.toString());
    // ignore: deprecated_member_use
    await p.commit();
  }

  String filterPhone(var Phone) {
    if (Phone.toString().length == 10 && Phone.toString().startsWith('05')) {
      Phone = Phone.toString().replaceFirst('0', '966');
      return Phone;
    } else if (Phone.toString().startsWith('5')) {
      Phone = Phone.toString().replaceFirst('5', '9665');
      return Phone;
    } else if (Phone.toString().startsWith('00')) {
      Phone = Phone.toString().replaceFirst('00', '');
      return Phone;
    } else if (Phone.toString().startsWith('+')) {
      Phone = Phone.toString().replaceFirst('+', '');
      return Phone;
    } else {
      return Phone;
    }
  }

  void setCurrentPhone(String val) {
    _currentPhone = filterPhone(val);
    notifyListeners();
  }

  void setNewAccountPhone(String val) {
    _newAccountPhone = filterPhone(val);
    notifyListeners();
  }


  String get newPhone => _newPhone;
  String get currentPhone => _currentPhone;
  String get newAccountPhone => _newAccountPhone;


}