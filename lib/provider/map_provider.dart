
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tadawl_app/models/RegionModel.dart';

class MapProvider extends ChangeNotifier{

  MapProvider(){
    print('init MapProvider');
    getLocPer().then((value) {
      getLoc();
    });
  }

  @override
  void dispose() {
    print('dispose MapProvider');
    super.dispose();
  }

  final Location _location = Location();
  LatLng _initialCameraPosition;
  double _zoom;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  String _ads_cityAddAds;
  String _ads_neighborhoodAddAds;
  String _ads_roadAddAds;

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
          var addresses = await Geocoder.google(
              'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
              language: 'ar')
              .findAddressesFromCoordinates(
              Coordinates(location.latitude, location.longitude));
          if (addresses.isNotEmpty) {
            _ads_cityAddAds = '${addresses.first.locality.toString()}';
            _ads_neighborhoodAddAds = '${addresses.first.subLocality.toString()}';
            _ads_roadAddAds = '${addresses.first.thoroughfare.toString()}';
          }
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
      var addresses = await Geocoder.google(
          'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
          language: 'ar')
          .findAddressesFromCoordinates(
          Coordinates(_initialCameraPosition.latitude, _initialCameraPosition.longitude));
      if (addresses.isNotEmpty) {
        _ads_cityAddAds = '${addresses.first.locality.toString()}';
        _ads_neighborhoodAddAds = '${addresses.first.subLocality.toString()}';
        _ads_roadAddAds = '${addresses.first.thoroughfare.toString()}';
      }
      Future.delayed(Duration(seconds: 1), (){
        notifyListeners();
      });
    }
    if(_permissionGranted == PermissionStatus.deniedForever){
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
      var addresses = await Geocoder.google(
          'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
          language: 'ar')
          .findAddressesFromCoordinates(
          Coordinates(_initialCameraPosition.latitude, _initialCameraPosition.longitude));
      if (addresses.isNotEmpty) {
        _ads_cityAddAds = '${addresses.first.locality.toString()}';
        _ads_neighborhoodAddAds = '${addresses.first.subLocality.toString()}';
        _ads_roadAddAds = '${addresses.first.thoroughfare.toString()}';
      }
      // notifyListeners();
    }
  }

  Location get location => _location;
  LatLng get initialCameraPosition => _initialCameraPosition;
  double get zoom => _zoom;
  String get ads_cityAddAds => _ads_cityAddAds;
  String get ads_neighborhoodAddAds => _ads_neighborhoodAddAds;
  String get ads_roadAddAds => _ads_roadAddAds;
}

