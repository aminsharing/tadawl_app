import 'package:flutter/material.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';

class AppBarTitleWidget extends StatelessWidget {
  AppBarTitleWidget({Key key, this.adsPage, this.idDescription}) : super(key: key);
  final AdPageProvider adsPage;
  final String idDescription;

  @override
  Widget build(BuildContext context) {
    return adsPage.is_favAdsPage == null
        ?
    adsPage.is_favAdsPageDB == 0
        ?
    Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: InkWell(
        onTap: () {
          adsPage.stopVideoAdsPage();
          adsPage.changeAdsFavState(context, 1, idDescription);
        },
        child: Icon(
          Icons.star_border_rounded,
          color: Color(0xffe6e600),
          size: 50,
        ),
      ),
    )
        :
    Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: InkWell(
        onTap: () {
          adsPage.stopVideoAdsPage();
          adsPage.changeAdsFavState(context, 0, idDescription);
        },
        child: Icon(
          Icons.star_rounded,
          color: Color(0xffe6e600),
          size: 50,
        ),
      ),
    )
        :
    adsPage.is_favAdsPage == 0
        ?
    Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: InkWell(
        onTap: () {
          adsPage.stopVideoAdsPage();
          adsPage.changeAdsFavState(context, 1, idDescription);
        },
        child: Icon(
          Icons.star_border_rounded,
          color: Color(0xffe6e600),
          size: 50,
        ),
      ),
    )
        :
    Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: InkWell(
        onTap: () {
          adsPage.stopVideoAdsPage();
          adsPage.changeAdsFavState(context, 0, idDescription);
        },
        child: Icon(
          Icons.star_rounded,
          color: Color(0xffe6e600),
          size: 50,
        ),
      ),
    );
  }
}
