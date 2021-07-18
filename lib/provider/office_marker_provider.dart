import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/Gist.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/OfficeModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/my_account.dart';

class OfficeMarkerProvider extends ChangeNotifier{
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _markers = <Marker>[];
  final List<OfficeModel> _officesList = [];
  List _OfficeListData = [];
  OverlayEntry _entry;


  Widget _getMarkerWidget(String name) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffffffff), width: 1),
          color: const Color(0xff00cccc),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            name,
            style: CustomTextStyle(

              fontSize: 15,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void getOfficeListMap(BuildContext context, {bool showOnMap = false}) {
    List<Widget> markerWidgets() {
      return _officesList
          .map((c) => _getMarkerWidget('${c.office_name ?? ""}'))
          .toList();
    }

    List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
      var markersList = <Marker>[];
      bitmaps.asMap().forEach((i, bmp) {
        final office = _officesList[i];

        // ignore: unrelated_type_equality_checks
        markersList.add(Marker(
            markerId: MarkerId('${office.office_name ?? ""}'),
            position: LatLng(double.parse(office.office_lat),
                double.parse(office.office_lng)),
            onTap: () {
              var user = Provider.of<UserMutualProvider>(context, listen: false);
              user.getAvatarList(context, office.phone_user);
              user.getUserAdsList(context, office.phone_user);
              user.getEstimatesInfo(context, office.phone_user);
              user.getSumEstimatesInfo(context, office.phone_user);
              user.checkOfficeInfo(context, office.phone_user);
              user.setUserPhone(office.phone_user);
              Future.delayed(Duration(seconds: 0), () {
                Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: MyAccount())
                );
              });
            },
            icon: BitmapDescriptor.fromBytes(bmp)));
      });
      return markersList;
    }

    // void getOfficeList(BuildContext context) {
    //   Future.delayed(Duration(milliseconds: 0), () {
    //     if (_officesList.isEmpty) {
    //       Api().getsOfficeFunc(context).then((value) {
    //         _OfficeListData = value;
    //         _OfficeListData.forEach((element) {
    //           _officesList.add(OfficeModel(
    //             office_name: element['office_name'],
    //             phone_user: element['phone_user'],
    //             office_lat: element['office_lat'],
    //             office_lng: element['office_lng'],
    //             state: element['state'],
    //           ));
    //         });
    //         // notifyListeners();
    //       });
    //     } else {
    //       Api().getsOfficeFunc(context).then((value) {
    //         _OfficeListData = value;
    //         _officesList.clear();
    //         _OfficeListData.forEach((element) {
    //           _officesList.add(OfficeModel(
    //             office_name: element['office_name'],
    //             phone_user: element['phone_user'],
    //             office_lat: element['office_lat'],
    //             office_lng: element['office_lng'],
    //             state: element['state'],
    //           ));
    //         });
    //         // notifyListeners();
    //       });
    //     }
    //   });
    // }

    Future.delayed(Duration(milliseconds: 0), () {
      if (_officesList.isEmpty) {
        Api().getsOfficeFunc(context).then((value) {
          _OfficeListData = value;
          _OfficeListData.forEach((element) {
            _officesList.add(OfficeModel(
              office_name: element['office_name'],
              phone_user: element['phone_user'],
              office_lat: element['office_lat'],
              office_lng: element['office_lng'],
              state: element['state'],
            ));
          });
          if(showOnMap){
            if(_entry != null){
              _entry.remove();
              _entry = OverlayEntry(
                  builder: (context) {
                    return _MarkerHelper(
                      markerWidgets: markerWidgets(),
                      callback: (bitmaps) {
                        _markers = mapBitmapsToMarkers(bitmaps);
                      },
                    );
                  },
                  maintainState: true);
              var overlayState = Overlay.of(context);
              overlayState.insert(_entry);
            }else{
              _entry = OverlayEntry(
                  builder: (context) {
                    return _MarkerHelper(
                      markerWidgets: markerWidgets(),
                      callback: (bitmaps) {
                        _markers = mapBitmapsToMarkers(bitmaps);
                      },
                    );
                  },
                  maintainState: true);
              MarkerGenerator(_entry).generate(context);
            }
          }else{
            if(_entry != null){
              _entry.remove();
              _entry = null;
            }
          }

          notifyListeners(); // TODO Added
        });
      }
      else {
        Api().getsOfficeFunc(context).then((value) {
          _OfficeListData = value;
          _officesList.clear();
          _OfficeListData.forEach((element) {
            _officesList.add(OfficeModel(
              office_name: element['office_name'],
              phone_user: element['phone_user'],
              office_lat: element['office_lat'],
              office_lng: element['office_lng'],
              state: element['state'],
            ));
          });
          if(showOnMap){
            if(_entry != null){
              _entry.remove();
              _entry = OverlayEntry(
                  builder: (context) {
                    return _MarkerHelper(
                      markerWidgets: markerWidgets(),
                      callback: (bitmaps) {
                        _markers = mapBitmapsToMarkers(bitmaps);
                      },
                    );
                  },
                  maintainState: true);
              var overlayState = Overlay.of(context);
              overlayState.insert(_entry);
            }else{
              _entry = OverlayEntry(
                  builder: (context) {
                    return _MarkerHelper(
                      markerWidgets: markerWidgets(),
                      callback: (bitmaps) {
                        _markers = mapBitmapsToMarkers(bitmaps);
                      },
                    );
                  },
                  maintainState: true);
              MarkerGenerator(_entry).generate(context);
            }


          }else{
            if(_entry != null){
              _entry.remove();
              _entry = null;
            }
          }

          notifyListeners(); // TODO Added
        });
      }
    });
  }

  void removeMarkers(){
    if(_entry != null){
      _entry.remove();
      _entry = null;
      _markers.clear();
    }
  }

  void getOfficeList(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_officesList.isEmpty) {
        Api().getsOfficeFunc(context).then((value) {
          _OfficeListData = value;
          _OfficeListData.forEach((element) {
            _officesList.add(OfficeModel(
              office_name: element['office_name'],
              phone_user: element['phone_user'],
              office_lat: element['office_lat'],
              office_lng: element['office_lng'],
              state: element['state'],
            ));
          });
        });
      } else {
        Api().getsOfficeFunc(context).then((value) {
          _OfficeListData = value;
          _officesList.clear();
          _OfficeListData.forEach((element) {
            _officesList.add(OfficeModel(
              office_name: element['office_name'],
              phone_user: element['phone_user'],
              office_lat: element['office_lat'],
              office_lng: element['office_lng'],
              state: element['state'],
            ));
          });
        });
      }
    });
  }

  void clearMarkers(){
    _markers.clear();
  }

  int countOffices() {
    if (_officesList.isNotEmpty) {
      return _officesList.length;
    } else {
      return 0;
    }
  }

  List<Marker> get markers => _markers;
  List<OfficeModel> get officesList => _officesList;
}


class _MarkerHelper extends StatefulWidget {
  final List<Widget> markerWidgets;
  final Function(List<Uint8List>) callback;
  // ignore: sort_constructors_first
  const _MarkerHelper({Key key, this.markerWidgets, this.callback})
      : super(key: key);
  @override
  _MarkerHelperState createState() => _MarkerHelperState();
}

class _MarkerHelperState extends State<_MarkerHelper> with AfterLayoutMixin {
  List<GlobalKey> globalKeys = <GlobalKey>[];
  @override
  void afterFirstLayout(BuildContext context) {
    _getBitmaps(context).then((list) {
      widget.callback(list);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(MediaQuery.of(context).size.width, 0),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: widget.markerWidgets.map((i) {
            final markerKey = GlobalKey();
            globalKeys.add(markerKey);
            return RepaintBoundary(
              key: markerKey,
              child: i,
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
    var futures = globalKeys.map((key) => _getUint8List(key));
    return Future.wait(futures);
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