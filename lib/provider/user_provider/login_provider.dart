import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  bool _passwordVisible = false;


  void setPasswordVisibleState(bool state) {
    _passwordVisible = state;
    notifyListeners();
  }


  bool get passwordVisible => _passwordVisible;
}