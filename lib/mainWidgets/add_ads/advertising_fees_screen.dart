import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/images_video_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/screens/ads/advertising_fee.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertisingFeesScreen extends StatelessWidget {
  AdvertisingFeesScreen(this.addAdProvider,{Key key}) : super(key: key);
  final AddAdProvider addAdProvider;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: const Color(0xff00cccc),
        leadingWidth: 70.0,
        title: Center(
          widthFactor: 2.0,
          child: Text(
            AppLocalizations
                .of(context)
                .advFees,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .title1,
                      style: CustomTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations
                        .of(context)
                        .rule27,
                    style: CustomTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: const Color(0xff8d8d8d),
                    ).getTextStyle(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .title2,
                      style: CustomTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .rule28,
                      style: CustomTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: AppLocalizations.of(context).rule29,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff8d8d8d),
                              ).getTextStyle(),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                                text: AppLocalizations.of(context).advFees,
                                style: CustomTextStyle(
                                  fontSize: 15,
                                  color: const Color(0xff0000ff),
                                ).getTextStyle(),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdvertisingFee()),
                                  );
                                }
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations
                        .of(context)
                        .marketingSolution,
                    style: CustomTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: AppLocalizations.of(context).contactEmail,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff8d8d8d),
                              ).getTextStyle(),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                                text: 'support@tadawl.com.sa',
                                style: CustomTextStyle(
                                  fontSize: 15,
                                  color: const Color(0xff8d8d8d),
                                ).getTextStyle(),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  launch(_emailLaunchUri.toString());
                                }
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations
                        .of(context)
                        .explanatoryPoints,
                    style: CustomTextStyle(
                      fontSize: 17,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .rule30,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // if (!_addAdsKey.currentState.validate()) {
                //   return;
                // }
                // _addAdsKey.currentState.save();
                // addAds.setCurrentStageAddAds(3);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ChangeNotifierProvider<AddAdProvider>.value(
                  value: addAdProvider,
                  child: ImagesVideoScreen(addAdProvider),
                )
                )
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  width: mediaQuery.size.width * 0.6,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xffffffff),
                    border: Border.all(
                        width: 1.0, color: const Color(0xff00cccc)),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .rule31,
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: const Color(0xff00cccc),
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
  }
}

final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@tadawl.com.sa',
    queryParameters: {'subject': 'تطبيق تداول العقاري - الحلول التسويقية'});