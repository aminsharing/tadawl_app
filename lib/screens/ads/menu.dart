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
import 'package:tadawl_app/mainWidgets/search_on_map.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/services/ad_page_helper.dart';

class Menu extends StatelessWidget {
  Menu({
    Key key,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<LocaleProvider>(context, listen: false);
    Provider.of<MenuProvider>(context, listen: false).setScrollListener();
    Provider.of<SearchDrawerProvider>(context, listen: false).setMenuFilter(null);
    Provider.of<SearchDrawerProvider>(context, listen: false).getMenuList(context);

      var mediaQuery = MediaQuery.of(context);

      Future<bool> _onBackPressed() async{
        locale.setCurrentPage(0);
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
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
                color: const Color(0xff1f2835),
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
                color: const Color(0xff04B404),
                size: 40,
              ),
            ),
          ),
          drawer: Drawer(
            child: CustomDrawer(),
          ),
          endDrawer: Drawer(
            child: SearchDrawer(selectedPage: SelectedPage.menu,),
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
                await Provider.of<SearchDrawerProvider>(context, listen: false).getMenuList(context);
              },
              child: Directionality(
                textDirection: locale.locale.toString() != 'en_US'
                    ?
                TextDirection.ltr
                    :
                TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child:
                  menu.menuAds.isNotEmpty
                      ?
                  Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height*.72,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: menu.menuController,
                      itemCount: menu.countMenuAds(),
                      // itemCount: menu.countMenuAds() > 20 ? menu.expendedMenuListCount : menu.countMenuAds(),
                      itemBuilder: (context,i){
                        return AdButton(
                          ads_image: menu.menuAds[i].ads_image,
                          title: menu.menuAds[i].title,
                          idSpecial: menu.menuAds[i].idSpecial,
                          price: menu.menuAds[i].price,
                          space: menu.menuAds[i].space,
                          ads_city: menu.menuAds[i].ads_city,
                          ads_neighborhood: menu.menuAds[i].ads_neighborhood,
                          ads_road: menu.menuAds[i].ads_road,
                          video: menu.menuAds[i].video,
                          onPressed: () {
                            // menu.getIsFav(context);
                            menu.clearExpendedMenuListCount();
                            // Provider.of<MutualProvider>(context, listen: false).getAllAdsPageInfo(context, menu.menuAds[i].idDescription);
                            // Provider.of<MutualProvider>(context, listen: false).getSimilarAdsList(context, menu.menuAds[i].idCategory, menu.menuAds[i].idDescription);
                            Future.delayed(Duration(seconds: 0), () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 10),
                                    child: AdPageHelper(ads: menu.menuAds, index: i,),
                                ),
                              );
                            });
                          },
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: const Color(0xff212a37),
                      );
                    },
                    ),
                  )
                      :
                  menu.noAdsInRegion
                      ?
                  Center(
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .noAdsAvailableNear,
                      style: CustomTextStyle(
                          fontSize: 15,
                          color: Colors.black
                      ).getTextStyle(),
                    ),
                  )
                      :
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



