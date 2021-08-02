import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/ads_details_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/map_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({Key key}) : super(key: key);


  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
  }



  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

     Future<bool> _onLocationContinue(String ads_neighborhoodAddAds) {
        return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(
                  AppLocalizations
                      .of(context)
                      .confirmLocationPlace,
                  style: CustomTextStyle(

                    fontSize: 20,
                    color: const Color(0xff00cccc),
                  ).getTextStyle(),
                  textAlign: TextAlign.right,
                ),
                content: Text(
                  AppLocalizations
                      .of(context)
                      .reLocationIn +
                      ' ( $ads_neighborhoodAddAds ) ',
                  style: CustomTextStyle(

                    fontSize: 17,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.right,
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(false);
                        // addAds.setCurrentStageAddAds(5);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdsDetailsScreen()));
                      },
                      child: Text(
                        AppLocalizations
                            .of(context)
                            .yes,
                        style: CustomTextStyle(

                          fontSize: 17,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  //SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Text(
                        AppLocalizations
                            .of(context)
                            .no,
                        style: CustomTextStyle(

                          fontSize: 17,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
        ) ??
            false;
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff00cccc),
          title: Center(
            widthFactor: 2.0,
            child: Text(
              AppLocalizations
                  .of(context)
                  .chooseLocation,
              style: CustomTextStyle(

                fontSize: 20,
                color: const Color(0xffffffff),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffffffff),
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer2<AddAdProvider, MapProvider>(builder: (context, addAds, map, child) {
          print("LocationScreen -> AddAdProvider");
          print("LocationScreen -> MapProvider");
            return SingleChildScrollView(
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
                              .of(context)
                              .city +
                              '${addAds.ads_cityAddAds}',
                          style: CustomTextStyle(

                            fontSize: 13,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .neighborhood +
                              ' ${addAds.ads_neighborhoodAddAds}',
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
                              target: addAds.customCameraPositionAddAds ?? map.initialCameraPosition, zoom: 13),
                          onMapCreated: _onMapCreated,
                          onCameraMove: (CameraPosition position) {
                            addAds.handleCameraMoveAddAds(position);
                          },
                        ),
                        Center(
                          child: Icon(
                            Icons.my_location_rounded,
                            color: Color(0xff00cccc),
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (addAds.ads_cordinatesAddAds == null) {
                        if (map.initialCameraPosition != null) {
                          addAds.setAdsCordinatesAddAds(map.initialCameraPosition);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'حرك الخريطة للوصول لموقع العقار المطلوب',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 15.0);
                        }
                      } else {
                        _onLocationContinue(addAds.ads_neighborhoodAddAds);
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
                                .continuee,
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
            );
          },),
      );
  }
}
class Utils {
  static String mapStyle = '''
  []
  ''';
}