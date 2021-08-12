import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/map_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/screens/general/regions.dart';

class MapWidget extends StatelessWidget {
  MapWidget(this._region_position ,{Key key}) : super(key: key);
  final CameraPosition _region_position;

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchDrawerProvider>(context, listen: false).getAdsList(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xffffffff), //Color(0xff1f2835),
      child: Center(
        child: Consumer2<MainPageProvider, MapProvider>(
            builder: (context, mainPage, mapProv, _) {
              void _onMapCreated(GoogleMapController controller) {
                controller.setMapStyle(Utils.mapStyle);
                mainPage.setMapControllerMainPage(controller);
              }
              if (mapProv.initialCameraPosition != null) {
                // mainPage.setSelectedArea(mainPage.region_position ??
                //     CameraPosition(target: mapProv.initialCameraPosition,
                //         zoom: mapProv.zoom));
              }
              return Stack(
                children: [
                  Listener(
                    onPointerMove: (move) {
                      mainPage.setMoveState(true);
                    },
                    onPointerUp: (move){
                      if(mainPage.isMove){
                        if(mainPage.showDiaogSearchDrawer){
                          mainPage.setShowDiogFalse();
                        }
                        Provider.of<SearchDrawerProvider>(context, listen: false).getAdsList(context);
                        mainPage.setMoveState(false);
                      }
                    },
                    child:
                    (_region_position??mapProv.initialCameraPosition) == null
                        ?
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xff00cccc),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff1f2835)),
                          ),
                        ),
                      ),
                    )
                        :
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: GoogleMap(
                        onTap: (d) {
                          if (mainPage.showDiaogSearchDrawer) {
                            mainPage.setShowDiogFalse();
                          }
                        },
                        initialCameraPosition: _region_position ?? CameraPosition(target: mapProv.initialCameraPosition, zoom: mapProv.zoom),
                        mapType: MapType.normal,
                        onMapCreated: _onMapCreated,
                        markers: mainPage.markersMainPage.toSet(),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        scrollGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                        onCameraMove: (cameraPosition) {
                          final locale = Provider.of<LocaleProvider>(context, listen: false);
                          locale.currentArea = cameraPosition;

                          if (cameraPosition.zoom <= 5) {
                            Provider.of<BottomNavProvider>(context, listen: false)
                                .setCurrentPage(1);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Regions()),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  //  : Container(),
                  mainPage.showDiaogSearchDrawer
                      ?
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * .2,
                    left: MediaQuery.of(context).size.width * .1,
                    child: Visibility(
                      visible: mainPage.showDiaogSearchDrawer,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Provider.of<MutualProvider>(context, listen: false)
                                    .getAllAdsPageInfo(
                                    context,
                                    mainPage.SelectedAdsModelMainPage.idDescription);
                                Provider.of<MutualProvider>(
                                    context, listen: false)
                                    .getSimilarAdsList(context,
                                    mainPage.SelectedAdsModelMainPage
                                        .idCategory,
                                    mainPage.SelectedAdsModelMainPage
                                        .idDescription);

                                if (mainPage.showDiaogSearchDrawer) {
                                  mainPage.setShowDiogFalse();
                                }
                                Future.delayed(Duration(seconds: 0),
                                        () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdPage()),
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.white),
                                height: 150,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.8,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 5,
                                      child: Stack(children: [
                                        CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          imageUrl: 'https://tadawl-store.com/API/assets/images/ads/' +
                                              mainPage
                                                  .SelectedAdsModelMainPage
                                                  .ads_image ??
                                              '',
                                          height: 150,
                                          width: 180,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              Random().nextInt(50).toDouble(),
                                              Random().nextInt(50).toDouble(),
                                              5,
                                              5),
                                          child: Opacity(
                                            opacity: 0.7,
                                            child: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: const CachedNetworkImageProvider(
                                                      'https://tadawl-store.com/API/assets/images/logo22.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            mainPage.SelectedAdsModelMainPage
                                                .title ??
                                                '',
                                            style: CustomTextStyle(

                                              fontSize: 16,
                                              color: Colors.black,
                                            ).getTextStyle(),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                mainPage
                                                    .SelectedAdsModelMainPage
                                                    .price
                                                    .toString(),
                                                style:
                                                CustomTextStyle(

                                                  fontSize: 16,
                                                  color:
                                                  Color(0xff00cccc),
                                                ).getTextStyle(),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .fromLTRB(
                                                    0, 0, 5, 0),
                                                child: Text(
                                                  'ريال',
                                                  style: CustomTextStyle(
                                                    fontSize: 16,
                                                    color: Color(
                                                        0xff00cccc),
                                                  ).getTextStyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                mainPage
                                                    .SelectedAdsModelMainPage
                                                    .space,
                                                style:
                                                CustomTextStyle(

                                                  fontSize: 12,
                                                  color: Colors.black45,
                                                ).getTextStyle(),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .fromLTRB(
                                                    0, 0, 5, 0),
                                                child: Text(
                                                  'م2',
                                                  style: CustomTextStyle(
                                                    fontSize: 12,
                                                    color:
                                                    Colors.black45,
                                                  ).getTextStyle(),
                                                  textAlign:
                                                  TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (mainPage.SelectedAdsModelMainPage.ads_city != null ||
                                              mainPage.SelectedAdsModelMainPage.ads_neighborhood != null)
                                            Flexible(
                                              child: Text(
                                                '${mainPage
                                                    .SelectedAdsModelMainPage
                                                    .ads_city} - ${mainPage
                                                    .SelectedAdsModelMainPage
                                                    .ads_neighborhood}',
                                                style:
                                                CustomTextStyle(

                                                  fontSize: 8,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black45,
                                                ).getTextStyle(),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Custom InfoWindow Widget ends here
                      ),
                    ),
                  )
                      :
                  Container(),
                  mainPage.markersMainPage.isEmpty
                      ?
                  mainPage.adsOnMap == 0
                      ?
                  Center(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .noAdsAvailableNear,
                      style: CustomTextStyle(
                          fontSize: 15,
                          color: Colors.white
                      ).getTextStyle(),
                    ),
                  )
                      :
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(
                      child: Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xff00cccc),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xff1f2835)),
                        ),
                      ),
                    ),
                  )
                      :
                  Container(),
                  if(mainPage.adsOnMap != 0 && mainPage.allAds != 0)
                    Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .6,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Center(
                            child: Text(
                              '${mainPage.adsOnMap != 1 ? mainPage.adsOnMap : 0} من ${mainPage.allAds} إعلان. قرب أكثر لجميع الإعلانات ',
                            style: CustomTextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 11
                            ).getTextStyle(),)
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
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
