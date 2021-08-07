import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/Gist.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/OfficeModel.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/my_account.dart';

import 'locale_provider.dart';

class OfficeMarkerProvider extends ChangeNotifier{

  OfficeMarkerProvider(){
    print("init of OfficeMarkerProvider");
    aO();
  }

  var _markers = <Marker>[];
  final List<OfficeModel> _officesList = [];
  OverlayEntry _entry;

  @override
  void dispose(){
    super.dispose();
    print("OfficeMarkerProvider dispose");
    _entry.remove();
    _entry = null;
    _markers.clear();
    // _officesList.clear();
  }

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

  Future getOfficeListMap(BuildContext context) async {
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
              // TODO Changed To my account provider
              // var user = Provider.of<UserMutualProvider>(context, listen: false);
              // user.getAvatarList(office.phone_user);
              // user.getUserAdsList(office.phone_user);
              // user.getEstimatesInfo(office.phone_user);
              // user.getSumEstimatesInfo(office.phone_user);
              // user.checkOfficeInfo(office.phone_user);
              // user.setUserPhone(office.phone_user);
              final locale = Provider.of<LocaleProvider>(context, listen: false);
              final MyAccountProvider myAccountProvider = MyAccountProvider(office.phone_user);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<MyAccountProvider>(
                          create: (_) => myAccountProvider,
                          child: MyAccount(myAccountProvider: myAccountProvider, phone: locale.phone,),
                        )
                ),
              );
              // Future.delayed(Duration(seconds: 0), () {
              //   final locale = Provider.of<LocaleProvider>(context, listen: false);
              //   if (user.userPhone == locale.phone){
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               OwenAccount()),
              //     );
              //   }else{
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               OtherAccount()),
              //     );
              //   }
              // });
            },
            icon: BitmapDescriptor.fromBytes(bmp)));
      });
      return markersList;
    }

    Future.delayed(Duration(milliseconds: 0), () {
      // var a = <String>[];
      // _officesList.forEach((element) {
      //   a.add(element.id_offices);
      // });
      aO().then((value) {
        _entry = OverlayEntry(
            builder: (context) {
              return _MarkerHelper(
                markerWidgets: markerWidgets(),
                callback: (bitmaps) {
                  _markers = mapBitmapsToMarkers(bitmaps);
                  notifyListeners();
                },
              );
            },
            maintainState: true);
        MarkerGenerator(_entry).generate(context);
        notifyListeners();
      });

      // if (_officesList.isEmpty) {
      //   Api().getsOfficeFunc().then((value) {
      //     _OfficeListData = value;
      //     _OfficeListData.forEach((element) {
      //       if(!a.contains(element['id_offices'])){
      //         print("id_officess");
      //         _officesList.add(OfficeModel.offices(element));
      //       }
      //     });
      //     _entry = OverlayEntry(
      //         builder: (context) {
      //           return _MarkerHelper(
      //             markerWidgets: markerWidgets(),
      //             callback: (bitmaps) {
      //               _markers = mapBitmapsToMarkers(bitmaps);
      //             },
      //           );
      //         },
      //         maintainState: true);
      //     MarkerGenerator(_entry).generate(context);
      //     notifyListeners();
      //   });
    });
  }

  Future aO() async {
    var a = <String>[];
    _officesList.forEach((element) {
      a.add(element.id_offices);
    });
    List<dynamic> value = await Api().getsOfficeFunc();
    value.forEach((element) {
      if(!a.contains(element['id_offices'])){
        print("id_officess");
        _officesList.add(OfficeModel.offices(element));
      }
    });
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