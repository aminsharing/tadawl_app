import 'package:flutter/material.dart';

class ChangePassProvider extends ChangeNotifier{
  String _newPass, _reNewPass;
  int _current_stage;
  String _verificationCode;


  void setReNewPass(String reNewPass) {
    _reNewPass = reNewPass;
    notifyListeners();
  }

  void setNewPass(String newPass) {
    _newPass = newPass;
    notifyListeners();
  }

  void setVerCode(String verCode) {
    _verificationCode = verCode;
    notifyListeners();
  }

  void setCurrentStage(int currentStage) {
    _current_stage = currentStage;
    notifyListeners();
  }



  String get newPass => _newPass;
  String get reNewPass => _reNewPass;
  int get current_stage => _current_stage;
  String get verificationCode => _verificationCode;


}