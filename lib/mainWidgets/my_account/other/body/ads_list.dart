import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class AdsList extends StatelessWidget {
  const AdsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer2<MyAccountProvider, UserMutualProvider>(builder: (context, avatar, userMutual, child) {
      print("AdsList other -> MyAccountProvider");
      print("AdsList other -> UserMutualProvider");

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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                    child: Text(
                      AppLocalizations.of(context).ads,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff00cccc),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              if (userMutual.userAds.isNotEmpty)
                Container(
                  height: userMutual.countUserAds() > 3 ? userMutual.countUserAds() == avatar.expendedListCount ? avatar.expendedListCount * 165.0 : (avatar.expendedListCount * 150.0) - 50 : userMutual.countUserAds() * 165.0,
                  child: ListView.builder(
                    itemCount: userMutual.countUserAds() > avatar.expendedListCount-1 ? avatar.expendedListCount : userMutual.countUserAds(),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i){
                      if(i != userMutual.countUserAds() -1){
                        if(i == avatar.expendedListCount-1){
                          return GestureDetector(
                            onTap: (){
                              if(userMutual.countUserAds() < avatar.expendedListCount){
                                avatar.setExpendedListCount(avatar.expendedListCount+5);
                              }else{
                                avatar.setExpendedListCount(userMutual.countUserAds());
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
                              context, userMutual.userAds[i].idDescription);
                          Provider.of<MutualProvider>(context, listen: false).getSimilarAdsList(context, userMutual.userAds[i].idCategory, userMutual.userAds[i].idDescription);

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
                          height: 150.0,
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
                                  width: 180.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          'https://tadawl-store.com/API/assets/images/ads/' +
                                              userMutual.userAds[i]
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
                                        if (userMutual.userAds[i].idSpecial ==
                                            '1')
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                5, 0, 10, 0),
                                            child: Icon(
                                              Icons.verified,
                                              color: Color(0xffe6e600),
                                              size: 30,
                                            ),
                                          ),
                                        Text(
                                          userMutual.userAds[i].title,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          userMutual.userAds[i].price,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff00cccc),
                                          ).getTextStyle(),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .rial,
                                            style: CustomTextStyle(

                                              fontSize: 15,
                                              color:
                                              const Color(0xff00cccc),
                                            ).getTextStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          userMutual.userAds[i].space,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Text(
                                            AppLocalizations.of(context).m2,
                                            style: CustomTextStyle(

                                              fontSize: 15,
                                              color:
                                              const Color(0xff000000),
                                            ).getTextStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          if (userMutual
                                              .userAds[i].video.isNotEmpty)
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                              child: Icon(
                                                Icons.videocam_outlined,
                                                color: Color(0xff00cccc),
                                                size: 30,
                                              ),
                                            ),
                                          if (userMutual.userAds[i].ads_city !=
                                              null ||
                                              userMutual.userAds[i]
                                                  .ads_neighborhood !=
                                                  null)
                                            Text(
                                              '${userMutual.userAds[i].ads_city} - ${userMutual.userAds[i].ads_neighborhood}',
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
