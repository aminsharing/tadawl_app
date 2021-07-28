import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';

class Stores extends StatelessWidget {
  const Stores({Key key}) : super(key: key);

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
                  AppLocalizations.of(context).stores,
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  updateDetails.StoresUpdate.floor()
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
            value: updateDetails.StoresUpdate,
            min: 0,
            max: 20,
            divisions: 20,
            label: updateDetails.StoresUpdate.floor()
                .toString(),
            onChanged: (double value) {
              updateDetails.setStoresUpdate(value);
            },
          ),
        ],
      );
    });
  }
}
