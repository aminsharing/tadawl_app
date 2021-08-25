import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkCoverageWidget extends StatelessWidget {
  NetworkCoverageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchSTC() async {
      await Provider.of<AdPageProvider>(context, listen: false).stopVideoAdsPage();
      const url = 'https://www.stc.com.sa/wps/wcm/connect/arabic/helpAndSupport/storelocator';
      await launch(url);
      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      //   throw 'Could not launch $url';
      // }
    }

    void _launchZain() async {
      await Provider.of<AdPageProvider>(context, listen: false).stopVideoAdsPage();
      const url = 'https://sa.zain.com/ar/coverage-map';
      await launch(url);
      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      //   throw 'Could not launch $url';
      // }
    }

    var mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).mapsNetwork,
                style: CustomTextStyle(
                  fontSize: 20,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _launchSTC,
              child: Container(
                width: mediaQuery.size.width * 0.2,
                height: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: const Color(0xff00cccc), width: 1),
                  color: const Color(0xffffffff),
                  image: DecorationImage(
                    image:
                    const AssetImage('assets/images/stc.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _launchZain,
              child: Container(
                width: mediaQuery.size.width * 0.2,
                height: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: const Color(0xff00cccc), width: 1),
                  color: const Color(0xffffffff),
                  image: DecorationImage(
                    image: const AssetImage('assets/images/zain.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
