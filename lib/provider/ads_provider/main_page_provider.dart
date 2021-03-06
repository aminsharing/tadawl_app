import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/Gist.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/cache_markers_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/general/regions.dart';

class MainPageProvider extends ChangeNotifier{

  MainPageProvider(){
    print('init MainPageProvider');
  }

  @override
  void dispose() {
    print('dispose MainPageProvider');
    try{
    _entry!.remove();
    }catch(e){
      print('Entry remove error: $e');
    }
    if (_showDiaogSearchDrawer) {
      setShowDiogFalse();
    }
    setInItMainPageDone(0);
    super.dispose();
  }

  int _inItMainPageDone = 0;
  int _adsOnMap = 1;
  int _allAds = 0;
  int zoomOutOfRange = 0;
  bool _isMove = false;
  bool _showDiaogSearchDrawer = false;
  bool _waitMainPage = false;
  bool _slider_state = false;
  var _markersMainPage = <Marker>[];
  GoogleMapController? _mapControllerMainPAge;
  final List<AdsModel> _Ads = [];
  AdsModel? _SelectedAdsModelMainPage;
  int? _SelectedAdsIndex;
  OverlayEntry? _entry;
  String? _idCategorySearch;



  void setInItMainPageDone(int val) {
    _inItMainPageDone= val;
    // notifyListeners();
  }

  void setMapControllerMainPage(BuildContext context ,GoogleMapController val) {
    _mapControllerMainPAge = val;
    Provider.of<LocaleProvider>(context, listen: false).mapControllerMainPAge = val;
    notifyListeners();
  }

  void animateToLocation(LatLng position, double zoom) async{
    await _mapControllerMainPAge!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: zoom,
      ),
    ),
    );
  }

  void setMoveState(bool val){
    _isMove = val;
  }

  void setShowDiogFalse() {
    _showDiaogSearchDrawer = false;
    notifyListeners();
  }

  void specificAreaAds(BuildContext context, double zoom){
    if(_Ads.isNotEmpty){
      _allAds = _Ads.length;
      closeAds(zoom);
      _adsOnMap = _Ads.length;
      // _Ads.forEach((element) {
      //   element.entry = OverlayEntry(
      //       builder: (ctxt) {
      //         return _MarkerHelper(
      //           markerWidgets: markerWidgets(ctxt, element),
      //           callback: (bitmaps) {
      //             _markersMainPage.add(mapBitmapsToMarkersMainPage(ctxt, bitmaps, element));
      //             Future.delayed(Duration(seconds: 1), () {
      //               _adsOnMap = _markersMainPage.length;
      //               notifyListeners();
      //             });
      //           },
      //           markerKey: GlobalKey(),
      //         );
      //       },
      //       maintainState: true);
      //   MarkerGenerator(element.entry).generate(context);
      // });
      Future.delayed(Duration(seconds: 4), () {
        if(_markersMainPage.isEmpty){
          if(zoomOutOfRange == 0){
            _adsOnMap = 0;
            if(hasListeners){
              notifyListeners();
            }
            Future.delayed(Duration(seconds: 1), (){
              if(_allAds == 0){
                //Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(1);
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => Regions()),
                // );
              }
            });
          }
        }
      });

      _entry = OverlayEntry(
          builder: (ctxt) {
            return MarkerHelper(
              markerWidgets: markerWidgets(ctxt),
              callback: (bitmaps) {
                _markersMainPage = mapBitmapsToMarkersMainPage(ctxt, bitmaps);
                _adsOnMap = _markersMainPage.length;
                notifyListeners();
                // Future.delayed(Duration(seconds: 1), () {
                //
                // });
              },
            );
          },
          maintainState: true);
      MarkerGenerator(_entry).generate(context);

      // MarkerGenerator(_entry, markerWidgets(context), (bitmaps) {
      //   _markersMainPage = mapBitmapsToMarkersMainPage(context, bitmaps);
      //   notifyListeners();
      // }).generate(context);
    }
  }

  List<Widget> markerWidgets(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return _Ads.map((c) => Provider.of<LocaleProvider>(context, listen: false)
        .locale
        .toString() !=
        'en_US'
        ? c.idSpecial == '1'
        ? getMarkerSpecialWidget(
        ' ${arNumberFormat(int.parse(c.price!))} ', size)
        : Provider.of<CacheMarkerModel>(context, listen: false)
        .getCache(context, c.idAds) ==
        c.idAds
        ? getMarkerViewedWidget(
        ' ${arNumberFormat(int.parse(c.price!))} ', size)
        : getMarkerWidget(' ${arNumberFormat(int.parse(c.price!))} ', size)
        : c.idSpecial == '1'
        ? getMarkerSpecialWidget(
        ' ${numberFormat(int.parse(c.price!))} ', size)
        : Provider.of<CacheMarkerModel>(context, listen: false)
        .getCache(context, c.idAds) ==
        c.idAds
        ? getMarkerViewedWidget(
        ' ${numberFormat(int.parse(c.price!))} ', size)
        : getMarkerWidget(
        ' ${numberFormat(int.parse(c.price!))} ', size)).toList();
  }

  List<Marker> mapBitmapsToMarkersMainPage(BuildContext context, List<Uint8List> bitmaps) {
    var markersList = <Marker>[];
    bitmaps.asMap().forEach((i, bmp) {
      var ad = _Ads[i];
      markersList.add(Marker(
          markerId: MarkerId(' ${ad.price}'),
          position: LatLng(double.parse(ad.lat!), double.parse(ad.lng!)),
          onTap: () {
            Provider.of<CacheMarkerModel>(context, listen: false)
                .updateCache(context, ad.idAds);
            setShowDiogTrue();
            _SelectedAdsModelMainPage = ad;
            _SelectedAdsIndex = i;
            // Provider.of<SearchDrawerProvider>(context, listen: false).getAdsList(context);
          },
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return markersList;
  }

  // Marker mapBitmapsToMarkersMainPageOld(BuildContext context, Uint8List bmp, AdsModel ad) {
  //   return Marker(
  //       markerId: MarkerId(' ${ad.price}'),
  //       position: LatLng(double.tryParse(ad.lat)??26.0, double.tryParse(ad.lng)??46.0),
  //       onTap: () {
  //         Provider.of<CacheMarkerModel>(context, listen: false).updateCache(context, ad.idDescription);
  //         setShowDiogTrue();
  //         _SelectedAdsModelMainPage = ad;
  //         // getUpdatedMarkerState(context, ad);
  //       },
  //       icon: BitmapDescriptor.fromBytes(bmp));
  // }

  Widget markerWidgetsOld(BuildContext context, AdsModel c) {
    final size = MediaQuery.of(context).size;
    return Provider.of<LocaleProvider>(context, listen: false).locale.toString() != 'en_US'
        ?
    c.idSpecial == '1'
        ?
    getMarkerSpecialWidget(' ${arNumberFormat(int.parse(c.price!))} ', size)
        :
    Provider.of<CacheMarkerModel>(context, listen: false).getCache(context, c.idDescription) == c.idDescription
        ?
    getMarkerViewedWidget(' ${arNumberFormat(int.parse(c.price!))} ', size)
        :
    getMarkerWidget(' ${arNumberFormat(int.parse(c.price!))} ', size)
        :
    c.idSpecial == '1'
        ?
    getMarkerSpecialWidget(' ${numberFormat(int.parse(c.price!))} ', size)
        :
    Provider.of<CacheMarkerModel>(context, listen: false).getCache(context, c.idDescription) == c.idDescription
        ?
    getMarkerViewedWidget(' ${numberFormat(int.parse(c.price!))} ', size)
        :
    (getMarkerWidget(' ${numberFormat(int.parse(c.price!))} ', size));
  }

  void closeAds(double zoom){
    if(_Ads.isNotEmpty){
      // ignore: omit_local_variable_types
      for(int i = 0; i < _Ads.length; i++){
        if(i < _Ads.length - 1){
          // ignore: omit_local_variable_types
          AdsModel firstAd = _Ads[i];
          // ignore: omit_local_variable_types
          AdsModel secondAd = _Ads[i+1];
          // ignore: omit_local_variable_types
          bool _isRemovable = calculateDistance(
              LatLng(
                  double.tryParse(firstAd.lat!)!,
                  double.tryParse(firstAd.lng!)!),
              LatLng(
                  double.tryParse(secondAd.lat!)!,
                  double.tryParse(secondAd.lng!)!),
              zoom
          );
          if(_isRemovable){
            if(firstAd.idSpecial != '1'){
              _Ads.remove(firstAd);
              i--;
            }else if(secondAd.idSpecial != '1'){
              _Ads.remove(secondAd);
              i--;
            }
          }
        }
      }
    }
  }

  void clearAdsOnMap(){
    _adsOnMap = 1;
  }

  double getRadius(double val){
    if(val >= 16){
      return 0;
    }else if(val <= 15 && val > 14){
      return 0.2;
    }else if(val <= 14 && val > 13){
      return 1;
    }else if(val <= 13 && val > 12){
      return 2;
    }else if(val <= 12 && val > 11){
      return 2;
    }else if(val <= 11 && val > 10){
      return 3;
    }else if(val <= 10 && val > 9){
      return 4;
    }else{
      return 0;
    }
  }

  bool calculateDistance(LatLng firstAd, LatLng secondAd, double zoom){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((firstAd.latitude - secondAd.latitude) * p)/2 + c(secondAd.latitude * p) * c(firstAd.latitude * p) * (1 - c((firstAd.longitude - secondAd.longitude) * p))/2;
    var calculateDistance = 12742 * asin(sqrt(a));
    if(calculateDistance < getRadius(zoom)){
      return true;
    }else{
      return false;
    }
  }

  Widget getMarkerSpecialWidget(String name, Size size) {
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
              fontSize: (12 + (size.width * .005)) > 18 ? 18 : (12 + (size.width * .005)),
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget getMarkerViewedWidget(String name, Size size) {
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
              fontSize: (12 + (size.width * .005)) > 18 ? 18 : (12 + (size.width * .005)),
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget getMarkerWidget(String name, Size size) {
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
              fontSize: (12 + (size.width * .005)) > 18 ? 18 : (12 + (size.width * .005)),
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
          ' ?????? ';
    } else if (n >= 1000000 && n < 1000000000) {
      return num.substring(0, len - 6) +
          '.' +
          num.substring(len - 6, 1 + (len - 6)) +
          ' ?????????? ';
    } else if (n > 1000000000) {
      return num.substring(0, len - 9) +
          '.' +
          num.substring(len - 9, 1 + (len - 9)) +
          ' ?????????? ';
    } else {
      return num.toString();
    }
  }

  void setShowDiogTrue() {
    _showDiaogSearchDrawer = true;
    notifyListeners();
  }

  int countAds() {
    if (_Ads.isNotEmpty) {
      return _Ads.length;
    } else {
      return 0;
    }
  }

  void setSliderState(bool val) {
    _slider_state = val;
    notifyListeners();
  }

  void setWaitMainPage(bool val){
    _waitMainPage = val;
  }

  void getAds(BuildContext context,List<dynamic> _AdsData, double zoom){
    if(_entry != null){
      try{
        _entry!.remove();
      }catch(e){
        print('Entry remove error: $e');
      }
    }
    _Ads.clear();
    _markersMainPage.clear();
    if(_AdsData.isNotEmpty){
      _AdsData.forEach((element) {
        _Ads.add(AdsModel.ads(element));
      });
      if(zoomOutOfRange == 0){
        specificAreaAds(context, zoom);
        notifyListeners();
      }
    }else{
      if(zoomOutOfRange == 0){
        _adsOnMap = 1;
        notifyListeners();
        Future.delayed(Duration(seconds: 3), (){
          _adsOnMap = 0;
          if(hasListeners) {
            notifyListeners();
          }
        });
        Future.delayed(Duration(seconds: 5), (){
          if(_allAds == 0){
            // try{
            //   Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(1);
            // }catch(e){
            //   print('dispose error cause of multiple zoom gesture: $e');
            // }
            //
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => Regions()),
            // );
          }
        });
      }
    }

  }

  void update(){
    notifyListeners();
  }

  int get inItMainPageDone => _inItMainPageDone;
  String? get idCategorySearch => _idCategorySearch;
  bool get isMove => _isMove;
  bool get showDiaogSearchDrawer => _showDiaogSearchDrawer;
  List<Marker> get markersMainPage => _markersMainPage;
  AdsModel? get SelectedAdsModelMainPage => _SelectedAdsModelMainPage;
  int? get SelectedAdsIndex => _SelectedAdsIndex;
  int get adsOnMap => _adsOnMap;
  int get allAds => _allAds;
  bool get waitMainPage => _waitMainPage;
  GoogleMapController? get mapControllerMainPAge => _mapControllerMainPAge;
  List<AdsModel> get ads => _Ads;
  bool get slider_state => _slider_state;
}


