import 'package:flutter/material.dart';
import 'package:tadawl_app/models/AdsModel.dart';

class MenuProvider extends ChangeNotifier{

  MenuProvider(){
    print('init MenuProvider');
  }
  @override
  void dispose() {
    print('dispose MenuProvider');
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
    clearExpendedMenuListCount();
    super.dispose();
  }

  // bool _waitMenu = false;
  List<AdsModel> _MenuAds = [];
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


  void getMenuAds(List<dynamic> _MenuAdsData){
    _MenuAds.clear();
    _MenuAdsData.forEach((element) {
      _MenuAds.add(AdsModel.adsPage(element));
    });
    // ignore: omit_local_variable_types
    final List<AdsModel> _specialAds = <AdsModel>[];
    _MenuAds.forEach((element) {
      if(element.idSpecial == '1'){
        _specialAds.add(element);
      }
    });
    _specialAds.forEach((element) {
      _MenuAds.remove(element);
    });
    // _MenuAds.sort((a, b) {
    //   return a.timeUpdated!.compareTo(b.timeUpdated!);
    // });
    _MenuAds = [..._specialAds, ..._MenuAds.reversed.toList()];
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