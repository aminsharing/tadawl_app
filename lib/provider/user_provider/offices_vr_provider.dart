import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/screens/account/real_estate_offices.dart';


class OfficesVRProvider extends ChangeNotifier{
  OfficesVRProvider(){
    print('init OfficesVRProvider');
    getLocPer().then((value) => getLoc());
  }

  @override
  void dispose(){
    print('dispose OfficesVRProvider');
    super.dispose();
  }

  int _currentStageOfficeVR = 0;
  File _imageOfficeVR;
  int _buttonClicked;
  String _CRNumber, _officeName;
  final _picker = ImagePicker();

  final Set<Marker> _markersOfficesVR = {};
  BitmapDescriptor _mapMarker;
  double _office_cordinates_lat;
  double _office_cordinates_lng;
  LatLng _office_cordinates;
  final Location _location = Location();
  LatLng _initialCameraPosition;
  double _zoom;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  void setButtonClicked(int state) {
    _buttonClicked = state;
    notifyListeners();
  }

  void setOfficeName(String officeName) {
    _officeName = officeName;
    notifyListeners();
  }

  void setCRNumber(String CRNumber) {
    _CRNumber = CRNumber;
    notifyListeners();
  }

  void setCurrentStageOfficeVR(int stage) {
    _currentStageOfficeVR = stage;
    notifyListeners();
  }

  Future<void> getImageOfficesVR() async {
    final _pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (_pickedFile != null) {
      _imageOfficeVR = File(_pickedFile.path);
      notifyListeners();
    } else {}
  }

  Future<void> sendOfficesVRInfo(
      BuildContext context,
      String phone,
      String CRNumber,
      String officeName,
      String office_cordinates_lat,
      String office_cordinates_lng,
      File image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().sendOfficesVRInfo(phone, CRNumber, officeName,
          office_cordinates_lat, office_cordinates_lng, image);
    });

    // var userMutual = Provider.of<UserMutualProvider>(context, listen: false);

    // userMutual.getAvatarList(phone);
    // userMutual.getUserAdsList(phone);
    // userMutual.getEstimatesInfo(phone);
    // userMutual.getSumEstimatesInfo(phone);
    // userMutual.checkOfficeInfo(phone);
    // userMutual.setUserPhone(phone);

    Future.delayed(Duration(seconds: 0), () {
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(2);
      _imageOfficeVR = null;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RealEstateOffices()),
              (route) => false
      );
    });
  }

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

  Future<void> getLocPer() async{
    _permissionGranted = await _location.requestPermission();
    _serviceEnabled = await _location.serviceEnabled();
  }

  Future<void> getLoc() async {
    if(_permissionGranted == PermissionStatus.granted){
      if(_serviceEnabled?? false){
        await _location.getLocation().then((LocationData location) async{
          _initialCameraPosition = LatLng(location.latitude, location.longitude);
          _zoom = 17;
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
      notifyListeners();
    }
  }

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

  int get currentStageOfficeVR => _currentStageOfficeVR;
  File get imageOfficeVR => _imageOfficeVR;
  int get buttonClicked => _buttonClicked;
  String get CRNumber => _CRNumber;
  String get officeName => _officeName;
}