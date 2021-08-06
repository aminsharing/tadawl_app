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
import 'package:tadawl_app/provider/cache_markers_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class MainPageProvider extends ChangeNotifier{

  MainPageProvider(){
    print("MainPageProvider init");
  }

  @override
  void dispose() {
    print("MainPageProvider dispose");
    if (_showDiaogSearchDrawer) {
      setShowDiogFalse();
    }
    setRegionPosition(null);
    setInItMainPageDone(0);
    removeMarkers();
    super.dispose();
  }

  int _inItMainPageDone = 0;
  String _idCategorySearch;
  CameraPosition _region_position;
  bool _isMove = false;
  int _adsOnMap = 1;
  bool _showDiaogSearchDrawer = false;
  final _markersMainPage = <Marker>[];
  AdsModel _SelectedAdsModelMainPage;
  int _slider_state = 1;

  GoogleMapController _mapControllerMainPAge;
  CameraPosition _selectedArea = CameraPosition(target: cities.first.position, zoom: cities.first.zoom);
  final List<AdsModel> _Ads = [];
  bool _waitMainPage = false;

  void setInItMainPageDone(int val) {
    _inItMainPageDone= val;
    // notifyListeners();
  }

  void setMapControllerMainPage(GoogleMapController val) {
    _mapControllerMainPAge = val;
    notifyListeners();
  }

  void animateToMyLocation(BuildContext context) async{
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

  void animateToLocation(LatLng position, double zoom) async{
    await _mapControllerMainPAge.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: zoom,
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
          // removeMarkers();
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
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xffe6b800), width: 1),
          color: const Color(0xffe6b800),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            name,
            style: CustomTextStyle(
              fontSize: 13,
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
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xff989696), width: 1),
          color: const Color(0xff989696),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            name,
            style: CustomTextStyle(
              fontSize: 13,
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
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xff00cccc), width: 1),
          color: const Color(0xff00cccc),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            name,
            style: CustomTextStyle(
              fontSize: 13,
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
          getUpdatedMarkerState2(context, ad);
        },
        icon: BitmapDescriptor.fromBytes(bmp));
  }

  void setShowDiogTrue() {
    _showDiaogSearchDrawer = true;
    notifyListeners();
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

  void setWaitMainPage(bool val){
    _waitMainPage = val;
  }

  void getAds(BuildContext context,List<dynamic> _AdsData){
    _Ads.clear();
    _AdsData.forEach((element) {
      print("id_description1");
      _Ads.add(AdsModel.ads(element));
    });
    spicificAreaAds2(context);
    notifyListeners();
  }

  // void getAdsList(BuildContext context) {
  //   // ...... basic array ........
  //   if (_filter == null) {
  //     Future.delayed(Duration(milliseconds: 0), () {
  //       List<String> a = <String>[];
  //       _Ads.forEach((element) {
  //         element.entry.remove();
  //         a.add(element.idDescription);
  //       });
  //       _Ads.clear();
  //       Api().getadsFunc().then((value) {
  //         _AdsData = value;
  //         print("aaaaaaaaaaaaaaaaaaaaaa ${a.length}");
  //         print("bbbbbbbbbbbbbbbbbbbbbb ${_AdsData.length}");
  //         _AdsData.forEach((element) {
  //           // if(!a.contains(element['id_description'])){
  //             print("id_description1");
  //             _Ads.add(AdsModel.ads(element));
  //           // }
  //         });
  //         spicificAreaAds2(context);
  //         notifyListeners();
  //       });
  //     });
  //   }
  //   // ...... left slider category array ........
  //   else if (_filter == 1) {
  //     Future.delayed(Duration(milliseconds: 0), () {
  //       List<String> a = <String>[];
  //       _Ads.forEach((element) {
  //         try{
  //           element.entry.remove();
  //         }catch(e){
  //           print("Cannot remove Overlaye: $e");
  //         }
  //         a.add(element.idDescription);
  //       });
  //       _Ads.clear();
  //       Api().getFilterAdsFunc(_idCategorySearch)
  //           .then((value) {
  //         _AdsData = value;
  //         print("aaaaaaaaaaaaaaaaaaaaaa 1 ${a.length}");
  //         print("bbbbbbbbbbbbbbbbbbbbbb 1 ${_AdsData.length}");
  //         _AdsData.forEach((element) {
  //           // if(!a.contains(element['id_description'])){
  //             print("id_description2");
  //             _Ads.add(AdsModel.ads(element));
  //           // }
  //         });
  //         spicificAreaAds2(context);
  //         notifyListeners();
  //       });
  //     });
  //   }
  //   // ...... two weeks ago array ........
  // else if (_filter == 2 && _isTwoWeeksAgoSearchDrawer) {
  //     Future.delayed(Duration(milliseconds: 0), () {
  //       List<String> a = <String>[];
  //       _Ads.forEach((element) {
  //         element.entry.remove();
  //         a.add(element.idDescription);
  //       });
  //       _Ads.clear();
  //       Api().getFilterTwoWeeksAgoFunc().then((value) {
  //         _AdsData = value;
  //         print("aaaaaaaaaaaaaaaaaaaaaa 2 ${a.length}");
  //         print("bbbbbbbbbbbbbbbbbbbbbb 2 ${_AdsData.length}");
  //         _AdsData.forEach((element) {
  //           // if(!a.contains(element['id_description'])){
  //             print("id_description3");
  //             _Ads.add(AdsModel.ads(element));
  //           // }
  //         });
  //         spicificAreaAds2(context);
  //         notifyListeners();
  //       });
  //     });
  //   }
  //   // ...... advanced search filter ........
  //   else if (_filter == 4) {
  //     Future.delayed(Duration(milliseconds: 0), () {
  //       List<String> a = <String>[];
  //       _Ads.forEach((element) {
  //         element.entry.remove();
  //         a.add(element.idDescription);
  //       });
  //       _Ads.clear();
  //       Api()
  //           .getAdvancedSearchFunc(
  //           _selectedCategory,
  //           _minPriceSearchDrawer,
  //           _maxPriceSearchDrawer,
  //           _minSpaceSearchDrawer,
  //           _maxSpaceSearchDrawer,
  //           _selectedTypeAqarSearchDrawer,
  //           _interfaceSelectedSearchDrawer,
  //           _selectedPlanSearchDrawer,
  //           _ageOfRealEstateSelectedSearchDrawer,
  //           _selectedApartmentsSearchDrawer,
  //           _floorSelectedSearchDrawer,
  //           _selectedLoungesSearchDrawer,
  //           _selectedRoomsSearchDrawer,
  //           _storesSelectedSearchDrawer,
  //           _streetWidthSelectedSearchDrawer,
  //           _selectedToiletsSearchDrawer,
  //           _treesSelectedSearchDrawer,
  //           _wellsSelectedSearchDrawer,
  //           _bool_feature1SearchDrawer.toString(),
  //           _bool_feature2SearchDrawer.toString(),
  //           _bool_feature3SearchDrawer.toString(),
  //           _bool_feature4SearchDrawer.toString(),
  //           _bool_feature5SearchDrawer.toString(),
  //           _bool_feature6SearchDrawer.toString(),
  //           _bool_feature7SearchDrawer.toString(),
  //           _bool_feature8SearchDrawer.toString(),
  //           _bool_feature9SearchDrawer.toString(),
  //           _bool_feature10SearchDrawer.toString(),
  //           _bool_feature11SearchDrawer.toString(),
  //           _bool_feature12SearchDrawer.toString(),
  //           _bool_feature13SearchDrawer.toString(),
  //           _bool_feature14SearchDrawer.toString(),
  //           _bool_feature15SearchDrawer.toString(),
  //           _bool_feature16SearchDrawer.toString(),
  //           _bool_feature17SearchDrawer.toString(),
  //           _bool_feature18SearchDrawer.toString())
  //           .then((value) {
  //         _AdsData = value;
  //         print("aaaaaaaaaaaaaaaaaaaaaa 4 ${a.length}");
  //         print("bbbbbbbbbbbbbbbbbbbbbb 4 ${_AdsData.length}");
  //         _AdsData.forEach((element) {
  //           // if(!a.contains(element['id_description'])){
  //             print("id_description4");
  //             _Ads.add(AdsModel.ads(element));
  //           // }
  //         });
  //         spicificAreaAds2(context);
  //         notifyListeners();
  //       });
  //     });
  //   }
  // }

  int get inItMainPageDone => _inItMainPageDone;
  String get idCategorySearch => _idCategorySearch;
  // String get selectedCategory => _selectedCategory;
  // String get minPriceSearchDrawer => _minPriceSearchDrawer;
  // String get maxSpaceSearchDrawer => _maxSpaceSearchDrawer;
  // String get minSpaceSearchDrawer => _minSpaceSearchDrawer;
  // String get selectedLoungesSearchDrawer => _selectedLoungesSearchDrawer;
  // String get selectedToiletsSearchDrawer => _selectedToiletsSearchDrawer;
  // String get selectedRoomsSearchDrawer => _selectedRoomsSearchDrawer;
  // String get selectedApartmentsSearchDrawer => _selectedApartmentsSearchDrawer;
  // String get selectedPlanSearchDrawer => _selectedPlanSearchDrawer;
  // String get storesSelectedSearchDrawer => _storesSelectedSearchDrawer;
  // String get floorSelectedSearchDrawer => _floorSelectedSearchDrawer;
  // String get selectedFamilyTypeSearchDrawer => _selectedFamilyTypeSearchDrawer;
  // String get treesSelectedSearchDrawer => _treesSelectedSearchDrawer;
  // String get wellsSelectedSearchDrawer => _wellsSelectedSearchDrawer;
  // bool get isTwoWeeksAgoSearchDrawer => _isTwoWeeksAgoSearchDrawer;
  // bool get bool_feature1SearchDrawer => _bool_feature1SearchDrawer;
  // bool get bool_feature2SearchDrawer => _bool_feature2SearchDrawer;
  // bool get bool_feature3SearchDrawer => _bool_feature3SearchDrawer;
  // bool get bool_feature4SearchDrawer => _bool_feature4SearchDrawer;
  // bool get bool_feature5SearchDrawer => _bool_feature5SearchDrawer;
  // bool get bool_feature6SearchDrawer => _bool_feature6SearchDrawer;
  // bool get bool_feature7SearchDrawer => _bool_feature7SearchDrawer;
  // bool get bool_feature8SearchDrawer => _bool_feature8SearchDrawer;
  // bool get bool_feature9SearchDrawer => _bool_feature9SearchDrawer;
  // bool get bool_feature10SearchDrawer => _bool_feature10SearchDrawer;
  // bool get bool_feature11SearchDrawer => _bool_feature11SearchDrawer;
  // bool get bool_feature12SearchDrawer => _bool_feature12SearchDrawer;
  // bool get bool_feature13SearchDrawer => _bool_feature13SearchDrawer;
  // bool get bool_feature14SearchDrawer => _bool_feature14SearchDrawer;
  // bool get bool_feature15SearchDrawer => _bool_feature15SearchDrawer;
  // bool get bool_feature16SearchDrawer => _bool_feature16SearchDrawer;
  // bool get bool_feature17SearchDrawer => _bool_feature17SearchDrawer;
  // bool get bool_feature18SearchDrawer => _bool_feature18SearchDrawer;
  // String get maxPriceSearchDrawer => _maxPriceSearchDrawer;
  // String get selectedTypeAqarSearchDrawer => _selectedTypeAqarSearchDrawer;
  // String get interfaceSelectedSearchDrawer => _interfaceSelectedSearchDrawer;
  // String get streetWidthSelectedSearchDrawer => _streetWidthSelectedSearchDrawer;
  // String get ageOfRealEstateSelectedSearchDrawer => _ageOfRealEstateSelectedSearchDrawer;
  CameraPosition get region_position => _region_position;
  bool get isMove => _isMove;
  bool get showDiaogSearchDrawer => _showDiaogSearchDrawer;
  List<Marker> get markersMainPage => _markersMainPage;
  AdsModel get SelectedAdsModelMainPage => _SelectedAdsModelMainPage;
  int get adsOnMap => _adsOnMap;
  bool get waitMainPage => _waitMainPage;
  GoogleMapController get mapControllerMainPAge => _mapControllerMainPAge;
  List<AdsModel> get ads => _Ads;
  // int get filterSearch => _filter;
  int get slider_state => _slider_state;




  /// Start Mutual get with Search Drawer
  // List<bool> get planSearchDrawer => _planSearchDrawer;
  // List<bool> get loungesSearchDrawer => _loungesSearchDrawer;
  // List<bool> get toiletsSearchDrawer => _toiletsSearchDrawer;
  // List<bool> get roomsSearchDrawer => _roomsSearchDrawer;
  // List<bool> get apartmentsSearchDrawer => _apartmentsSearchDrawer;
  // List<bool> get familyTypeSearchDrawer => _familyTypeSearchDrawer;
  // List<bool> get typeAqarSearchDrawer => _typeAqarSearchDrawer;

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