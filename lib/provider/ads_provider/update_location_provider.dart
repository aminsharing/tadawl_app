import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class UpdateLocationProvider extends ChangeNotifier{
  UpdateLocationProvider(){
    print('init UpdateLocationProvider');
    getLocPer().then((value) {
      getLoc();
    });
  }

  String _adss_city;
  String _adss_neighborhood;
  LatLng _adss_cordinates;
  String _adss_road;
  double _adss_cordinates_lat;
  double _adss_cordinates_lng;
  final Location _location = Location();
  LatLng _initialCameraPosition;
  double _zoom;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  @override
  void dispose() {
    print('dispose UpdateLocationProvider');
    super.dispose();
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
          var addresses = await Geocoder.google(
              'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
              language: 'ar')
              .findAddressesFromCoordinates(Coordinates(location.latitude, location.longitude));
          if (addresses.isNotEmpty) {
            _adss_city = '${addresses.first.locality.toString()}';
            _adss_neighborhood = '${addresses.first.subLocality.toString()}';
            _adss_road = '${addresses.first.thoroughfare.toString()}';
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
      Future.delayed(Duration(seconds: 1), (){
        notifyListeners();
      });
    }
    if(_permissionGranted == PermissionStatus.deniedForever){
      _initialCameraPosition = cities.first.position;
      _zoom = cities.first.zoom;
      // notifyListeners();
    }
  }

  void handleCameraMoveUpdateLoc(CameraPosition position) async {

    // if (_markersUpdateLoc.isEmpty) {
    //   _markersUpdateLoc.add(Marker(
    //     markerId: MarkerId(position.target.toString()),
    //     position: position.target,
    //   ));
    // }
    // else {
    //   _markersUpdateLoc.clear();
    //   _markersUpdateLoc.add(Marker(
    //     markerId: MarkerId(position.target.toString()),
    //     position: position.target,
    //   ));
    // }
    _adss_cordinates = position.target;
    _adss_cordinates_lat = position.target.latitude;
    _adss_cordinates_lng = position.target.longitude;

    var addresses = await Geocoder.google(
        'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
        language: 'ar')
        .findAddressesFromCoordinates(
        Coordinates(_adss_cordinates_lat, _adss_cordinates_lng));
    if (addresses.isNotEmpty) {
      _adss_city = '${addresses.first.locality.toString()}';
      _adss_neighborhood = '${addresses.first.subLocality.toString()}';
      _adss_road = '${addresses.first.thoroughfare.toString()}';
    }
    notifyListeners();
  }

  void updateLocation(
      BuildContext context,
      String id_description,
      String ads_city,
      String ads_neighborhood,
      String ads_road,
      String ads_cordinates_lat,
      String ads_cordinates_lng,
      List<AdsModel> ads
      ) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateLocationFunc(
        id_description,
        ads_city,
        ads_neighborhood,
        ads_road,
        ads_cordinates_lat,
        ads_cordinates_lng,
      );
    });

    // Provider.of<MutualProvider>(context, listen: false)
    //     .getAllAdsPageInfo(context, id_description);

    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            ChangeNotifierProvider<AdPageProvider>(
              create: (_) => AdPageProvider(context, id_description, null),
              child: AdPage(ads: ads, selectedScreen: SelectedScreen.menu),
            )
            ),
      );
    });
  }


  String get ads_city => _adss_city;
  String get ads_neighborhood => _adss_neighborhood;
  LatLng get ads_cordinates => _adss_cordinates;
  String get ads_road => _adss_road;
  double get ads_cordinates_lat => _adss_cordinates_lat;
  double get ads_cordinates_lng => _adss_cordinates_lng;
  Location get location => _location;
  LatLng get initialCameraPosition => _initialCameraPosition;
  double get zoom => _zoom;









}