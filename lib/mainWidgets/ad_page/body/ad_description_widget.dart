import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class AdDescriptionWidget extends StatelessWidget {
  AdDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);

    return Consumer<AdPageProvider>(builder: (context, adsPage, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.desc,
                  style: CustomTextStyle(
                    fontSize: 20,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                if( adsPage.adsUser != null)
                  if( adsPage.adsUser!.phone == locale.phone)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextButton(
                        onPressed: () {
                          if(!adsPage.busyAdsPage){
                            adsPage.busyAdsPage = true;
                            if(DateTime.now().difference(DateTime.parse(adsPage.adsPage!.timeUpdated!)).inMinutes - 180 > 60){
                              adsPage.stopVideoAdsPage();
                              adsPage.updateAdsAdsPage(context, adsPage.adsPage!.idDescription).then((value) {
                                if(value){
                                  Fluttertoast.showToast(
                                      msg:
                                      '???? ?????????????? ??????????',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 15.0);
                                  adsPage.getAllAdsPageInfo(context, adsPage.adsPage!.idDescription);
                                  adsPage.busyAdsPage = false;
                                }
                              });
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg:
                                  '???????????? ???? ?????????????? ?????? ${60-(DateTime.now().difference(DateTime.parse(adsPage.adsPage!.timeUpdated!)).inMinutes - 180)} ??????????',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 15.0);
                            }
                          }
                        },
                        child: Container(
                          width: mediaQuery.size.width * 0.15,
                          height: 35.0,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(
                                5.0),
                            border: Border.all(
                                width: 1.0,
                                color: DateTime.now().difference(DateTime.parse(adsPage.adsPage!.timeUpdated!)).inMinutes - 180 > 60?
                                const Color(0xff3f9d28):
                                Colors.grey
                            ),
                          ),
                          child: Center(
                            child: adsPage.busyAdsPage
                                ?
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  backgroundColor: Color(0xff04B404),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xff1f2835)
                                  ),
                                ),
                              ),
                            )
                                :
                            Text(
                              AppLocalizations.of(context)!.updateAds,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: DateTime.now().difference(DateTime.parse(adsPage.adsPage!.timeUpdated!)).inMinutes - 180 > 60?
                                const Color(0xff3f9d28):
                                Colors.grey,
                              ).getTextStyle(),
                              textAlign:
                              TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    adsPage.adsPage!.description ?? '',
                    style: CustomTextStyle(
                      fontSize: 17,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
