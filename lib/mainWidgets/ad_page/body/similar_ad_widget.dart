import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        Consumer2<MutualProvider, AdPageProvider>(builder: (context,mutualProv, adsPage, child) {
          return mutualProv.adsSimilar.isNotEmpty
              ?
          Directionality(
            textDirection: locale.locale.toString() != 'en_US'
                ?
            TextDirection.ltr
                :
            TextDirection.rtl,
            child: Container(
              width: mediaQuery.size.width,
              height: mutualProv.countAdsSimilar() > 5 ? 5 * mediaQuery.size.width*.43 : mutualProv.countAdsSimilar() * mediaQuery.size.width*.43,
              child: ListView.separated(
                // itemCount: mutualProv.countAdsSimilar() > adsPage.expendedListCount-1 ? adsPage.expendedListCount : mutualProv.countAdsSimilar(),
                itemCount: mutualProv.countAdsSimilar() > 5 ? 5 : mutualProv.countAdsSimilar(),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i){
                  return AdButton(
                      onPressed: () {
                        adsPage.stopVideoAdsPage();
                        mutualProv.getAdsPageList(context,
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getImagesAdsPageList(context,
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getUserAdsPageInfo(context,
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getAdsVRInfo(context,
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getBFAdsPageList(context,
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getQFAdsPageList(context,
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getViewsChartInfo(context,
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getNavigationAdsPageList(context);
                        mutualProv.setIdDescription(
                            mutualProv.adsSimilar[i].idDescription);
                        mutualProv.getSimilarAdsList(context, mutualProv.adsSimilar[i].idCategory, mutualProv.adsSimilar[i].idDescription);
                        Future.delayed(Duration(seconds: 0), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdPage()),
                          );
                        });
                      },
                      ads_image: mutualProv.adsSimilar[i].ads_image,
                      title: mutualProv.adsSimilar[i].title,
                      idSpecial: mutualProv.adsSimilar[i].idSpecial,
                      price: mutualProv.adsSimilar[i].price,
                      space: mutualProv.adsSimilar[i].space,
                      ads_city: mutualProv.adsSimilar[i].ads_city,
                      ads_neighborhood:mutualProv.adsSimilar[i].ads_neighborhood,
                      ads_road: mutualProv.adsSimilar[i].ads_road,
                      video: mutualProv.adsSimilar[i].video,
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
