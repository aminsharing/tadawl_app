import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/CategoryModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

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
  double _LoungesUpdateUpdate = 0;
  bool _AcceptedUpdate = false;
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
  double _ToiletsUpdateUpdate = 0;
  double _RoomsUpdate = 0;
  double _AgeOfRealEstateUpdate = 0;
  double _ApartmentsUpdate = 0;
  double _StoresUpdate = 0;
  double _WellsUpdate = 0;
  double _TreesUpdate = 0;
  double _FloorUpdate = 0;
  double _StreetWidthUpdate = 0;
  int _selectedPlanUpdate = 0;
  int _selectedFamilyUpdate = 0;
  int _selectedTypeAqarUpdate = 0;



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

  void setAcceptedUpdate(bool state) {
    _AcceptedUpdate = state;
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
  bool get isMonstersUpdate => _isMonstersUpdate;
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