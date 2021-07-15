import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

import 'dart:ui' as ui;

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
import 'package:tadawl_app/mainWidgets/Gist.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/CategoryModel.dart';
import 'package:tadawl_app/models/KeySearchModel.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/cache_markers_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/test/mutual_provider.dart';
import 'package:tadawl_app/provider/user_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/my_account.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:tadawl_app/screens/ads/add_ads.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdsProvider extends ChangeNotifier{

  int _countAdsRiyadh = 0;
  int _countAdsMekkah = 0;
  int _countAdsDammam = 0;
  int _countAdsRest = 0;
  LocationData _currentPosition;

  /// handle camera posisition and zoom
  CameraPosition _currentCameraView;
  String _search;
  List _KeyData = [];
  final List<KeySearchModel> _key = [];
  VideoPlayerController _videoControllerAdsPage;
  VideoPlayerController _videoControllerAddAds;
  Future<void> _initializeFutureVideoPlyerAdsPage;
  ChewieController _chewieControllerAdsPage;
  ChewieController _chewieControllerAddAds;
  int _is_favAdsPageDB = 0;
  File _videoAddAds;
  // final _pickerAddAds = ImagePicker();
  final _pickerAddAdsVid = ImagePicker();
  bool _AcceptedAddAds = false;
  bool _AcceptedUpdate = false;
  int _currentStageUpdateDetails;
  int _filterCity;


  int _number;
  File _video;

  bool _busy = false;
  bool _busyAdsPage = false;
  final bool _waitAdsPage = false;





  final List<AdsModel> _AdsUpdateLoc = [];
  List _AdsUpdateLocData = [];
  final List<AdsModel> _AdsSpecial = [];
  List _AdsSpecialData = [];
  final List<AdsModel> _TodayAds = [];
  List _TodayAdsData = [];



  List _imageData = [];
  final List<AdsModel> _image = [];
  final List<bool> _isSelected1 = List.generate(3, (_) => false);
  int _selectedNav1;
  final List<bool> _isSelected2 = List.generate(3, (_) => false);
  int _selectedNav2;
  final List<bool> _isSelected3 = List.generate(2, (_) => false);
  int _selectedNav3;
  final List<bool> _isSelected4 = List.generate(1, (_) => false);
  int _selectedNav4;
  final List<bool> _isSelected5 = List.generate(4, (_) => false);
  File _imageAqarVR;
  final _picker3 = ImagePicker();

  int _buttonClickedAqarVR;
  final List<bool> _list_id_type = List.generate(3, (_) => false);
  String _identity_number, _saq_number, _identity_type;
  final Set<Marker> _markersUpdateLoc = {};
  String _adss_city;
  String _adss_neighborhood;
  String _adss_road;
  LatLng _adss_cordinates;
  double _adss_cordinates_lat;
  double _adss_cordinates_lng;
  int _currentControllerPageImgVedUpdate = 0;
  final PageController _controllerImgVedUpdate = PageController();
  List<File> _imagesListUpdate = [];
  VideoPlayerController _videoControllerUpdate;
  File _videoUpdate;
  final _pickerVideoUpdate = ImagePicker();
  List _CategoryDataUpdate = [];
  final List<CategoryModel> _categoryUpdate = [];
  List _CategoryDataAddAds = [];
  final List<CategoryModel> _categoryAddAds = [];
  List _AdsDataUpdateDetails = [];
  final List<AdsModel> _adsUpdateDetails = [];
  int _id_category_finalUpdate;
  String _category_finalUpdate;
  int _id_category_finalAddAds;
  String _category_finalAddAds;
  int _currentStageAddAds;
  final TextEditingController _priceControllerUpdate = TextEditingController();
  final TextEditingController _spaceControllerUpdate = TextEditingController();
  final TextEditingController _meterPriceControllerUpdate =
  TextEditingController();
  final TextEditingController _descControllerUpdate = TextEditingController();
  int _meterPriceUpdate;
  String _interfaceSelectedUpdate;
  bool _isFurnishedUpdate = false;
  bool _isKitchenUpdate = false;
  bool _isAppendixUpdate = false;
  bool _isCarEntranceUpdate = false;
  bool _isElevatorUpdate = false;
  bool _isConditionerUpdate = false;
  bool _isHallStaircaseUpdate = false;
  bool _isDuplexUpdate = false;
  bool _isDriverRoomUpdate = false;
  bool _isSwimmingPoolUpdate = false;
  bool _isMaidRoomUpdate = false;
  bool _isMonstersUpdate = false;
  bool _isVerseUpdate = false;
  bool _isCellarUpdate = false;
  bool _isFamilyPartitionUpdate = false;
  bool _isAmusementParkUpdate = false;
  bool _isVolleyballCourtUpdate = false;
  bool _isFootballCourtUpdate = false;
  double _LoungesUpdateUpdate = 0;
  double _ToiletsUpdateUpdate = 0;
  double _RoomsUpdate = 0;
  double _AgeOfRealEstateUpdate = 0;
  double _ApartmentsUpdate = 0;
  double _StoresUpdate = 0;
  double _WellsUpdate = 0;
  double _TreesUpdate = 0;
  double _FloorUpdate = 0;
  double _StreetWidthUpdate = 0;
  String _totalPricUpdatee;
  String _totalSpaceUpdate;
  String _detailsAqarUpdate;
  final List<bool> _planUpdate = List.generate(3, (_) => false);
  int _selectedPlanUpdate = 0;
  final List<bool> _familyUpdate = List.generate(2, (_) => false);
  int _selectedFamilyUpdate = 0;
  final List<bool> _typeAqarUpdate = List.generate(3, (_) => false);
  int _selectedTypeAqarUpdate = 0;
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
  final TextEditingController _meterPriceControllerAddAds =
  TextEditingController();
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
  bool _isMonstersAddAds = false;
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
  int _selectedPlanAddAds = 0;
  final List<bool> _familyAddAds = List.generate(2, (_) => false);
  int _selectedFamilyAddAds = 0;
  final List<bool> _typeAqarAddAds = List.generate(3, (_) => false);
  int _selectedTypeAqarAddAds = 0;
  List<File> _imagesListAddAds = [];
  int _currentControllerPageAddAds = 0;
  final PageController _controllerAddAds = PageController();


  int _currentControllerPageAdsPage = 0;
  final PageController _controllerAdsPage = PageController();
  int _is_favAdsPage;










  int _id_categorySearchDrawer;
  String _currentLocationSearchDrawer;

  // ignore: prefer_final_fields
  bool _isClickedSearchDrawer = false;




  bool _wait = false;





  //int _idWait;

  void setWaitState(bool wait) {
    _wait = wait;
  }



  void setVideo(BuildContext context, File video) {
    _video = video;
  }











  void getAdsSpecialList(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsSpecial.clear();
      Api().getadsFunc(context).then((value) {
        _AdsSpecialData = value;
        _AdsSpecialData.forEach((element) {
          if (element['id_special'] == '1') {
            _AdsSpecial.add(AdsModel.ads(element));
          }
        });
        notifyListeners();
      });
    });
  }

  void setCurrentCameraView(CameraPosition val){
    _currentCameraView = val;
  }

  void getTodayAdsList(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _TodayAds.clear();
      Api().getadsFunc(context).then((value) {
        _TodayAdsData = value;
        _TodayAdsData.forEach((element) {
          var now = DateTime.now();
          var adsDateTime = DateTime.parse(element['timeAdded']);
          var def = now.difference(adsDateTime).inDays;
          if (def <= 1) {
            _TodayAds.add(AdsModel.ads(element));
          }
        });
        for(var i = 0; i < _TodayAds.length; i++) {
          if(_TodayAds[i].ads_city == 'الرياض') {
            _countAdsRiyadh += 1;
          } else if(_TodayAds[i].ads_city == 'مكة') {
            _countAdsMekkah += 1;
          } else if(_TodayAds[i].ads_city == 'الدمام') {
            _countAdsDammam += 1;
          } else if(_TodayAds[i].ads_city != 'الدمام' && _TodayAds[i].ads_city == 'مكة' && _TodayAds[i].ads_city == 'الرياض') {
            _countAdsRest += 1;
          }
        }
        notifyListeners();
      });
    });
  }









  void clearChacheAddAds() {
    _currentStageAddAds = null;
    _detailsAqarAddAds = null;
    _isFootballCourtAddAds = false;
    _isVolleyballCourtAddAds= false;
    _isAmusementParkAddAds= false;
    _isFamilyPartitionAddAds= false;
    _isVerseAddAds= false;
    _isCellarAddAds= false;
    _isMonstersAddAds= false;
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
    _selectedTypeAqarAddAds= 0;
    _selectedFamilyAddAds= 0;
    _interfaceSelectedAddAds= null;
    _totalSpaceAddAds= null;
    _totalPricAddAds= null;
    _selectedPlanAddAds= 0;
    _id_category_finalAddAds= 0;
    _ads_cordinates_latAddAds= 0;
    _ads_cordinates_lngAddAds= 0;
    _ads_cityAddAds= null;
    _ads_neighborhoodAddAds= null;
    _ads_roadAddAds= null;
    _videoAddAds= null;
    _imagesListAddAds.clear();
  }

  void addNewAd(
      BuildContext context,
      String detailsAqar,
      String isFootballCourt,
      String isVolleyballCourt,
      String isAmusementPark,
      String isFamilyPartition,
      String isVerse,
      String isCellar,
      String isMonsters,
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
    Future.delayed(Duration(milliseconds: 0), () {
      Api().addNewAdsFunc(
        context,
        detailsAqar,
        isFootballCourt,
        isVolleyballCourt,
        isAmusementPark,
        isFamilyPartition,
        isVerse,
        isCellar,
        isMonsters,
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
        interfaceSelected,
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
      );
    });

    await Fluttertoast.showToast(
        msg: 'تتم الآن مراجعة الإعلان',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0);

    clearChacheAddAds();
    Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  void update(){
    notifyListeners();
  }

  void getImagesAdsPageInfo(BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _image.clear();
      Api()
          .getImagesAdsPageFunc(context, id_description)
          .then((value) {
        _imageData = value;
        _imageData.forEach((element) {
          _image.add(AdsModel.adsImage(element));
        });
        notifyListeners();
      });
    });
  }



  Future<bool> updateAds(BuildContext context, String id_ads) async {


    return Future.delayed(Duration(milliseconds: 0), () {
      return Api().updateAdsFunc(context, id_ads).then((value) {
        _busy = false;
        return true;
      });
    });
  }

  void setNumber(int i) {
    _number = i;
    _busy = true;
    notifyListeners();
  }

  void initStateSelected() {
    _isSelected1[0] = true;
    _isSelected2[0] = true;
    _isSelected3[0] = true;
    _isSelected4[0] = true;
    _isSelected5[0] = true;
    _selectedNav1 = 0;
    _selectedNav2 = 0;
    _selectedNav3 = 0;
    _selectedNav4 = 0;
  }

  void updateSelected1(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _isSelected1.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _isSelected1[buttonIndex] = true;
        _selectedNav1 = buttonIndex;
      } else {
        _isSelected1[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void updateSelected2(int index) {
    for (var buttonIndex2 = 0;
    buttonIndex2 < _isSelected2.length;
    buttonIndex2++) {
      if (buttonIndex2 == index) {
        _isSelected2[buttonIndex2] = true;
        _selectedNav2 = buttonIndex2;
      } else {
        _isSelected2[buttonIndex2] = false;
      }
    }
    notifyListeners();
  }

  void updateSelected3(int index) {
    for (var buttonIndex3 = 0;
    buttonIndex3 < _isSelected3.length;
    buttonIndex3++) {
      if (buttonIndex3 == index) {
        _isSelected3[buttonIndex3] = true;
        _selectedNav3 = buttonIndex3;
      } else {
        _isSelected3[buttonIndex3] = false;
      }
    }
    notifyListeners();
  }

  void updateSelected4(int index) {
    for (var buttonIndex4 = 0;
    buttonIndex4 < _isSelected4.length;
    buttonIndex4++) {
      if (buttonIndex4 == index) {
        _isSelected4[buttonIndex4] = true;
        _selectedNav4 = buttonIndex4;
      } else {
        _isSelected4[buttonIndex4] = false;
      }
    }
    notifyListeners();
  }

  void updateSelected5(BuildContext context, int index) {
    for (var buttonIndex5 = 0;
    buttonIndex5 < _isSelected5.length;
    buttonIndex5++) {
      if (buttonIndex5 == index) {
        _isSelected5[buttonIndex5] = true;
        getTodayAdsList(context);
        _filterCity = buttonIndex5 + 1;
      } else {
        _isSelected5[buttonIndex5] = false;
      }
    }
    notifyListeners();
  }

  void updateSelectedNav4(int index) {
    _selectedNav4 = index;
    notifyListeners();
  }

  Future<void> getImageAqarVR() async {
    final _pickedFile3 = await _picker3.getImage(
      source: ImageSource.gallery,
    );
    if (_pickedFile3 != null) {
      _imageAqarVR = File(_pickedFile3.path);
    } else {}
    notifyListeners();
  }



  void setButtonClickedAqarVR(int buttonClickedAqarVR) {
    _buttonClickedAqarVR = buttonClickedAqarVR;
    notifyListeners();
  }

  void setIdentityNumber(String id) {
    _identity_number = id;
    notifyListeners();
  }

  void setSaqNumber(String saqNumber) {
    _saq_number = saqNumber;
    notifyListeners();
  }

  void updateIdentityType(int index) {
    for (var buttonIndex4 = 0;
    buttonIndex4 < _list_id_type.length;
    buttonIndex4++) {
      if (buttonIndex4 == index) {
        _list_id_type[buttonIndex4] = true;
        _identity_type = (buttonIndex4 + 1).toString();
      } else {
        _list_id_type[buttonIndex4] = false;
      }
    }
    notifyListeners();
  }

  Future sendInfoAqarVR(
      BuildContext context,
      String identity_number,
      String saq_number,
      String identity_type,
      String id_description,
      File image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().sendInfoAqarVRFunc(context, identity_number, saq_number,
          identity_type, id_description, image);
    });



    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdPage()),
      );
    });
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

  void getAdsPageInfo(BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsUpdateLoc.clear();
      Api().getAdsPageFunc(context, id_description).then((value) {
        _AdsUpdateLocData = value;
        _AdsUpdateLocData.forEach((element) {
          _AdsUpdateLoc.add(AdsModel.adsUpdateLoc(element));
        });
        setMarker(context);
        notifyListeners();
      });
    });
    // notifyListeners();
  }

  void setMarker(BuildContext context) async {
    if (Provider.of<AdsProvider>(context, listen: false).ads.isNotEmpty) {
      _markersUpdateLoc.add(Marker(
        markerId: MarkerId(_AdsUpdateLoc.first.lat),
        position: LatLng(double.parse(_AdsUpdateLoc.first.lat),
            double.parse(_AdsUpdateLoc.first.lng)),
      ));
    }
  }

  void handleCameraMoveUpdateLoc(CameraPosition position) async {

    if (_markersUpdateLoc.isEmpty) {
      _markersUpdateLoc.add(Marker(
        markerId: MarkerId(position.target.toString()),
        position: position.target,
      ));
    } else {
      _markersUpdateLoc.clear();
      _markersUpdateLoc.add(Marker(
        markerId: MarkerId(position.target.toString()),
        position: position.target,
      ));
    }
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

  Future getImagesUpdate() async {
    _imagesListUpdate = [];

    var resultList = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
      materialOptions: MaterialOptions(
        actionBarColor: '#00cccc',
        actionBarTitle: 'تداول العقاري',
        allViewTitle: 'كل الصور',
        useDetailsView: true,
        selectCircleStrokeColor: '#00cccc',
      ),
    );
    for (var x = 0; x < resultList.length; x++) {
      var image =
      await FlutterAbsolutePath.getAbsolutePath(resultList[x].identifier);
      _imagesListUpdate.add(File(image));
    }
    notifyListeners();
  }

  void removeImageAt(int index) {
    _imagesListUpdate.removeAt(index);
    if (_currentControllerPageImgVedUpdate != 0) {
      _currentControllerPageImgVedUpdate = index - 1;
    }
    notifyListeners();
  }

  void currentControllerPageImgVedUpdateFunc(int index) {
    _currentControllerPageImgVedUpdate = index;
    notifyListeners();
  }

  void currentControllerPageAdsPageFunc(int index) {
    _currentControllerPageAdsPage = index;
    notifyListeners();
  }

  void updateImgVed(BuildContext context, String id_description,
      List<File> imagesList, File video) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateImgVedFunc(
        context,
        id_description,
        imagesList,
        video,
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
    notifyListeners();
  }

  Future getVideoUpdate() async {
    var _pickedVideoUpdate = await _pickerVideoUpdate.getVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: 30),
    );
    _videoUpdate = File(_pickedVideoUpdate.path);
    _videoControllerUpdate = VideoPlayerController.file(_videoUpdate);
    _videoControllerUpdate.addListener(() {});
    await _videoControllerUpdate.setLooping(true);
    await _videoControllerUpdate.initialize();
    await _videoControllerUpdate.play();
    notifyListeners();
  }

  void deleteVideoUpdate() {
    _videoUpdate = null;
    notifyListeners();
  }

  void deleteVideoAdsPage() {
    _videoControllerAdsPage = null;
    notifyListeners();
  }

  void pausePlayVideoUpdate() {
    if (_videoControllerUpdate.value.isPlaying) {
      _videoControllerUpdate.pause();
    } else {
      _videoControllerUpdate.play();
    }
    notifyListeners();
  }

  void setCurrentStageUpdateDetails(int current) {
    _currentStageUpdateDetails = current;
    notifyListeners();
  }

  void getCategoryeInfoUpdate(BuildContext context) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _categoryUpdate.clear();
      Api().getCategoryFunc(context).then((value) {
        _CategoryDataUpdate = value;
        _CategoryDataUpdate.forEach((element) {
          _categoryUpdate.add(CategoryModel.fromJson(element));
        });
        // notifyListeners();
      });
    });
  }

  void getAdsPageInfoUpdateDetails(
      BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _adsUpdateDetails.clear();
      Api().getAdsPageFunc(context, id_description).then((value) {
        _AdsDataUpdateDetails = value;
        _AdsDataUpdateDetails.forEach((element) {
          _adsUpdateDetails.add(AdsModel.adsUpdateDetails(element));
        });
        if (_adsUpdateDetails.isNotEmpty) {
          _priceControllerUpdate..text = _adsUpdateDetails.first.price;
          _spaceControllerUpdate..text = _adsUpdateDetails.first.space;
          _descControllerUpdate..text = _adsUpdateDetails.first.description;
        }
        // notifyListeners();
      });
    });
  }

  void updateCategoryDetails(int id, String category) {
    _id_category_finalUpdate = id;
    _category_finalUpdate = category;
    notifyListeners();
  }

  void updateDetails(
      BuildContext context,
      String id_description,
      String detailsAqar,
      String isFootballCourt,
      String isVolleyballCourt,
      String isAmusementPark,
      String isFamilyPartition,
      String isVerse,
      String isCellar,
      String isMonsters,
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
      String id_category_final,
      String selectedAdderRelation,
      String selectedMarketerRelation,
      ) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateDetailsFunc(
        context,
        id_description,
        detailsAqar,
        isFootballCourt,
        isVolleyballCourt,
        isAmusementPark,
        isFamilyPartition,
        isVerse,
        isCellar,
        isMonsters,
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
        interfaceSelected,
        totalSpace,
        totalPrice,
        selectedPlan,
        id_category_final,
        null,
        null,
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

  void setAcceptedUpdate(bool state) {
    _AcceptedUpdate = state;
    notifyListeners();
  }

  void setInterfaceSelectedUpdate(String interfaceSelectedUpdate) {
    _interfaceSelectedUpdate = interfaceSelectedUpdate;
    notifyListeners();
  }

  void setTyprAqarUpdate(int index, bool update) {
    for (var buttonIndex33 = 0;
    buttonIndex33 < _typeAqarUpdate.length;
    buttonIndex33++) {
      if (buttonIndex33 == index) {
        _typeAqarUpdate[buttonIndex33] = true;
        _selectedTypeAqarUpdate = buttonIndex33 + 1;
      } else {
        _typeAqarUpdate[buttonIndex33] = false;
      }
    }
    if(update){
      notifyListeners();
    }
  }

  void setFamilyUpdate(int index) {
    for (var buttonIndex34 = 0;
    buttonIndex34 < _familyUpdate.length;
    buttonIndex34++) {
      if (buttonIndex34 == index) {
        _familyUpdate[buttonIndex34] = true;
        _selectedFamilyUpdate = buttonIndex34;
      } else {
        _familyUpdate[buttonIndex34] = false;
      }
    }
    notifyListeners();
  }

  void setPlanUpdate(int index) {
    for (var buttonIndex35 = 0;
    buttonIndex35 < _planUpdate.length;
    buttonIndex35++) {
      if (buttonIndex35 == index) {
        _planUpdate[buttonIndex35] = true;
        _selectedPlanUpdate = buttonIndex35 + 1;
      } else {
        _planUpdate[buttonIndex35] = false;
      }
    }
    notifyListeners();
  }

  void setLoungesUpdate(double value) {
    _LoungesUpdateUpdate = value;
    notifyListeners();
  }

  void setToiletsUpdate(double value) {
    _ToiletsUpdateUpdate = value;
    notifyListeners();
  }

  void setStreetWidthUpdate(double value) {
    _StreetWidthUpdate = value;
    notifyListeners();
  }

  void setRoomsUpdate(double value) {
    _RoomsUpdate = value;
    notifyListeners();
  }

  void setApartementsUpdate(double value) {
    _ApartmentsUpdate = value;
    notifyListeners();
  }

  void setFloorUpdate(double value) {
    _FloorUpdate = value;
    notifyListeners();
  }

  void setAgeOfREUpdate(double value) {
    _AgeOfRealEstateUpdate = value;
    notifyListeners();
  }

  void setStoresUpdate(double value) {
    _StoresUpdate = value;
    notifyListeners();
  }

  void setTreesUpdate(double value) {
    _TreesUpdate = value;
    notifyListeners();
  }

  void setWellsUpdate(double value) {
    _WellsUpdate = value;
    notifyListeners();
  }

  void setIsHallStaircaseUpdate(bool value) {
    _isHallStaircaseUpdate = value;
    notifyListeners();
  }

  void setIsDriverRoomUpdate(bool value) {
    _isDriverRoomUpdate = value;
    notifyListeners();
  }

  void setIsMaidRoomUpdate(bool value) {
    _isMaidRoomUpdate = value;
    notifyListeners();
  }

  void setIsSwimmingPoolUpdate(bool val) {
    _isSwimmingPoolUpdate = val;
    notifyListeners();
  }

  void setIsFootballCourtUpdate(bool val) {
    _isFootballCourtUpdate = val;
    notifyListeners();
  }

  void setIsVolleyballCourtUpdate(bool val) {
    _isVolleyballCourtUpdate = val;
    notifyListeners();
  }

  void setIsFurnishedUpdate(bool val) {
    _isFurnishedUpdate = val;
    notifyListeners();
  }

  void setIsVerseUpdate(bool val) {
    _isVerseUpdate = val;
    notifyListeners();
  }

  void setIsMonstersUpdate(bool val) {
    _isMonstersUpdate = val;
    notifyListeners();
  }

  void setIsKitchenUpdate(bool val) {
    _isKitchenUpdate = val;
    notifyListeners();
  }

  void setIsAppendixUpdate(bool val) {
    _isAppendixUpdate = val;
    notifyListeners();
  }

  void setIsCarEntranceUpdate(bool val) {
    _isCarEntranceUpdate = val;
    notifyListeners();
  }

  void setIsCellarUpdate(bool val) {
    _isCellarUpdate = val;
    notifyListeners();
  }

  void setIsElevatorUpdate(bool val) {
    _isElevatorUpdate = val;
    notifyListeners();
  }

  void setIsDuplexUpdate(bool val) {
    _isDuplexUpdate = val;
    notifyListeners();
  }

  void setIsConditionerUpdate(bool val) {
    _isConditionerUpdate = val;
    notifyListeners();
  }

  void setIsAmusementParkUpdate(bool val) {
    _isAmusementParkUpdate = val;
    notifyListeners();
  }

  void setIsFamilyPartitionUpdate(bool val) {
    _isFamilyPartitionUpdate = val;
    notifyListeners();
  }

  void setOnChangedSpaceUpdate(String value) {
    if (_meterPriceUpdate != null) {
      _priceControllerUpdate
        ..text = (double.parse(value) * double.parse('$_meterPriceUpdate'))
            .toString();
    }
    _totalSpaceUpdate = value;
    notifyListeners();
  }

  void setOnSavedSpaceUpdate(String value) {
    _totalSpaceUpdate = value;
    _spaceControllerUpdate..text = '$value';
    notifyListeners();
  }

  void setOnChangedMeterPriceUpdate(String value) {
    if (_totalSpaceUpdate != null) {
      _priceControllerUpdate
        ..text =
        (double.parse(value) * double.parse(_totalSpaceUpdate)).toString();
    }
    _meterPriceUpdate = int.parse(value);
    notifyListeners();
  }

  void setOnSavedMeterPriceUpdate(String value) {
    _meterPriceUpdate = int.parse(value);
    _meterPriceControllerUpdate..text = '$value';
    notifyListeners();
  }

  void setOnSavedTotalPriceUpdate(String value) {
    _totalPricUpdatee = value;
    _priceControllerUpdate..text = value;
    notifyListeners();
  }

  void setOnSavedDetailsUpdate(String value) {
    _detailsAqarUpdate = value;
    _descControllerUpdate..text = value;
    notifyListeners();
  }

  void setCurrentStageAddAds(int value) {
    _currentStageAddAds = value;
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
    // notifyListeners();
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

  void setIsMonstersAddAds(bool val) {
    _isMonstersAddAds = val;
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
        ..text = (double.parse(value) * double.parse('$_meterPriceAddAds'))
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
        (double.parse(value) * double.parse(_totalSpaceAddAds)).toString();
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

    var resultList = await MultiImagePicker.pickImages(
      maxImages: 30,
      enableCamera: true,
      materialOptions: MaterialOptions(
        actionBarColor: '#00cccc',
        actionBarTitle: 'تداول العقاري',
        allViewTitle: 'كل الصور',
        useDetailsView: true,
        selectCircleStrokeColor: '#00cccc',
      ),
    );
    for (var x = 0; x < resultList.length; x++) {
      var image = await FlutterAbsolutePath.getAbsolutePath(resultList[x].identifier);
      _imagesListAddAds.add(File(image));
    }

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => AddAds()),
    );
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

  void getCategoryeInfoAddAds(BuildContext context) async {
    Future.delayed(Duration(milliseconds: 200), () {
      _categoryAddAds.clear();
      Api().getCategoryFunc(context).then((value) {
        _CategoryDataAddAds = value;
        _CategoryDataAddAds.forEach((element) {
          _categoryAddAds.add(CategoryModel.fromJson(element));
        });
        notifyListeners();
      });
    });
  }

  void updateCategoryDetailsAddAds(int id, String category) {
    _id_category_finalAddAds = id;
    _category_finalAddAds = category;
    notifyListeners();
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



  void stopVideoAdsUpdate() {
    if(_videoControllerUpdate != null) {
      //_videoAddAds = null;
      //_video = null;
      //_videoUpdate = null;
      _videoControllerUpdate.pause();
      //_videoControllerAddAds.pause();
      //videoControllerAdsPage.pause();
    }
    //notifyListeners();
  }





  void updateAdsAdsPage(BuildContext context, String id_ads) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _busyAdsPage = true;
      Api().updateAdsFunc(context, id_ads).then((value) {
        _busyAdsPage = false;
        notifyListeners();
      });
    });
  }







  void clearFav(){
    _is_favAdsPage = null;
  }

  void sendEstimate(BuildContext context, String phone, String phoneEstimated, String rating, String comment, String idDescription) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api()
          .sendEstimateFunc(context, phone, phoneEstimated, rating, comment);
    });
    Provider.of<MutualProvider>(context, listen: false)
        .getAllAdsPageSendEs(context, idDescription);

    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdPage()),
      );
    });
  }

  void searchKeyInfo(BuildContext context, String keySearch) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().searchKeyFunc(context, keySearch).then((value) {
        if (value == 'false') {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context).notFoundToast,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 15.0);
        } else {
          _KeyData = value;
          _KeyData.forEach((element) {
            _key.add(KeySearchModel.fromJson(element));
          });
          if (_key.isNotEmpty) {
            if (_key.first.phone == keySearch) {
              Provider.of<UserProvider>(context, listen: false)
                  .getAvatarList(context, _key.first.phone);
              Provider.of<UserProvider>(context, listen: false)
                  .getUserAdsList(context, _key.first.phone);
              Provider.of<UserProvider>(context, listen: false)
                  .getEstimatesInfo(context, _key.first.phone);
              Provider.of<UserProvider>(context, listen: false)
                  .getSumEstimatesInfo(context, _key.first.phone);
              Provider.of<UserProvider>(context, listen: false)
                  .checkOfficeInfo(context, _key.first.phone);
              Provider.of<UserProvider>(context, listen: false)
                  .setUserPhone(_key.first.phone);

              Future.delayed(Duration(seconds: 0), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAccount()),
                );
              });
            }
            else if (_key.first.id_ads == keySearch) {
              Provider.of<MutualProvider>(context, listen: false)
              .getAllAdsPageInfo(context, _key.first.id_description);

              Future.delayed(Duration(seconds: 0), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdPage()),
                );
              });
            }
          }
        }
        notifyListeners();
      });
    });
  }

  void setSearchKey(String value) {
    _search = filterPhone(value);
    notifyListeners();
  }

  String filterPhone(var Phone) {
    if (Phone.toString().length == 10 && Phone.toString().startsWith('05')) {
      Phone = Phone.toString().replaceFirst('0', '966');
      return Phone;
    } else if (Phone.toString().startsWith('5')) {
      Phone = Phone.toString().replaceFirst('5', '9665');
      return Phone;
    } else if (Phone.toString().startsWith('00')) {
      Phone = Phone.toString().replaceFirst('00', '');
      return Phone;
    } else if (Phone.toString().startsWith('+')) {
      Phone = Phone.toString().replaceFirst('+', '');
      return Phone;
    } else {
      return Phone;
    }
  }

  void setVideoAdsPage(String video) {
    _videoControllerAdsPage = VideoPlayerController.network(
        'https://tadawl.com.sa/API/assets/videos/$video');
    _initializeFutureVideoPlyerAdsPage = _videoControllerAdsPage.initialize();
    _chewieControllerAdsPage = ChewieController(
      videoPlayerController: _videoControllerAdsPage,
      autoPlay: true,
      looping: true,
    );
    //notifyListeners();
  }

  void choiceAction(BuildContext context, String choice, String idDescription) {
    if (choice == 'تعديل الصور والفيديو' ||
        choice == 'Update Images and Videos') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.pushNamed(context, '/main/update_ads_img_ved', arguments: {
        'id_description': idDescription,
      });
    } else if (choice == 'تعديل الموقع' || choice == 'Update Location') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.pushNamed(context, '/main/update_location', arguments: {
        'id_description': idDescription,
      });
    } else if (choice == 'تعديل التفاصيل' || choice == 'Update Details') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.pushNamed(context, '/main/update_datails', arguments: {
        'id_description': idDescription,
      });
    } else if (choice == 'حذف الإعلان' || choice == 'Delete Ad') {
      onDeletePressed(context, idDescription);
    }
  }

  void deleteAdsFunc(BuildContext context, String idDescription) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().deleteAdsFunc(context, idDescription);
    });
  }

  Future<bool> onDeletePressed(BuildContext context, String idDescription) {
    if(_videoControllerAdsPage != null) {
      _videoControllerAdsPage.pause();
    }
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'أنت على وشك حذف الإعلان',
          style: CustomTextStyle(

            fontSize: 20,
            color: const Color(0xffff0000),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'هل أنت متأكد من حذف الإعلان؟',
          style: CustomTextStyle(

            fontSize: 15,
            color: const Color(0xff000000),
          ).getTextStyle(),
          textAlign: TextAlign.right,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              deleteAdsFunc(context, idDescription);
              Provider.of<AdsProvider>(context, listen: false)
                  .getAdsList(
                  context,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null);
              Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: Text(
              'نعم',
              style: CustomTextStyle(

                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text(
              'لا',
              style: CustomTextStyle(

                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
    ) ??
        false;
  }

  void changeAdsFavState(BuildContext context, int fav, String idDescription) async {
    if(Provider.of<UserProvider>(context, listen: false).phone != null){
      Future.delayed(Duration(milliseconds: 0), () {
        Api().changeAdsFavStateFunc(context, idDescription, Provider.of<UserProvider>(context, listen: false).phone).then((value) {
          _is_favAdsPage = fav;
          notifyListeners();
        });
        Provider.of<UserProvider>(context, listen: false).getUserAdsFavList(context, Provider.of<UserProvider>(context, listen: false).phone);
        // notifyListeners();
      });
    }else{
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  void getIsFav(BuildContext context, String idDescription) {
      _is_favAdsPageDB = int.tryParse(Provider.of<UserProvider>(context, listen: false).getIsFav(idDescription)?? '0');
      // notifyListeners();
  }

  void setVideoAddAds(String video) {
    _videoControllerAddAds = VideoPlayerController.network(
        'https://tadawl.com.sa/API/assets/videos/$video');
    _initializeFutureVideoPlyerAdsPage = _videoControllerAddAds.initialize();
    _chewieControllerAdsPage = ChewieController(
      videoPlayerController: _videoControllerAddAds,
      autoPlay: true,
      looping: true,
    );
    //notifyListeners();
  }

  void stopVideoAdsPage() {
    if(_videoControllerAdsPage != null) {
      //_videoAddAds = null;
      //_video = null;
      //_videoUpdate = null;
      //_videoControllerUpdate.pause();
      //_videoControllerAddAds.pause();
      _videoControllerAdsPage.pause();
    }
    //notifyListeners();
  }




















  int countAdsSpecial() {
    if (_AdsSpecial.isNotEmpty) {
      return _AdsSpecial.length;
    } else {
      return 0;
    }
  }

  int countTodayAds() {
    if (_TodayAds.isNotEmpty) {
      return _TodayAds.length;
    } else {
      return 0;
    }
  }







  /// start









  /// end


  /// start main page provider
  GoogleMapController _mapControllerMainPAge;
  String _idCategorySearch;
  int _inItMainPageDone = 0;
  bool _showDiaogSearchDrawer = false;
  int _slider_state = 1;
  AdsModel _SelectedAdsModelMainPage;
  final _markersMainPage = <Marker>[];
  int _adsOnMap = 1;
  bool _isMove = false;
  int _filter;
  final List<AdsModel> _Ads = [];
  List _AdsData = [];
  // To spicifice ads on area
  CameraPosition _selectedArea = CameraPosition(target: cities.first.position, zoom: cities.first.zoom);
  int _menuMainFilterAds;
  int _filterSearchDrawer;
  bool _waitMainPage = false;
  bool _waitMenu = false;
  int _menuFilter;
  final List<AdsModel> _MenuAds = [];
  List _MenuAdsData = [];
  // final List<GlobalKey> _markersKey = <GlobalKey>[];
  final ScrollController _menuController = ScrollController();
  int _expendedMenuListCount = 20;

  CameraPosition _region_position;
  List<Map> _categoriesFun() {
    var _categories = <Map>[
      {'id_category': '0', 'name': 'الكل'},
      {'id_category': '1', 'name': 'فيلا للبيع'},
      {'id_category': '2', 'name': 'أرض للبيع'},
      {'id_category': '3', 'name': 'عمارة للبيع'},
      {'id_category': '4', 'name': 'بيت للبيع'},
      {'id_category': '5', 'name': 'استراحة للبيع'},
      {'id_category': '6', 'name': 'مزرعة للبيع'},
      {'id_category': '7', 'name': 'مستودع للبيع'},
      {'id_category': '8', 'name': 'شقة للبيع'},
      {'id_category': '9', 'name': 'فيلا للإيجار'},
      {'id_category': '10', 'name': 'أرض للإيجار'},
      {'id_category': '11', 'name': 'عمارة للإيجار'},
      {'id_category': '12', 'name': 'استراحة للإيجار'},
      {'id_category': '13', 'name': 'مزرعة للإيجار'},
      {'id_category': '14', 'name': 'شقة للإيجار'},
      {'id_category': '15', 'name': 'دور للإيجار'},
      {'id_category': '16', 'name': 'مكتب للإيجار'},
      {'id_category': '17', 'name': 'غرفة للإيجار'},
      {'id_category': '18', 'name': 'محل للإيجار'},
      {'id_category': '19', 'name': 'مستودع للإيجار'},
      {'id_category': '20', 'name': 'مخيم للإيجار'},
      {'id_category': '21', 'name': 'محل للتقبيل'},
    ];
    return _categories;
  }
  List<Map> _enCategoriesFun() {
    var _enCategories = <Map>[
      {'id_category': '0', 'name': 'All'},
      {'id_category': '1', 'name': 'Villa for sale'},
      {'id_category': '2', 'name': 'Land for sale'},
      {'id_category': '3', 'name': 'Building for sale'},
      {'id_category': '4', 'name': 'House for sale'},
      {'id_category': '5', 'name': 'Chalet for sale'},
      {'id_category': '6', 'name': 'Farm for sale'},
      {'id_category': '7', 'name': 'Warehouse for sale'},
      {'id_category': '8', 'name': 'Apartment for sale'},
      {'id_category': '9', 'name': 'Villa for rent'},
      {'id_category': '10', 'name': 'Land for rent'},
      {'id_category': '11', 'name': 'Building for rent'},
      {'id_category': '12', 'name': 'Chalet for rent'},
      {'id_category': '13', 'name': 'Farm for rent'},
      {'id_category': '14', 'name': 'Apartment for rent'},
      {'id_category': '15', 'name': 'Floor for rent'},
      {'id_category': '16', 'name': 'Office for rent'},
      {'id_category': '17', 'name': 'Room for rent'},
      {'id_category': '18', 'name': 'Shop for rent'},
      {'id_category': '19', 'name': 'Warehouse for rent'},
      {'id_category': '20', 'name': 'Camp for rent'},
      {'id_category': '21', 'name': 'Shop for sale'},
    ];
    return _enCategories;
  }

  /// Start Mutual Variables with Search Drawer
  String _selectedCategory = '0',
      _minPriceSearchDrawer = '0',
      _maxSpaceSearchDrawer = '0',
      _minSpaceSearchDrawer = '0',
      _selectedLoungesSearchDrawer = '0',
      _selectedToiletsSearchDrawer = '0',
      _selectedRoomsSearchDrawer = '0',
      _selectedApartmentsSearchDrawer = '0',
      _selectedPlanSearchDrawer = '0',
      _storesSelectedSearchDrawer = '0',
      _floorSelectedSearchDrawer = '0',
      _selectedFamilyTypeSearchDrawer = '0',
      _treesSelectedSearchDrawer = '0',
      _maxPriceSearchDrawer = '0',
      _selectedTypeAqarSearchDrawer = '0',
      _interfaceSelectedSearchDrawer = '0',
      _streetWidthSelectedSearchDrawer = '0',
      _ageOfRealEstateSelectedSearchDrawer = '0',
      _wellsSelectedSearchDrawer = '0';
  bool _isTwoWeeksAgoSearchDrawer = false,
      _bool_feature1SearchDrawer = false,
      _bool_feature2SearchDrawer = false,
      _bool_feature3SearchDrawer = false,
      _bool_feature4SearchDrawer = false,
      _bool_feature5SearchDrawer = false,
      _bool_feature6SearchDrawer = false,
      _bool_feature7SearchDrawer = false,
      _bool_feature8SearchDrawer = false,
      _bool_feature9SearchDrawer = false,
      _bool_feature10SearchDrawer = false,
      _bool_feature11SearchDrawer = false,
      _bool_feature12SearchDrawer = false,
      _bool_feature13SearchDrawer = false,
      _bool_feature14SearchDrawer = false,
      _bool_feature15SearchDrawer = false,
      _bool_feature16SearchDrawer = false,
      _bool_feature17SearchDrawer = false,
      _bool_feature18SearchDrawer = false;
  final List<bool> _planSearchDrawer = List.generate(3, (_) => false);
  final List<bool> _loungesSearchDrawer = List.generate(4, (_) => false);
  final List<bool> _toiletsSearchDrawer = List.generate(4, (_) => false);
  final List<bool> _roomsSearchDrawer = List.generate(4, (_) => false);
  final List<bool> _apartmentsSearchDrawer = List.generate(6, (_) => false);
  final List<bool> _familyTypeSearchDrawer = List.generate(2, (_) => false);
  final List<bool> _typeAqarSearchDrawer = List.generate(3, (_) => false);
  final List<Map> _Interface = [
    {'id_type': '0', 'type': 'الكل'},
    {'id_type': '1', 'type': 'شمال'},
    {'id_type': '2', 'type': 'شرق'},
    {'id_type': '3', 'type': 'غرب'},
    {'id_type': '4', 'type': 'جنوب'},
    {'id_type': '5', 'type': 'شمال شرقي'},
    {'id_type': '6', 'type': 'جنوب شرقي'},
    {'id_type': '7', 'type': 'جنوب غربي'},
    {'id_type': '8', 'type': 'شمال غربي'},
    {'id_type': '9', 'type': 'جنوبي شمالي'},
    {'id_type': '10', 'type': 'شرقي غربي'},
    {'id_type': '11', 'type': '3 شوارع'},
    {'id_type': '12', 'type': '4 شوارع'},
  ];
  final List<Map> _EnInterface = [
    {'id_type': '0', 'type': 'All'},
    {'id_type': '1', 'type': 'North'},
    {'id_type': '2', 'type': 'East'},
    {'id_type': '3', 'type': 'West'},
    {'id_type': '4', 'type': 'South'},
    {'id_type': '5', 'type': 'Eastnorth'},
    {'id_type': '6', 'type': 'Eastsouth'},
    {'id_type': '7', 'type': 'Westsouth'},
    {'id_type': '8', 'type': 'Westnorth'},
    {'id_type': '9', 'type': 'South North'},
    {'id_type': '10', 'type': 'East West'},
    {'id_type': '11', 'type': '3 Roads'},
    {'id_type': '12', 'type': '4 Roads'},
  ];
  final List<Map> _StreetWidth = [
    {'id_type': '0', 'type': 'الكل'},
    {'id_type': '5', 'type': 'أكثر من 5'},
    {'id_type': '10', 'type': 'أكثر من 10'},
    {'id_type': '15', 'type': 'أكثر من 15'},
    {'id_type': '20', 'type': 'أكثر من 20'},
    {'id_type': '25', 'type': 'أكثر من 25'},
    {'id_type': '30', 'type': 'أكثر من 30'},
    {'id_type': '35', 'type': 'أكثر من 35'},
    {'id_type': '40', 'type': 'أكثر من 40'},
    {'id_type': '45', 'type': 'أكثر من 45'},
    {'id_type': '50', 'type': 'أكثر من 50'},
  ];
  final List<Map> _EnStreetWidth = [
    {'id_type': '0', 'type': 'All'},
    {'id_type': '5', 'type': 'More than 5'},
    {'id_type': '10', 'type': 'More than 10'},
    {'id_type': '15', 'type': 'More than 15'},
    {'id_type': '20', 'type': 'More than 20'},
    {'id_type': '25', 'type': 'More than 25'},
    {'id_type': '30', 'type': 'More than 30'},
    {'id_type': '35', 'type': 'More than 35'},
    {'id_type': '40', 'type': 'More than 40'},
    {'id_type': '45', 'type': 'More than 45'},
    {'id_type': '50', 'type': 'More than 50'},
  ];
  final List<Map> _AgeOfRealEstate = [
    {'id_type': '0', 'type': 'الكل'},
    {'id_type': '1', 'type': 'أقل من سنة'},
    {'id_type': '2', 'type': 'أقل من 2 سنة'},
    {'id_type': '3', 'type': 'أقل من 3 سنة'},
    {'id_type': '4', 'type': 'أقل من 4 سنة'},
    {'id_type': '5', 'type': 'أقل من 5 سنة'},
    {'id_type': '6', 'type': 'أقل من 6 سنة'},
    {'id_type': '7', 'type': 'أقل من 7 سنة'},
    {'id_type': '8', 'type': 'أقل من 8 سنة'},
    {'id_type': '9', 'type': 'أقل من 9 سنة'},
    {'id_type': '10', 'type': 'أقل من 10 سنة'},
    {'id_type': '11', 'type': 'أقل من 11 سنة'},
    {'id_type': '12', 'type': 'أقل من 12 سنة'},
    {'id_type': '13', 'type': 'أقل من 13 سنة'},
    {'id_type': '14', 'type': 'أقل من 14 سنة'},
    {'id_type': '15', 'type': 'أقل من 15 سنة'},
    {'id_type': '16', 'type': 'أقل من 16 سنة'},
    {'id_type': '17', 'type': 'أقل من 17 سنة'},
    {'id_type': '18', 'type': 'أقل من 18 سنة'},
    {'id_type': '19', 'type': 'أقل من 19 سنة'},
    {'id_type': '20', 'type': 'أقل من 20 سنة'},
  ];
  final List<Map> _EnAgeOfRealEstate = [
    {'id_type': '0', 'type': 'All'},
    {'id_type': '1', 'type': 'Less than 1 years'},
    {'id_type': '2', 'type': 'Less than 2 years'},
    {'id_type': '3', 'type': 'Less than 3 years'},
    {'id_type': '4', 'type': 'Less than 4 years'},
    {'id_type': '5', 'type': 'Less than 5 years'},
    {'id_type': '6', 'type': 'Less than 6 years'},
    {'id_type': '7', 'type': 'Less than 7 years'},
    {'id_type': '8', 'type': 'Less than 8 years'},
    {'id_type': '9', 'type': 'Less than 9 years'},
    {'id_type': '10', 'type': 'Less than 10 years'},
    {'id_type': '11', 'type': 'Less than 11 years'},
    {'id_type': '12', 'type': 'Less than 12 years'},
    {'id_type': '13', 'type': 'Less than 13 years'},
    {'id_type': '14', 'type': 'Less than 14 years'},
    {'id_type': '15', 'type': 'Less than 15 years'},
    {'id_type': '16', 'type': 'Less than 16 years'},
    {'id_type': '17', 'type': 'Less than 17 years'},
    {'id_type': '18', 'type': 'Less than 18 years'},
    {'id_type': '19', 'type': 'Less than 19 years'},
    {'id_type': '20', 'type': 'Less than 20 years'},
  ];
  final List<Map> _Stores = [
    {'id_type': '0', 'type': 'الكل'},
    {'id_type': '1', 'type': '1'},
    {'id_type': '2', 'type': '2'},
    {'id_type': '3', 'type': '3'},
    {'id_type': '4', 'type': '4'},
  ];
  final List<Map> _EnStores = [
    {'id_type': '0', 'type': 'All'},
    {'id_type': '1', 'type': '1'},
    {'id_type': '2', 'type': '2'},
    {'id_type': '3', 'type': '3'},
    {'id_type': '4', 'type': '4'},
  ];
  final List<Map> _Trees = [
    {'id_type': '0', 'type': 'الكل'},
    {'id_type': '100', 'type': 'أقل من 100 أشجار'},
    {'id_type': '200', 'type': 'أقل من 200 أشجار'},
    {'id_type': '500', 'type': 'أقل من 500 أشجار'},
    {'id_type': '1000', 'type': 'أقل من 1000 أشجار'},
    {'id_type': '2000', 'type': 'أقل من 2000 أشجار'},
    {'id_type': '5000', 'type': 'أقل من 5000 أشجار'},
    {'id_type': '10000', 'type': 'أقل من 10000 أشجار'},
  ];
  final List<Map> _EnTrees = [
    {'id_type': '0', 'type': 'All'},
    {'id_type': '100', 'type': 'Less than 100 trees'},
    {'id_type': '200', 'type': 'Less than 200 trees'},
    {'id_type': '500', 'type': 'Less than 500 trees'},
    {'id_type': '1000', 'type': 'Less than 1000 trees'},
    {'id_type': '2000', 'type': 'Less than 2000 trees'},
    {'id_type': '5000', 'type': 'Less than 5000 trees'},
    {'id_type': '10000', 'type': 'Less than 10000 trees'},
  ];
  final List<Map> _Wells = [
    {'id_type': '0', 'type': 'الكل'},
    {'id_type': '1', 'type': '1'},
    {'id_type': '2', 'type': '2'},
    {'id_type': '3', 'type': '3'},
    {'id_type': '4', 'type': '4'},
    {'id_type': '5', 'type': '5'},
    {'id_type': '6', 'type': '6'},
    {'id_type': '7', 'type': '7'},
    {'id_type': '8', 'type': '8'},
    {'id_type': '9', 'type': '9'},
    {'id_type': '10', 'type': '10'},
  ];
  final List<Map> _EnWells = [
    {'id_type': '0', 'type': 'All'},
    {'id_type': '1', 'type': '1'},
    {'id_type': '2', 'type': '2'},
    {'id_type': '3', 'type': '3'},
    {'id_type': '4', 'type': '4'},
    {'id_type': '5', 'type': '5'},
    {'id_type': '6', 'type': '6'},
    {'id_type': '7', 'type': '7'},
    {'id_type': '8', 'type': '8'},
    {'id_type': '9', 'type': '9'},
    {'id_type': '10', 'type': '10'},
  ];
  final List<Map> _Floor = [
    {'id_type': '0', 'type': 'الكل'},
    {'id_type': '1', 'type': 'دور أرضي'},
    {'id_type': '2', 'type': 'دور علوي'},
    {'id_type': '3', 'type': '3'},
    {'id_type': '4', 'type': '4'},
    {'id_type': '5', 'type': '5'},
    {'id_type': '6', 'type': '6'},
    {'id_type': '7', 'type': '7'},
    {'id_type': '8', 'type': '8'},
    {'id_type': '9', 'type': '9'},
    {'id_type': '10', 'type': '10'},
    {'id_type': '11', 'type': '11'},
    {'id_type': '12', 'type': '12'},
    {'id_type': '13', 'type': '13'},
    {'id_type': '14', 'type': '14'},
    {'id_type': '15', 'type': '15'},
  ];
  final List<Map> _EnFloor = [
    {'id_type': '0', 'type': 'All'},
    {'id_type': '1', 'type': 'Ground Floor'},
    {'id_type': '2', 'type': 'Upstairs'},
    {'id_type': '3', 'type': '3'},
    {'id_type': '4', 'type': '4'},
    {'id_type': '5', 'type': '5'},
    {'id_type': '6', 'type': '6'},
    {'id_type': '7', 'type': '7'},
    {'id_type': '8', 'type': '8'},
    {'id_type': '9', 'type': '9'},
    {'id_type': '10', 'type': '10'},
    {'id_type': '11', 'type': '11'},
    {'id_type': '12', 'type': '12'},
    {'id_type': '13', 'type': '13'},
    {'id_type': '14', 'type': '14'},
    {'id_type': '15', 'type': '15'},
  ];
  /// End Mutual Variables with Search Drawer


  /// Start Mutual Functions with Search Drawer
  void setSelectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void setMinPriceSearchDrawer(String value) {
    _minPriceSearchDrawer = value;
    notifyListeners();
  }

  void setMaxPriceSearchDrawer(String value) {
    _maxPriceSearchDrawer = value;
    notifyListeners();
  }

  void setTypeAqarSearchDrawer(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _typeAqarSearchDrawer.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _typeAqarSearchDrawer[buttonIndex] = true;
        _selectedTypeAqarSearchDrawer = (buttonIndex + 1).toString();
      } else {
        _typeAqarSearchDrawer[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void setInterfaceSelectedSearchDrawer(String newValue) {
    _interfaceSelectedSearchDrawer = newValue;
    notifyListeners();
  }

  void setStreetWidthSelectedSearchDrawer(String newValue) {
    _streetWidthSelectedSearchDrawer = newValue;
    notifyListeners();
  }

  void setAgeOfRealEstateSelectedSearchDrawer(String newValue) {
    _ageOfRealEstateSelectedSearchDrawer = newValue;
    notifyListeners();
  }

  void setRoomsSearchDrawer(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _roomsSearchDrawer.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _roomsSearchDrawer[buttonIndex] = true;
        _selectedRoomsSearchDrawer = (buttonIndex + 1).toString();
      } else {
        _roomsSearchDrawer[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void setLoungesSearchDrawer(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _loungesSearchDrawer.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _loungesSearchDrawer[buttonIndex] = true;
        _selectedLoungesSearchDrawer = (buttonIndex + 1).toString();
      } else {
        _loungesSearchDrawer[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void setToiletsSearchDrawer(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _toiletsSearchDrawer.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _toiletsSearchDrawer[buttonIndex] = true;
        _selectedToiletsSearchDrawer = (buttonIndex + 1).toString();
      } else {
        _toiletsSearchDrawer[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void setPlanSearchDrawer(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _planSearchDrawer.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _planSearchDrawer[buttonIndex] = true;
        _selectedPlanSearchDrawer = (buttonIndex + 1).toString();
      } else {
        _planSearchDrawer[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void setStoresSearchDrawer(String newValue) {
    _storesSelectedSearchDrawer = newValue;
    notifyListeners();
  }

  void setFloorSearchDrawer(String newValue) {
    _floorSelectedSearchDrawer = newValue;
    notifyListeners();
  }

  void setTreesSearchDrawer(String newValue) {
    _treesSelectedSearchDrawer = newValue;
    notifyListeners();
  }

  void setWellsSearchDrawer(String newValue) {
    _wellsSelectedSearchDrawer = newValue;
    notifyListeners();
  }

  void setFamilyTypeSearchDrawer(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _familyTypeSearchDrawer.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _familyTypeSearchDrawer[buttonIndex] = true;
        _selectedFamilyTypeSearchDrawer = (buttonIndex + 1).toString();
        if (_familyTypeSearchDrawer[0] == true) {
          _bool_feature17SearchDrawer = true;
        }
      } else {
        _familyTypeSearchDrawer[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  void setbool_feature1SearchDrawer(bool val) {
    _bool_feature1SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature2SearchDrawer(bool val) {
    _bool_feature2SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature3SearchDrawer(bool val) {
    _bool_feature3SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature4SearchDrawer(bool val) {
    _bool_feature4SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature5SearchDrawer(bool val) {
    _bool_feature5SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature6SearchDrawer(bool val) {
    _bool_feature6SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature7SearchDrawer(bool val) {
    _bool_feature7SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature8SearchDrawer(bool val) {
    _bool_feature8SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature9SearchDrawer(bool val) {
    _bool_feature9SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature10SearchDrawer(bool val) {
    _bool_feature10SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature11SearchDrawer(bool val) {
    _bool_feature11SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature12SearchDrawer(bool val) {
    _bool_feature12SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature13SearchDrawer(bool val) {
    _bool_feature13SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature14SearchDrawer(bool val) {
    _bool_feature14SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature15SearchDrawer(bool val) {
    _bool_feature15SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature16SearchDrawer(bool val) {
    _bool_feature16SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature17SearchDrawer(bool val) {
    _bool_feature17SearchDrawer = val;
    notifyListeners();
  }

  void setbool_feature18SearchDrawer(bool val) {
    _bool_feature18SearchDrawer = val;
    notifyListeners();
  }

  void setIsTwoWeekSearchDrawer(bool val) {
    _isTwoWeeksAgoSearchDrawer = val;
    notifyListeners();
  }

  void setMaxSpaceSearchDrawer(String value) {
    _maxSpaceSearchDrawer = value;
    notifyListeners();
  }

  void setMinSpaceSearchDrawer(String value) {
    _minSpaceSearchDrawer = value;
    notifyListeners();
  }

  void setApartmentsSearchDrawer(int index) {
    for (var buttonIndex = 0;
    buttonIndex < _apartmentsSearchDrawer.length;
    buttonIndex++) {
      if (buttonIndex == index) {
        _apartmentsSearchDrawer[buttonIndex] = true;
        _selectedApartmentsSearchDrawer = (buttonIndex + 1).toString();
      } else {
        _apartmentsSearchDrawer[buttonIndex] = false;
      }
    }
    notifyListeners();
  }
  /// End Mutual Functions with Search Drawer




  // to spicifice ads on area
  void setSelectedArea(CameraPosition val){
    _selectedArea = val;
    // notifyListeners();
  }

  void setMenuMainFilterAds(int val) {
    _menuMainFilterAds = val;
    //notifyListeners();
  }

  void removeMarkers(){
    if(_Ads.isNotEmpty){
      _Ads.forEach((element) {
        if(element.entry != null){
          try{
            element.entry.remove();
            element.entry = null;
            element.key = null;
          }catch(e){
            print('Overlay entry remove error: $e');
          }
        }
      });
      _markersMainPage.clear();
    }
  }

  void setScrollListener(){
    _menuController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_menuController.offset >= _menuController.position.maxScrollExtent && !_menuController.position.outOfRange) {
      if(_expendedMenuListCount < countMenuAds() - 21){
        _expendedMenuListCount += 20;
        notifyListeners();
      }else{
        _expendedMenuListCount = countMenuAds();
        notifyListeners();
      }
    }
  }

  void setExpendedMenuListCount(int val){
    _expendedMenuListCount = val;
    notifyListeners();
  }

  void clearExpendedMenuListCount(){
    _expendedMenuListCount = 20;
  }

  int countAds() {
    if (_Ads.isNotEmpty) {
      return _Ads.length;
    } else {
      return 0;
    }
  }

  void setFilterSearchDrawer(int value) {
    _filterSearchDrawer = value;
    //notifyListeners();
  }

  void setMapControllerMainPage(GoogleMapController val) {
    _mapControllerMainPAge = val;
    notifyListeners();
  }

  void setIdCategorySearch(String val) {
    _idCategorySearch = val;
    // notifyListeners();
  }

  void setInItMainPageDone(int val) {
    _inItMainPageDone= val;
    // notifyListeners();
  }

  void setShowDiogFalse() {
    _showDiaogSearchDrawer = false;
    notifyListeners();
  }

  void setShowDiogTrue() {
    _showDiaogSearchDrawer = true;
    notifyListeners();
  }

  void setSliderState(int val) {
    _slider_state = val;
    notifyListeners();
  }

  void setRegionPosition(CameraPosition val) {
    _region_position = val;
    //notifyListeners();
  }

  // void updateInfoWindow(BuildContext context, GoogleMapController controller, LatLng location, double infoWindowWidth, double markerOffset) async {
  //   var screenCoordinate = await controller.getScreenCoordinate(location);
  //   var devicePixelRatio =
  //   Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
  //   var left = (screenCoordinate.x.toDouble() / devicePixelRatio) -
  //       (infoWindowWidth / 2);
  //   var top = (screenCoordinate.y.toDouble() / devicePixelRatio) - markerOffset;
  //   if (left < 0 || top < 0) {
  //     leftMargin = left;
  //     topMargin = top;
  //   } else {
  //     leftMargin = left;
  //     topMargin = top;
  //   }
  // }

  Marker mapBitmapsToMarkersMainPage(BuildContext context, Uint8List bmp, AdsModel ad) {
    return Marker(
        markerId: MarkerId(' ${ad.price}'),
        position: LatLng(double.tryParse(ad.lat)??26.0, double.tryParse(ad.lng)??46.0),
        onTap: () {
          print(context);
          Provider.of<CacheMarkerModel>(context, listen: false).updateCache(context, ad.idDescription);
          setShowDiogTrue();
          _SelectedAdsModelMainPage = ad;
          // _SelectedAdsModelMainPage.lat != null ||
          //     _SelectedAdsModelMainPage.lng != null
          //     ?
          // updateInfoWindow(
          //     context,
          //     _mapControllerMainPAge,
          //     LatLng(double.parse(_SelectedAdsModelMainPage.lat),
          //         double.parse(_SelectedAdsModelMainPage.lng)),
          //     250,
          //     170)
          //     : print('');
          getUpdatedMarkerState2(context, ad);
        },
        icon: BitmapDescriptor.fromBytes(bmp));
  }

  void getUpdatedMarkerState2(BuildContext context, AdsModel ad){
    var key = GlobalKey();
    if(ad.entry != null){
      ad.entry.remove();
      ad.key = null;
      ad.entry = null;
      OverlayEntry newEntry;
      ad.key = key;
      newEntry = OverlayEntry(
          builder: (ctxt) {
            return _MarkerHelper(
              markerWidgets: markerWidgets(ctxt, ad),
              callback: (bitmaps) {
                _markersMainPage.add(mapBitmapsToMarkersMainPage(ctxt, bitmaps, ad));
              },
              markerKey: ad.key,
            );
          },
          maintainState: true);
      var overlayState = Overlay.of(context);
      overlayState.insert(newEntry);
      ad.entry = newEntry;
    }
  }

  void spicificAreaAds2(BuildContext context){

    if(_Ads.isNotEmpty){
      if(_markersMainPage.isNotEmpty){
        _markersMainPage.clear();
      }
      _Ads.forEach((element) {
        if(calculateArea(double.tryParse(element.lat) ?? 0.0, double.tryParse(element.lng) ?? 0.0, _selectedArea)){
          _adsOnMap++;
          element.key = GlobalKey();
          element.entry = OverlayEntry(
              builder: (ctxt) {
                return _MarkerHelper(
                  markerWidgets: markerWidgets(ctxt, element),
                  callback: (bitmaps) {
                    _markersMainPage.add(mapBitmapsToMarkersMainPage(ctxt, bitmaps, element));
                    Future.delayed(Duration(seconds: 1), () {
                      notifyListeners();
                    });
                  },
                  markerKey: element.key,
                );
              },
              maintainState: true);
          MarkerGenerator(element.entry).generate(context);
        }
      });
      Future.delayed(Duration(seconds: 4), () {
        if(_markersMainPage.isEmpty){
          _adsOnMap = 0;
          notifyListeners();
          removeMarkers();
          // Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(1);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Regions()));
        }
      });
    }
  }

  void clearAdsOnMap(){
    _adsOnMap = 1;
  }

  void setMoveState(bool val){
    _isMove = val;
  }

  Widget markerWidgets(BuildContext context, AdsModel c) {
    return Provider.of<LocaleProvider>(context, listen: false).locale.toString() != 'en_US'
        ?
    c.idSpecial == '1'
        ?
    getMarkerSpecialWidget(' ${arNumberFormat(int.parse(c.price))} ')
        :
    Provider.of<CacheMarkerModel>(context, listen: false).getCache(context, c.idDescription) == c.idDescription
        ?
    getMarkerViewedWidget(' ${arNumberFormat(int.parse(c.price))} ')
        :
    getMarkerWidget(' ${arNumberFormat(int.parse(c.price))} ')
        :
    c.idSpecial == '1'
        ?
    getMarkerSpecialWidget(' ${numberFormat(int.parse(c.price))} ')
        :
    Provider.of<CacheMarkerModel>(context, listen: false).getCache(context, c.idDescription) == c.idDescription
        ?
    getMarkerViewedWidget(' ${numberFormat(int.parse(c.price))} ')
        :
    getMarkerWidget(' ${numberFormat(int.parse(c.price))} ') ?? [];
  }

  bool calculateArea(double lat, double lng, CameraPosition selectedArea){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat - selectedArea.target.latitude) * p)/2 + c(selectedArea.target.latitude * p) * c(lat * p) * (1 - c((lng - selectedArea.target.longitude) * p))/2;
    var calculateDistance = 12742 * asin(sqrt(a));
    if(calculateDistance < (21.0 - selectedArea.zoom)){
      return true;
    }else{
      return false;
    }
  }

  Widget getMarkerWidget(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff00cccc), width: 1),
          color: const Color(0xff00cccc),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            name,
            style: CustomTextStyle(

              fontSize: 18,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget getMarkerSpecialWidget(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffe6b800), width: 1),
          color: const Color(0xffe6b800),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            name,
            style: CustomTextStyle(

              fontSize: 18,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget getMarkerViewedWidget(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff989696), width: 1),
          color: const Color(0xff989696),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            name,
            style: CustomTextStyle(

              fontSize: 18,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String numberFormat(int n) {
    var num = n.toString();
    var len = num.length;
    if (n >= 1000 && n < 1000000) {
      return num.substring(0, len - 3) +
          '.' +
          num.substring(len - 3, 1 + (len - 3)) +
          'K';
    } else if (n >= 1000000 && n < 1000000000) {
      return num.substring(0, len - 6) +
          '.' +
          num.substring(len - 6, 1 + (len - 6)) +
          'M';
    } else if (n > 1000000000) {
      return num.substring(0, len - 9) +
          '.' +
          num.substring(len - 9, 1 + (len - 9)) +
          'G';
    } else {
      return num.toString();
    }
  }

  String arNumberFormat(int n) {
    var num = n.toString();
    var len = num.length;
    if (n >= 1000 && n < 1000000) {
      return num.substring(0, len - 3) +
          '.' +
          num.substring(len - 3, 1 + (len - 3)) +
          ' ألف ';
    } else if (n >= 1000000 && n < 1000000000) {
      return num.substring(0, len - 6) +
          '.' +
          num.substring(len - 6, 1 + (len - 6)) +
          ' مليون ';
    } else if (n > 1000000000) {
      return num.substring(0, len - 9) +
          '.' +
          num.substring(len - 9, 1 + (len - 9)) +
          ' مليار ';
    } else {
      return num.toString();
    }
  }



  void getAdsList(
      BuildContext context,
      String sliderCategory,
      String category,
      String min_price,
      String max_price,
      String min_space,
      String max_space,
      String type_aqar,
      String interface,
      String plan,
      String age_of_real_estate,
      String apartements,
      String floor,
      String lounges,
      String rooms,
      String stores,
      String street_width,
      String toilets,
      String trees,
      String wells,
      String bool_feature1,
      String bool_feature2,
      String bool_feature3,
      String bool_feature4,
      String bool_feature5,
      String bool_feature6,
      String bool_feature7,
      String bool_feature8,
      String bool_feature9,
      String bool_feature10,
      String bool_feature11,
      String bool_feature12,
      String bool_feature13,
      String bool_feature14,
      String bool_feature15,
      String bool_feature16,
      String bool_feature17,
      String bool_feature18) {
    // ...... basic array ........
    if (_filter == null) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (_Ads.isNotEmpty) {
          _Ads.forEach((element){
            if(element.entry != null){
              try{
                element.entry.remove();
                element.key = null;
              }catch(e){
                print('entry.remove 1 : $e');
              }
            }
          });
          _Ads.clear();
        }
        Api().getadsFunc(context).then((value) {
          _AdsData = value;
          _AdsData.forEach((element) {
            _Ads.add(AdsModel.ads(element));
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    } // ...... left slider category array ........
    else if (_filter == 1) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (_Ads.isNotEmpty) {
          _Ads.forEach((element){
            if(element.entry != null){
              try{
                element.entry.remove();
                element.key = null;
              }catch(e){
                print('entry.remove 2 : $e');
              }
            }
          });
          _Ads.clear();
        }
        Api()
            .getFilterAdsFunc(context, sliderCategory)
            .then((value) {
          _AdsData = value;
          _AdsData.forEach((element) {
            _Ads.add(AdsModel.ads(element));
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    } // ...... two weeks ago array ........
    else if (_filter == 2) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (_Ads.isNotEmpty) {
          _Ads.forEach((element){
            if(element.entry != null){
              try{
                element.entry.remove();
                element.key = null;
              }catch(e){
                print('entry.remove 3 : $e');
              }
            }
          });
          _Ads.clear();
        }
        Api().getFilterTwoWeeksAgoFunc(context).then((value) {
          _AdsData = value;
          _AdsData.forEach((element) {
            _Ads.add(AdsModel.ads(element));
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    }
    else if (_filter == 4) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (_Ads.isNotEmpty) {
          _Ads.forEach((element){
            if(element.entry != null){
              try{
                element.entry.remove();
                element.key = null;
              }catch(e){
                print('entry.remove 4 : $e');
              }
            }
          });
          _Ads.clear();
        }
        Api()
            .getAdvancedSearchFunc(
            context,
            category,
            min_price,
            max_price,
            min_space,
            max_space,
            type_aqar,
            interface,
            plan,
            age_of_real_estate,
            apartements,
            floor,
            lounges,
            rooms,
            stores,
            street_width,
            toilets,
            trees,
            wells,
            bool_feature1,
            bool_feature2,
            bool_feature3,
            bool_feature4,
            bool_feature5,
            bool_feature6,
            bool_feature7,
            bool_feature8,
            bool_feature9,
            bool_feature10,
            bool_feature11,
            bool_feature12,
            bool_feature13,
            bool_feature14,
            bool_feature15,
            bool_feature16,
            bool_feature17,
            bool_feature18)
            .then((value) {
          _AdsData = value;
          _AdsData.forEach((element) {
            _Ads.add(AdsModel.ads(element));
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    }
  }

  void getAdsInfo(
      BuildContext context,
      String id_category,
      String selectedCategory,
      String minPriceSearchDrawer,
      String maxPriceSearchDrawer,
      String minSpaceSearchDrawer,
      String maxSpaceSearchDrawer,
      String selectedTypeAqarSearchDrawer,
      String interfaceSelectedSearchDrawer,
      String selectedPlanSearchDrawer,
      String ageOfRealEstateSelectedSearchDrawer,
      String selectedApartmentsSearchDrawer,
      String floorSelectedSearchDrawer,
      String selectedLoungesSearchDrawer,
      String selectedRoomsSearchDrawer,
      String storesSelectedSearchDrawer,
      String streetWidthSelectedSearchDrawer,
      String selectedToiletsSearchDrawer,
      String treesSelectedSearchDrawer,
      String wellsSelectedSearchDrawer,
      String bool_feature1SearchDrawer,
      String bool_feature2SearchDrawer,
      String bool_feature3SearchDrawer,
      String bool_feature4SearchDrawer,
      String bool_feature5SearchDrawer,
      String bool_feature6SearchDrawer,
      String bool_feature7SearchDrawer,
      String bool_feature8SearchDrawer,
      String bool_feature9SearchDrawer,
      String bool_feature10SearchDrawer,
      String bool_feature11SearchDrawer,
      String bool_feature12SearchDrawer,
      String bool_feature13SearchDrawer,
      String bool_feature14SearchDrawer,
      String bool_feature15SearchDrawer,
      String bool_feature16SearchDrawer,
      String bool_feature17SearchDrawer,
      String bool_feature18SearchDrawer,
      {bool showOnMap = false}
      ) async {
    if(_menuMainFilterAds == 1) {
      _waitMenu = true;
      if (_filterSearchDrawer == null) {
        clearMenuFilter(context);
        getMenuList(
            context,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null);
        Future.delayed(Duration(seconds: 0), () {
          _waitMenu = false;
        });

      } // basic filter .................

      else if (_filterSearchDrawer == 2) {
        setMenuFilter(context, 2);
        getMenuList(
            context,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null);
        Future.delayed(Duration(seconds: 0), () {
          _waitMenu = false;
        });

      } // 2 weeks ago filter .................

      else if (_filterSearchDrawer == 4) {
        setMenuFilter(context, 4);
        getMenuList(
            context,
            null,
            selectedCategory,
            minPriceSearchDrawer,
            maxPriceSearchDrawer,
            minSpaceSearchDrawer,
            maxSpaceSearchDrawer,
            selectedTypeAqarSearchDrawer,
            interfaceSelectedSearchDrawer,
            selectedPlanSearchDrawer,
            ageOfRealEstateSelectedSearchDrawer,
            selectedApartmentsSearchDrawer,
            floorSelectedSearchDrawer,
            selectedLoungesSearchDrawer,
            selectedRoomsSearchDrawer,
            storesSelectedSearchDrawer,
            streetWidthSelectedSearchDrawer,
            selectedToiletsSearchDrawer,
            treesSelectedSearchDrawer,
            wellsSelectedSearchDrawer,
            bool_feature1SearchDrawer,
            bool_feature2SearchDrawer,
            bool_feature3SearchDrawer,
            bool_feature4SearchDrawer,
            bool_feature5SearchDrawer,
            bool_feature6SearchDrawer,
            bool_feature7SearchDrawer,
            bool_feature8SearchDrawer,
            bool_feature9SearchDrawer,
            bool_feature10SearchDrawer,
            bool_feature11SearchDrawer,
            bool_feature12SearchDrawer,
            bool_feature13SearchDrawer,
            bool_feature14SearchDrawer,
            bool_feature15SearchDrawer,
            bool_feature16SearchDrawer,
            bool_feature17SearchDrawer,
            bool_feature18SearchDrawer);

        Future.delayed(Duration(seconds: 0), () {
          _waitMenu = false;
        });
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

      }
      // advanced search filter .................

    }
    else if(_menuMainFilterAds == 2) {
      _waitMainPage = true;

      if (_filterSearchDrawer == null) {
        _markersMainPage.clear();
        clearFilter(context);
        getAdsList(
            context,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null);
        if (ads.isNotEmpty) {
          Future.delayed(Duration(seconds: 1), () {
            _waitMainPage = false;
            // notifyListeners();
          });
        }
      } // basic filter .................
      else if (_filterSearchDrawer == 1) {
        _markersMainPage.clear();
        setFilter(context, 1);
        getAdsList(
            context,
            id_category,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null);
        if (ads.isNotEmpty) {
          Future.delayed(Duration(seconds: 1), () {
            _waitMainPage = false;
            // }
            // notifyListeners();
          });
        }
      } // left slider category filter .................

      else if (_filterSearchDrawer == 2) {
        _markersMainPage.clear();

        setFilter(context, 2);

        getAdsList(
            context,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null);
        if (ads.isNotEmpty) {
          Future.delayed(Duration(seconds: 1), () {
            _waitMainPage = false;
            // }
            // notifyListeners();
          });
        }

      } // 2 weeks ago filter .................

      else if (_filterSearchDrawer == 4) {
        _markersMainPage.clear();

        setFilter(context, 4);

        getAdsList(
            context,
            null,
            selectedCategory,
            minPriceSearchDrawer,
            maxPriceSearchDrawer,
            minSpaceSearchDrawer,
            maxSpaceSearchDrawer,
            selectedTypeAqarSearchDrawer,
            interfaceSelectedSearchDrawer,
            selectedPlanSearchDrawer,
            ageOfRealEstateSelectedSearchDrawer,
            selectedApartmentsSearchDrawer,
            floorSelectedSearchDrawer,
            selectedLoungesSearchDrawer,
            selectedRoomsSearchDrawer,
            storesSelectedSearchDrawer,
            streetWidthSelectedSearchDrawer,
            selectedToiletsSearchDrawer,
            treesSelectedSearchDrawer,
            wellsSelectedSearchDrawer,
            bool_feature1SearchDrawer,
            bool_feature2SearchDrawer,
            bool_feature3SearchDrawer,
            bool_feature4SearchDrawer,
            bool_feature5SearchDrawer,
            bool_feature6SearchDrawer,
            bool_feature7SearchDrawer,
            bool_feature8SearchDrawer,
            bool_feature9SearchDrawer,
            bool_feature10SearchDrawer,
            bool_feature11SearchDrawer,
            bool_feature12SearchDrawer,
            bool_feature13SearchDrawer,
            bool_feature14SearchDrawer,
            bool_feature15SearchDrawer,
            bool_feature16SearchDrawer,
            bool_feature18SearchDrawer,
            bool_feature18SearchDrawer);

        Future.delayed(Duration(seconds: 0), () {
          _waitMainPage = false;
        });

        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        if (ads.isNotEmpty) {
          Future.delayed(Duration(seconds: 1), () {
          });
        }

      }
      // advanced search filter .................

    }

  }

  void setFilter(BuildContext context, int assignedFilter) {
    _filter = assignedFilter;
  }

  void clearFilter(BuildContext context) {
    _filter = null;
  }

  void clearMenuFilter(BuildContext context) {
    _menuFilter = null;
  }

  void setMenuFilter(BuildContext context, int assignedMenuFilter) {
    _menuFilter = assignedMenuFilter;
  }

  void getMenuList(
      BuildContext context,
      String sliderCategory,
      String category,
      String min_price,
      String max_price,
      String min_space,
      String max_space,
      String type_aqar,
      String interface,
      String plan,
      String age_of_real_estate,
      String apartements,
      String floor,
      String lounges,
      String rooms,
      String stores,
      String street_width,
      String toilets,
      String trees,
      String wells,
      String bool_feature1,
      String bool_feature2,
      String bool_feature3,
      String bool_feature4,
      String bool_feature5,
      String bool_feature6,
      String bool_feature7,
      String bool_feature8,
      String bool_feature9,
      String bool_feature10,
      String bool_feature11,
      String bool_feature12,
      String bool_feature13,
      String bool_feature14,
      String bool_feature15,
      String bool_feature16,
      String bool_feature17,
      String bool_feature18) {
    // ...... basic array & latest menu ads array ........
    if (_menuFilter == null) {
      Future.delayed(Duration(milliseconds: 0), () {
        _MenuAds.clear();
        Api().filterUpToDateAdsFunc(context).then((value) {
          _MenuAdsData = value;
          _MenuAdsData.forEach((element) {
            _MenuAds.add(AdsModel.ads(element));
          });
          notifyListeners();
        });
      });
    }
    // ...... two weeks ago menu array ........
    else if (_menuFilter == 2) {
      Future.delayed(Duration(milliseconds: 0), () {
        _MenuAds.clear();
        Api().getFilterTwoWeeksAgoFunc(context).then((value) {
          _MenuAdsData = value;
          _MenuAdsData.forEach((element) {
            _MenuAds.add(AdsModel.ads(element));
          });
          notifyListeners();
        });
      });
    }
    // ...... advanced menu search array ........
    else if (_menuFilter == 4) {
      Future.delayed(Duration(milliseconds: 0), () {
        _MenuAds.clear();
        Api()
            .getAdvancedSearchFunc(
            context,
            category,
            min_price,
            max_price,
            min_space,
            max_space,
            type_aqar,
            interface,
            plan,
            age_of_real_estate,
            apartements,
            floor,
            lounges,
            rooms,
            stores,
            street_width,
            toilets,
            trees,
            wells,
            bool_feature1,
            bool_feature2,
            bool_feature3,
            bool_feature4,
            bool_feature5,
            bool_feature6,
            bool_feature7,
            bool_feature8,
            bool_feature9,
            bool_feature10,
            bool_feature11,
            bool_feature12,
            bool_feature13,
            bool_feature14,
            bool_feature15,
            bool_feature16,
            bool_feature17,
            bool_feature18)
            .then((value) {
          _MenuAdsData = value;
          _MenuAdsData.forEach((element) {
            _MenuAds.add(AdsModel.ads(element));
          });
          notifyListeners();
        });
      });
    }
  }

  int countMenuAds() {
    if (_MenuAds.isNotEmpty) {
      return _MenuAds.length;
    } else {
      return 0;
    }
  }




  GoogleMapController get mapControllerMainPAge => _mapControllerMainPAge;
  String get idCategorySearch => _idCategorySearch;
  int get inItMainPageDone => _inItMainPageDone;
  bool get showDiaogSearchDrawer => _showDiaogSearchDrawer;
  int get slider_state => _slider_state;
  AdsModel get SelectedAdsModelMainPage => _SelectedAdsModelMainPage;
  List<Marker> get markersMainPage => _markersMainPage;
  int get adsOnMap => _adsOnMap;
  bool get isMove => _isMove;
  int get filterSearch => _filter;
  List<AdsModel> get ads => _Ads;
  int get menuMainFilterAds => _menuMainFilterAds;
  int get filterSearchDrawer => _filterSearchDrawer;
  bool get waitMainPage => _waitMainPage;
  bool get waitMenu => _waitMenu;
  int get menuFilterSearch => _menuFilter;
  List<AdsModel> get menuAds => _MenuAds;
// Menu Controller to listen when list reach end of list
  ScrollController get menuController => _menuController;
  int get expendedMenuListCount => _expendedMenuListCount;

  CameraPosition get region_position => _region_position;
  List<Map> get categories => _categoriesFun();
  List<Map> get enCategories => _enCategoriesFun();


  /// Start Mutual get with Search Drawer
  String get selectedCategory => _selectedCategory;
  String get minPriceSearchDrawer => _minPriceSearchDrawer;
  String get maxSpaceSearchDrawer => _maxSpaceSearchDrawer;
  String get minSpaceSearchDrawer => _minSpaceSearchDrawer;
  String get selectedLoungesSearchDrawer => _selectedLoungesSearchDrawer;
  String get selectedToiletsSearchDrawer => _selectedToiletsSearchDrawer;
  String get selectedRoomsSearchDrawer => _selectedRoomsSearchDrawer;
  String get selectedApartmentsSearchDrawer => _selectedApartmentsSearchDrawer;
  String get selectedPlanSearchDrawer => _selectedPlanSearchDrawer;
  String get storesSelectedSearchDrawer => _storesSelectedSearchDrawer;
  String get floorSelectedSearchDrawer => _floorSelectedSearchDrawer;
  String get selectedFamilyTypeSearchDrawer => _selectedFamilyTypeSearchDrawer;
  String get treesSelectedSearchDrawer => _treesSelectedSearchDrawer;
  String get wellsSelectedSearchDrawer => _wellsSelectedSearchDrawer;
  bool get isTwoWeeksAgoSearchDrawer => _isTwoWeeksAgoSearchDrawer;
  bool get bool_feature1SearchDrawer => _bool_feature1SearchDrawer;
  bool get bool_feature2SearchDrawer => _bool_feature2SearchDrawer;
  bool get bool_feature3SearchDrawer => _bool_feature3SearchDrawer;
  bool get bool_feature4SearchDrawer => _bool_feature4SearchDrawer;
  bool get bool_feature5SearchDrawer => _bool_feature5SearchDrawer;
  bool get bool_feature6SearchDrawer => _bool_feature6SearchDrawer;
  bool get bool_feature7SearchDrawer => _bool_feature7SearchDrawer;
  bool get bool_feature8SearchDrawer => _bool_feature8SearchDrawer;
  bool get bool_feature9SearchDrawer => _bool_feature9SearchDrawer;
  bool get bool_feature10SearchDrawer => _bool_feature10SearchDrawer;
  bool get bool_feature11SearchDrawer => _bool_feature11SearchDrawer;
  bool get bool_feature12SearchDrawer => _bool_feature12SearchDrawer;
  bool get bool_feature13SearchDrawer => _bool_feature13SearchDrawer;
  bool get bool_feature14SearchDrawer => _bool_feature14SearchDrawer;
  bool get bool_feature15SearchDrawer => _bool_feature15SearchDrawer;
  bool get bool_feature16SearchDrawer => _bool_feature16SearchDrawer;
  bool get bool_feature17SearchDrawer => _bool_feature17SearchDrawer;
  bool get bool_feature18SearchDrawer => _bool_feature18SearchDrawer;
  List<bool> get planSearchDrawer => _planSearchDrawer;
  List<bool> get loungesSearchDrawer => _loungesSearchDrawer;
  List<bool> get toiletsSearchDrawer => _toiletsSearchDrawer;
  List<bool> get roomsSearchDrawer => _roomsSearchDrawer;
  List<bool> get apartmentsSearchDrawer => _apartmentsSearchDrawer;
  List<bool> get familyTypeSearchDrawer => _familyTypeSearchDrawer;
  String get maxPriceSearchDrawer => _maxPriceSearchDrawer;
  String get selectedTypeAqarSearchDrawer => _selectedTypeAqarSearchDrawer;
  String get interfaceSelectedSearchDrawer => _interfaceSelectedSearchDrawer;
  String get streetWidthSelectedSearchDrawer => _streetWidthSelectedSearchDrawer;
  String get ageOfRealEstateSelectedSearchDrawer => _ageOfRealEstateSelectedSearchDrawer;
  List<bool> get typeAqarSearchDrawer => _typeAqarSearchDrawer;
  List<Map> get Interface => _Interface;
  List<Map> get EnInterface => _EnInterface;
  List<Map> get StreetWidth => _StreetWidth;
  List<Map> get EnStreetWidth => _EnStreetWidth;
  List<Map> get AgeOfRealEstate => _AgeOfRealEstate;
  List<Map> get EnAgeOfRealEstate => _EnAgeOfRealEstate;
  List<Map> get Stores => _Stores;
  List<Map> get EnStores => _EnStores;
  List<Map> get Trees => _Trees;
  List<Map> get EnTrees => _EnTrees;
  List<Map> get Wells => _Wells;
  List<Map> get EnWells => _EnWells;
  List<Map> get Floor => _Floor;
  List<Map> get EnFloor => _EnFloor;
  /// End Mutual get with Search Drawer
  ///
  /// End main page provider








  List<AdsModel> get adsSpecial => _AdsSpecial;
  List<AdsModel> get todayAds => _TodayAds;




  File get video => _video;


  List<AdsModel> get image => _image;
  bool get busy => _busy;
  int get number => _number;
  List<bool> get isSelected1 => _isSelected1;
  List<bool> get isSelected2 => _isSelected2;
  List<bool> get isSelected3 => _isSelected3;
  List<bool> get isSelected4 => _isSelected4;
  List<bool> get isSelected5 => _isSelected5;
  int get selectedNav1 => _selectedNav1;
  int get selectedNav2 => _selectedNav2;
  int get selectedNav3 => _selectedNav3;
  int get selectedNav4 => _selectedNav4;
  int get filterCity => _filterCity;
  File get imageAqarVR => _imageAqarVR;
  int get buttonClickedAqarVR => _buttonClickedAqarVR;
  String get identity_number => _identity_number;
  String get saq_number => _saq_number;
  String get identity_type => _identity_type;
  List<bool> get list_id_type => _list_id_type;
  List<AdsModel> get AdsUpdateLoc => _AdsUpdateLoc;
  Set<Marker> get markersUpdateLoc => _markersUpdateLoc;
  String get ads_city => _adss_city;
  String get ads_neighborhood => _adss_neighborhood;
  String get ads_road => _adss_road;
  LatLng get ads_cordinates => _adss_cordinates;
  double get ads_cordinates_lat => _adss_cordinates_lat;
  double get ads_cordinates_lng => _adss_cordinates_lng;
  int get currentControllerPageImgVedUpdate =>
      _currentControllerPageImgVedUpdate;
  PageController get controllerImgVedUpdate => _controllerImgVedUpdate;
  List<File> get imagesListUpdate => _imagesListUpdate;
  VideoPlayerController get videoControllerUpdate => _videoControllerUpdate;
  File get videoUpdate => _videoUpdate;
  int get currentStageUpdateDetails => _currentStageUpdateDetails;
  List<CategoryModel> get categoryUpdate => _categoryUpdate;
  List<AdsModel> get adsUpdateDetails => _adsUpdateDetails;
  int get id_category_finalUpdate => _id_category_finalUpdate;
  String get category_finalUpdate => _category_finalUpdate;
  bool get AcceptedUpdate => _AcceptedUpdate;
  TextEditingController get priceControllerUpdate => _priceControllerUpdate;
  TextEditingController get spaceControllerUpdate => _spaceControllerUpdate;
  TextEditingController get meterPriceControllerUpdate =>
      _meterPriceControllerUpdate;
  TextEditingController get descControllerUpdate => _descControllerUpdate;
  int get meterPriceUpdate => _meterPriceUpdate;
  String get interfaceSelectedUpdate => _interfaceSelectedUpdate;





  bool get isFurnishedUpdate => _isFurnishedUpdate;
  bool get isKitchenUpdate => _isKitchenUpdate;
  bool get isAppendixUpdate => _isAppendixUpdate;
  bool get isCarEntranceUpdate => _isCarEntranceUpdate;
  bool get isElevatorUpdate => _isElevatorUpdate;
  bool get isConditionerUpdate => _isConditionerUpdate;
  bool get isHallStaircaseUpdate => _isHallStaircaseUpdate;
  bool get isDuplexUpdate => _isDuplexUpdate;
  bool get isDriverRoomUpdate => _isDriverRoomUpdate;
  bool get isSwimmingPoolUpdate => _isSwimmingPoolUpdate;
  bool get isMaidRoomUpdate => _isMaidRoomUpdate;
  bool get isMonstersUpdate => _isMonstersUpdate;
  bool get isVerseUpdate => _isVerseUpdate;
  bool get isCellarUpdate => _isCellarUpdate;
  bool get isFamilyPartitionUpdate => _isFamilyPartitionUpdate;
  bool get isAmusementParkUpdate => _isAmusementParkUpdate;
  bool get isVolleyballCourtUpdate => _isVolleyballCourtUpdate;
  bool get isFootballCourtUpdate => _isFootballCourtUpdate;
  double get LoungesUpdateUpdate => _LoungesUpdateUpdate;
  double get ToiletsUpdateUpdate => _ToiletsUpdateUpdate;
  double get RoomsUpdate => _RoomsUpdate;
  double get AgeOfRealEstateUpdate => _AgeOfRealEstateUpdate;
  double get ApartmentsUpdate => _ApartmentsUpdate;
  double get StoresUpdate => _StoresUpdate;
  double get WellsUpdate => _WellsUpdate;
  double get TreesUpdate => _TreesUpdate;
  double get FloorUpdate => _FloorUpdate;
  double get StreetWidthUpdate => _StreetWidthUpdate;
  String get totalPricUpdatee => _totalPricUpdatee;
  String get totalSpaceUpdate => _totalSpaceUpdate;
  String get detailsAqarUpdate => _detailsAqarUpdate;
  List<bool> get planUpdate => _planUpdate;
  int get selectedPlanUpdate => _selectedPlanUpdate;
  List<bool> get familyUpdate => _familyUpdate;
  int get selectedFamilyUpdate => _selectedFamilyUpdate;
  List<bool> get typeAqarUpdate => _typeAqarUpdate;
  int get selectedTypeAqarUpdate => _selectedTypeAqarUpdate;
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
  bool get isMonstersAddAds => _isMonstersAddAds;
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
  VideoPlayerController get videoControllerAdsPage => _videoControllerAdsPage;
  ChewieController get chewieControllerAddAds => _chewieControllerAddAds;
  ChewieController get chewieControllerAdsPage => _chewieControllerAdsPage;
  Future<void> get initializeFutureVideoPlyerAdsPage => _initializeFutureVideoPlyerAdsPage;
  File get videoAddAds => _videoAddAds;
  bool get busyAdsPage => _busyAdsPage;
  bool get waitAdsPage => _waitAdsPage;

  int get currentControllerPageAdsPage => _currentControllerPageAdsPage;
  PageController get controllerAdsPage => _controllerAdsPage;
  int get is_favAdsPage => _is_favAdsPage;


  String get search => _search;
  List<KeySearchModel> get key => _key;


  int get id_categorySearchDrawer => _id_categorySearchDrawer;
  String get currentLocationSearchDrawer => _currentLocationSearchDrawer;



  bool get isClickedSearchDrawer => _isClickedSearchDrawer;

  int get is_favAdsPageDB => _is_favAdsPageDB;




  /// handle camera posisition and zoom
  CameraPosition get currentCameraView => _currentCameraView;




  // List<bool> get isSelectedMenu => _isSelectedMenu;
  LocationData get currentPosition => _currentPosition;




  int get countAdsRiyadh => _countAdsRiyadh;
  int get countAdsMekkah => _countAdsMekkah;
  int get countAdsDammam => _countAdsDammam;
  int get countAdsRest => _countAdsRest;

  bool get wait => _wait;







// ScrollController get adPageHelperController => _adPageHelperController;
//int get idWait => _idWait;
}




class _MarkerHelper extends StatefulWidget {
  final Widget markerWidgets;
  final Function(Uint8List) callback;
  final GlobalKey markerKey;
  // ignore: sort_constructors_first
  const _MarkerHelper({Key key, this.markerWidgets, this.callback, @required this.markerKey})
      : super(key: key);
  @override
  _MarkerHelperState createState() => _MarkerHelperState();
}

class _MarkerHelperState extends State<_MarkerHelper> with AfterLayoutMixin {

  @override
  void afterFirstLayout(BuildContext context) async {
    widget.callback(await _getBitmaps(context));
  }


  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(MediaQuery.of(context).size.width, 0),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            RepaintBoundary(
              key: widget.markerKey,
              child: widget.markerWidgets,
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _getBitmaps(BuildContext context) async {
    var futures = _getUint8List(widget.markerKey);
    return futures;
  }

  Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary boundary =
    markerKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 2.0);
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}