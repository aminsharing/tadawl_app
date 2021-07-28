
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tadawl_app/models/RegionModel.dart';

class MapProvider extends ChangeNotifier{


  final Location _location = Location();
  // LocationData _currentPosition;
  LatLng _initialCameraPosition;
  double _zoom;
  // String _ads_cityAddAds;
  // String _ads_neighborhoodAddAds;
  // String _ads_roadAddAds;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;


  void getLocPer() async{
    _permissionGranted = await _location.requestPermission();
    if(_permissionGranted == PermissionStatus.granted){
      await _location.requestService().then((value) async{
        _serviceEnabled = await _location.serviceEnabled();
      });
    }
  }

  Future<void> getLoc() async {
    if(_permissionGranted == PermissionStatus.granted){
      if(_serviceEnabled?? false){
        await _location.getLocation().then((LocationData location) async{
          _initialCameraPosition = LatLng(location.latitude, location.longitude);
          _zoom = 17;
          // var addresses = await Geocoder.google(
          //     'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
          //     language: 'ar').findAddressesFromCoordinates(
          //     Coordinates(location.latitude, location.longitude));
          // if (addresses.isNotEmpty) {
          //   _ads_cityAddAds = '${addresses.first.locality.toString()}';
          //   _ads_neighborhoodAddAds = '${addresses.first.subLocality.toString()}';
          //   _ads_roadAddAds = '${addresses.first.thoroughfare.toString()}';
          // }
          // notifyListeners();
        });
      }
      else {
        _initialCameraPosition = cities.first.position;
        _zoom = cities.first.zoom;
        // notifyListeners();
      }
    }
    else if(_permissionGranted == PermissionStatus.denied){
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
      Future.delayed(Duration(seconds: 1), (){
        // notifyListeners();
      });
    }
    if(_permissionGranted == PermissionStatus.deniedForever){
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
      // notifyListeners();
    }
  }



  void update(){
    notifyListeners();
  }

  Location get location => _location;
  // LocationData get currentPosition => _currentPosition;
  LatLng get initialCameraPosition => _initialCameraPosition;
  double get zoom => _zoom;


  // String get ads_cityAddAds => _ads_cityAddAds;
  // String get ads_neighborhoodAddAds => _ads_neighborhoodAddAds;
  // String get ads_roadAddAds => _ads_roadAddAds;

}

