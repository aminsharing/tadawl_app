import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/BFModel.dart';
import 'package:tadawl_app/models/CategoryModel.dart';
import 'package:tadawl_app/models/QFModel.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';

class UpdateDetailsProvider extends ChangeNotifier{
  final List<bool> _typeAqarUpdate = List.generate(3, (_) => false);
  final List<bool> _familyUpdate = List.generate(2, (_) => false);
  final List<bool> _planUpdate = List.generate(3, (_) => false);
  int _currentStageUpdateDetails;
  final List<CategoryModel> _categoryUpdate = [];
  String _category_finalUpdate;
  List _CategoryDataUpdate = [];
  int _id_category_finalUpdate;
  String _interfaceSelectedUpdate;
  bool _AcceptedUpdate = false;
  bool _isFurnishedUpdate;
  bool _isKitchenUpdate;
  bool _isAppendixUpdate;
  bool _isCarEntranceUpdate;
  bool _isElevatorUpdate;
  bool _isConditionerUpdate;
  bool _isHallStaircaseUpdate;
  bool _isDuplexUpdate;
  bool _isDriverRoomUpdate;
  bool _isSwimmingPoolUpdate;
  bool _isMaidRoomUpdate;
  bool _isYardUpdate;
  bool _isVerseUpdate;
  bool _isCellarUpdate;
  bool _isFamilyPartitionUpdate;
  bool _isAmusementParkUpdate;
  bool _isVolleyballCourtUpdate;
  bool _isFootballCourtUpdate;
  double _LoungesUpdateUpdate;
  double _ToiletsUpdateUpdate;
  double _RoomsUpdate;
  double _AgeOfRealEstateUpdate;
  double _ApartmentsUpdate;
  double _StoresUpdate;
  double _WellsUpdate;
  double _TreesUpdate;
  double _FloorUpdate;
  double _StreetWidthUpdate;
  int _selectedPlanUpdate = 0;
  int _selectedFamilyUpdate = 0;
  int _selectedTypeAqarUpdate = 0;


  void getAdsUpdateInfo(List<BFModel> _adsBF, List<QFModel> _adsQF, String _interface, String _idTypeAqar, String _plan) {
    _interfaceSelectedUpdate = _interfaceSelectedUpdate ?? _interface;
    
    _isYardUpdate = _isYardUpdate ?? bool.hasEnvironment(_adsBF[17].state);
    _isFurnishedUpdate = _isFurnishedUpdate ?? bool.hasEnvironment(_adsBF[16].state);
    _isKitchenUpdate = _isKitchenUpdate ?? bool.hasEnvironment(_adsBF[15].state);
    _isAppendixUpdate = _isAppendixUpdate ?? bool.hasEnvironment(_adsBF[14].state);
    _isCarEntranceUpdate = _isCarEntranceUpdate ?? bool.hasEnvironment(_adsBF[13].state);
    _isElevatorUpdate = _isElevatorUpdate ?? bool.hasEnvironment(_adsBF[12].state);
    _isConditionerUpdate = _isConditionerUpdate ?? bool.hasEnvironment(_adsBF[11].state);
    _isHallStaircaseUpdate = _isHallStaircaseUpdate ?? bool.hasEnvironment(_adsBF[10].state);
    _isDuplexUpdate = _isDuplexUpdate ?? bool.hasEnvironment(_adsBF[9].state);
    _isDriverRoomUpdate = _isDriverRoomUpdate ?? bool.hasEnvironment(_adsBF[8].state);
    _isSwimmingPoolUpdate = _isSwimmingPoolUpdate ?? bool.hasEnvironment(_adsBF[7].state);
    _isMaidRoomUpdate = _isMaidRoomUpdate ?? bool.hasEnvironment(_adsBF[6].state);
    _isVerseUpdate = _isVerseUpdate ?? bool.hasEnvironment(_adsBF[5].state);
    _isCellarUpdate = _isCellarUpdate ?? bool.hasEnvironment(_adsBF[4].state);
    _isFamilyPartitionUpdate = _isFamilyPartitionUpdate ?? bool.hasEnvironment(_adsBF[3].state);
    _isAmusementParkUpdate = _isAmusementParkUpdate ?? bool.hasEnvironment(_adsBF[2].state);
    _isVolleyballCourtUpdate = _isVolleyballCourtUpdate ?? bool.hasEnvironment(_adsBF[1].state);
    _isFootballCourtUpdate = _isFootballCourtUpdate ?? bool.hasEnvironment(_adsBF[0].state);

    _LoungesUpdateUpdate = _LoungesUpdateUpdate ?? double.parse(_adsQF[9].quantity);
    _ToiletsUpdateUpdate = _ToiletsUpdateUpdate ?? double.parse(_adsQF[8].quantity);
    _RoomsUpdate = _RoomsUpdate ?? double.parse(_adsQF[7].quantity);
    _AgeOfRealEstateUpdate = _AgeOfRealEstateUpdate ?? double.parse(_adsQF[6].quantity);
    _ApartmentsUpdate = _ApartmentsUpdate ?? double.parse(_adsQF[5].quantity);
    _StoresUpdate = _StoresUpdate ?? double.parse(_adsQF[4].quantity);
    _WellsUpdate = _WellsUpdate ?? double.parse(_adsQF[3].quantity);
    _TreesUpdate = _TreesUpdate ?? double.parse(_adsQF[2].quantity);
    _FloorUpdate = _FloorUpdate ?? double.parse(_adsQF[1].quantity);
    _StreetWidthUpdate = _StreetWidthUpdate ?? double.parse(_adsQF[0].quantity);

    if(!typeAqarUpdate.contains(true)){
      setTyprAqarUpdate(int.parse(_idTypeAqar)-1, false);
    }
    if(!_planUpdate.contains(true)){
      setPlanUpdate(int.parse(_plan), false);
    }

    
  }

  void getCategoryeInfoUpdate(BuildContext context) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _categoryUpdate.clear();
      Api().getCategoryFunc().then((value) {
        _CategoryDataUpdate = value;
        _CategoryDataUpdate.forEach((element) {
          _categoryUpdate.add(CategoryModel.fromJson(element));
        });
        notifyListeners();
      });
    });
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

  void updateCategoryDetails(int id, String category) {
    _id_category_finalUpdate = id;
    _category_finalUpdate = category;
    notifyListeners();
  }

  void setCurrentStageUpdateDetails(int current) {
    _currentStageUpdateDetails = current;
    notifyListeners();
  }

  void setInterfaceSelectedUpdate(String interfaceSelectedUpdate) {
    _interfaceSelectedUpdate = interfaceSelectedUpdate;
    notifyListeners();
  }

  void setFamilyUpdate(int index, bool update) {
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
    if(update){
      notifyListeners();
    }
  }

  void setPlanUpdate(int index, bool update) {
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
    if(update){
      notifyListeners();
    }
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

  void setIsYardUpdate(bool val) {
    _isYardUpdate = val;
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

  void setAcceptedUpdate(bool state) {
    _AcceptedUpdate = state;
    notifyListeners();
  }

  void update(){
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
      String id_category_final,
      String selectedAdderRelation,
      String selectedMarketerRelation,
      ) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateDetailsFunc(
        id_description,
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
      Provider.of<MainPageProvider>(context, listen: false).removeMarkers();
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
      Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
      Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          ModalRoute.withName('/MainPage')
      );
    });
  }



  List<bool> get typeAqarUpdate => _typeAqarUpdate;
  int get currentStageUpdateDetails => _currentStageUpdateDetails;
  List<CategoryModel> get categoryUpdate => _categoryUpdate;
  int get id_category_finalUpdate => _id_category_finalUpdate;
  String get interfaceSelectedUpdate => _interfaceSelectedUpdate;
  List<bool> get familyUpdate => _familyUpdate;
  List<bool> get planUpdate => _planUpdate;
  double get LoungesUpdateUpdate => _LoungesUpdateUpdate;
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
  bool get isYardUpdate => _isYardUpdate;
  bool get isVerseUpdate => _isVerseUpdate;
  bool get isCellarUpdate => _isCellarUpdate;
  bool get isFamilyPartitionUpdate => _isFamilyPartitionUpdate;
  bool get isAmusementParkUpdate => _isAmusementParkUpdate;
  bool get isVolleyballCourtUpdate => _isVolleyballCourtUpdate;
  bool get isFootballCourtUpdate => _isFootballCourtUpdate;
  double get ToiletsUpdateUpdate => _ToiletsUpdateUpdate;
  double get RoomsUpdate => _RoomsUpdate;
  double get AgeOfRealEstateUpdate => _AgeOfRealEstateUpdate;
  double get ApartmentsUpdate => _ApartmentsUpdate;
  double get StoresUpdate => _StoresUpdate;
  double get WellsUpdate => _WellsUpdate;
  double get TreesUpdate => _TreesUpdate;
  double get FloorUpdate => _FloorUpdate;
  double get StreetWidthUpdate => _StreetWidthUpdate;
  bool get AcceptedUpdate => _AcceptedUpdate;
  String get category_finalUpdate => _category_finalUpdate;
  int get selectedPlanUpdate => _selectedPlanUpdate;
  int get selectedFamilyUpdate => _selectedFamilyUpdate;
  int get selectedTypeAqarUpdate => _selectedTypeAqarUpdate;



}