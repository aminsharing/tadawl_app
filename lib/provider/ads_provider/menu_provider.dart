import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';

class MenuProvider extends ChangeNotifier{

  MenuProvider(){
    print('init MenuProvider');
  }
  @override
  void dispose() {
    print('dispose MenuProvider');
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    clearExpendedMenuListCount();
    super.dispose();
  }

  // bool _waitMenu = false;
  final List<AdsModel> _MenuAds = [];
  final ScrollController _menuController = ScrollController();
  int _expendedMenuListCount = 20;
  bool _noAdsInRegion = false;
  // int _filterSearchDrawer;
  // int _menuMainFilterAds;
  // int _menuFilter;
  // List _MenuAdsData = [];



  // void setFilterSearchDrawer(int value) {
  //   _filterSearchDrawer = value;
  //   //notifyListeners();
  // }

  // void setMenuMainFilterAds(int val) {
  //   _menuMainFilterAds = val;
  //   //notifyListeners();
  // }

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

  // void getMenuList(BuildContext context) {
  //   // ...... basic array & latest menu ads array ........
  //   if (_menuFilter == null) {
  //     Future.delayed(Duration(milliseconds: 0), () {
  //       _MenuAds.clear();
  //       Api().filterUpToDateAdsFunc().then((value) {
  //         _MenuAdsData = value;
  //         _MenuAdsData.forEach((element) {
  //           _MenuAds.add(AdsModel.ads(element));
  //         });
  //         notifyListeners();
  //       });
  //     });
  //   }
  //   // ...... two weeks ago menu array ........
  //   else if (_menuFilter == 2) {
  //     Future.delayed(Duration(milliseconds: 0), () {
  //       _MenuAds.clear();
  //       Api().getFilterTwoWeeksAgoFunc().then((value) {
  //         _MenuAdsData = value;
  //         _MenuAdsData.forEach((element) {
  //           _MenuAds.add(AdsModel.ads(element));
  //         });
  //         notifyListeners();
  //       });
  //     });
  //   }
  //   // ...... advanced menu search array ........
  //   // else if (_menuFilter == 4) {
  //   //   Future.delayed(Duration(milliseconds: 0), () {
  //   //     _MenuAds.clear();
  //   //     Api().getAdvancedSearchFunc(
  //   //         _selectedCategory,
  //   //         _minPriceSearchDrawer,
  //   //         _maxPriceSearchDrawer,
  //   //         _minSpaceSearchDrawer,
  //   //         _maxSpaceSearchDrawer,
  //   //         _selectedTypeAqarSearchDrawer,
  //   //         _interfaceSelectedSearchDrawer,
  //   //         _selectedPlanSearchDrawer,
  //   //         _ageOfRealEstateSelectedSearchDrawer,
  //   //         _selectedApartmentsSearchDrawer,
  //   //         _floorSelectedSearchDrawer,
  //   //         _selectedLoungesSearchDrawer,
  //   //         _selectedRoomsSearchDrawer,
  //   //         _storesSelectedSearchDrawer,
  //   //         _streetWidthSelectedSearchDrawer,
  //   //         _selectedToiletsSearchDrawer,
  //   //         _treesSelectedSearchDrawer,
  //   //         _wellsSelectedSearchDrawer,
  //   //         _bool_feature1SearchDrawer.toString(),
  //   //         _bool_feature2SearchDrawer.toString(),
  //   //         _bool_feature3SearchDrawer.toString(),
  //   //         _bool_feature4SearchDrawer.toString(),
  //   //         _bool_feature5SearchDrawer.toString(),
  //   //         _bool_feature6SearchDrawer.toString(),
  //   //         _bool_feature7SearchDrawer.toString(),
  //   //         _bool_feature8SearchDrawer.toString(),
  //   //         _bool_feature9SearchDrawer.toString(),
  //   //         _bool_feature10SearchDrawer.toString(),
  //   //         _bool_feature11SearchDrawer.toString(),
  //   //         _bool_feature12SearchDrawer.toString(),
  //   //         _bool_feature13SearchDrawer.toString(),
  //   //         _bool_feature14SearchDrawer.toString(),
  //   //         _bool_feature15SearchDrawer.toString(),
  //   //         _bool_feature16SearchDrawer.toString(),
  //   //         _bool_feature17SearchDrawer.toString(),
  //   //         _bool_feature18SearchDrawer.toString()
  //   //     )
  //   //         .then((value) {
  //   //       _MenuAdsData = value;
  //   //       _MenuAdsData.forEach((element) {
  //   //         _MenuAds.add(AdsModel.ads(element));
  //   //       });
  //   //       notifyListeners();
  //   //     });
  //   //   });
  //   // }
  // }

  void getMenuAds(BuildContext context, List<dynamic> _MenuAdsData){
    _MenuAds.clear();
    _MenuAdsData.forEach((element) {
      _MenuAds.add(AdsModel.ads(element));
    });
    if(_MenuAdsData.isEmpty){
      _noAdsInRegion = true;
    }
    notifyListeners();
    // Future.delayed(Duration(seconds: 3), (){
    //   if(_MenuAds.isEmpty){
    //     _noAdsInRegion = true;
    //     notifyListeners();
    //     Future.delayed(Duration(seconds: 1), (){
    //       Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(1);
    //       Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(builder: (context) => Regions()),
    //       );
    //     });
    //   }else{
    //     _noAdsInRegion = false;
    //     notifyListeners();
    //   }
    // });
    // notifyListeners();
  }

  // bool get waitMenu => _waitMenu;
  List<AdsModel> get menuAds => _MenuAds;
  ScrollController get menuController => _menuController;
  int get expendedMenuListCount => _expendedMenuListCount;
  bool get noAdsInRegion => _noAdsInRegion;
  // int get filterSearchDrawer => _filterSearchDrawer;
  // int get menuMainFilterAds => _menuMainFilterAds;
  // int get menuFilterSearch => _menuFilter;



}