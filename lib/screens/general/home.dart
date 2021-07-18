import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tadawl_app/provider/NotificationProvider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/office_marker_provider.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/ads_provider/special_offers_provider.dart';
import 'package:tadawl_app/provider/ads_provider/today_ads_provider.dart';
import 'package:tadawl_app/provider/user_provider/favourite_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';

class Home extends StatelessWidget {
  Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Provider.of<MapProvider>(context, listen: false).getLocPer();
    // Provider.of<MapProvider>(context, listen: false).getLoc();
    Provider.of<TodayAdsProvider>(context, listen: false).initStateSelected();
    Provider.of<MenuProvider>(context, listen: false).setMenuMainFilterAds(2);
    // Provider.of<AdsProvider>(context, listen: false).getAdsList(
    //     context, null, null, null, null, null, null, null, null, null, null, null,
    //     null, null, null, null, null, null, null, null, null, null, null, null,
    //     null, null, null, null, null, null, null, null, null, null, null, null,
    //     null, null);
    Provider.of<SpecialOffersProvider>(context, listen: false)
        .getAdsSpecialList(context);
    Provider.of<TodayAdsProvider>(context, listen: false).getTodayAdsList(context);
    Provider.of<MenuProvider>(context, listen: false).clearMenuFilter(context);
    Provider.of<MutualProvider>(context, listen: false).randomPosition(50);
    Provider.of<AddAdProvider>(context, listen: false).getCategoryeInfoAddAds(context);
    Provider.of<MenuProvider>(context, listen: false).getMenuList(
        context, null, null, null, null, null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null, null, null, null, null,
        null, null);

    // Provider.of<AdsProvider>(context, listen: false).setRegionPosition(null);
    //
    // Provider.of<AdsProvider>(context, listen: false).setInItMainPageDone(0);

    Provider.of<OfficeMarkerProvider>(context, listen: false).getOfficeList(context);

    Provider.of<UserMutualProvider>(context, listen: false).getUsersList(context, Provider.of<UserMutualProvider>(context, listen: false).phone);

    Provider.of<TodayAdsProvider>(context, listen: false).getTodayAdsList(context);

    Provider.of<FavouriteProvider>(context, listen: false).getUserAdsFavList(context, Provider.of<UserMutualProvider>(context, listen: false).phone);

    Provider.of<NotificationProvider>(context, listen: false)
        .getNotificationsList(
        context, Provider.of<UserMutualProvider>(context, listen: false).phone);

    Provider.of<UserMutualProvider>(context, listen: false).getSession();

    Provider.of<MsgProvider>(context, listen: false).getUnreadMsgs(context, Provider.of<UserMutualProvider>(context, listen: false).phone);

    Provider.of<MyAccountProvider>(context, listen: false).initStateSelected();

    Future.delayed(Duration(seconds: 1), () {
      Provider.of<MsgProvider>(context, listen: false).getConvInfo(context, Provider.of<UserMutualProvider>(context, listen: false).phone);
    });

    Future.delayed(Duration(seconds: 5), () {
      Provider.of<NotificationProvider>(context, listen: false).showNotification(context, Provider.of<UserMutualProvider>(context, listen: false).phone);
    });


    return Scaffold(
        backgroundColor: const Color(0xff1f2835),
        body: AnimatedSplashScreen(
          duration: 2500,
          splash: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          nextScreen: MainPage(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 200,
          backgroundColor: const Color(0xff1f2835),
        ));
  }
}
