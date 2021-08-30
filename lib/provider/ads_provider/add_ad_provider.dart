import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/CategoryModel.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAdProvider extends ChangeNotifier{

  AddAdProvider(){
    print('init AddAdProvider');
    getCategoryeInfoAddAds();
    // getLocPer().then((value) {
    //   getLoc();
    // });
  }

  @override
  void dispose() {
    print('dispose AddAdProvider');
    super.dispose();
    _priceControllerAddAds.dispose();
    _spaceControllerAddAds.dispose();
    _meterPriceControllerAddAds.dispose();
    _descControllerAddAds.dispose();
    _controllerAddAds.dispose();
  }

  VideoPlayerController _videoControllerAddAds;
  ChewieController _chewieControllerAddAds;
  File _videoAddAds;
  final _pickerAddAdsVid = ImagePicker();
  bool _AcceptedAddAds = false;
  List _CategoryDataAddAds = [];
  final List<CategoryModel> _categoryAddAds = [];
  int _id_category_finalAddAds;
  String _category_finalAddAds;
  int _currentStageAddAds;
  final Set<Marker> _markersAddAds = {};
  String _ads_cityAddAds;
  String _ads_neighborhoodAddAds;
  String _ads_roadAddAds;
  LatLng _ads_cordinatesAddAds;
  double _ads_cordinates_latAddAds;
  double _ads_cordinates_lngAddAds;
  LatLng _customCameraPositionAddAds;
  final TextEditingController _priceControllerAddAds = TextEditingController();
  final TextEditingController _spaceControllerAddAds = TextEditingController();
  final TextEditingController _meterPriceControllerAddAds = TextEditingController();
  final TextEditingController _descControllerAddAds = TextEditingController();
  int _meterPriceAddAds;
  String _interfaceSelectedAddAds = '0';
  bool _isFurnishedAddAds = false;
  bool _isKitchenAddAds = false;
  bool _isAppendixAddAds = false;
  bool _isCarEntranceAddAds = false;
  bool _isElevatorAddAds = false;
  bool _isConditionerAddAds = false;
  bool _isHallStaircaseAddAds = false;
  bool _isDuplexAddAds = false;
  bool _isDriverRoomAddAds = false;
  bool _isSwimmingPoolAddAds = false;
  bool _isMaidRoomAddAds = false;
  bool _isYardAddAds = false;
  bool _isVerseAddAds = false;
  bool _isCellarAddAds = false;
  bool _isFamilyPartitionAddAds = false;
  bool _isAmusementParkAddAds = false;
  bool _isVolleyballCourtAddAds = false;
  bool _isFootballCourtAddAds = false;
  double _LoungesAddAds = 0;
  double _ToiletsAddAds = 0;
  double _RoomsAddAds = 0;
  double _AgeOfRealEstateAddAds = 0;
  double _ApartmentsAddAds = 0;
  double _StoresAddAds = 0;
  double _WellsAddAds = 0;
  double _TreesAddAds = 0;
  double _FloorAddAds = 0;
  double _StreetWidthAddAds = 0;
  String _totalPricAddAds;
  String _totalSpaceAddAds;
  String _detailsAqarAddAds;
  final List<bool> _planAddAds = List.generate(3, (_) => false);
  int _selectedPlanAddAds = -1;
  final List<bool> _familyAddAds = List.generate(2, (_) => false);
  int _selectedFamilyAddAds = -1;
  final List<bool> _typeAqarAddAds = List.generate(3, (_) => false);
  int _selectedTypeAqarAddAds = -1;
  List<File> _imagesListAddAds = [];
  int _currentControllerPageAddAds = 0;
  final PageController _controllerAddAds = PageController();
  int _userAdsCount;
  final Location _location = Location();
  LatLng _initialCameraPosition;
  double _zoom;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  GoogleMapController _mapController;
  set mapController(GoogleMapController val) => _mapController = val;
  GoogleMapController get mapController => _mapController;
  bool _isSending = false;


  void clearChacheAddAds() {
    _currentStageAddAds = null;
    _detailsAqarAddAds = null;
    _isFootballCourtAddAds = false;
    _isVolleyballCourtAddAds= false;
    _isAmusementParkAddAds= false;
    _isFamilyPartitionAddAds= false;
    _isVerseAddAds= false;
    _isCellarAddAds= false;
    _isYardAddAds= false;
    _isMaidRoomAddAds= false;
    _isSwimmingPoolAddAds= false;
    _isDriverRoomAddAds= false;
    _isDuplexAddAds= false;
    _isHallStaircaseAddAds= false;
    _isConditionerAddAds= false;
    _isElevatorAddAds= false;
    _isCarEntranceAddAds= false;
    _isAppendixAddAds= false;
    _isKitchenAddAds= false;
    _isFurnishedAddAds= false;
    _StreetWidthAddAds = 0;
    _FloorAddAds= 0;
    _TreesAddAds= 0;
    _WellsAddAds= 0;
    _StoresAddAds= 0;
    _ApartmentsAddAds= 0;
    _AgeOfRealEstateAddAds= 0;
    _RoomsAddAds= 0;
    _ToiletsAddAds= 0;
    _LoungesAddAds= 0;
    _selectedTypeAqarAddAds= -1;
    _selectedFamilyAddAds= -1;
    _totalSpaceAddAds= null;
    _totalPricAddAds= null;
    _selectedPlanAddAds= -1;
    _id_category_finalAddAds= 0;
    _ads_cordinates_latAddAds= 0;
    _ads_cordinates_lngAddAds= 0;
    _ads_cityAddAds= null;
    _ads_neighborhoodAddAds= null;
    _ads_roadAddAds= null;
    _videoAddAds= null;
    _imagesListAddAds.clear();
    _priceControllerAddAds.dispose();
    _spaceControllerAddAds.dispose();
    _meterPriceControllerAddAds.dispose();
    _meterPriceAddAds = null;
    _descControllerAddAds.dispose();
    _controllerAddAds.dispose();
    _interfaceSelectedAddAds = '0';
    _typeAqarAddAds[0] = false;
    _typeAqarAddAds[1] = false;
    _typeAqarAddAds[2] = false;
  }

  void animateToLocation(LatLng position, double zoom) async{
    await _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: zoom,
      ),
    ),
    );
  }

  Future<int> getSession() async {
    var p = await SharedPreferences.getInstance();
    _userAdsCount = p.getInt('userAdsCount');
    return _userAdsCount;
  }

  Future<void> saveSession(int userAdsCount) async {
    var p = await SharedPreferences.getInstance();
    await p.setInt('userAdsCount', userAdsCount);
    // ignore: deprecated_member_use
    await p.commit();
  }

  void setCurrentStageAddAds(int value) {
    _currentStageAddAds = value;
    notifyListeners();
  }

  set isSending(bool val){
    _isSending = val;
    notifyListeners();
  }

  void setCurrentStageBackAddAds() {
    _currentStageAddAds -= 1;
    notifyListeners();
  }

  void setInitSelectionsAddAds() {
    if (_selectedTypeAqarAddAds != null) {
      _typeAqarAddAds[_selectedTypeAqarAddAds] = true;
    }
    if (_selectedFamilyAddAds != null) {
      _familyAddAds[_selectedFamilyAddAds] = true;
    }
    if (_selectedPlanAddAds != null) {
      _planAddAds[_selectedPlanAddAds] = true;
    }
    // notifyListeners();
  }

  void setAcceptedAddAds(bool state) {
    _AcceptedAddAds = state;
    notifyListeners();
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
      notifyListeners();
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



  void handleCameraMoveAddAds(CameraPosition position) async {
    if (_markersAddAds.isEmpty) {
      _markersAddAds.add(Marker(
        markerId: MarkerId(position.target.toString()),
        position: position.target,
      ));
    } else {
      _markersAddAds.clear();
      _markersAddAds.add(Marker(
        markerId: MarkerId(position.target.toString()),
        position: position.target,
      ));
    }
    _ads_cordinatesAddAds = position.target;
    _ads_cordinates_latAddAds = position.target.latitude;
    _ads_cordinates_lngAddAds = position.target.longitude;
    _customCameraPositionAddAds = LatLng(_ads_cordinates_latAddAds, _ads_cordinates_lngAddAds);
    var addresses = await Geocoder.google(
        'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
        language: 'ar')
        .findAddressesFromCoordinates(
        Coordinates(_ads_cordinates_latAddAds, _ads_cordinates_lngAddAds));
    if (addresses.isNotEmpty) {
      _ads_cityAddAds = '${addresses.first.locality.toString()}';
      _ads_neighborhoodAddAds = '${addresses.first.subLocality.toString()}';
      _ads_roadAddAds = '${addresses.first.thoroughfare.toString()}';
    }
    notifyListeners();
  }

  void setAdsCordinatesAddAds(LatLng val){
    _ads_cordinatesAddAds = val;
    notifyListeners();
  }

  void setInterfaceSelectedAddAds(String interfaceSelectedAddAds) {
    _interfaceSelectedAddAds = interfaceSelectedAddAds;
    notifyListeners();
  }

  void setTyprAqarAddAds(int index) {
    for (var buttonIndex33 = 0;
    buttonIndex33 < _typeAqarAddAds.length;
    buttonIndex33++) {
      if (buttonIndex33 == index) {
        _typeAqarAddAds[buttonIndex33] = true;
        _selectedTypeAqarAddAds = buttonIndex33;
      } else {
        _typeAqarAddAds[buttonIndex33] = false;
      }
    }
    notifyListeners();
  }

  void setFamilyAddAds(int index) {
    for (var buttonIndex34 = 0;
    buttonIndex34 < _familyAddAds.length;
    buttonIndex34++) {
      if (buttonIndex34 == index) {
        _familyAddAds[buttonIndex34] = true;
        _selectedFamilyAddAds = buttonIndex34;
      } else {
        _familyAddAds[buttonIndex34] = false;
      }
    }
    notifyListeners();
  }

  void setPlanAddAds(int index) {
    for (var buttonIndex35 = 0;
    buttonIndex35 < _planAddAds.length;
    buttonIndex35++) {
      if (buttonIndex35 == index) {
        _planAddAds[buttonIndex35] = true;
        _selectedPlanAddAds = buttonIndex35;
      } else {
        _planAddAds[buttonIndex35] = false;
      }
    }
    notifyListeners();
  }

  void setLoungesAddAds(double value) {
    _LoungesAddAds = value;
    notifyListeners();
  }

  void setToiletsAddAds(double value) {
    _ToiletsAddAds = value;
    notifyListeners();
  }

  void setStreetWidthAddAds(double value) {
    _StreetWidthAddAds = value;
    notifyListeners();
  }

  void setRoomsAddAds(double value) {
    _RoomsAddAds = value;
    notifyListeners();
  }

  void setApartementsAddAds(double value) {
    _ApartmentsAddAds = value;
    notifyListeners();
  }

  void setFloorAddAds(double value) {
    _FloorAddAds = value;
    notifyListeners();
  }

  void setAgeOfREAddAds(double value) {
    _AgeOfRealEstateAddAds = value;
    notifyListeners();
  }

  void setStoresAddAds(double value) {
    _StoresAddAds = value;
    notifyListeners();
  }

  void setTreesAddAds(double value) {
    _TreesAddAds = value;
    notifyListeners();
  }

  void setWellsAddAds(double value) {
    _WellsAddAds = value;
    notifyListeners();
  }

  void setIsHallStaircaseAddAds(bool value) {
    _isHallStaircaseAddAds = value;
    notifyListeners();
  }

  void setIsDriverRoomAddAds(bool value) {
    _isDriverRoomAddAds = value;
    notifyListeners();
  }

  void setIsMaidRoomAddAds(bool value) {
    _isMaidRoomAddAds = value;
    notifyListeners();
  }

  void setIsSwimmingPoolAddAds(bool val) {
    _isSwimmingPoolAddAds = val;
    notifyListeners();
  }

  void setIsFootballCourtAddAds(bool val) {
    _isFootballCourtAddAds = val;
    notifyListeners();
  }

  void setIsVolleyballCourtAddAds(bool val) {
    _isVolleyballCourtAddAds = val;
    notifyListeners();
  }

  void setIsFurnishedAddAds(bool val) {
    _isFurnishedAddAds = val;
    notifyListeners();
  }

  void setIsVerseAddAds(bool val) {
    _isVerseAddAds = val;
    notifyListeners();
  }

  void setIsYardAddAds(bool val) {
    _isYardAddAds = val;
    notifyListeners();
  }

  void setIsKitchenAddAds(bool val) {
    _isKitchenAddAds = val;
    notifyListeners();
  }

  void setIsAppendixAddAds(bool val) {
    _isAppendixAddAds = val;
    notifyListeners();
  }

  void setIsCarEntranceAddAds(bool val) {
    _isCarEntranceAddAds = val;
    notifyListeners();
  }

  void setIsCellarAddAds(bool val) {
    _isCellarAddAds = val;
    notifyListeners();
  }

  void setIsElevatorAddAds(bool val) {
    _isElevatorAddAds = val;
    notifyListeners();
  }

  void setIsDuplexAddAds(bool val) {
    _isDuplexAddAds = val;
    notifyListeners();
  }

  void setIsConditionerAddAds(bool val) {
    _isConditionerAddAds = val;
    notifyListeners();
  }

  void setIsAmusementParkAddAds(bool val) {
    _isAmusementParkAddAds = val;
    notifyListeners();
  }

  void setIsFamilyPartitionAddAds(bool val) {
    _isFamilyPartitionAddAds = val;
    notifyListeners();
  }

  void setOnChangedSpaceAddAds(String value) {
    if (_meterPriceAddAds != null) {
      _priceControllerAddAds
        ..text = (int.parse(value) * int.parse('$_meterPriceAddAds'))
            .toString();
    }
    _totalSpaceAddAds = value;
    notifyListeners();
  }

  void setOnSavedSpaceAddAds(String value) {
    _totalSpaceAddAds = value;
    _spaceControllerAddAds..text = '$value';
    notifyListeners();
  }

  void setOnChangedMeterPriceAddAds(String value) {
    if (_totalSpaceAddAds != null) {
      _priceControllerAddAds
        ..text =
        (int.parse(value) * int.parse(_totalSpaceAddAds)).toString();
    }
    _meterPriceAddAds = int.parse(value);
    notifyListeners();
  }

  void setOnSavedMeterPriceAddAds(String value) {
    _meterPriceAddAds = int.parse(value);
    _meterPriceControllerAddAds..text = '$value';
    notifyListeners();
  }

  void setOnSavedTotalPriceAddAds(String value) {
    _totalPricAddAds = value;
    _priceControllerAddAds..text = value;
    notifyListeners();
  }

  void setOnSavedDetailsAddAds(String value) {
    _detailsAqarAddAds = value;
    _descControllerAddAds..text = value;
    notifyListeners();
  }

  Future getImagesAddAds(BuildContext context) async {
    _imagesListAddAds = [];

    await MultiImagePicker.pickImages(
      maxImages: 30,
      enableCamera: true,
      materialOptions: MaterialOptions(
        actionBarColor: '#00cccc',
        actionBarTitle: 'تداول العقاري',
        allViewTitle: 'كل الصور',
        useDetailsView: true,
        selectCircleStrokeColor: '#00cccc',
      ),
    ).then((value) async{
      for (var x = 0; x < value.length; x++) {
        var image = await FlutterAbsolutePath.getAbsolutePath(value[x].identifier);
        _imagesListAddAds.add(File(image));
      }
      notifyListeners();
    });

    // await Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => AddAds()),
    // );
  }

  void setCurrentControllerPageAddAds(int value) {
    _currentControllerPageAddAds = value;
    notifyListeners();
  }

  void removeImageAddAds() {
    _imagesListAddAds.removeAt(_currentControllerPageAddAds);
    if (_currentControllerPageAddAds != 0) {
      _currentControllerPageAddAds -= 1;
    }
    notifyListeners();
  }

  void getCategoryeInfoAddAds() async {
    _categoryAddAds.clear();
    await Api().getCategoryFunc().then((value) {
      _CategoryDataAddAds = value;
      _CategoryDataAddAds.forEach((element) {
        _categoryAddAds.add(CategoryModel.fromJson(element));
      });
      notifyListeners();
    });
  }

  void updateCategoryDetailsAddAds(int id, String category) {
    _id_category_finalAddAds = id;
    _category_finalAddAds = category;
    notifyListeners();
  }

  void removeVideoAddAds() {
    _videoAddAds = null;
    notifyListeners();
  }

  void stopVideoAddAds() {
    if(_videoControllerAddAds != null) {
      //_videoAddAds = null;
      // _video = null;
      //_videoUpdate = null;
      //_videoControllerUpdate.pause();
      _videoControllerAddAds.pause();
      //videoControllerAdsPage.pause();
    }
    //notifyListeners();
  }

  Future getCameraVideo(BuildContext context) async {
    var pickedVideo55 = await _pickerAddAdsVid.getVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: 60),

    );
    _videoAddAds = File(pickedVideo55.path);
    _videoControllerAddAds = VideoPlayerController.file(_videoAddAds);
    await _videoControllerAddAds.initialize().then((value) {notifyListeners();});
    _chewieControllerAddAds = ChewieController(
      videoPlayerController: _videoControllerAddAds,
      autoPlay: true,
      looping: true,
    );
  }

  Future getGalleryVideo(BuildContext context) async {
    var _result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi'],
      allowCompression: true,
    );
    var _file = _result.files.first;
    var _pickedVideo = File(_file.path);

    var sizeInBytes = _pickedVideo.lengthSync();
    var sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 30) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            AppLocalizations.of(context).bigFile,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xff00cccc),
            ).getTextStyle(),
            textAlign: TextAlign.right,
          ),
          content: Text(
            AppLocalizations.of(context).bigFileHint,
            style: CustomTextStyle(

              fontSize: 17,
              color: const Color(0xff000000),
            ).getTextStyle(),
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  AppLocalizations.of(context).accept,
                  style: CustomTextStyle(

                    fontSize: 17,
                    color: const Color(0xff00cccc),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }
    else {
      _videoAddAds = null;
      _videoAddAds = File(_pickedVideo.path);
      _videoControllerAddAds = VideoPlayerController.file(_videoAddAds);
      await _videoControllerAddAds.initialize().then((value) {notifyListeners();});
      _chewieControllerAddAds = ChewieController(
        videoPlayerController: _videoControllerAddAds,
        autoPlay: true,
        looping: true,
      );
    }
  }

  Future<void> addNewAd(
      BuildContext context,
      String detailsAqar,
      String isFootballCourt,
      String isVolleyballCourt,
      String isAmusementPark,
      String isFamilyPartition,
      String isVerse,
      String isCellar,
      String isYard,
      String isMaidRoom,
      String isSwimmingPool,
      String isDriverRoom,
      String isDuplex,
      String isHallStaircase,
      String isConditioner,
      String isElevator,
      String isCarEntrance,
      String isAppendix,
      String isKitchen,
      String isFurnished,
      String StreetWidth,
      String Floor,
      String Trees,
      String Wells,
      String Stores,
      String Apartments,
      String AgeOfRealEstate,
      String Rooms,
      String Toilets,
      String Lounges,
      String selectedTypeAqar,
      String selectedFamily,
      String interfaceSelected,
      String totalSpace,
      String totalPrice,
      String selectedPlan,
      String id_category,
      String ads_cordinates_lat,
      String ads_cordinates_lng,
      String selectedAdderRelation,
      String selectedMarketerRelation,
      String phone,
      String ads_city,
      String ads_neighborhood,
      String ads_road,
      File video,
      List<File> imagesList,
      ) async {
    await Api().addNewAdsFunc(
      detailsAqar,
      isFootballCourt,
      isVolleyballCourt,
      isAmusementPark,
      isFamilyPartition,
      isVerse,
      isCellar,
      isYard,
      isMaidRoom,
      isSwimmingPool,
      isDriverRoom,
      isDuplex,
      isHallStaircase,
      isConditioner,
      isElevator,
      isCarEntrance,
      isAppendix,
      isKitchen,
      isFurnished,
      StreetWidth,
      Floor,
      Trees,
      Wells,
      Stores,
      Apartments,
      AgeOfRealEstate,
      Rooms,
      Toilets,
      Lounges,
      selectedTypeAqar,
      selectedFamily,
      (int.parse(interfaceSelected)+1).toString(),
      totalSpace,
      totalPrice,
      selectedPlan,
      id_category,
      ads_cordinates_lat,
      ads_cordinates_lng,
      selectedAdderRelation,
      selectedMarketerRelation,
      phone,
      ads_city,
      ads_neighborhood,
      ads_road,
      video,
      imagesList,
    ).then((value) async{
      isSending = true;
      Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
      Future.delayed(Duration(seconds: 1), () async{
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
                (route) => false
        );
      });
    });
  }




  int get currentStageAddAds => _currentStageAddAds;
  bool get AcceptedAddAds => _AcceptedAddAds;
  Set<Marker> get markersAddAds => _markersAddAds;
  String get ads_cityAddAds => _ads_cityAddAds;
  String get ads_neighborhoodAddAds => _ads_neighborhoodAddAds;
  String get ads_roadAddAds => _ads_roadAddAds;
  LatLng get ads_cordinatesAddAds => _ads_cordinatesAddAds;
  double get ads_cordinates_latAddAds => _ads_cordinates_latAddAds;
  double get ads_cordinates_lngAddAds => _ads_cordinates_lngAddAds;
  LatLng get customCameraPositionAddAds => _customCameraPositionAddAds;
  TextEditingController get priceControllerAddAds => _priceControllerAddAds;
  TextEditingController get spaceControllerAddAds => _spaceControllerAddAds;
  TextEditingController get meterPriceControllerAddAds =>
      _meterPriceControllerAddAds;
  TextEditingController get descControllerAddAds => _descControllerAddAds;
  int get meterPriceAddAds => _meterPriceAddAds;
  String get interfaceSelectedAddAds => _interfaceSelectedAddAds;
  bool get isFurnishedAddAds => _isFurnishedAddAds;
  bool get isKitchenAddAds => _isKitchenAddAds;
  bool get isAppendixAddAds => _isAppendixAddAds;
  bool get isCarEntranceAddAds => _isCarEntranceAddAds;
  bool get isElevatorAddAds => _isElevatorAddAds;
  bool get isConditionerAddAds => _isConditionerAddAds;
  bool get isHallStaircaseAddAds => _isHallStaircaseAddAds;
  bool get isDuplexAddAds => _isDuplexAddAds;
  bool get isDriverRoomAddAds => _isDriverRoomAddAds;
  bool get isSwimmingPoolAddAds => _isSwimmingPoolAddAds;
  bool get isMaidRoomAddAds => _isMaidRoomAddAds;
  bool get isYardAddAds => _isYardAddAds;
  bool get isVerseAddAds => _isVerseAddAds;
  bool get isCellarAddAds => _isCellarAddAds;
  bool get isFamilyPartitionAddAds => _isFamilyPartitionAddAds;
  bool get isAmusementParkAddAds => _isAmusementParkAddAds;
  bool get isVolleyballCourtAddAds => _isVolleyballCourtAddAds;
  bool get isFootballCourtAddAds => _isFootballCourtAddAds;
  double get LoungesAddAds => _LoungesAddAds;
  double get ToiletsAddAds => _ToiletsAddAds;
  double get RoomsAddAds => _RoomsAddAds;
  double get AgeOfRealEstateAddAds => _AgeOfRealEstateAddAds;
  double get ApartmentsAddAds => _ApartmentsAddAds;
  double get StoresAddAds => _StoresAddAds;
  double get WellsAddAds => _WellsAddAds;
  double get TreesAddAds => _TreesAddAds;
  double get FloorAddAds => _FloorAddAds;
  double get StreetWidthAddAds => _StreetWidthAddAds;
  String get totalPricAddAds => _totalPricAddAds;
  String get totalSpaceAddAds => _totalSpaceAddAds;
  String get detailsAqarAddAds => _detailsAqarAddAds;
  List<bool> get planAddAds => _planAddAds;
  int get selectedPlanAddAds => _selectedPlanAddAds;
  List<bool> get familyAddAds => _familyAddAds;
  int get selectedFamilyAddAds => _selectedFamilyAddAds;
  List<bool> get typeAqarAddAds => _typeAqarAddAds;
  int get selectedTypeAqarAddAds => _selectedTypeAqarAddAds;
  List<File> get imagesListAddAds => _imagesListAddAds;
  int get currentControllerPageAddAds => _currentControllerPageAddAds;
  PageController get controllerAddAds => _controllerAddAds;
  List<CategoryModel> get categoryAddAds => _categoryAddAds;
  int get id_category_finalAddAds => _id_category_finalAddAds;
  String get category_finalAddAds => _category_finalAddAds;
  VideoPlayerController get videoControllerAddAds => _videoControllerAddAds;
  ChewieController get chewieControllerAddAds => _chewieControllerAddAds;
  File get videoAddAds => _videoAddAds;
  Location get location => _location;
  LatLng get initialCameraPosition => _initialCameraPosition;
  double get zoom => _zoom;
  bool get isSending => _isSending;
}