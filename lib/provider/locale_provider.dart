import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';

import 'api/ApiFunctions.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(){
    print('init LocaleProvider');
    getSession().then((value) {
      if(value != null){
        Api().setLastSeenFunc(value);
      }
    });
  }

  @override
  void dispose() {
    print('dispose LocaleProvider');
    super.dispose();
  }

  String _phone;
  Locale _locale;
  Locale get locale => _locale;
  CameraPosition _currentArea;
  set currentArea(CameraPosition val) => _currentArea = val;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  Future<String> getSession() async {
    var p = await SharedPreferences.getInstance();
    _phone = p.getString('token');
    return _phone;
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

  String get phone => _phone;
  CameraPosition get currentArea => _currentArea;
}
