import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/bottom_navigation_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/maps/regions_map.dart';
import 'package:tadawl_app/provider/region_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Regions extends StatelessWidget {
  Regions({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    Future<bool> _onBackPressed() {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.closeApp,
            style: CustomTextStyle(
              fontSize: 20,
              color: const Color(0xff00cccc),
            ).getTextStyle(),
            textAlign: TextAlign.right,
          ),
          content: Text(
            AppLocalizations.of(context)!.areYouSureCloseApp,
            style: CustomTextStyle(
              fontSize: 17,
              color: const Color(0xff000000),
            ).getTextStyle(),
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () => SystemNavigator.pop(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: CustomTextStyle(
                    fontSize: 17,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Text(
                  AppLocalizations.of(context)!.no,
                  style: CustomTextStyle(
                    fontSize: 17,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ).then((value) => value??false);
    }
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        body: Center(
          child: ChangeNotifierProvider<RegionProvider>(
            create: (_) => RegionProvider(),
            child: RegionsMap(),
          ),
        ),
        bottomNavigationBar: SizedBox(
              height: mediaQuery.size.height * 0.11,
            child: BottomNavigationBarApp()),
      ),
    );
  }
}
