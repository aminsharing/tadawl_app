import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Duplex extends StatelessWidget {
  const Duplex({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context).duplex,
            style: CustomTextStyle(

              fontSize: 15,
              color: const Color(0xff000000),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          Consumer<AddAdProvider>(builder: (context, addAd, _) {
            print("Duplex -> AddAdProvider");
            return FlutterSwitch(
              activeColor: const Color(0xff00cccc),
              width: 40.0,
              height: 20.0,
              valueFontSize: 15.0,
              toggleSize: 15.0,
              value: addAd.isDuplexAddAds,
              borderRadius: 15.0,
              padding: 2.0,
              showOnOff: false,
              onToggle: (val) {
                addAd.setIsDuplexAddAds(val);
              },
            );
          }),
        ],
      ),
    );
  }
}