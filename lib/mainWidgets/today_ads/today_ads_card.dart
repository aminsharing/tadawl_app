import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class TodayAdsCard extends StatelessWidget {
  const TodayAdsCard({
    Key key,
    @required this.todayAds
  }) : super(key: key);
  final AdsModel todayAds;

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
            Provider.of<MutualProvider>(context, listen: false)
                .getAllAdsPageInfo(context, todayAds.idDescription);
            Provider.of<MutualProvider>(context, listen: false)
                .getSimilarAdsList(
                context, todayAds.idCategory, todayAds.idDescription);
            Future.delayed(Duration(seconds: 0), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdPage()),
              );
            });
          },
          ads_image: todayAds.ads_image,
          title: todayAds.title,
          idSpecial: todayAds.idSpecial,
          price: todayAds.price,
          space: todayAds.space,
          ads_city: todayAds.ads_city,
          ads_neighborhood: todayAds.ads_neighborhood,
          ads_road: todayAds.ads_road,
          video: todayAds.video,
      ),
    );
  }
}