import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';



class SearchDrawerProvider extends ChangeNotifier{

  SearchDrawerProvider(){
    print('init SearchDrawerProvider');
  }

  @override
  void dispose() {
    print('dispose SearchDrawerProvider');
    super.dispose();
  }

  int _menuFilter;
  set menuFilter(int i) => _menuFilter = i;
  List _MenuAdsData = [];
  String _idCategorySearch;
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
  List _AdsData = [];
  int _filter;
  int _mainAdsCount;
  int _menuAdsCount;
  final List<bool> _planSearchDrawer = List.generate(3, (_) => false);
  final List<bool> _loungesSearchDrawer = List.generate(4, (_) => false);
  final List<bool> _toiletsSearchDrawer = List.generate(4, (_) => false);
  final List<bool> _roomsSearchDrawer = List.generate(4, (_) => false);
  final List<bool> _apartmentsSearchDrawer = List.generate(6, (_) => false);
  final List<bool> _familyTypeSearchDrawer = List.generate(2, (_) => false);
  final List<bool> _typeAqarSearchDrawer = List.generate(3, (_) => false);


  void setFilter(int assignedFilter) {
    _filter = assignedFilter;
  }

  void setIdCategorySearch(String val) {
    _idCategorySearch = val;
    // notifyListeners();
  }

  void clearFilter(BuildContext context) {
    _filter = null;
  }

  void clearMenuFilter() {
    _menuFilter = null;
  }

  void setMenuFilter(int assignedMenuFilter) {
    _menuFilter = assignedMenuFilter;
  }

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

  void setMainAdsCount(int val){
    _mainAdsCount = val;
    notifyListeners();
  }

  void setMenuAdsCount(int val){
    _menuAdsCount = val;
    notifyListeners();
  }

  void getAdsList(BuildContext context) {
    // ...... basic array ........
    if (_filter == null) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api().getadsFunc().then((value) {
          _AdsData = value;
          setMainAdsCount(_AdsData.length);
          Provider.of<MainPageProvider>(context, listen: false)
              .getAds(context ,_AdsData);
        });
      });
    }
    // ...... left slider category array ........
    else if (_filter == 1) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api().getFilterAdsFunc(_idCategorySearch)
            .then((value) {
          _AdsData = value;
          setMainAdsCount(_AdsData.length);
          Provider.of<MainPageProvider>(context, listen: false)
              .getAds(context ,_AdsData);
        });
      });
    }
    // ...... two weeks ago array ........
    else if (_filter == 2) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api().getFilterTwoWeeksAgoFunc().then((value) {
          _AdsData = value;
          setMainAdsCount(_AdsData.length);
          Provider.of<MainPageProvider>(context, listen: false)
              .getAds(context ,_AdsData);
        });
      });
    }
    // ...... advanced search filter ........
    else if (_filter == 4) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api()
            .getAdvancedSearchFunc(
            _selectedCategory,
            _minPriceSearchDrawer,
            _maxPriceSearchDrawer,
            _minSpaceSearchDrawer,
            _maxSpaceSearchDrawer,
            _selectedTypeAqarSearchDrawer,
            _interfaceSelectedSearchDrawer,
            _selectedPlanSearchDrawer,
            _ageOfRealEstateSelectedSearchDrawer,
            _selectedApartmentsSearchDrawer,
            _floorSelectedSearchDrawer,
            _selectedLoungesSearchDrawer,
            _selectedRoomsSearchDrawer,
            _storesSelectedSearchDrawer,
            _streetWidthSelectedSearchDrawer,
            _selectedToiletsSearchDrawer,
            _treesSelectedSearchDrawer,
            _wellsSelectedSearchDrawer,
            _bool_feature1SearchDrawer.toString(),
            _bool_feature2SearchDrawer.toString(),
            _bool_feature3SearchDrawer.toString(),
            _bool_feature4SearchDrawer.toString(),
            _bool_feature5SearchDrawer.toString(),
            _bool_feature6SearchDrawer.toString(),
            _bool_feature7SearchDrawer.toString(),
            _bool_feature8SearchDrawer.toString(),
            _bool_feature9SearchDrawer.toString(),
            _bool_feature10SearchDrawer.toString(),
            _bool_feature11SearchDrawer.toString(),
            _bool_feature12SearchDrawer.toString(),
            _bool_feature13SearchDrawer.toString(),
            _bool_feature14SearchDrawer.toString(),
            _bool_feature15SearchDrawer.toString(),
            _bool_feature16SearchDrawer.toString(),
            _bool_feature17SearchDrawer.toString(),
            _bool_feature18SearchDrawer.toString())
            .then((value) {
          _AdsData = value;
          setMainAdsCount(_AdsData.length);
          Provider.of<MainPageProvider>(context, listen: false)
              .getAds(context ,_AdsData);
        });
      });
    }
  }

  void getMenuList(BuildContext context) {
    // ...... basic array & latest menu ads array ........
    if (_menuFilter == null) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api().filterUpToDateAdsFunc().then((value) {
          _MenuAdsData = value;
          setMenuAdsCount(_MenuAdsData.length);
          Provider.of<MenuProvider>(context, listen: false)
              .getMenuAds(_MenuAdsData);
        });
      });
    }
    // ...... two weeks ago menu array ........
    else if (_menuFilter == 2) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api().getFilterTwoWeeksAgoFunc().then((value) {
          _MenuAdsData = value;
          setMenuAdsCount(_MenuAdsData.length);
          Provider.of<MenuProvider>(context, listen: false)
              .getMenuAds(_MenuAdsData);
        });
      });
    }
    // ...... advanced menu search array ........
    else if (_menuFilter == 4) {
      Future.delayed(Duration(milliseconds: 0), () {
        Api()
            .getAdvancedSearchFunc(
            _selectedCategory,
            _minPriceSearchDrawer,
            _maxPriceSearchDrawer,
            _minSpaceSearchDrawer,
            _maxSpaceSearchDrawer,
            _selectedTypeAqarSearchDrawer,
            _interfaceSelectedSearchDrawer,
            _selectedPlanSearchDrawer,
            _ageOfRealEstateSelectedSearchDrawer,
            _selectedApartmentsSearchDrawer,
            _floorSelectedSearchDrawer,
            _selectedLoungesSearchDrawer,
            _selectedRoomsSearchDrawer,
            _storesSelectedSearchDrawer,
            _streetWidthSelectedSearchDrawer,
            _selectedToiletsSearchDrawer,
            _treesSelectedSearchDrawer,
            _wellsSelectedSearchDrawer,
            _bool_feature1SearchDrawer.toString(),
            _bool_feature2SearchDrawer.toString(),
            _bool_feature3SearchDrawer.toString(),
            _bool_feature4SearchDrawer.toString(),
            _bool_feature5SearchDrawer.toString(),
            _bool_feature6SearchDrawer.toString(),
            _bool_feature7SearchDrawer.toString(),
            _bool_feature8SearchDrawer.toString(),
            _bool_feature9SearchDrawer.toString(),
            _bool_feature10SearchDrawer.toString(),
            _bool_feature11SearchDrawer.toString(),
            _bool_feature12SearchDrawer.toString(),
            _bool_feature13SearchDrawer.toString(),
            _bool_feature14SearchDrawer.toString(),
            _bool_feature15SearchDrawer.toString(),
            _bool_feature16SearchDrawer.toString(),
            _bool_feature17SearchDrawer.toString(),
            _bool_feature18SearchDrawer.toString()
        )
            .then((value) {
          _MenuAdsData = value;
          setMenuAdsCount(_MenuAdsData.length);
          Provider.of<MenuProvider>(context, listen: false)
              .getMenuAds(_MenuAdsData);
        });
      });
    }
  }

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
  List<bool> get planSearchDrawer => _planSearchDrawer;
  List<bool> get loungesSearchDrawer => _loungesSearchDrawer;
  List<bool> get toiletsSearchDrawer => _toiletsSearchDrawer;
  List<bool> get roomsSearchDrawer => _roomsSearchDrawer;
  List<bool> get apartmentsSearchDrawer => _apartmentsSearchDrawer;
  List<bool> get familyTypeSearchDrawer => _familyTypeSearchDrawer;
  List<bool> get typeAqarSearchDrawer => _typeAqarSearchDrawer;
  int get filterSearch => _filter;
  int get menuFilterSearch => _menuFilter;
  int get mainAdsCount => _mainAdsCount;
  int get menuAdsCount => _menuAdsCount;

}