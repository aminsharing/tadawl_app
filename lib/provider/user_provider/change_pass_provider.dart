import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassProvider extends ChangeNotifier{
  ChangePassProvider(){
    print('init ChangePassProvider');
  }
  String _newPass, _reNewPass;
  int _current_stage;
  String _verificationCode;

  @override
  void dispose() {
    print('dispose ChangePassProvider');
    super.dispose();
  }

  Future<void> saveSession(String phone) async {
    var p = await SharedPreferences.getInstance();
    await p.setString('token', phone.toString());
    // ignore: deprecated_member_use
    await p.commit();
  }

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