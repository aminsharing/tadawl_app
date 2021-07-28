import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';


import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_location_provider.dart';
import 'package:tadawl_app/provider/user_markers_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class UpdateLocation extends StatelessWidget {
  UpdateLocation(
      this._id_description,
      {
    Key key,
  }) : super(key: key);
  final String _id_description;

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateLocationProvider>(builder: (context, updateLoc, child) {

      print("UpdateLocation -> UpdateLocationProvider");

      var mediaQuery = MediaQuery.of(context);
      Provider.of<UserMarkersProvider>(context, listen: false).getLoc();
      // ignore: omit_local_variable_types
      Map data = {};
      data = ModalRoute
          .of(context)
          .settings
          .arguments;
      // var _id_description = data['id_description'];

      void _onMapCreated(GoogleMapController controller) {
        controller.setMapStyle(Utils.mapStyle);
      }


      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                Provider.of<MutualProvider>(context, listen: false)
                .getAllAdsPageInfo(context, _id_description);

                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdPage()),
                  );
                });
              },
            ),
          ),
          title: Text(
            AppLocalizations
                .of(context)
                .updateLocation,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    updateLoc.ads_city == null
                        ? Text(
                      AppLocalizations
                          .of(context)
                          .city +
                          ' ${Provider.of<MutualProvider>(context, listen: false).adsPage.first.ads_city}',
                      style: CustomTextStyle(
                        fontSize: 13,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    )
                        : Text(
                      AppLocalizations
                          .of(context)
                          .city +
                          ' ${updateLoc.ads_city}',
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    updateLoc.ads_neighborhood == null
                        ? Text(
                      AppLocalizations
                          .of(context)
                          .neighborhood +
                          ' ${Provider.of<MutualProvider>(context, listen: false).adsPage.first.ads_neighborhood}',
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    )
                        : Text(
                      AppLocalizations
                          .of(context)
                          .neighborhood +
                          ' ${updateLoc.ads_neighborhood}',
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition( ///Provider.of<UserMarkersProvider>(context,listen: false).initialCameraPosition
                          target: LatLng(
                              double.parse(
                                  Provider.of<MutualProvider>(context, listen: false).adsPage.first.lat ?? Provider.of<UserMarkersProvider>(context,listen: false).initialCameraPosition.latitude
                              ),
                              double.parse(
                                  Provider.of<MutualProvider>(context, listen: false).adsPage.first.lng ?? Provider.of<UserMarkersProvider>(context,listen: false).initialCameraPosition.longitude
                              ),
                          ),
                          zoom: 13),
                      onMapCreated: _onMapCreated,
                      onCameraMove: (CameraPosition position) {
                        // TODO This changed
                        updateLoc.handleCameraMoveUpdateLoc(position);
                      },
                    ),
                    Center(
                      child: Icon(
                        Icons.my_location_rounded,
                        color: Color(0xff00cccc),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (updateLoc.ads_cordinates == null) {
                    Fluttertoast.showToast(
                        msg: 'تعديل موقع العقار مطلوب',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 15.0);
                  } else {
                    updateLoc.updateLocation(
                        context,
                        _id_description,
                        updateLoc.ads_city,
                        updateLoc.ads_neighborhood,
                        updateLoc.ads_road,
                        updateLoc.ads_cordinates_lat.toString(),
                        updateLoc.ads_cordinates_lng.toString());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Container(
                    width: mediaQuery.size.width * 0.6,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff3f9d28)),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations
                            .of(context)
                            .edit,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff3f9d28),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Utils {
  static String mapStyle = '''[]''';
}
