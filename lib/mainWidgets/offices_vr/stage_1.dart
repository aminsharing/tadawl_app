import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/offices_vr_provider.dart';

class Stage1 extends StatelessWidget {
  const Stage1({
    Key key,
    @required this.officeName,
    @required this.CRNumber,
    @required this.imageOfficeVR,
  }) : super(key: key);
  final String CRNumber;
  final String officeName;
  final File imageOfficeVR;

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
  }
  
  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    final translate = AppLocalizations.of(context);


    return Scaffold(
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
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          translate.officesAccreditation,
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
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      translate.reLocation,
                      style: CustomTextStyle(
                        fontSize: 13,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Consumer<OfficesVRProvider>(builder: (context, officesVR, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: Stack(
                      children: [
                        officesVR.initialCameraPosition != null
                            ?
                        GoogleMap(
                            myLocationButtonEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            scrollGesturesEnabled: true,
                            rotateGesturesEnabled: true,
                            myLocationEnabled: true,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: officesVR.initialCameraPosition,
                                zoom: 13),
                            onMapCreated: _onMapCreated,
                            onCameraMove: (CameraPosition position) {
                              officesVR.handleCameraMoveOfficesVR(position);
                            })
                            :
                        Container(),
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
                  if (officesVR.buttonClicked == null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: TextButton(
                        onPressed: () async {
                          officesVR.setButtonClicked(1);

                          if (officesVR.initialCameraPosition == null) {
                            await Fluttertoast.showToast(
                                msg:
                                'حرك الخريطة للوصول لموقع المكتب المطلوب',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                          } else {
                            if(officesVR.office_cordinates != null){
                              await officesVR.sendOfficesVRInfo(
                                  context,
                                  locale.phone,
                                  CRNumber,
                                  officeName,
                                  officesVR.office_cordinates_lat.toString(),
                                  officesVR.office_cordinates_lng.toString(),
                                  imageOfficeVR);
                            }else{
                              await officesVR.sendOfficesVRInfo(
                                  context,
                                  locale.phone,
                                  CRNumber,
                                  officeName,
                                  officesVR.initialCameraPosition.latitude.toString(),
                                  officesVR.initialCameraPosition.longitude.toString(),
                                  imageOfficeVR);
                            }
                          }
                        },
                        child: Container(
                          width: 200,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: const Color(0xff00cccc), width: 1),
                            color: const Color(0xffffffff),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)
                                  .officesAccreditation,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff00cccc),
                              ).getTextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (officesVR.buttonClicked == 1)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: Container(
                        width: 200,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: const Color(0xff989898), width: 1),
                          color: const Color(0xffffffff),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)
                                .officesAccreditation,
                            style: CustomTextStyle(
                              fontSize: 15,
                              color: const Color(0xff989898),
                            ).getTextStyle(),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class Utils {
  static String mapStyle = '''
[]
  ''';
}