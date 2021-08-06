import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';

class AppBarTitleWidget extends StatelessWidget {
  AppBarTitleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Consumer2<AdPageProvider, MutualProvider>(builder: (context, adsPage, mutualProv, child) {
        return InkWell(
          onTap: () {
            adsPage.stopVideoAdsPage();
            adsPage.changeAdsFavState(context,
                (adsPage.is_favAdsPage??mutualProv.is_favAdsPageDB) ? 0 : 1
                , mutualProv.idDescription);
          },
          child: Icon(
            (adsPage.is_favAdsPage??mutualProv.is_favAdsPageDB) ? Icons.star_rounded : Icons.star_border_rounded,
            color: Color(0xffe6e600),
            size: 50,
          ),
        );
      })
    );
  }
}
