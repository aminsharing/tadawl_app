import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';
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
    getLocPer().then((value) {
      getLoc();
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
  // bool fromMainPage = false;
  double _zoom;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  final Location _location = Location();
  LatLng _initialCameraPosition;

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
      getLocPer().then((value) {
        getLoc().then((value) {
          searchProv.getAdsList(context);
        });
      });
    });
  }

  Future<void> getLocPer() async{
    _permissionGranted = await _location.hasPermission().then((value) async{
      if(value != PermissionStatus.granted){
        await _location.requestPermission();
      }else{
        await _location.requestService().then((value) async{
          _serviceEnabled = await _location.serviceEnabled();
        });
      }
      return value;
    });
  }

  Future<void> getLoc() async {
    if(_permissionGranted == PermissionStatus.granted){
      if(_serviceEnabled?? false){
        await _location.getLocation().then((LocationData location) async{
          _initialCameraPosition = LatLng(location.latitude, location.longitude);
          _zoom = 17;
          _currentArea = CameraPosition(target: LatLng(location.latitude, location.longitude), zoom: _zoom);
          notifyListeners();
        });
      }
      else {
        _initialCameraPosition = cities.first.position;
        _zoom = cities.first.zoom;
        notifyListeners();
      }
    }
    else if(_permissionGranted == PermissionStatus.denied){
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
      Future.delayed(Duration(seconds: 1), (){
        if(hasListeners) {
          notifyListeners();
        }
      });
    }
    if(_permissionGranted == PermissionStatus.deniedForever){
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
      // notifyListeners();
    }
  }

  String get phone => _phone;
  CameraPosition get currentArea => _currentArea;
  int get currentPage => _currentPage;
  int get unreadMsgs => _unreadMsgs;
  Location get location => _location;
  LatLng get initialCameraPosition => _initialCameraPosition;
  double get zoom => _zoom;
}
