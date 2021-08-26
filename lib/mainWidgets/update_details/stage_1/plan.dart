import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';

class Plan extends StatelessWidget {
  const Plan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateDetailsProvider>(builder: (context, updateDetails, _) {
      // if(!updateDetails.planUpdate.contains(true)){
      //   // updateDetails.adsPage.first
      //   updateDetails.setPlanUpdate(int.parse(Provider.of<MutualProvider>(context, listen: false).adsPage.first.idTypeRes), false);
      // }

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
                      37, 0, 37, 0),
                  child: Text(
                    AppLocalizations.of(context).daily,
                    style: CustomTextStyle(

                      fontSize: 13,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      37, 0, 37, 0),
                  child: Text(
                    AppLocalizations.of(context)
                        .monthly,
                    style: CustomTextStyle(

                      fontSize: 13,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      37, 0, 37, 0),
                  child: Text(
                    AppLocalizations.of(context).annual,
                    style: CustomTextStyle(

                      fontSize: 13,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              onPressed: (int index) {
                updateDetails.setPlanUpdate(index, true);
              },
              isSelected: updateDetails.planUpdate,
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
