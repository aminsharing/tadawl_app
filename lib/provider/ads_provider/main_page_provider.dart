import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/Gist.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/cache_markers_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class MainPageProvider extends ChangeNotifier{
  int _inItMainPageDone = 0;
  String _idCategorySearch;
  CameraPosition _region_position;
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
  bool _isMove = false;
  int _adsOnMap = 1;
  bool _showDiaogSearchDrawer = false;
  final _markersMainPage = <Marker>[];
  AdsModel _SelectedAdsModelMainPage;
  int _slider_state = 1;

  GoogleMapController _mapControllerMainPAge;
  CameraPosition _selectedArea = CameraPosition(target: cities.first.position, zoom: cities.first.zoom);
  final List<AdsModel> _Ads = [];
  List _AdsData = [];
  bool _waitMainPage = false;
  int _filter;
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




  void setIdCategorySearch(String val) {
    _idCategorySearch = val;
    // notifyListeners();
  }





  void setInItMainPageDone(int val) {
    _inItMainPageDone= val;
    // notifyListeners();
  }

  void setMapControllerMainPage(GoogleMapController val) {
    _mapControllerMainPAge = val;
    notifyListeners();
  }

  void animateLocation(BuildContext context) async{
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    await _mapControllerMainPAge.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 17,
      ),
    ),
    );
  }

  void setSelectedArea(CameraPosition val){
    _selectedArea = val;
    // notifyListeners();
  }

  void setMoveState(bool val){
    _isMove = val;
  }

  void setShowDiogFalse() {
    _showDiaogSearchDrawer = false;
    notifyListeners();
  }

  void spicificAreaAds2(BuildContext context){
    if(_Ads.isNotEmpty){
      if(_markersMainPage.isNotEmpty){
        _markersMainPage.clear();
      }
      _Ads.forEach((element) {
        // if(calculateArea(double.tryParse(element.lat) ?? 0.0, double.tryParse(element.lng) ?? 0.0, _selectedArea)){
        //
        // }
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

  void spicificAreaAds3(BuildContext context, AdsModel element){
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

  void clearAdsOnMap(){
    _adsOnMap = 1;
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

  bool calculateArea(double lat, double lng, CameraPosition selectedArea){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat - selectedArea.target.latitude) * p)/2 + c(selectedArea.target.latitude * p) * c(lat * p) * (1 - c((lng - selectedArea.target.longitude) * p))/2;
    var calculateDistance = 12742 * asin(sqrt(a));
    if(calculateDistance < (21.0 - (selectedArea.zoom+1))){
      return true;
    }else{
      return false;
    }
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

  Marker mapBitmapsToMarkersMainPage(BuildContext context, Uint8List bmp, AdsModel ad) {
    return Marker(
        markerId: MarkerId(' ${ad.price}'),
        position: LatLng(double.tryParse(ad.lat)??26.0, double.tryParse(ad.lng)??46.0),
        onTap: () {
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

  void setShowDiogTrue() {
    _showDiaogSearchDrawer = true;
    notifyListeners();
  }

  void setFilter(BuildContext context, int assignedFilter) {
    _filter = assignedFilter;
  }

  void clearFilter(BuildContext context) {
    _filter = null;
  }

  void setRegionPosition(CameraPosition val) {
    _region_position = val;
    //notifyListeners();
  }

  int countAds() {
    if (_Ads.isNotEmpty) {
      return _Ads.length;
    } else {
      return 0;
    }
  }

  void setSliderState(int val) {
    _slider_state = val;
    notifyListeners();
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
        // if (_Ads.isNotEmpty) {
        //   _Ads.forEach((element){
        //     if(element.entry != null){
        //       try{
        //         element.entry.remove();
        //         element.key = null;
        //       }catch(e){
        //         print('entry.remove 1 : $e');
        //       }
        //     }
        //   });
        //   _Ads.clear();
        // }

        List<String> a = <String>[];
        _Ads.forEach((element) {
          a.add(element.idDescription);
        });

        Api().getadsFunc().then((value) {
          _AdsData = value;
          _AdsData.forEach((element) {
            if(!a.contains(element['id_description'])){
              print("id_description1");
              _Ads.add(AdsModel.ads(element));
            }
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    } // ...... left slider category array ........
    else if (_filter == 1) {
      Future.delayed(Duration(milliseconds: 0), () {
        // if (_Ads.isNotEmpty) {
        //   _Ads.forEach((element){
        //     if(element.entry != null){
        //       try{
        //         element.entry.remove();
        //         element.key = null;
        //       }catch(e){
        //         print('entry.remove 2 : $e');
        //       }
        //     }
        //   });
        //   _Ads.clear();
        // }
        List<String> a = <String>[];
        _Ads.forEach((element) {
          a.add(element.idDescription);
        });
        Api()
            .getFilterAdsFunc(sliderCategory)
            .then((value) {
          _AdsData = value;
          _AdsData.forEach((element) {
            if(!a.contains(element['id_description'])){
              print("id_description2");
              _Ads.add(AdsModel.ads(element));
            }
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    } // ...... two weeks ago array ........
    else if (_filter == 2) {
      Future.delayed(Duration(milliseconds: 0), () {
        // if (_Ads.isNotEmpty) {
        //   _Ads.forEach((element){
        //     if(element.entry != null){
        //       try{
        //         element.entry.remove();
        //         element.key = null;
        //       }catch(e){
        //         print('entry.remove 3 : $e');
        //       }
        //     }
        //   });
        //   _Ads.clear();
        // }
        List<String> a = <String>[];
        _Ads.forEach((element) {
          a.add(element.idDescription);
        });

        Api().getFilterTwoWeeksAgoFunc().then((value) {
          _AdsData = value;
          _AdsData.forEach((element) {
            if(!a.contains(element['id_description'])){
              print("id_description3");
              _Ads.add(AdsModel.ads(element));
            }
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    }
    else if (_filter == 4) {
      Future.delayed(Duration(milliseconds: 0), () {
        // if (_Ads.isNotEmpty) {
        //   _Ads.forEach((element){
        //     if(element.entry != null){
        //       try{
        //         element.entry.remove();
        //         element.key = null;
        //       }catch(e){
        //         print('entry.remove 4 : $e');
        //       }
        //     }
        //   });
        //   _Ads.clear();
        // }

        List<String> a = <String>[];
        _Ads.forEach((element) {
          a.add(element.idDescription);
        });
        Api()
            .getAdvancedSearchFunc(
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
            if(!a.contains(element['id_description'])){
              print("id_description4");
              _Ads.add(AdsModel.ads(element));
            }
          });
          spicificAreaAds2(context);
          notifyListeners();
        });
      });
    }
  }

  void setWaitMainPage(bool val){
    _waitMainPage = val;
  }

  void basicFilter(BuildContext context){
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
    if (_Ads.isNotEmpty) {
      Future.delayed(Duration(seconds: 1), () {
        _waitMainPage = false;
        // notifyListeners();
      });
    }
  }

  void leftSliderCategoryFilter(BuildContext context, String id_category){
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
    if (_Ads.isNotEmpty) {
      Future.delayed(Duration(seconds: 1), () {
        _waitMainPage = false;
        // }
        // notifyListeners();
      });
    }
  }

  void twoWeeksAgoFilter(BuildContext context){
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
    if (_Ads.isNotEmpty) {
      Future.delayed(Duration(seconds: 1), () {
        _waitMainPage = false;
        // }
        // notifyListeners();
      });
    }
  }

  void advancedSearchFilter(
      BuildContext context,
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
      String bool_feature18SearchDrawer){
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
    if (_Ads.isNotEmpty) {
      Future.delayed(Duration(seconds: 1), () {
      });
    }
  }

  int get inItMainPageDone => _inItMainPageDone;
  String get idCategorySearch => _idCategorySearch;
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
  String get maxPriceSearchDrawer => _maxPriceSearchDrawer;
  String get selectedTypeAqarSearchDrawer => _selectedTypeAqarSearchDrawer;
  String get interfaceSelectedSearchDrawer => _interfaceSelectedSearchDrawer;
  String get streetWidthSelectedSearchDrawer => _streetWidthSelectedSearchDrawer;
  String get ageOfRealEstateSelectedSearchDrawer => _ageOfRealEstateSelectedSearchDrawer;
  CameraPosition get region_position => _region_position;
  bool get isMove => _isMove;
  bool get showDiaogSearchDrawer => _showDiaogSearchDrawer;
  List<Marker> get markersMainPage => _markersMainPage;
  AdsModel get SelectedAdsModelMainPage => _SelectedAdsModelMainPage;
  int get adsOnMap => _adsOnMap;
  bool get waitMainPage => _waitMainPage;
  GoogleMapController get mapControllerMainPAge => _mapControllerMainPAge;
  List<AdsModel> get ads => _Ads;
  int get filterSearch => _filter;
  int get slider_state => _slider_state;
  List<Map> get categories => _categoriesFun();
  List<Map> get enCategories => _enCategoriesFun();



  /// Start Mutual get with Search Drawer
  List<bool> get planSearchDrawer => _planSearchDrawer;
  List<bool> get loungesSearchDrawer => _loungesSearchDrawer;
  List<bool> get toiletsSearchDrawer => _toiletsSearchDrawer;
  List<bool> get roomsSearchDrawer => _roomsSearchDrawer;
  List<bool> get apartmentsSearchDrawer => _apartmentsSearchDrawer;
  List<bool> get familyTypeSearchDrawer => _familyTypeSearchDrawer;
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