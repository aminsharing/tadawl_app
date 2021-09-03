import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

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

  OfficeMarkerProvider(BuildContext context){
    print('init OfficeMarkerProvider');
    aO().then((value) {
      getOfficeListMap(context);
    });
  }

  @override
  void dispose(){
    super.dispose();
    print('dispose OfficeMarkerProvider');
    _entry!.remove();
    _entry = null;
    _markers.clear();
    // _officesList.clear();
  }

  var _markers = <Marker>[];
  final List<OfficeModel> _officesList = [];
  OverlayEntry? _entry;



  Widget _getMarkerWidget(String name) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: const Color(0xffffffff), width: 1),
                color: const Color(0xff00cccc),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  name,
                  style: CustomTextStyle(
                    fontSize: 12,
                    color: const Color(0xffffffff),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff00cccc),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(Icons.home_work),
                )),
          ),
        ],
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
            position: LatLng(double.parse(office.office_lat!),
                double.parse(office.office_lng!)),
            onTap: () {
              final locale = Provider.of<LocaleProvider>(context, listen: false);
              // ignore: omit_local_variable_types
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
            },
            icon: BitmapDescriptor.fromBytes(bmp)));
      });
      return markersList;
    }
    Future.delayed(Duration(milliseconds: 0), () {
      _entry = OverlayEntry(
          builder: (context) {
            return MarkerHelper(
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
  }

  Future aO() async {
    // ignore: omit_local_variable_types
    List<dynamic> value = await Api().getsOfficeFunc();
    _officesList.clear();
    value.forEach((element) {
        _officesList.add(OfficeModel.offices(element));
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


// class _MarkerHelper extends StatefulWidget {
//   final List<Widget>? markerWidgets;
//   final Function(List<Uint8List>)? callback;
//   // ignore: sort_constructors_first
//   const _MarkerHelper({Key? key, this.markerWidgets, this.callback})
//       : super(key: key);
//   @override
//   _MarkerHelperState createState() => _MarkerHelperState();
// }
//
// class _MarkerHelperState extends State<_MarkerHelper> with AfterLayoutMixin {
//   List<GlobalKey> globalKeys = <GlobalKey>[];
//   @override
//   void afterFirstLayout(BuildContext context) {
//     _getBitmaps(context).then((list) {
//       widget.callback!(list);
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform.translate(
//       offset: Offset(MediaQuery.of(context).size.width, 0),
//       child: Material(
//         type: MaterialType.transparency,
//         child: Stack(
//           children: widget.markerWidgets!.map((i) {
//             final markerKey = GlobalKey();
//             globalKeys.add(markerKey);
//             return RepaintBoundary(
//               key: markerKey,
//               child: i,
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
//
//   Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
//     var futures = globalKeys.map((key) => _getUint8List(key));
//     return Future.wait(futures);
//   }
//
//   Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
//     // ignore: omit_local_variable_types
//     RenderRepaintBoundary boundary =
//     markerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     var image = await boundary.toImage(pixelRatio: 2.0);
//     var byteData = await (image.toByteData(format: ui.ImageByteFormat.png) as FutureOr<ByteData>);
//     return byteData.buffer.asUint8List();
//   }
// }
//
// mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!
//         .addPostFrameCallback((_) => afterFirstLayout(context));
//   }
//
//   void afterFirstLayout(BuildContext context);
// }