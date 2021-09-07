import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';

class TodayAdsCard extends StatelessWidget {
  const TodayAdsCard({
    Key? key,
    required this.todayAds,
    required this.index,
  }) : super(key: key);
  final List<AdsModel> todayAds;
  final int index;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Directionality(
      textDirection: locale.locale.toString() != 'en_US'
          ?
      TextDirection.ltr
          :
      TextDirection.rtl,
      child: AdButton(
          onPressed: () {
            Future.delayed(Duration(seconds: 0), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AdPageHelper(ads: todayAds, index: index, selectedScreen: SelectedScreen.todayAds,)
                ),
              );
            });
          },
          ads_image: todayAds[index].ads_image,
          title: todayAds[index].title,
          idSpecial: todayAds[index].idSpecial,
          price: todayAds[index].price,
          space: todayAds[index].space,
          ads_city: todayAds[index].ads_city,
          ads_neighborhood: todayAds[index].ads_neighborhood,
          ads_road: todayAds[index].ads_road,
          video: todayAds[index].video,
      ),
    );
  }
}