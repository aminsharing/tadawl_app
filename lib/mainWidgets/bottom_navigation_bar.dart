import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/discussion_list.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/screens/ads/menu.dart';
import 'package:tadawl_app/screens/account/real_estate_offices.dart';
import 'package:tadawl_app/screens/general/regions.dart';

class BottomNavigationBarApp extends StatelessWidget {
  BottomNavigationBarApp({
    Key key,
  }) : super(key: key);

  /// This page to use in animations
  final pages = [
    DiscussionList(),
    // TestXX(),
    Login(),
    ChangeNotifierProvider<MenuProvider>(
      create: (_) => MenuProvider(),
      child: ChangeNotifierProvider<SearchDrawerProvider>(
        create: (_) => SearchDrawerProvider(),
        child: Menu(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final msgProv = Provider.of<MsgProvider>(context, listen: false);
    // final menuProv = Provider.of<MenuProvider>(context, listen: false);



    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        height: mediaQuery.size.height * 0.11,
        width: mediaQuery.size.width,
        color: Color(0xff00cccc),
        child: Consumer<BottomNavProvider>(builder: (ctxt, btmNav, child){
          print("BottomNavigationBarApp -> BottomNavProvider");
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {

                      // Scaffold.of(context).openEndDrawer();
                      Scaffold.of(context).openDrawer();
                      // Provider.of<AdsProvider>(context, listen: false).update();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Color(0xffffffff),
                          size: 25,
                        ),
                        Text(
                          AppLocalizations.of(context).myAccount,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: const Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if(btmNav.currentPage == 0){
                        // mainPageProv.animateLocation(context);
                      }else{
                        // mainPageProv.removeMarkers();
                        btmNav.setCurrentPage(0);
                        // CHANGED: To disappear diog if it shown
                        // if (mainPageProv.showDiaogSearchDrawer) {
                        //   mainPageProv.setShowDiogFalse();
                        // }
                        // CHANGED: To clear expended menu list count
                        // menuProv.clearExpendedMenuListCount();
                        // CHANGED: To reset region position
                        // mainPageProv.setRegionPosition(null);
                        // CHANGED: To reload ads markers on map
                        // mainPageProv.setInItMainPageDone(0);
                        // CHANGED: To get current position before go to main page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage(null)),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: btmNav.currentPage == 0 ? Colors.black45 : Color(0xffffffff),
                          size: btmNav.currentPage == 0 ? 30 : 25,
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .myLocation,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: btmNav.currentPage == 0 ? Colors.black45 : Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if(btmNav.currentPage != 1){
                        btmNav.setCurrentPage(1);
                        // CHANGED: To disappear diog if it shown
                        // if (mainPageProv.showDiaogSearchDrawer) {
                        //   mainPageProv.setShowDiogFalse();
                        // }
                        // CHANGED: To clear expended menu list count
                        // menuProv.clearExpendedMenuListCount();
                        // mainPageProv.removeMarkers();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Regions()),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.map,
                          color: btmNav.currentPage == 1 ? Colors.black45 : Color(0xffffffff),
                          size: btmNav.currentPage == 1 ? 30 : 25,
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .regions,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: btmNav.currentPage == 1 ? Colors.black45 : Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async{
                      if(btmNav.currentPage != 2){
                        btmNav.setCurrentPage(2);
                        // CHANGED: To disappear diog if it shown
                        // if (mainPageProv
                        //     .showDiaogSearchDrawer) {
                        //   mainPageProv
                        //       .setShowDiogFalse();
                        // }
                        // CHANGED: To clear expended menu list count
                        // menuProv.clearExpendedMenuListCount();
                        // CHANGED: To clear office markers from map
                        // mainPageProv.removeMarkers();
                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RealEstateOffices()),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.home_work,
                          color: btmNav.currentPage == 2 ? Colors.black45 : Color(0xffffffff),
                          size: btmNav.currentPage == 2 ? 30 : 25,
                        ),
                        Flexible(
                          child: Text(
                            AppLocalizations
                                .of(context)
                                .realEstateOffices,
                            style: CustomTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: btmNav.currentPage == 2 ? Colors.black45 : Color(0xffffffff),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // CHANGED: To disappear diog if it shown
                      // if (mainPageProv.showDiaogSearchDrawer) {
                      //   mainPageProv.setShowDiogFalse();
                      // }
                      // CHANGED: To clear ads markers from map
                      // mainPageProv.removeMarkers();
                      // CHANGED: To clear expended menu list count
                      // menuProv.clearExpendedMenuListCount();
                      final locale = Provider.of<LocaleProvider>(context, listen: false);
                      if(locale.phone != null) {
                        // btmNav.setCurrentPage(3);
                        // CHANGED
                        // Provider.of<MsgProvider>(context, listen: false).getConvInfo(context, _phone);
                        Navigator.push(context, _createRoute(0),);
                      }else{
                        Navigator.push(
                          context,
                          _createRoute(1),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.message_rounded,
                                color: btmNav.currentPage == 3 ? Colors.black45 : Color(0xffffffff),
                          size: btmNav.currentPage == 3 ? 30 : 25,
                        ),
                            ),
                            if(msgProv.unreadMsgs != 0)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration:
                                  BoxDecoration(
                                      color: Colors
                                          .red
                                          .withOpacity(
                                          0.8),
                                      shape: BoxShape
                                          .circle),
                                  child: Center(
                                    child: Text(
                                      '${msgProv.unreadMsgs}',
                                      style: TextStyle(
                                        fontFamily:
                                        'DINNext',
                                        fontSize: 11,
                                        color: Colors.white,
                                        // color:
                                        // convList.conv[i].phone_user_sender == _phone
                                        //         ? Color(0xff848282)
                                        //         : Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            AppLocalizations
                                .of(context)
                                .messages,
                            style: CustomTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: btmNav.currentPage == 3 ? Colors.black45 : Color(0xffffffff),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if(btmNav.currentPage != 4){
                        btmNav.setCurrentPage(4);
                        // CHANGED: To disappear diog if it shown
                        // if (mainPageProv.showDiaogSearchDrawer) {
                        //   mainPageProv.setShowDiogFalse();
                        // }
                        // CHANGED: To clear expended menu list count
                        // menuProv.clearExpendedMenuListCount();
                        // mainPageProv.removeMarkers();
                        Navigator.pushReplacement(
                          context,
                          _createRoute(2),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.menu,
                          color: btmNav.currentPage == 4 ? Colors.black45 : Color(0xffffffff),
                          size: btmNav.currentPage == 4 ? 30 : 25,
                        ),
                        Text(
                          AppLocalizations.of(context).menu,
                          style: CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: btmNav.currentPage == 4 ? Colors.black45 : Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  //  this function make animations of routes
  // Route _createRoute(int i) {
  //   return PageRouteBuilder(
  //       pageBuilder: (context, animation, secondaryAnimation) => pages[i],
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //
  //         return FadeTransition(
  //           opacity: animation,
  //           child: child,
  //         );
  //       },
  //       transitionDuration: Duration(milliseconds: 500)
  //   );
  // }
  PageTransition _createRoute(int i) {
    return PageTransition(type: PageTransitionType.bottomToTop,
        duration: Duration(milliseconds: 10),
        child: pages[i]);
  }
}
