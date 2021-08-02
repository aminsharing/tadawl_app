import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';

class Floor extends StatelessWidget {
  const Floor({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<AddAdProvider>(builder: (context, addAd, _) {
      print("Floor -> AddAdProvider");
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
                  AppLocalizations.of(context).floor,
                  style: CustomTextStyle(

                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                if (addAd.FloorAddAds == 0)
                  Text(
                    AppLocalizations.of(context).undefined,
                    style: CustomTextStyle(

                      fontSize: 15,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  )
                else if (addAd.FloorAddAds == 1)
                  Text(
                    AppLocalizations.of(context)
                        .groundFloor,
                    style: CustomTextStyle(

                      fontSize: 15,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  )
                else if (addAd.FloorAddAds == 2)
                    Text(
                      AppLocalizations.of(context).first,
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    )
                  else if (addAd.FloorAddAds > 20)
                      Text(
                        '+20',
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff000000),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      )
                    else
                      Text(addAd.FloorAddAds.floor()
                            .toString(),
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
            activeColor: const Color(0xff00cccc),
            value: addAd.FloorAddAds,
            min: 0,
            max: 20,
            divisions: 20,
            label: addAd.FloorAddAds.floor()
                .toString(),
            onChanged: (double value) {
              addAd.setFloorAddAds(value);
            },
          )
        ],
      );
    });
  }
}
