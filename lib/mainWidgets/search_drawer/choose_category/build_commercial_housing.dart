import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';


class BuildCommercialHousing extends StatelessWidget {
  const BuildCommercialHousing({Key? key, this.searchDrawer}) : super(key: key);
  final SearchDrawerProvider? searchDrawer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
            return ToggleButtons(
              onPressed: (int index) {
                searchDrawer.setTypeAqarSearchDrawer(index);
              },
              isSelected: searchDrawer.typeAqarSearchDrawer,
              color: const Color(0xff00cccc),
              selectedColor: const Color(0xffffffff),
              fillColor: const Color(0xff00cccc),
              borderColor: const Color(0xff00cccc),
              selectedBorderColor: const Color(0xff00cccc),
              borderWidth: 1,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context)!.commHousing,
                    style: CustomTextStyle(
                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context)!.commercial,
                    style: CustomTextStyle(

                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    AppLocalizations.of(context)!.housing,
                    style: CustomTextStyle(

                      fontSize: 10,
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
