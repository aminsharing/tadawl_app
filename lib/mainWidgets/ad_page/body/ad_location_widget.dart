import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AdLocationWidget extends StatelessWidget {
  AdLocationWidget({Key key, this.adsPage, this.ads}) : super(key: key);

  final AdsProvider adsPage;
  final List<AdsModel> ads;


  Future<void> _openMap(double latitude, double longitude) async {
    var googleUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    // 'https://www.google.com/maps/search/?provider.api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).locServ,
                style: CustomTextStyle(

                  fontSize: 20,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        if (ads.isNotEmpty)
          InkWell(
            onTap: () {
              adsPage.stopVideoAdsPage();
              _openMap(double.parse(ads.first.lat),
                  double.parse(ads.first.lng));
              //MapUtils.openMap();
            },
            child: Container(
              width: mediaQuery.size.width,
              height: 300,
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            double.parse(
                                ads.first.lat),
                            double.parse(
                                ads.first.lng)),
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
          )
        else
          Container(),
      ],
    );
  }
}

class Utils {
  static String mapStyle = '''
  []
  ''';
}