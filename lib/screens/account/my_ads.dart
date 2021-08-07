import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyAds extends StatelessWidget {
  MyAds({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<MyAccountProvider>(builder: (context, myAds, child) {

      print("MyAds -> UserMutualProvider");

      var mediaQuery = MediaQuery.of(context);
      //var _phone = myAds.phone;
      //myAds.getUserAdsList(context, _phone);
      //Provider.of<AdsProvider>(context, listen: false).randomPosition(50);
      return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80.0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            AppLocalizations.of(context).myAds + ' (${myAds.countUserAds()}) ',
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Column(
              children: [
                if (myAds.userAds.isNotEmpty)
                  for (int i = 0; i < myAds.countUserAds(); i++)
                   // myAds.wait?
                    //Padding(
                    //  padding: const EdgeInsets.all(20.0),
                   //   child: Center(child: CircularProgressIndicator()),
                   // ):
                    TextButton(
                      onPressed: () {
                        //myAds.setWaitState(true);
                        Provider.of<MutualProvider>(context, listen: false)
                            .getAllAdsPageInfo(
                                context, myAds.userAds[i].idDescription);
                        Provider.of<MutualProvider>(context, listen: false).getSimilarAdsList(context, myAds.userAds[i].idCategory, myAds.userAds[i].idDescription);

                        Future.delayed(Duration(seconds: 0), () {
                       Navigator.push(
                            context,
                           MaterialPageRoute(
                               builder: (context) => AdPage()),
                          );
                      // myAds.setWaitState(false);
                        });
                      },
                      child: Container(
                        width: mediaQuery.size.width,
                        height: mediaQuery.size.height*.2,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffa6a6a6),
                              offset: const Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 7.0,
                              spreadRadius: 2.0,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Container(
                                width: mediaQuery.size.width*.4,
                                height: mediaQuery.size.height*.2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        'https://tadawl-store.com/API/assets/images/ads/' +
                                                myAds.userAds[i].ads_image ??
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
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: const CachedNetworkImageProvider(
                                            'https://tadawl-store.com/API/assets/images/logo22.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (myAds.userAds[i].idSpecial == '1')
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Icon(
                                      Icons.verified,
                                      color: Color(0xffe6e600),
                                      size: 30,
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: (Provider.of<MutualProvider>(context, listen: false).busy == true &&
                                          Provider.of<MutualProvider>(context, listen: false).number == i)
                                      ?
                                  CircularProgressIndicator()
                                      :
                                  DateTime.now().difference(DateTime.parse(myAds.userAds[i].timeUpdated)).inMinutes - 180 > 60
                                      ?
                                  TextButton(
                                          onPressed: () {
                                            Provider.of<MutualProvider>(context, listen: false).setNumber(i);
                                            Provider.of<MutualProvider>(context, listen: false).updateAds(context, myAds.userAds[i].idDescription).then((value) {
                                              if(value){
                                                myAds.getUserAdsList(locale.phone);
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: mediaQuery.size.width * 0.15,
                                            height: 35.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color:
                                                      const Color(0xff3f9d28)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .updateAds,
                                                style: CustomTextStyle(

                                                  color:
                                                      const Color(0xff3f9d28),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      :
                                  TextButton(
                                    onPressed: (){
                                      Fluttertoast.showToast(
                                          msg:
                                          'ستتمكن من التحديث بعد ${24-(DateTime.now().difference(DateTime.parse(myAds.userAds[i].timeUpdated)).inMinutes - 180)} دقيقة',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 15.0);
                                    },
                                    child: Container(
                                          width: mediaQuery.size.width * 0.15,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5.0),
                                            border: Border.all(
                                                width: 1.0,
                                                color: Colors.grey),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .updateAds,
                                              style: CustomTextStyle(

                                                color:
                                                Colors.grey,
                                              ).getTextStyle(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                                if (myAds.userAds[i].video.isNotEmpty)
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: Icon(
                                      Icons.videocam_outlined,
                                      color: Color(0xff00cccc),
                                      size: 30,
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 0),
                                        child: Text(
                                          myAds.userAds[i].title,
                                          style: CustomTextStyle(

                                            fontSize: 13,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Text(
                                          myAds.userAds[i].price,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff00cccc),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Text(
                                          AppLocalizations.of(context).rial,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff00cccc),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 15, 0),
                                        child: Text(
                                          myAds.userAds[i].space,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 0),
                                        child: Text(
                                          AppLocalizations.of(context).m2,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (myAds.userAds[i].ads_city != null ||
                                            myAds.userAds[i].ads_neighborhood !=
                                                null)
                                          Text(
                                            '${myAds.userAds[i].ads_city} - ${myAds.userAds[i].ads_neighborhood}',
                                            style: CustomTextStyle(

                                              fontSize: 8,
                                              color: const Color(0xff000000),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.right,
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
                    )
                else
                  Container(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
