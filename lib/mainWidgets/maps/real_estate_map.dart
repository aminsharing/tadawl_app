import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/RegionModel.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/office_marker_provider.dart';
import 'package:tadawl_app/screens/general/regions.dart';

class RealEstateMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OfficeMarkerProvider>(builder: (context, realEstate, child) {


      void _onMapCreated(GoogleMapController controller) {
        controller.setMapStyle(Utils.mapStyle);
      }
      // if(realEstate.markers.isEmpty){
      //   realEstate.getOfficeListMap(context, showOnMap: true);
      // }


      return Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(24.7790412871858, 46.767165544575), zoom: 13),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              markers: realEstate.markers.toSet(),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              onCameraMove: (cameraPosition) {
                if (cameraPosition.zoom <= 5) {
                  Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(1);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Regions()),
                  );
                }
              }),
        ),
      );
    });
  }
}
