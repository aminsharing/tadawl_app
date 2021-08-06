import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier{
  bool _passwordVisible = false;


  void setPasswordVisibleState(bool state) {
    _passwordVisible = state;
    notifyListeners();
  }

  Future<void> saveSession(String phone) async {
    var p = await SharedPreferences.getInstance();
    await p.setString('token', phone.toString());
    // ignore: deprecated_member_use
    await p.commit();
  }


  bool get passwordVisible => _passwordVisible;
}