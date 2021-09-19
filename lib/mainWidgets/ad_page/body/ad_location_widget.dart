import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdLocationWidget extends StatelessWidget {
  AdLocationWidget({Key? key}) : super(key: key);
  
  Future<void> _openMap(String latitude, String longitude) async {
    var googleUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    // 'https://www.google.com/maps/search/?provider.api=1&query=$latitude,$longitude';
    await launch(googleUrl);
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return  Consumer<AdPageProvider>(
        builder: (context, adsPage, child) {
          return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.locServ,
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () {
                      Share.share('https://www.google.com/maps/dir/?api=1&destination=${adsPage.adsPage!.lat!},${adsPage.adsPage!.lng!}');
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (adsPage.adsPage != null)
              Container(
                  width: mediaQuery.size.width * .9,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff04B404).withAlpha(150)
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        onTap: (value) {
                          adsPage.stopVideoAdsPage();
                          _openMap(adsPage.adsPage!.lat!, adsPage.adsPage!.lng!);
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                double.parse(
                                    adsPage.adsPage!.lat!),
                                double.parse(
                                    adsPage.adsPage!.lng!)),
                            zoom: 15),
                        mapType: MapType.normal,
                        onMapCreated: _onMapCreated,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                      ),
                      Center(
                        child: Icon(
                          Icons.my_location_rounded,
                          color: Color(0xff00cccc),
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        );
      },
    );
  }
}

class Utils {
  static String mapStyle = '''
  []
  ''';
}