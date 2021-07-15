import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tadawl_app/models/RegionModel.dart';

class UserMarkersProvider extends ChangeNotifier{
  final Set<Marker> _markersOfficesVR = {};
  BitmapDescriptor _mapMarker;
  double _office_cordinates_lat;
  double _office_cordinates_lng;
  LatLng _office_cordinates;
  // LocationData _currentPosition;
  final Location _location = Location();
  LatLng _initialCameraPosition;
  double _zoom;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;


  void handleCameraMoveOfficesVR(CameraPosition position) async {
    if (_markersOfficesVR.isEmpty) {
      _markersOfficesVR.add(Marker(
        markerId: MarkerId(position.target.toString()),
        position: position.target,
        icon: mapMarker,
      ));
    } else {
      _markersOfficesVR.clear();
      _markersOfficesVR.add(Marker(
        markerId: MarkerId(position.target.toString()),
        position: position.target,
        icon: mapMarker,
      ));
    }
    _office_cordinates = position.target;
    _office_cordinates_lat = position.target.latitude;
    _office_cordinates_lng = position.target.longitude;
    notifyListeners();
  }

  void getLocPer() async{
    _permissionGranted = await _location.requestPermission();
    _serviceEnabled = await _location.serviceEnabled();
  }

  Future<void> getLoc() async {

    if(_permissionGranted == PermissionStatus.granted){
      _initialCameraPosition = null;
      if (_serviceEnabled == null || !_serviceEnabled) {
        _initialCameraPosition = cities.first.position;
        _zoom = cities.first.zoom;
        notifyListeners();
      }
      else{
        await _location.getLocation().then((LocationData location) {
          _initialCameraPosition = LatLng(location.latitude, location.longitude);
          _zoom = 17;
          notifyListeners();
        });
      }
    }
    else{
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
    }
    if(_permissionGranted == PermissionStatus.deniedForever){
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
      notifyListeners();
    }
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await _location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     _initialCameraPosition = cities.first.position;
    //   }
    // }

    // _locationListener = _location.onLocationChanged.listen((LocationData currentLocation) {
    //   _currentPosition = currentLocation;
    //   _initialCameraPosition = LatLng(_currentPosition.latitude, _currentPosition.longitude);
    // });




    //await _location.enableBackgroundMode(enable: false);
  }

  // Future<void> getLoc() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   _serviceEnabled = await _location.serviceEnabled();
  //   if (!_serviceEnabled) {}
  //   _permissionGranted = await _location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await _location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       _initialCameraPosition = LatLng(24.713704574942028, 46.68523302830853);
  //     }
  //   }
  //   _currentPosition = await _location.getLocation();
  //   _initialCameraPosition =
  //       LatLng(_currentPosition.latitude, _currentPosition.longitude);
  //   _location.onLocationChanged.listen((LocationData currentLocation) {
  //     _currentPosition = currentLocation;
  //     _initialCameraPosition =
  //         LatLng(_currentPosition.latitude, _currentPosition.longitude);
  //   });
  //   notifyListeners();
  //   //await _location.enableBackgroundMode(enable: false);
  //   // Future.delayed(Duration(seconds: 20), () => notifyListeners());
  // }




  void setOfficeCordinates(LatLng val){
    _office_cordinates = val;
    notifyListeners();
  }



  Set<Marker> get markersOfficesVR => _markersOfficesVR;


  BitmapDescriptor get mapMarker => _mapMarker;
  double get office_cordinates_lat => _office_cordinates_lat;
  double get office_cordinates_lng => _office_cordinates_lng;
  LatLng get office_cordinates => _office_cordinates;
  LatLng get initialCameraPosition => _initialCameraPosition;
  double get zoom => _zoom;
}