import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';

class FamilyORSingle extends StatelessWidget {
  const FamilyORSingle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateDetailsProvider>(builder: (context, updateDetails, _) {
      print("FamilyORSingle -> UpdateDetailsProvider");
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
                      66, 0, 66, 0),
                  child: Text(
                    AppLocalizations.of(context).single,
                    style: CustomTextStyle(

                      fontSize: 13,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      66, 0, 66, 0),
                  child: Text(
                    AppLocalizations.of(context).family,
                    style: CustomTextStyle(

                      fontSize: 13,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              onPressed: (int index) {
                updateDetails.setFamilyUpdate(index, true);
              },
              isSelected: updateDetails.familyUpdate,
              color: const Color(0xff00cccc),
              selectedColor: const Color(0xffffffff),
              fillColor: const Color(0xff00cccc),
              borderColor: const Color(0xff00cccc),
              selectedBorderColor:
              const Color(0xff00cccc),
              borderWidth: 1,
            ),
          ],
        ),
      );
    });
  }
}
