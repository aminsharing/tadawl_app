import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';

class BuildCellar extends StatelessWidget {
  const BuildCellar({Key key, this.searchDrawer}) : super(key: key);
  final SearchDrawerProvider searchDrawer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context).cellar,
            style: CustomTextStyle(

              fontSize: 15,
              color: const Color(0xff000000),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
            return FlutterSwitch(
              activeColor: const Color(0xff00cccc),
              width: 40.0,
              height: 20.0,
              valueFontSize: 15.0,
              toggleSize: 15.0,
              value: searchDrawer.bool_feature11SearchDrawer,
              borderRadius: 15.0,
              padding: 2.0,
              showOnOff: false,
              onToggle: (val) {
                searchDrawer.setbool_feature11SearchDrawer(val);
              },
            );
          }),
        ],
      ),
    );
  }
}
