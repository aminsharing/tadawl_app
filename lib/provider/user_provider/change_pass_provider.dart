import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassProvider extends ChangeNotifier{
  ChangePassProvider(){
    print("ChangePassProvider init");
    getSession().then((value) {
      print("ChangePassProvider _phone $_phone");
    });
  }
  String _newPass, _reNewPass;
  int _current_stage;
  String _verificationCode;
  String _phone;

  @override
  void dispose() {
    print("ChangePassProvider dispose");
    super.dispose();
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

  Future getSession() async {
    var p = await SharedPreferences.getInstance();
    _phone = p.getString('token');
    // notifyListeners(); // TODO this case problem because provider repeating this func too many times
  }

  String get newPass => _newPass;
  String get reNewPass => _reNewPass;
  int get current_stage => _current_stage;
  String get verificationCode => _verificationCode;
  String get phone => _phone;

}