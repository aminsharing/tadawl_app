import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tadawl_app/provider/NotificationProvider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';

class Home extends StatelessWidget {
  Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Homeee");
    final notificationProv = Provider.of<NotificationProvider>(context, listen: false);
    // final msgProv = Provider.of<MsgProvider>(context, listen: false);
    final locale = Provider.of<LocaleProvider>(context, listen: false);

    locale.getSession().then((value) {
      if(value != null){
        notificationProv.getNotificationsList(value);
        Future.delayed(Duration(seconds: 5), () {
          notificationProv.showNotification(value);
        });
      }
    });

    // msgProv.getUnreadMsgs(context, locale.phone);
    // Future.delayed(Duration(seconds: 1), () {
    //   msgProv.getConvInfo(context, locale.phone);
    // });

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
          nextScreen: MainPage(null),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 200,
          backgroundColor: const Color(0xff1f2835),
        ));
  }
}
