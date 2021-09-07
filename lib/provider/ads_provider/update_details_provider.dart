import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/BFModel.dart';
import 'package:tadawl_app/models/CategoryModel.dart';
import 'package:tadawl_app/models/QFModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class UpdateDetailsProvider extends ChangeNotifier{
  UpdateDetailsProvider(BuildContext context, String? _id_description, List<BFModel> adsBF, List<QFModel> adsQF, AdsModel adsPage){
    getAdsUpdateInfo(
        adsBF,
        adsQF,
        adsPage.idInterface,
        adsPage.idTypeAqar,
        adsPage.idTypeRes
    );
    getCategoryeInfoUpdate().then((value) {
      getAdsPageInfoUpdateDetails(context, _id_description);

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<bool> _typeAqarUpdate = List.generate(3, (_) => false);
  final List<bool> _familyUpdate = List.generate(2, (_) => false);
  final List<bool> _planUpdate = List.generate(3, (_) => false);
  final List<CategoryModel> _categoryUpdate = [];
  String? _category_finalUpdate;
  List? _CategoryDataUpdate = [];
  int? _id_category_finalUpdate;
  String? _interfaceSelectedUpdate;
  bool? _AcceptedUpdate = false;
  bool? _isFurnishedUpdate;
  bool? _isKitchenUpdate;
  bool? _isAppendixUpdate;
  bool? _isCarEntranceUpdate;
  bool? _isElevatorUpdate;
  bool? _isConditionerUpdate;
  bool? _isHallStaircaseUpdate;
  bool? _isDuplexUpdate;
  bool? _isDriverRoomUpdate;
  bool? _isSwimmingPoolUpdate;
  bool? _isMaidRoomUpdate;
  bool? _isYardUpdate;
  bool? _isVerseUpdate;
  bool? _isCellarUpdate;
  bool? _isFamilyPartitionUpdate;
  bool? _isAmusementParkUpdate;
  bool? _isVolleyballCourtUpdate;
  bool? _isFootballCourtUpdate;
  double? _LoungesUpdateUpdate;
  double? _ToiletsUpdateUpdate;
  double? _RoomsUpdate;
  double? _AgeOfRealEstateUpdate;
  double? _ApartmentsUpdate;
  double? _StoresUpdate;
  double? _WellsUpdate;
  double? _TreesUpdate;
  double? _FloorUpdate;
  double? _StreetWidthUpdate;
  int _selectedPlanUpdate = 0;
  int _selectedFamilyUpdate = 0;
  int _selectedTypeAqarUpdate = 0;
  AdsModel? _adsUpdateDetails;
  final TextEditingController _priceControllerUpdate = TextEditingController();
  final TextEditingController _spaceControllerUpdate = TextEditingController();
  final TextEditingController _descControllerUpdate = TextEditingController();
  final TextEditingController _meterPriceControllerUpdate = TextEditingController();
  int? _meterPriceUpdate;
  String? _totalPricUpdatee;
  String? _detailsAqarUpdate;
  String? _totalSpaceUpdate;
  bool _isSending = false;


  set isSending(bool val){
    _isSending = val;
    notifyListeners();
  }


  void getAdsUpdateInfo(List<BFModel> _adsBF, List<QFModel> _adsQF, String? _interface, String? _idTypeAqar, String? _plan) {
    _interfaceSelectedUpdate = _interfaceSelectedUpdate ?? _interface;

    _adsBF.forEach((element) {
      switch(element.id_BFAT){
        case '1':
          _isFurnishedUpdate = _isFurnishedUpdate ?? (element.state ??'false') == 'true';
          break;
        case '2':
          _isKitchenUpdate = _isKitchenUpdate ?? (element.state ??'false') == 'true';
          break;
        case '3':
          _isFamilyPartitionUpdate = _isFamilyPartitionUpdate ?? (element.state ??'false') == 'true';
          break;
        case '5':
          _isCarEntranceUpdate = _isCarEntranceUpdate ?? (element.state ??'false') == 'true';
          break;
        case '7':
          _isElevatorUpdate = _isElevatorUpdate ?? (element.state ??'false') == 'true';
          break;
        case '12':
          _isAppendixUpdate = _isAppendixUpdate ?? (element.state ??'false') == 'true';
          break;
        case '16':
          _isCellarUpdate = _isCellarUpdate ?? (element.state ??'false') == 'true';
          break;
        case '17':
          _isYardUpdate = _isYardUpdate ?? (element.state ??'false') == 'true';
          break;
        case '18':
          _isDriverRoomUpdate = _isDriverRoomUpdate ?? (element.state ??'false') == 'true';
          break;
        case '19':
          _isMaidRoomUpdate = _isMaidRoomUpdate ?? (element.state ??'false') == 'true';
          break;
        case '20':
          _isSwimmingPoolUpdate = _isSwimmingPoolUpdate ?? (element.state ??'false') == 'true';
          break;
        case '21':
          _isFootballCourtUpdate = _isFootballCourtUpdate ?? (element.state ??'false') == 'true';
          break;
        case '22':
          _isVolleyballCourtUpdate = _isVolleyballCourtUpdate ?? (element.state ??'false') == 'true';
          break;
        case '23':
          _isAmusementParkUpdate = _isAmusementParkUpdate ?? (element.state ??'false') == 'true';
          break;
        case '24':
          _isVerseUpdate = _isVerseUpdate ?? (element.state ??'false') == 'true';
          break;
        case '25':
          _isDuplexUpdate = _isDuplexUpdate ?? (element.state ??'false') == 'true';
          break;
        case '26':
          _isHallStaircaseUpdate = _isHallStaircaseUpdate ?? (element.state ??'false') == 'true';
          break;
        case '27':
          _isConditionerUpdate = _isConditionerUpdate ?? (element.state ??'false') == 'true';
          break;
      }
    });

    _adsQF.forEach((element) {
      switch(element.id_QFAT){
        case '7':
          _LoungesUpdateUpdate = _LoungesUpdateUpdate ?? double.parse(element.quantity!);
          break;
        case '8':
          _ToiletsUpdateUpdate = _ToiletsUpdateUpdate ?? double.parse(element.quantity!);
          break;
        case '9':
          _RoomsUpdate = _RoomsUpdate ?? double.parse(element.quantity!);
          break;
        case '10':
          _FloorUpdate = _FloorUpdate ?? double.parse(element.quantity!);
          break;
        case '11':
          _AgeOfRealEstateUpdate = _AgeOfRealEstateUpdate ?? double.parse(element.quantity!);
          break;
        case '12':
          _ApartmentsUpdate = _ApartmentsUpdate ?? double.parse(element.quantity!);
          break;
        case '13':
          _StreetWidthUpdate = _StreetWidthUpdate ?? double.parse(element.quantity!);
          break;
        case '14':
          _TreesUpdate = _TreesUpdate ?? double.parse(element.quantity!);
          break;
        case '15':
          _WellsUpdate = _WellsUpdate ?? double.parse(element.quantity!);
          break;
        case '16':
          _StoresUpdate = _StoresUpdate ?? double.parse(element.quantity!);
          break;
      }
    });

    if(!typeAqarUpdate.contains(true)){
      setTyprAqarUpdate(int.parse(_idTypeAqar!)-1, false);
    }
    if(!_planUpdate.contains(true)){
      setPlanUpdate(int.parse(_plan!), false);
    }

    
  }

  Future<void> getCategoryeInfoUpdate() async {
    Future.delayed(Duration(milliseconds: 0), () async{
      _categoryUpdate.clear();
      await Api().getCategoryFunc().then((value) {
        _CategoryDataUpdate = value;
        _CategoryDataUpdate!.forEach((element) {
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

  void updateCategoryDetails(int id, String? category) {
    _id_category_finalUpdate = id;
    _category_finalUpdate = category;
    notifyListeners();
  }

  void setInterfaceSelectedUpdate(String? interfaceSelectedUpdate) {
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

  void setAcceptedUpdate(bool? state) {
    _AcceptedUpdate = state;
    notifyListeners();
  }

  void update(){
    notifyListeners();
  }

  void setOnSavedTotalPriceUpdate(String value) {
    _totalPricUpdatee = value;
    _priceControllerUpdate.text = value;
    notifyListeners();
  }

  void setOnSavedDetailsUpdate(String value) {
    _detailsAqarUpdate = value;
    _descControllerUpdate.text = value;
    notifyListeners();
  }

  void setOnChangedSpaceUpdate(String value) {
    if (_meterPriceUpdate != null) {
      _priceControllerUpdate
        .text = (double.parse(value) * double.parse('$_meterPriceUpdate'))
            .toString();
    }
    _totalSpaceUpdate = value;
    notifyListeners();
  }

  void setOnSavedSpaceUpdate(String? value) {
    _totalSpaceUpdate = value;
    _spaceControllerUpdate.text = '$value';
    notifyListeners();
  }

  void setOnChangedMeterPriceUpdate(String value) {
    if (_totalSpaceUpdate != null) {
      _priceControllerUpdate
        .text =
        (double.parse(value) * double.parse(_totalSpaceUpdate!)).toString();
    }
    _meterPriceUpdate = int.parse(value);
    notifyListeners();
  }

  void setOnSavedMeterPriceUpdate(String value) {
    _meterPriceUpdate = int.parse(value);
    _meterPriceControllerUpdate.text = '$value';
    notifyListeners();
  }

  void getAdsPageInfoUpdateDetails(BuildContext context, String? id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().getAdsPageFunc(id_description).then((value) {
        _adsUpdateDetails = AdsModel.adsUpdateDetails(value);
        if (_adsUpdateDetails != null) {
          _priceControllerUpdate.text = _adsUpdateDetails!.price!;
          _spaceControllerUpdate.text = _adsUpdateDetails!.space!;
          _meterPriceControllerUpdate.text = (int.tryParse(_adsUpdateDetails!.price!)! ~/ int.tryParse(_adsUpdateDetails!.space!)!).toString();
          _meterPriceUpdate = int.parse(_meterPriceControllerUpdate.text);
          _descControllerUpdate.text = _adsUpdateDetails!.description!;
        }
        notifyListeners();
        // Provider.of<UpdateDetailsProvider>(context, listen: false).update();
      });
    });
  }

  Future updateDetails(
      BuildContext context,
      String id_description,
      String? detailsAqar,
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
      String? interfaceSelected,
      String? totalSpace,
      String? totalPrice,
      String selectedPlan,
      String id_category_final,
      String? selectedAdderRelation,
      String? selectedMarketerRelation,
      ) async {
    await Api().updateDetailsFunc(
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
    // Provider.of<AdPageProvider>(context, listen: false)
    //     .getAllAdsPageInfo(context, id_description);


    // Future.delayed(Duration(seconds: 0), () {
    //   // Provider.of<MainPageProvider>(context, listen: false).removeMarkers();
    //   Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
    //   // Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
    //   // Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => Home()),
    //           (route) => false
    //   );
    // });
  }



  List<bool> get typeAqarUpdate => _typeAqarUpdate;
  List<CategoryModel> get categoryUpdate => _categoryUpdate;
  int? get id_category_finalUpdate => _id_category_finalUpdate;
  String? get interfaceSelectedUpdate => _interfaceSelectedUpdate;
  List<bool> get familyUpdate => _familyUpdate;
  List<bool> get planUpdate => _planUpdate;
  double? get LoungesUpdateUpdate => _LoungesUpdateUpdate;
  bool? get isFurnishedUpdate => _isFurnishedUpdate;
  bool? get isKitchenUpdate => _isKitchenUpdate;
  bool? get isAppendixUpdate => _isAppendixUpdate;
  bool? get isCarEntranceUpdate => _isCarEntranceUpdate;
  bool? get isElevatorUpdate => _isElevatorUpdate;
  bool? get isConditionerUpdate => _isConditionerUpdate;
  bool? get isHallStaircaseUpdate => _isHallStaircaseUpdate;
  bool? get isDuplexUpdate => _isDuplexUpdate;
  bool? get isDriverRoomUpdate => _isDriverRoomUpdate;
  bool? get isSwimmingPoolUpdate => _isSwimmingPoolUpdate;
  bool? get isMaidRoomUpdate => _isMaidRoomUpdate;
  bool? get isYardUpdate => _isYardUpdate;
  bool? get isVerseUpdate => _isVerseUpdate;
  bool? get isCellarUpdate => _isCellarUpdate;
  bool? get isFamilyPartitionUpdate => _isFamilyPartitionUpdate;
  bool? get isAmusementParkUpdate => _isAmusementParkUpdate;
  bool? get isVolleyballCourtUpdate => _isVolleyballCourtUpdate;
  bool? get isFootballCourtUpdate => _isFootballCourtUpdate;
  double? get ToiletsUpdateUpdate => _ToiletsUpdateUpdate;
  double? get RoomsUpdate => _RoomsUpdate;
  double? get AgeOfRealEstateUpdate => _AgeOfRealEstateUpdate;
  double? get ApartmentsUpdate => _ApartmentsUpdate;
  double? get StoresUpdate => _StoresUpdate;
  double? get WellsUpdate => _WellsUpdate;
  double? get TreesUpdate => _TreesUpdate;
  double? get FloorUpdate => _FloorUpdate;
  double? get StreetWidthUpdate => _StreetWidthUpdate;
  bool? get AcceptedUpdate => _AcceptedUpdate;
  String? get category_finalUpdate => _category_finalUpdate;
  int get selectedPlanUpdate => _selectedPlanUpdate;
  int get selectedFamilyUpdate => _selectedFamilyUpdate;
  int get selectedTypeAqarUpdate => _selectedTypeAqarUpdate;
  TextEditingController get priceControllerUpdate => _priceControllerUpdate;
  TextEditingController get spaceControllerUpdate => _spaceControllerUpdate;
  TextEditingController get descControllerUpdate => _descControllerUpdate;
  AdsModel? get adsUpdateDetails => _adsUpdateDetails;
  int? get meterPriceUpdate => _meterPriceUpdate;
  TextEditingController get meterPriceControllerUpdate => _meterPriceControllerUpdate;
  String? get totalPricUpdatee => _totalPricUpdatee;
  String? get detailsAqarUpdate => _detailsAqarUpdate;
  String? get totalSpaceUpdate => _totalSpaceUpdate;
  bool get isSending => _isSending;
}