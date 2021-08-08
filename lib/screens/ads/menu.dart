import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_button.dart';
import 'package:tadawl_app/mainWidgets/bottom_navigation_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/search_drawer.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class Menu extends StatelessWidget {
  Menu({
    Key key,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).setScrollListener();
    Provider.of<SearchDrawerProvider>(context, listen: false).setMenuFilter(null);
    Provider.of<SearchDrawerProvider>(context, listen: false).getMenuList(context);

      var mediaQuery = MediaQuery.of(context);

      Future<bool> _onBackPressed() async{
        return false;
      }

      return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xffffffff),
          appBar: AppBar(
            centerTitle: true,
            leadingWidth: 100,
            toolbarHeight: 80,
            backgroundColor: Color(0xffffffff),
            title: Container(
              decoration: BoxDecoration(
                color: const Color(0xff00cccc),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Text(
                  AppLocalizations.of(context).latestDate,
                  style: CustomTextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            leading: TextButton(
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
              child: Icon(
                Icons.search_rounded,
                color: Color(0xff00cccc),
                size: 40,
              ),
            ),
          ),
          drawer: Drawer(
            child: CustomDrawer(),
          ),
          endDrawer: Drawer(
            child: SearchDrawer(isMainPage: false,),
          ),
          body: Consumer<MenuProvider>(builder: (context, menu, child) {
            // menu.setFilterSearchDrawer(null);
            // menu.setMenuMainFilterAds(1);
            return RefreshIndicator(
              // ignore: missing_return
              onRefresh: () async {
                // menu.clearExpendedMenuListCount();
                // menu.setFilterSearchDrawer(null);
                // menu.setMenuFilter(null);
                // menu.setMenuMainFilterAds(1);
                Provider.of<SearchDrawerProvider>(context, listen: false).getMenuList(context);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: menu.menuAds.isEmpty
                    ?
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                      child: Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xff00cccc),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xff1f2835)),
                        ),
                      )),
                ) // menu.countMenuAds()
                    :
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height*.72,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: menu.menuController,
                    // itemCount: menu.countMenuAds(),
                    itemCount: menu.countMenuAds() > 20 ? menu.expendedMenuListCount : menu.countMenuAds(),
                    itemBuilder: (context,i){
                      return AdButton(
                        ads_image: menu.menuAds[i].ads_image,
                        title: menu.menuAds[i].title,
                        idSpecial: menu.menuAds[i].idSpecial,
                        price: menu.menuAds[i].price,
                        space: menu.menuAds[i].space,
                        ads_city: menu.menuAds[i].ads_city,
                        ads_neighborhood: menu.menuAds[i].ads_neighborhood,
                        video: menu.menuAds[i].video,
                        onPressed: () {
                          // menu.getIsFav(context);
                          menu.clearExpendedMenuListCount();
                          Provider.of<MutualProvider>(context, listen: false)
                              .getAllAdsPageInfo(context, menu.menuAds[i].idDescription);
                          Provider.of<MutualProvider>(context, listen: false)
                              .getSimilarAdsList(context, menu.menuAds[i].idCategory, menu.menuAds[i].idDescription);
                          Future.delayed(Duration(seconds: 0), () {
                            Navigator.push(
                              context,
                              PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: AdPage()),
                            );
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          }),
          bottomNavigationBar: SizedBox(
              height: mediaQuery.size.height * 0.11,
              child: BottomNavigationBarApp()),
        ),
      );
  }
}



