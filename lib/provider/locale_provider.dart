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
    getLocPer().then((value) {
      getLoc();
    });
    getCurrentLocation();
    print('init LocaleProvider');
    getSession().then((value) {
      if(value != null){
        getAdsPer();
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

  String? _phone;
  Locale? _locale;
  Locale? get locale => _locale;
  late GoogleMapController _mapControllerMainPAge;
  set mapControllerMainPAge(GoogleMapController val) => _mapControllerMainPAge = val;
  int _currentPage = 0;
  int? _unreadMsgs = 0;
  AdsPerModel? _adsPerModel;
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  final Location _location = Location();
  CameraPosition? initialCameraPosition;
  CameraPosition? _savedPosition;

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

  Future<void> getUnreadMsgs(String? _phone) async{
    if(_phone != null) {
      await Api().getUnreadMessagesFunc(_phone).then((value) {
        _unreadMsgs = value;
      });
    }
  }

  Future<void> getAdsPer() async{
    if(_phone != null) {
      await Api().getAdsPer(_phone).then((value) {
        _adsPerModel = AdsPerModel.fromJson(value);
      });
    }
  }

  Future<String?> getSession() async {
    var p = await SharedPreferences.getInstance();
    _phone = p.getString('token');
    return _phone;
  }
  Future<String?> getImage() async {
    var p = await SharedPreferences.getInstance();
    _phone = p.getString('image');
    return _phone;
  }


  Future<void> saveCurrentLocation(LatLng position, double currentZoom) async {
    var p = await SharedPreferences.getInstance();
    await p.setDouble('current_lat', position.latitude);
    await p.setDouble('current_lng', position.longitude);
    await p.setDouble('current_zoom', currentZoom);
    // ignore: deprecated_member_use
    await p.commit();
  }

  Future<CameraPosition?> getCurrentLocation() async {
    var p = await SharedPreferences.getInstance();
    var lat = p.getDouble('current_lat');
    var lng = p.getDouble('current_lng');
    var zoom = p.getDouble('current_zoom');
    if(lat != null && lng != null && zoom != null){
      _savedPosition = CameraPosition(target: LatLng(lat, lng), zoom: zoom);
    }
    initialCameraPosition = _savedPosition;
    return _savedPosition;
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

  void animateToMyLocation(BuildContext context) async{
    final searchProv = Provider.of<SearchDrawerProvider>(context, listen: false);
    LocationData? currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    await _mapControllerMainPAge.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentLocation!.latitude!, currentLocation.longitude!),
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
          initialCameraPosition = CameraPosition(target: LatLng(location.latitude!, location.longitude!), zoom: 17);
          // notifyListeners();
        });
      }
      else {
        initialCameraPosition = _savedPosition ?? CameraPosition(target: cities.first.position, zoom: cities.first.zoom);
        // notifyListeners();
      }
    }
    else if(_permissionGranted == PermissionStatus.denied){
      initialCameraPosition = _savedPosition ?? CameraPosition(target: cities.first.position, zoom: cities.first.zoom);
      Future.delayed(Duration(seconds: 1), (){
        if(hasListeners) {
          notifyListeners();
        }
      });
    }
    if(_permissionGranted == PermissionStatus.deniedForever){
      initialCameraPosition = _savedPosition ?? CameraPosition(target: cities.first.position, zoom: cities.first.zoom);
      // notifyListeners();
    }
  }

  String? get phone => _phone;
  // CameraPosition get currentArea => _currentArea;
  int get currentPage => _currentPage;
  int? get unreadMsgs => _unreadMsgs;
  Location get location => _location;
  AdsPerModel? get adsPerModel => _adsPerModel;
  // double get zoom => _zoom;
  // CameraPosition get savedPosition => _savedPosition;
}


class AdsPerModel{
  int? adsCount;
  int? deletedAds;

  // ignore: sort_constructors_first
  AdsPerModel({this.adsCount, this.deletedAds});

  // ignore: sort_constructors_first
  AdsPerModel.fromJson(Map<String, dynamic> json){
    adsCount = int.tryParse(json['ads_count']);
    deletedAds = int.tryParse(json['deleted_ads']);
  }

  Map<String, dynamic> toJson(){
    return {
      'ads_count' : adsCount,
      'deleted_ads' : deletedAds
    };
  }

}