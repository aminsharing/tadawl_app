import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';

class BuildSingleFamily extends StatelessWidget {
  const BuildSingleFamily({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
            print("BuildSingleFamily -> SearchDrawerProvider");
            return ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context).family,
                    style: CustomTextStyle(

                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context).single,
                    style: CustomTextStyle(

                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              onPressed: (int index) {
                searchDrawer.setFamilyTypeSearchDrawer(index);
              },
              isSelected: searchDrawer.familyTypeSearchDrawer,
              color: const Color(0xff00cccc),
              selectedColor: const Color(0xffffffff),
              fillColor: const Color(0xff00cccc),
              borderColor: const Color(0xff00cccc),
              selectedBorderColor: const Color(0xff00cccc),
              borderWidth: 1,
            );
          }),
        ],
      ),
    );
  }
}
