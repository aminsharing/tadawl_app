import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';

class AgeOfRealEstate extends StatelessWidget {
  const AgeOfRealEstate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateDetailsProvider>(builder: (context, updateDetails, _) {
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
                  AppLocalizations.of(context).ageOfRealEstate,
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                if (updateDetails.AgeOfRealEstateUpdate == -1)
                  Text(
                    AppLocalizations.of(context).undefined,
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  )
                else if (updateDetails.AgeOfRealEstateUpdate == 0)
                  Text(
                    AppLocalizations.of(context).lessYear,
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  )
                else if (updateDetails.AgeOfRealEstateUpdate > 35)
                    Text(
                      '+35',
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    )
                  else
                    Text(
                      updateDetails.AgeOfRealEstateUpdate
                          .floor()
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
            activeColor: const Color(0xff04B404),
            value: updateDetails.AgeOfRealEstateUpdate,
            min: 0,
            max: 36,
            divisions: 36,
            label:
            updateDetails.AgeOfRealEstateUpdate.floor()
                .toString(),
            onChanged: (double value) {
              updateDetails.setAgeOfREUpdate(value);
            },
          ),
        ],
      );
    });
  }
}
