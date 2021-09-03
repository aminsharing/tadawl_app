import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';

class Lounges extends StatelessWidget {
  const Lounges({Key? key}) : super(key: key);

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
                  AppLocalizations.of(context)!.lounges,
                  style: CustomTextStyle(

                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                if (updateDetails.LoungesUpdateUpdate! > 5)
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
                    updateDetails.LoungesUpdateUpdate!
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
            value: updateDetails.LoungesUpdateUpdate!,
            min: 0,
            max: 5,
            divisions: 5,
            label: updateDetails.LoungesUpdateUpdate!.floor()
                .toString(),
            onChanged: (double value) {
              updateDetails.setLoungesUpdate(value);
            },
          ),
        ],
      );
    });
  }
}
