import 'dart:math';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/bottom_navigation_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/search_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class Menu extends StatelessWidget {
  Menu({
    Key key,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).setScrollListener();
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
            child: SearchDrawer(),
          ),
          body: Consumer<MenuProvider>(builder: (context, menu, child) {
            print("Menu -> MenuProvider");
            menu.setFilterSearchDrawer(null);
            menu.setMenuMainFilterAds(1);
            return RefreshIndicator(
              // ignore: missing_return
              onRefresh: () async {
                // menu.clearExpendedMenuListCount();
                menu.setFilterSearchDrawer(null);
                menu.setMenuMainFilterAds(1);
                menu.getAdsInfo(
                  context, null, null, null, null, null, null, null,
                  null, null, null, null, null, null, null, null, null,
                  null, null, null, null, null, null, null, null, null,
                  null, null, null, null, null, null, null, null, null,
                  null, null, null,
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: menu.waitMenu == true
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
                menu.menuAds.isNotEmpty
                    ?
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
                      return TextButton(
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
                        child: Container(
                          width: mediaQuery.size.width,
                          height: 150.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff8d8d8d),
                                offset: const Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 1.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(children: [
                                Container(
                                  width: 180.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          'https://tadawl.com.sa/API/assets/images/ads/' +
                                              menu.menuAds[i]
                                                  .ads_image ??
                                              ''),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      Random().nextInt(50).toDouble(),
                                      Random().nextInt(50).toDouble(),
                                      5,
                                      5),
                                  child: Opacity(
                                    opacity: 0.7,
                                    //opacity: 0.7,
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: const CachedNetworkImageProvider(
                                              'https://tadawl.com.sa/API/assets/images/logo22.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          menu.menuAds[i].title,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(
                                                0xff000000),
                                          ).getTextStyle(),
                                        ),
                                        if (menu.menuAds[i]
                                            .idSpecial ==
                                            '1')
                                          Padding(
                                            padding: const EdgeInsets
                                                .fromLTRB(
                                                5, 0, 10, 0),
                                            child: Icon(
                                              Icons.verified,
                                              color:
                                              Color(0xffe6e600),
                                              size: 30,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          menu.menuAds[i].price,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(
                                                0xff00cccc),
                                          ).getTextStyle(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(0, 0, 5, 0),
                                          child: Text(
                                            AppLocalizations.of(
                                                context)
                                                .rial,
                                            style:
                                            CustomTextStyle(

                                              fontSize: 15,
                                              color: const Color(
                                                  0xff00cccc),
                                            ).getTextStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          menu.menuAds[i].space,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(
                                                0xff000000),
                                          ).getTextStyle(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(0, 0, 5, 0),
                                          child: Text(
                                            AppLocalizations.of(
                                                context)
                                                .m2,
                                            style:
                                            CustomTextStyle(

                                              fontSize: 15,
                                              color: const Color(
                                                  0xff000000),
                                            ).getTextStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          5, 0, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          if (menu.menuAds[i]
                                              .ads_city !=
                                              null ||
                                              menu.menuAds[i]
                                                  .ads_neighborhood !=
                                                  null)
                                            Text(
                                              '${menu.menuAds[i].ads_city} - ${menu.menuAds[i].ads_neighborhood}',
                                              style:
                                              CustomTextStyle(

                                                fontSize: 10,
                                                color: const Color(
                                                    0xff000000),
                                              ).getTextStyle(),
                                            ),
                                          if (menu.menuAds[i].video
                                              .isNotEmpty)
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .fromLTRB(
                                                  0, 0, 5, 0),
                                              child: Icon(
                                                Icons
                                                    .videocam_outlined,
                                                color:
                                                Color(0xff00cccc),
                                                size: 30,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                    :
                Container(),
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
