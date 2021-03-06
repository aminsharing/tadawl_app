import 'dart:typed_data';
import 'package:flutter/rendering.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/Gist.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/utils/constants.dart';
import 'locale_provider.dart';

class RegionProvider extends ChangeNotifier {

  RegionProvider(){
    print('init RegionProvider');
  }

  var _markers = <Marker>[];
  OverlayEntry? _entry;

  @override
  void dispose(){
    print('dispose RegionProvider');
    try{
      _entry!.remove();
    }catch(e){
      print('Region remove entry error: $e');
    }
    _entry = null;
    _markers.clear();
    super.dispose();
  }

  List<Widget> markerWidgets() {
    return cities.map((c) => _getMarkerWidget(c.name)).toList();
  }

  List<Widget> enMarkerWidgets() {
    return engCities.map((e) => _getEnMarkerWidget(e.name)).toList();
  }

  Widget _getMarkerWidget(String name) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: markerBackground,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            name,
            style: CustomTextStyle(
              fontSize: 13,
              color: textColor,
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _getEnMarkerWidget(String name) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: const Color(0xff00cccc),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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

  void getRegionMapList(BuildContext context) {

    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();

    List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
      var markersList = <Marker>[];
      bitmaps.asMap().forEach((i, bmp) {
        final city = _lang != 'en_US' ? cities[i] : engCities[i];
        markersList.add(Marker(
            consumeTapEvents: true,
            markerId: MarkerId(city.name),// d46d1
            position: city.position,
            onTap: () {
              Provider.of<LocaleProvider>(context, listen: false).initialCameraPosition = CameraPosition(target: city.position, zoom: city.zoom);
              Provider.of<LocaleProvider>(context, listen: false).saveCurrentLocation(city.position, city.zoom);
              Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
            },
            icon: BitmapDescriptor.fromBytes(bmp)));
      });
      return markersList;
    }

    if(_entry != null){
      try{
        _entry!.remove();
      }catch(e){
        print('Error to remove region entry: $e');
      }
    }
    if(_lang == 'en_US'){
      _entry = OverlayEntry(
          builder: (context) {
            return MarkerHelper(
              markerWidgets: enMarkerWidgets(),
              callback: (bitmaps) {
                _markers = mapBitmapsToMarkers(bitmaps);
                notifyListeners();
              },
            );
          },
          maintainState: true);
      MarkerGenerator(_entry).generate(context);
    }
    else{
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
    }
  }

  List<Marker> get markers => _markers;
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