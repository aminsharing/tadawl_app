import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';

class StreetWidth extends StatelessWidget {
  const StreetWidth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddAdProvider>(builder: (context, addAd, _) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.streetWidth,
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  addAd.StreetWidthAddAds.floor().toString(),
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Slider(
            activeColor: const Color(0xff04B404),
            value: addAd.StreetWidthAddAds,
            min: 0,
            max: 100,
            divisions: 198,
            label: addAd.StreetWidthAddAds.floor().toString(),
            onChanged: (double value) {
              addAd.setStreetWidthAddAds(value);
            },
          )
        ],
      );
    });
  }
}
