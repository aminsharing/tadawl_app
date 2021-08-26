import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';


class Toilets extends StatelessWidget {
  const Toilets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddAdProvider>(builder: (context, addAd, _) {
      return Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).toilets,
                  style: CustomTextStyle(

                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                if (addAd.ToiletsAddAds > 5)
                  Text(
                    '+5',
                    style: CustomTextStyle(

                      fontSize: 15,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  )
                else
                  Text(
                    addAd.ToiletsAddAds.floor().toString(),
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
            value: addAd.ToiletsAddAds,
            min: 0,
            max: 5,
            divisions: 5,
            label: addAd.ToiletsAddAds.floor()
                .toString(),
            onChanged: (double value) {
              addAd.setToiletsAddAds(value);
            },
          ),
        ],
      );
    });
  }
}
