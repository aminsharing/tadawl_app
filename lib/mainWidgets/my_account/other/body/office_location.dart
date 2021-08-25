import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficeLocation extends StatelessWidget {
  const OfficeLocation({Key key}) : super(key: key);

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
  }

  Future<void> _openMap(double latitude, double longitude) async {
    var googleUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    // 'https://www.google.com/maps/search/?provider.api=1&query=$latitude,$longitude';
    await launch(googleUrl);
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<MyAccountProvider>(builder: (context, userMutual, child) {
      return userMutual.offices != null
          ?
      userMutual.offices.state == '1'
          ?
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              AppLocalizations.of(context).officeLoc,
              style: CustomTextStyle(
                fontSize: 20,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: mediaQuery.size.width*.9,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xff00cccc)
                )
            ),
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  onTap: (value){
                    _openMap(double.parse(userMutual.offices.office_lat),
                        double.parse(userMutual.offices.office_lng));
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(userMutual.offices.office_lat),
                          double.parse(userMutual.offices.office_lng)),
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
                  child: IconButton(
                    onPressed: (){
                      _openMap(double.parse(userMutual.offices.office_lat),
                          double.parse(userMutual.offices.office_lng));
                    },
                    icon: Icon(
                      Icons.my_location_rounded,
                      color: Color(0xff04B404),
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          :
      Container()
          :
      Container();
    });
  }
}

class Utils {
  static String mapStyle = '''
 [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]
  ''';
}