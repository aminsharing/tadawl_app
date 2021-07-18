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
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/map_provider.dart';
//import 'package:tadawl_app/provider/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';

class MainPage extends StatelessWidget {
  MainPage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<MapProvider>(context, listen: false).getLocPer();
    return Consumer<MainPageProvider>(builder: (context, mainPage, child) {

      print("MainPage -> MainPageProvider");


      Future<bool> _onBackPressed() {
        return showDialog(
              context: context,
              builder: (context) => AlertDialog( //
                title: Text(
                  AppLocalizations.of(context).closeApp,
                  style: CustomTextStyle(

                    fontSize: 20,
                    color: const Color(0xff00cccc),
                  ).getTextStyle(),
                  textAlign: TextAlign.right,
                ),
                content: Text(
                  AppLocalizations.of(context).areYouSureCloseApp,
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
                        AppLocalizations.of(context).yes,
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
                        AppLocalizations.of(context).no,
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
            ) ??
            false;
      }

      //var _phone = Provider.of<UserProvider>(context, listen: false).phone;
      //mainPage.randomPosition(50);

      var _lang = Provider.of<LocaleProvider>(context, listen: false).locale.toString();

      if(mainPage.inItMainPageDone == 0) {
        mainPage.setIdCategorySearch('0');
        Provider.of<MenuProvider>(context,listen: false)
        .setFilterSearchDrawer(1);
        Provider.of<MenuProvider>(context,listen: false)
        .setMenuMainFilterAds(2);
        Provider.of<MenuProvider>(context,listen: false)
        .getAdsInfo(
          context,
          mainPage.idCategorySearch,
          mainPage.selectedCategory,
          mainPage.minPriceSearchDrawer,
          mainPage.maxPriceSearchDrawer,
          mainPage.minSpaceSearchDrawer,
          mainPage.maxSpaceSearchDrawer,
          mainPage.selectedTypeAqarSearchDrawer,
          mainPage.interfaceSelectedSearchDrawer,
          mainPage.selectedPlanSearchDrawer,
          mainPage.ageOfRealEstateSelectedSearchDrawer,
          mainPage.selectedApartmentsSearchDrawer,
          mainPage.floorSelectedSearchDrawer,
          mainPage.selectedLoungesSearchDrawer,
          mainPage.selectedRoomsSearchDrawer,
          mainPage.storesSelectedSearchDrawer,
          mainPage.streetWidthSelectedSearchDrawer,
          mainPage.selectedToiletsSearchDrawer,
          mainPage.treesSelectedSearchDrawer,
          mainPage.wellsSelectedSearchDrawer,
          mainPage.bool_feature1SearchDrawer.toString(),
          mainPage.bool_feature2SearchDrawer.toString(),
          mainPage.bool_feature3SearchDrawer.toString(),
          mainPage.bool_feature4SearchDrawer.toString(),
          mainPage.bool_feature5SearchDrawer.toString(),
          mainPage.bool_feature6SearchDrawer.toString(),
          mainPage.bool_feature7SearchDrawer.toString(),
          mainPage.bool_feature8SearchDrawer.toString(),
          mainPage.bool_feature9SearchDrawer.toString(),
          mainPage.bool_feature10SearchDrawer.toString(),
          mainPage.bool_feature11SearchDrawer.toString(),
          mainPage.bool_feature12SearchDrawer.toString(),
          mainPage.bool_feature13SearchDrawer.toString(),
          mainPage.bool_feature14SearchDrawer.toString(),
          mainPage.bool_feature15SearchDrawer.toString(),
          mainPage.bool_feature16SearchDrawer.toString(),
          mainPage.bool_feature17SearchDrawer.toString(),
          mainPage.bool_feature18SearchDrawer.toString(),
          showOnMap: true
        );
        mainPage.setInItMainPageDone(1);
      }

      return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xffffffff),
          drawer: Drawer(
            child: CustomDrawer(),
          ),
          endDrawer: Drawer(
            child: SearchDrawer(),
          ),
          body: Stack(
            children: <Widget>[
              MapWidget(mainPage: mainPage),
              // map ....................................
              SliderWidget(mainPage: mainPage),
              // slider ....................................
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(100, 50, 20, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0x00000000),
                      ),
                      child: Row(
                        mainAxisAlignment: _lang != 'en_US'
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // _scaffoldKey.currentState.openDrawer();
                              _scaffoldKey.currentState.openEndDrawer();
                            },
                            child: Container(
                              width: 50,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Color(0xff00cccc),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.search_rounded,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
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
      );
    });
  }
}



