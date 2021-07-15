import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/NotificationProvider.dart';

import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/map_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/office_marker_provider.dart';
import 'package:tadawl_app/provider/user_provider.dart';
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

  /// TODO This page to use in animations
  final pages = [
    DiscussionList(),
    // TestXX(),
    Login(),
    Menu(),
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    Provider.of<UserProvider>(context, listen: false).getSession();
    var _phone = Provider
        .of<UserProvider>(context, listen: false)
        .phone;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        height: mediaQuery.size.height * 0.11,
        width: mediaQuery.size.width,
        color: Color(0xff00cccc),
        child: Consumer<BottomNavProvider>(
          builder: (ctxt, btmNav, child){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (Provider
                          .of<AdsProvider>(context, listen: false)
                          .showDiaogSearchDrawer) {
                        Provider.of<AdsProvider>(context, listen: false)
                            .setShowDiogFalse();
                      }
                      // Scaffold.of(context).openEndDrawer();
                      Scaffold.of(context).openDrawer();
                      Provider.of<AdsProvider>(context, listen: false).update();
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Color(0xffffffff),
                          size: 25,
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .myAccount,
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
                      Provider.of<AdsProvider>(context, listen: false).removeMarkers();
                      btmNav.setCurrentPage(0);
                      // TODO CHANGED: To disappear diog if it shown
                      if (Provider.of<AdsProvider>(context, listen: false).showDiaogSearchDrawer) {
                        Provider.of<AdsProvider>(context, listen: false).setShowDiogFalse();
                      }
                      // TODO CHANGED: To clear expended menu list count
                      Provider.of<AdsProvider>(context, listen: false).clearExpendedMenuListCount();
                      // TODO CHANGED: To reset region position
                      Provider.of<AdsProvider>(context, listen: false).setRegionPosition(null);
                      // TODO CHANGED: To reload ads markers on map
                      Provider.of<AdsProvider>(context, listen: false).setInItMainPageDone(0);
                      // TODO CHANGED: To get current position before go to main page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
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
                      btmNav.setCurrentPage(1);
                      // TODO CHANGED: To disappear diog if it shown
                      if (Provider.of<AdsProvider>(context, listen: false).showDiaogSearchDrawer) {
                        Provider.of<AdsProvider>(context, listen: false).setShowDiogFalse();
                      }
                      // TODO CHANGED: To clear expended menu list count
                      Provider.of<AdsProvider>(context, listen: false).clearExpendedMenuListCount();
                      Provider.of<AdsProvider>(context, listen: false).removeMarkers();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Regions()),
                      );
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
                      btmNav.setCurrentPage(2);
                      // TODO CHANGED: To disappear diog if it shown
                      if (Provider
                          .of<AdsProvider>(context, listen: false)
                          .showDiaogSearchDrawer) {
                        Provider.of<AdsProvider>(context, listen: false)
                            .setShowDiogFalse();
                      }
                      // TODO CHANGED: To clear expended menu list count
                      Provider.of<AdsProvider>(context, listen: false).clearExpendedMenuListCount();
                      // TODO CHANGED: To clear office markers from map
                      Provider.of<OfficeMarkerProvider>(context, listen: false).clearMarkers();
                      Provider.of<AdsProvider>(context, listen: false).removeMarkers();
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RealEstateOffices()),
                      );
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
                      // TODO CHANGED: To disappear diog if it shown
                      if (Provider
                          .of<AdsProvider>(context, listen: false)
                          .showDiaogSearchDrawer) {
                        Provider.of<AdsProvider>(context, listen: false)
                            .setShowDiogFalse();
                      }
                      // TODO CHANGED: To clear ads markers from map
                      Provider.of<AdsProvider>(context, listen: false).removeMarkers();
                      // TODO CHANGED: To clear expended menu list count
                      Provider.of<AdsProvider>(context, listen: false)
                          .clearExpendedMenuListCount();
                      if(_phone != null) {
                        // btmNav.setCurrentPage(3);
                        // TODO CHANGED
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
                            if(Provider.of<MsgProvider>(context, listen: false).unreadMsgs != 0)
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
                                      '${Provider.of<MsgProvider>(context, listen: false).unreadMsgs}',
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
                      btmNav.setCurrentPage(4);
                      // TODO CHANGED: To disappear diog if it shown
                      if (Provider
                          .of<AdsProvider>(context, listen: false)
                          .showDiaogSearchDrawer) {
                        Provider.of<AdsProvider>(context, listen: false)
                            .setShowDiogFalse();
                      }
                      // TODO CHANGED: To clear expended menu list count
                      Provider.of<AdsProvider>(context, listen: false).clearExpendedMenuListCount();
                      Provider.of<AdsProvider>(context, listen: false).removeMarkers();
                      Navigator.pushReplacement(
                        context,
                        _createRoute(2),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.menu,
                          color: btmNav.currentPage == 4 ? Colors.black45 : Color(0xffffffff),
                          size: btmNav.currentPage == 4 ? 30 : 25,
                        ),
                        Text(
                          AppLocalizations
                              .of(context)
                              .menu,
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

  // TODO this function make animations of routes
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
