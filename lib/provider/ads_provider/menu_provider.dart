import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';

class MenuProvider extends ChangeNotifier{
  bool _waitMenu = false;
  final List<AdsModel> _MenuAds = [];
  final ScrollController _menuController = ScrollController();
  int _expendedMenuListCount = 20;
  int _filterSearchDrawer;
  int _menuMainFilterAds;
  int _menuFilter;
  List _MenuAdsData = [];



  void setFilterSearchDrawer(int value) {
    _filterSearchDrawer = value;
    //notifyListeners();
  }

  void setMenuMainFilterAds(int val) {
    _menuMainFilterAds = val;
    //notifyListeners();
  }

  int countMenuAds() {
    if (_MenuAds.isNotEmpty) {
      return _MenuAds.length;
    } else {
      return 0;
    }
  }

  void setExpendedMenuListCount(int val){
    _expendedMenuListCount = val;
    notifyListeners();
  }

  void clearExpendedMenuListCount(){
    _expendedMenuListCount = 20;
  }

  void clearMenuFilter(BuildContext context) {
    _menuFilter = null;
  }

  void setMenuFilter(BuildContext context, int assignedMenuFilter) {
    _menuFilter = assignedMenuFilter;
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
    if (_menuMainFilterAds == 1) {
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
    else if (_menuMainFilterAds == 2) {
      var mainProv = Provider.of<MainPageProvider>(context, listen: false);
      mainProv.setWaitMainPage(true);

      if (_filterSearchDrawer == null) {
        mainProv.basicFilter(context);
      } // basic filter .................

      else if (_filterSearchDrawer == 1) {
        mainProv.leftSliderCategoryFilter(context, id_category);
      } // left slider category filter .................

      else if (_filterSearchDrawer == 2) {
        mainProv.twoWeeksAgoFilter(context);
      } // 2 weeks ago filter .................

      else if (_filterSearchDrawer == 4) {
        mainProv.advancedSearchFilter(
            context,
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
      }
      // advanced search filter .................

    }
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



  bool get waitMenu => _waitMenu;
  List<AdsModel> get menuAds => _MenuAds;
  ScrollController get menuController => _menuController;
  int get expendedMenuListCount => _expendedMenuListCount;
  int get filterSearchDrawer => _filterSearchDrawer;
  int get menuMainFilterAds => _menuMainFilterAds;
  int get menuFilterSearch => _menuFilter;



}