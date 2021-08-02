import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tadawl_app/provider/NotificationProvider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/ads_provider/special_offers_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';

class Home extends StatelessWidget {
  Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuProv = Provider.of<MenuProvider>(context, listen: false);
    final addAdProv = Provider.of<AddAdProvider>(context, listen: false);
    final userMutualProv = Provider.of<UserMutualProvider>(context, listen: false);
    final notificationProv = Provider.of<NotificationProvider>(context, listen: false);
    final msgProv = Provider.of<MsgProvider>(context, listen: false);

    menuProv.setMenuMainFilterAds(2);
    menuProv.clearMenuFilter(context);
    menuProv.getMenuList(
        context, null, null, null, null, null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null, null, null, null, null,
        null, null);



    addAdProv.getCategoryeInfoAddAds(context);



    userMutualProv.getSession();
    userMutualProv.getUsersList(userMutualProv.phone);



    notificationProv.getNotificationsList(userMutualProv.phone);
    Future.delayed(Duration(seconds: 5), () {
      notificationProv.showNotification(userMutualProv.phone);
    });

    msgProv.getUnreadMsgs(context, userMutualProv.phone);
    Future.delayed(Duration(seconds: 1), () {
      msgProv.getConvInfo(context, userMutualProv.phone);
    });



    // Provider.of<AdsProvider>(context, listen: false).getAdsList(
    //     context, null, null, null, null, null, null, null, null, null, null, null,
    //     null, null, null, null, null, null, null, null, null, null, null, null,
    //     null, null, null, null, null, null, null, null, null, null, null, null,
    //     null, null);

    
    // Provider.of<MutualProvider>(context, listen: false).randomPosition(50);

    // Provider.of<AdsProvider>(context, listen: false).setRegionPosition(null);
    //
    // Provider.of<AdsProvider>(context, listen: false).setInItMainPageDone(0);



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
