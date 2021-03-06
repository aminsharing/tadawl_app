import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/special_offers_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<SpecialOffersProvider>(builder: (context, specialAds, child) {


      var mediaQuery = MediaQuery.of(context);
      //specialAds.getAdsSpecialList(context);
      //specialAds.randomPosition(50);

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
            AppLocalizations.of(context)!.specialOffers +
                ' (${specialAds.countAdsSpecial()}) ',
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff1f2835),
        ),
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Directionality(
                textDirection: locale.locale.toString() != 'en_US'
                    ?
                TextDirection.ltr
                    :
                TextDirection.rtl,
                // if (specialAds.adsSpecial.isNotEmpty)
                // for (int i = 0; i < specialAds.countAdsSpecial(); i++)
                child: Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height,
                  child: specialAds.adsSpecial.isNotEmpty
                      ?
                  ListView.separated(
                      itemCount: specialAds.countAdsSpecial(),
                      itemBuilder: (context, i){
                        return AdButton(
                          onPressed: () {
                            specialAds.setWaitState(true);
                            Future.delayed(Duration(seconds: 0), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdPageHelper(ads: specialAds.adsSpecial, index: i, selectedScreen: SelectedScreen.adSpecial,)

                                ),
                              );
                              //specialAds.setWaitState(false);
                            });
                          },
                          ads_image: specialAds.adsSpecial[i].ads_image,
                          title: specialAds.adsSpecial[i].title,
                          idSpecial: specialAds.adsSpecial[i].idSpecial,
                          price: specialAds.adsSpecial[i].price,
                          space: specialAds.adsSpecial[i].space,
                          ads_city: specialAds.adsSpecial[i].ads_city,
                          ads_neighborhood: specialAds.adsSpecial[i].ads_neighborhood,
                          ads_road: specialAds.adsSpecial[i].ads_road,
                          video: specialAds.adsSpecial[i].video,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: const Color(0xff212a37),
                        );
                      },
                  )
                      :
                  Container(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
