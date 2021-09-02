import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';

class SimilarAdWidget extends StatelessWidget {
  SimilarAdWidget({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).similarAds,
                style: CustomTextStyle(
                  fontSize: 20,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Consumer<AdPageProvider>(builder: (context, adsPage, child) {
          return adsPage.adsSimilar.isNotEmpty
              ?
          Directionality(
            textDirection: locale.locale.toString() != 'en_US'
                ?
            TextDirection.ltr
                :
            TextDirection.rtl,
            child: Container(
              width: mediaQuery.size.width,
              height: adsPage.countAdsSimilar() > 5 ? 5 * mediaQuery.size.width*.43 : adsPage.countAdsSimilar() * mediaQuery.size.width*.43,
              child: ListView.separated(
                // itemCount: adsPage.countAdsSimilar() > adsPage.expendedListCount-1 ? adsPage.expendedListCount : adsPage.countAdsSimilar(),
                itemCount: adsPage.countAdsSimilar() > 5 ? 5 : adsPage.countAdsSimilar(),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i){
                  return AdButton(
                      onPressed: () {
                        adsPage.stopVideoAdsPage();
                        // adsPage.getAdsPageList(context,
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getImagesAdsPageList(context,
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getUserAdsPageInfo(context,
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getAdsVRInfo(context,
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getBFAdsPageList(context,
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getQFAdsPageList(context,
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getViewsChartInfo(context,
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getNavigationAdsPageList(context);
                        // adsPage.setIdDescription(
                        //     adsPage.adsSimilar[i].idDescription);
                        // adsPage.getSimilarAdsList(context, adsPage.adsSimilar[i].idCategory, adsPage.adsSimilar[i].idDescription);
                        Future.delayed(Duration(seconds: 0), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdPageHelper(ads:adsPage.adsSimilar, index: i,)

                            ),
                          );
                        });
                      },
                      ads_image: adsPage.adsSimilar[i].ads_image,
                      title: adsPage.adsSimilar[i].title,
                      idSpecial: adsPage.adsSimilar[i].idSpecial,
                      price: adsPage.adsSimilar[i].price,
                      space: adsPage.adsSimilar[i].space,
                      ads_city: adsPage.adsSimilar[i].ads_city,
                      ads_neighborhood:adsPage.adsSimilar[i].ads_neighborhood,
                      ads_road: adsPage.adsSimilar[i].ads_road,
                      video: adsPage.adsSimilar[i].video,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: const Color(0xff212a37),
                  );
                },
              ),
            ),
          )
              :
          Container();
        }),
      ],
    );
  }
}
