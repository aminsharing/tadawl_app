import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/ads_details_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/search_on_map.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen(this.addAdProvider,{Key? key}) : super(key: key);
  final AddAdProvider addAdProvider;

  
  



  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    void _onMapCreated(GoogleMapController controller) {
      controller.setMapStyle(Utils.mapStyle);
      Provider.of<AddAdProvider>(context, listen: false).mapController = controller;
    }

     Future<bool?> _onLocationContinue(String? ads_neighborhoodAddAds) {
        return showDialog<bool>(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(
                  AppLocalizations
                      .of(context)!
                      .confirmLocationPlace,
                  style: CustomTextStyle(
                    fontSize: 20,
                    color: const Color(0xff04B404),
                  ).getTextStyle(),
                  textAlign: TextAlign.right,
                ),
                content: Text(
                  AppLocalizations
                      .of(context)!
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        ChangeNotifierProvider<AddAdProvider>.value(
                          value: addAdProvider,
                          child: AdsDetailsScreen(addAdProvider),
                        )
                        ));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.yes,
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
                            .of(context)!
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
        );
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1f2835),
          title: Center(
            widthFactor: 2.0,
            child: Text(
              AppLocalizations
                  .of(context)!
                  .chooseLocation,
              style: CustomTextStyle(
                fontSize: 20,
                color: const Color(0xffffffff),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          leadingWidth: 70.0,
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
        body: Consumer<AddAdProvider>(builder: (context, addAds, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SearchOnMap(
                  selectedPage: SelectedPage.locationScreen,
                  // SearchMapPlaceWidget(
                  //   language: 'ar',
                  //   hasClearButton: true,
                  //   iconColor: Color(0xff04B404),
                  //   placeType: PlaceType.geocode,
                  //   placeholder: AppLocalizations.of(context).trySearching,
                  //   apiKey: 'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
                  //   onSelected: (Place place) async {
                  //     await place.geolocation.then((value) async{
                  //       addAds.animateToLocation(value.coordinates, 13);
                  //     });
                  //   },
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.city + '${addAds.ads_cityAddAds}',
                        style: CustomTextStyle(
                          fontSize: 13,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        AppLocalizations.of(context)!.neighborhood + ' ${addAds.ads_neighborhoodAddAds}',
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
                (addAds.customCameraPositionAddAds ?? addAds.initialCameraPosition) == null
                    ?
                Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xff04B404),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff1f2835)
                        ),
                      ),
                    )
                )
                    :
                SizedBox(
                  height: mediaQuery.size.height * .55,
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
                            target: addAds.customCameraPositionAddAds ?? addAds.initialCameraPosition!, zoom: 13),
                        onMapCreated: _onMapCreated,
                        onCameraMove: (CameraPosition position) {
                          addAds.handleCameraMoveAddAds(position);
                        },
                      ),
                      Center(
                        child: Icon(
                          Icons.my_location_rounded,
                          color: Color(0xff04B404),
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (addAds.ads_cordinatesAddAds == null) {
                      if (addAds.initialCameraPosition != null) {
                        addAds.setAdsCordinatesAddAds(addAds.initialCameraPosition);
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
                              .of(context)!
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