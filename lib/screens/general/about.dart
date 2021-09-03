import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: Color(0xff1f2835),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
          child: Text(
            AppLocalizations.of(context)!.about,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        toolbarHeight: 80,
        leadingWidth: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 40,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    width: double.infinity,
                    height: 47.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          width: 2.0, color: const Color(0xff04B404)),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.tadawl,
                        style: CustomTextStyle(

                          fontSize: 20,
                          color: const Color(0xff04B404),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => directSupport(context),
                        child: Text(
                          AppLocalizations.of(context)!.support,
                          style: CustomTextStyle(

                            fontSize: 20,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: () => directSupport(context),
                        child: Icon(
                          Icons.message_rounded,
                          color: Color(0xff04B404),
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: launchWhatsApp,
                        child: Text(
                          'واتساب',
                          style: CustomTextStyle(

                            fontSize: 20,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: launchWhatsApp,
                        child: Container(
                          width: 39.0,
                          height: 33.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/images/img15.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _launchURLTwitter,
                        child: Text(
                          '@1_TADAWL',
                          style: CustomTextStyle(

                            fontSize: 20,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: _launchURLTwitter,
                        child: Container(
                          width: 39.0,
                          height: 33.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/images/img20.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _launchURLFacebook,
                        child: Text(
                          '@TADAWLAPP',
                          style: CustomTextStyle(

                            fontSize: 20,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: _launchURLFacebook,
                        child: Container(
                          width: 39.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/images/img29.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _launchURLInstagram,
                        child: Text(
                          '@tadawl_comsa',
                          style: CustomTextStyle(
                            fontSize: 20,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: _launchURLInstagram,
                        child: Container(
                          width: 39.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/images/img30.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _launchURLTadawl,
                        child: Text(
                          'tadawl-store.com',
                          style: CustomTextStyle(
                            fontSize: 20,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: _launchURLTadawl,
                        child: Container(
                          width: 39.0,
                          height: 39.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: const AssetImage('assets/images/logo22.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          if(Platform.isAndroid){
                            Share.share('https://play.google.com/store/apps/details?id=com.tadawlapp.tadawl_app');
                          }else if(Platform.isIOS){
                            Share.share('https://apps.apple.com/sa/app/id1569963764');
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.shareApp,
                          style: CustomTextStyle(
                            fontSize: 20,
                            color: const Color(0xff04B404),
                          ).getTextStyle(),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if(Platform.isAndroid){
                            Share.share('https://play.google.com/store/apps/details?id=com.tadawlapp.tadawl_app');
                          }else if(Platform.isIOS){
                            Share.share('https://apps.apple.com/sa/app/id1569963764');
                          }
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          launch(_emailLaunchUri.toString());
                        },
                        child: Text(
                          'support@tadawl.com.sa',
                          style: CustomTextStyle(
                            fontSize: 20,
                            color: const Color(0xff434388),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _launchURLSnapchat,
                        child: Container(
                          width: 200.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.0),
                            image: DecorationImage(
                              image: const AssetImage('assets/images/imgsnap.jpeg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                  child: Container(
                    width: double.infinity,
                    height: 47.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      border: Border.all(
                          width: 2.0, color: const Color(0xff04B404)),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.directoryServices,
                        style: CustomTextStyle(

                          fontSize: 20,
                          color: const Color(0xff04B404),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                  child: Container(
                    width: double.infinity,
                    height: 47.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      border: Border.all(
                          width: 2.0, color: const Color(0xff04B404)),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.commonQuestions,
                        style: CustomTextStyle(

                          fontSize: 20,
                          color: const Color(0xff04B404),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    AppLocalizations.of(context)!.tadawl,
                    style: CustomTextStyle(

                      fontSize: 10,
                      color: const Color(0xff707070),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  'v 1.6.3',
                  style: CustomTextStyle(
                    fontSize: 10,
                    color: const Color(0xff707070),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          AppLocalizations.of(context)!.developedCompany,
                          style: CustomTextStyle(

                            fontSize: 13,
                            color: const Color(0xff707070),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextButton(
                        onPressed: _launchURLWebsite,
                        child: Container(
                          width: 100.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage(
                                  'assets/images/logoStarsTech.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURLTwitter() async {
  const url = 'https://twitter.com/1_TADAWL';
  await launch(url);
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

void _launchURLWebsite() async {
  const url = 'https://www.sta.sa';
  await launch(url);
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

void _launchURLSnapchat() async {
  const url = 'https://www.snapchat.com/add/tadawl_comsa';
  await launch(url);
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

void _launchURLFacebook() async {
  const url = 'https://www.facebook.com/TADAWLAPP';
  await launch(url);
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

void _launchURLInstagram() async {
  const url = 'https://www.instagram.com/tadawl_comsa';
  await launch(url);
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

void _launchURLTadawl() async {
  const url = 'https://tadawl-store.com/';
  await launch(url);
}

final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@tadawl.com.sa',
    queryParameters: {'subject': 'تطبيق تداول العقاري'});

void launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: '+966552525000',
    text: 'تطبيق تداول العقاري - الدعم الفني',
  );
  await launch('$link');
}

void directSupport(BuildContext context) async {
  final locale = Provider.of<LocaleProvider>(context, listen: false);

  if(locale.phone == '966552525000'){
    await Fluttertoast.showToast(
        msg: 'لا يمكن لصاحب التطبيق التواصل مع الدعم الفني',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0);
  }
  else{
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ChangeNotifierProvider<MsgProvider>(
                  create: (context) => MsgProvider(context, locale.phone, customMsg: 'الدعم الفني',),
                  child: Discussion(
                    '966552525000',
                    username: 'تطبيق تداول العقاري',
                  ),
                )
        )
    );
  }
}