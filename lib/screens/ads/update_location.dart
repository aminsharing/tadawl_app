import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_location_provider.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';

class UpdateLocation extends StatelessWidget {
  UpdateLocation(
      this._id_description,
      {
        Key? key,
        required this.ads,
        required this.lat,
        required this.lng,
        required this.ads_city,
        required this.ads_neighborhood,
        required this.index,
      }) : super(key: key);
  final List<AdsModel?> ads;
  final String? _id_description;
  final String? lat;
  final String? lng;
  final String? ads_city;
  final String? ads_neighborhood;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateLocationProvider>(builder: (context, updateLoc, child) {


      var mediaQuery = MediaQuery.of(context);
      // ignore: omit_local_variable_types
      // Map data = {};
      // data = ModalRoute.of(context).settings.arguments;
      // var _id_description = data['id_description'];

      void _onMapCreated(GoogleMapController controller) {
        controller.setMapStyle(Utils.mapStyle);
      }


      return WillPopScope(
        onWillPop: () async{
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                AdPageHelper(ads: ads, index: index, selectedScreen: SelectedScreen.menu,)
            ),
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
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
                  // mutualProv
                  // .getAllAdsPageInfo(context, _id_description);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        AdPageHelper(ads: ads, index: index, selectedScreen: SelectedScreen.menu,)
                    ),
                  );
                },
              ),
            ),
            title: Text(
              AppLocalizations
                  .of(context)!
                  .updateLocation,
              style: CustomTextStyle(

                fontSize: 20,
                color: const Color(0xffffffff),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xff1f2835),
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
                      Text(
                        AppLocalizations
                            .of(context)!
                            .city +
                            ' ${updateLoc.ads_city ?? ads_city}',
                        style: CustomTextStyle(
                          fontSize: 13,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        AppLocalizations
                            .of(context)!
                            .neighborhood +
                            ' ${updateLoc.ads_neighborhood??ads_neighborhood}',
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
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                double.parse(lat ?? '${updateLoc.ads_cordinates_lat}'),
                                double.parse(lng ?? '${updateLoc.ads_cordinates_lng}'),
                            ),
                            zoom: 13),
                        onMapCreated: _onMapCreated,
                        onCameraMove: (CameraPosition position) {
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
                      if(!updateLoc.isSending){
                        updateLoc.isSending = true;
                        updateLoc.updateLocation(
                            context,
                            _id_description,
                            updateLoc.ads_city,
                            updateLoc.ads_neighborhood,
                            updateLoc.ads_road,
                            updateLoc.ads_cordinates_lat.toString(),
                            updateLoc.ads_cordinates_lng.toString(),
                            ads,
                            index
                        );
                      }

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
                        child: updateLoc.isSending
                            ?
                        LinearProgressIndicator()
                            :
                        Text(
                          AppLocalizations
                              .of(context)!
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
        ),
      );
    });
  }
}

class Utils {
  static String mapStyle = '''[]''';
}
