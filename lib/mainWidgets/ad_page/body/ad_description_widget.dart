import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/UserModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class AdDescriptionWidget extends StatelessWidget {
  AdDescriptionWidget({Key key, this.adsPage, this.adsUser, this.ads}) : super(key: key);

  final AdPageProvider adsPage;
  final List<AdsModel> ads;
  final List<UserModel> adsUser;

  @override
  Widget build(BuildContext context) {
    var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;
    var mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).desc,
                style: CustomTextStyle(

                  fontSize: 20,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
              adsUser.isNotEmpty
                  ?
              adsUser.first.phone == _phone
                  ?
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: (adsPage.busyAdsPage == true)
                    ?
                CircularProgressIndicator()
                    :
                DateTime.now().difference(DateTime.parse(ads.first.timeUpdated)).inMinutes - 180 > 60
                    ?
                TextButton(
                  onPressed: () {
                    adsPage.stopVideoAdsPage();
                    adsPage.updateAdsAdsPage(
                        context,
                        ads.first
                            .idDescription);
                  },
                  child: Container(
                    width: mediaQuery.size.width *
                        0.15,
                    height: 35.0,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          5.0),
                      border: Border.all(
                          width: 1.0,
                          color: const Color(
                              0xff3f9d28)),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(
                            context)
                            .updateAds,
                        style:
                        CustomTextStyle(

                          fontSize: 15,
                          color: const Color(
                              0xff3f9d28),
                        ).getTextStyle(),
                        textAlign:
                        TextAlign.center,
                      ),
                    ),
                  ),
                )
                    :
                TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg:
                        'ستتمكن من التحديث بعد ${24-(DateTime.now().difference(DateTime.parse(ads.first.timeUpdated)).inMinutes - 180)} دقيقة',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 15.0);
                  },
                  child: Container(
                    width: mediaQuery.size.width *
                        0.15,
                    height: 35.0,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          5.0),
                      border: Border.all(
                          width: 1.0,
                          color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(
                            context)
                            .updateAds,
                        style:
                        CustomTextStyle(

                          fontSize: 15,
                          color: Colors.grey,
                        ).getTextStyle(),
                        textAlign:
                        TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
                  : Container()
                  : Container(),
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
                  ads.first.description ?? '',
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
  }
}
