import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';

import 'ads_provider/main_page_provider.dart';
import 'ads_provider/search_drawer_provider.dart';
import 'api/ApiFunctions.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(){
    print('init LocaleProvider');
    getSession().then((value) {
      if(value != null){
        getUnreadMsgs(value);
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
  GoogleMapController _mapControllerMainPAge;
  set mapControllerMainPAge(GoogleMapController val) => _mapControllerMainPAge = val;
  CameraPosition _currentArea;
  set currentArea(CameraPosition val) => _currentArea = val;
  int _currentPage = 0;
  int _unreadMsgs = 0;


  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void setCurrentPage(int val){
    _currentPage = val;
  }

  void update(){
    notifyListeners();
  }

  Future<void> getUnreadMsgs(String _phone) async{
    if(_phone != null) {
      await Api().getUnreadMessagesFunc(_phone).then((value) {
        _unreadMsgs = value;
      });
    }
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

  void animateToMyLocation(BuildContext context) async{
    final mainProv = Provider.of<MainPageProvider>(context, listen: false);
    final searchProv = Provider.of<SearchDrawerProvider>(context, listen: false);
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    await _mapControllerMainPAge.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17,
      ),
    ),
    ).then((value) {
      mainProv.getLocPer().then((value) {
        mainProv.getLoc(context).then((value) {
          searchProv.getAdsList(context);
        });
      });
    });
  }

  String get phone => _phone;
  CameraPosition get currentArea => _currentArea;
  int get currentPage => _currentPage;
  int get unreadMsgs => _unreadMsgs;
}
