import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class UpdateLocationProvider extends ChangeNotifier{
  String _adss_city;
  String _adss_neighborhood;
  LatLng _adss_cordinates;
  String _adss_road;
  double _adss_cordinates_lat;
  double _adss_cordinates_lng;


  void handleCameraMoveUpdateLoc(CameraPosition position) async {

    // TODO This changed remove comments
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
      ) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateLocationFunc(
        context,
        id_description,
        ads_city,
        ads_neighborhood,
        ads_road,
        ads_cordinates_lat,
        ads_cordinates_lng,
      );
    });

    Provider.of<MutualProvider>(context, listen: false)
        .getAllAdsPageInfo(context, id_description);

    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdPage()),
      );
    });
  }


  String get ads_city => _adss_city;
  String get ads_neighborhood => _adss_neighborhood;
  LatLng get ads_cordinates => _adss_cordinates;
  String get ads_road => _adss_road;
  double get ads_cordinates_lat => _adss_cordinates_lat;
  double get ads_cordinates_lng => _adss_cordinates_lng;










}