import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class AdsList extends StatelessWidget {
  const AdsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
    return Consumer<MyAccountProvider>(builder: (context, avatar, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              width: mediaQuery.size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xffdddddd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(50, 5, 50, 5),
                        child: Text(
                          AppLocalizations.of(context).ads,
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(50, 5, 50, 5),
                        child: Text(
                          AppLocalizations.of(context).payments,
                          style: CustomTextStyle(
                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      avatar.updateSelected(index);
                    },
                    isSelected: avatar.isSelected,
                    color: const Color(0xff8d8d8d),
                    selectedColor: const Color(0xff00cccc),
                    fillColor: const Color(0xffdddddd),
                    borderWidth: 2,
                    borderColor: const Color(0xffdddddd),
                    selectedBorderColor: const Color(0xffdddddd),
                  ),
                ],
              ),
            ),
          ),
          if (avatar.selectedNav == 1)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '...',
                  style: CustomTextStyle(
                    fontSize: 15,
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          if (avatar.selectedNav == 0)
            Column(
              children: [
                if (avatar.userAds.isNotEmpty)
                  Container(
                    height: avatar.countUserAds() == avatar.expendedListCount ? avatar.expendedListCount * ((mediaQuery.size.height*.2)+15) : (avatar.expendedListCount * (mediaQuery.size.height*.2)) - 40,
                    child: ListView.builder(
                      itemCount: avatar.countUserAds() > avatar.expendedListCount-1 ? avatar.expendedListCount : avatar.countUserAds(),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i){
                        if(i != avatar.countUserAds() -1){
                          if(i == avatar.expendedListCount-1){
                            return GestureDetector(
                              onTap: (){
                                if(avatar.countUserAds() < avatar.expendedListCount){
                                  avatar.setExpendedListCount(avatar.expendedListCount+5);
                                }else{
                                  avatar.setExpendedListCount(avatar.countUserAds());
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                                child: Icon(Icons.expand_more, size: 35,),
                              ),
                            );
                          }
                        }
                        return TextButton(
                          onPressed: () {
                            Provider.of<MutualProvider>(context, listen: false)
                                .getAllAdsPageInfo(
                                context, avatar.userAds[i].idDescription);
                            Provider.of<MutualProvider>(context, listen: false).getSimilarAdsList(context, avatar.userAds[i].idCategory, avatar.userAds[i].idDescription);
                            Future.delayed(Duration(seconds: 0), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdPage()),
                              );
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                                                avatar.userAds[i]
                                                    .ads_image ??
                                                ''),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        Random().nextInt(50).toDouble(),
                                        Random().nextInt(50).toDouble(),
                                        5, 5),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (avatar.userAds[i].idSpecial == '1')
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 5),
                                        child: Icon(
                                          Icons.verified,
                                          color: Color(0xffe6e600),
                                          size: 30,
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: (
                                          Provider.of<MutualProvider>(context, listen: false).busy == true && Provider.of<MutualProvider>(context, listen: false).number == i)
                                          ?
                                      CircularProgressIndicator()
                                          :
                                      DateTime.now().difference(DateTime.parse(avatar.userAds[i].timeUpdated)).inMinutes - 180 > 60
                                          ?
                                      TextButton(
                                        onPressed: () {
                                          Provider.of<MutualProvider>(context, listen: false).setNumber(i);
                                          // Provider.of<FavouriteProvider>(context, listen: false).update();
                                          Provider.of<MutualProvider>(context, listen: false).updateAds(context, avatar.userAds[i].idDescription).then((value) {
                                            if(value){
                                              avatar.getUserAdsList(locale.phone);
                                              // Provider.of<FavouriteProvider>(context, listen: false).update();
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: mediaQuery.size.width *
                                              0.15,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0),
                                            border: Border.all(
                                                width: 1.0,
                                                color: const Color(
                                                    0xff3f9d28)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(
                                                  context)
                                                  .updateAds,
                                              style:
                                              CustomTextStyle(

                                                fontSize: 15,
                                                color: const Color(
                                                    0xff3f9d28),
                                              ).getTextStyle(),
                                              textAlign:
                                              TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )
                                          :
                                      TextButton(
                                        onPressed: (){
                                          Fluttertoast.showToast(
                                              msg:
                                              'ستتمكن من التحديث بعد ${24-(DateTime.now().difference(DateTime.parse(avatar.userAds[i].timeUpdated)).inMinutes - 180)} دقيقة',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              textColor: Colors.white,
                                              fontSize: 15.0);
                                        },
                                        child: Container(
                                          width: mediaQuery.size.width *
                                              0.15,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0),
                                            border: Border.all(
                                                width: 1.0,
                                                color: Colors.grey),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(
                                                  context)
                                                  .updateAds,
                                              style:
                                              CustomTextStyle(

                                                fontSize: 15,
                                                color: Colors.grey,
                                              ).getTextStyle(),
                                              textAlign:
                                              TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (avatar.userAds[i].video.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: Icon(
                                          Icons.videocam_outlined,
                                          color: Color(0xff00cccc),
                                          size: 30,
                                        ),
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Text(
                                              avatar.userAds[i].title,
                                              style: CustomTextStyle(

                                                fontSize: 13,
                                                color:
                                                const Color(0xff000000),
                                              ).getTextStyle(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Text(
                                              avatar.userAds[i].price,
                                              style: CustomTextStyle(

                                                fontSize: 15,
                                                color:
                                                const Color(0xff00cccc),
                                              ).getTextStyle(),
                                              // textAlign: TextAlign.right,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .rial,
                                              style: CustomTextStyle(

                                                fontSize: 15,
                                                color:
                                                const Color(0xff00cccc),
                                              ).getTextStyle(),
                                              // textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 0, 15, 0),
                                            child: Text(
                                              avatar.userAds[i].space,
                                              style: CustomTextStyle(

                                                fontSize: 15,
                                                color:
                                                const Color(0xff000000),
                                              ).getTextStyle(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Text(
                                              AppLocalizations.of(context).m2,
                                              style: CustomTextStyle(

                                                fontSize: 15,
                                                color:
                                                const Color(0xff000000),
                                              ).getTextStyle(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            if (avatar.userAds[i].ads_city !=
                                                null ||
                                                avatar.userAds[i]
                                                    .ads_neighborhood !=
                                                    null)
                                              Text(
                                                '${avatar.userAds[i].ads_city} - ${avatar.userAds[i].ads_neighborhood}',
                                                style: CustomTextStyle(

                                                  fontSize: 8,
                                                  color:
                                                  const Color(0xff000000),
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
                        );
                      },
                    ),
                  )
                else
                  Container(),
              ],
            )
        ],
      );
    });
  }
}
