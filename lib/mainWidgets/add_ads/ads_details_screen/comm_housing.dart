import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';

class CommHousing extends StatelessWidget {
  const CommHousing({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<AddAdProvider>(builder: (context, addAd, _) {
      return Padding(
        padding:
        const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context)
                        .commHousing,
                    style: CustomTextStyle(

                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context)
                        .commercial,
                    style: CustomTextStyle(

                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context)
                        .housing,
                    style: CustomTextStyle(

                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              onPressed: (int index) {
                addAd.setTyprAqarAddAds(index);
              },
              isSelected: addAd.typeAqarAddAds,
              color: const Color(0xff04B404),
              selectedColor: const Color(0xffffffff),
              fillColor: const Color(0xff04B404),
              borderColor: const Color(0xff04B404),
              selectedBorderColor:
              const Color(0xff04B404),
              borderWidth: 1,
            ),
          ],
        ),
      );
    });
  }
}
