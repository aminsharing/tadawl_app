import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/main_page/map_widget.dart';
import 'package:tadawl_app/mainWidgets/main_page/slider_widget.dart';
import 'package:tadawl_app/mainWidgets/search_drawer.dart';
import 'package:tadawl_app/mainWidgets/bottom_navigation_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:tadawl_app/mainWidgets/search_on_map.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainPageProvider mainPageProvider = MainPageProvider();


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

    return ChangeNotifierProvider<MainPageProvider>(
      create: (_) => mainPageProvider,
      child: ChangeNotifierProvider<SearchDrawerProvider>(
        create: (_) => SearchDrawerProvider(),
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: const Color(0xffffffff),
            drawer: Drawer(
              child: CustomDrawer(),
            ),
            endDrawer: Drawer(
              child: SearchDrawer(selectedPage: SelectedPage.mainPage,),
            ),
            body: Stack(
              children: <Widget>[
                MapWidget(),
                // map ....................................
                SliderWidget(),
                // slider ....................................
                Positioned(
                  top: 30.0,
                  right: 20.0,
                  child: TextButton(
                    onPressed: () {
                      // _scaffoldKey.currentState.openDrawer();
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff2d3872), width: 1),
                        shape: BoxShape.circle,
                        color: const Color(0xff1f2835),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search_rounded,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
                // search button .............................
              ],
            ),
            bottomNavigationBar: SizedBox(
                height: MediaQuery.of(context).size.height * 0.11,
                child: BottomNavigationBarApp()),
          ),
        ),
      ),
    );
  }
}



