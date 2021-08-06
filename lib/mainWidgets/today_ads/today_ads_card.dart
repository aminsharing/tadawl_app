import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodayAdsCard extends StatelessWidget {
  const TodayAdsCard({
    Key key,
    @required this.todayAds
  }) : super(key: key);
  final AdsModel todayAds;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return TextButton(
      onPressed: () {
        Provider.of<MutualProvider>(context, listen: false)
            .getAllAdsPageInfo(context, todayAds.idDescription);
        Provider.of<MutualProvider>(context, listen: false)
            .getSimilarAdsList(
            context, todayAds.idCategory, todayAds.idDescription);
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
                            todayAds.ads_image ?? ''),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      if (todayAds
                          .idSpecial ==
                          '1')
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(
                              5, 0, 10, 0),
                          child: Icon(
                            Icons.verified,
                            color:
                            Color(0xffe6e600),
                            size: 30,
                          ),
                        ),
                      Text(
                        todayAds.title,
                        style:
                        CustomTextStyle(
                          fontSize: 20,
                          color: const Color(
                              0xff000000),
                        ).getTextStyle(),
                        textAlign:
                        TextAlign.right,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Text(
                        todayAds.price,
                        style:
                        CustomTextStyle(

                          fontSize: 15,
                          color: const Color(
                              0xff00cccc),
                        ).getTextStyle(),
                        textAlign:
                        TextAlign.right,
                      ),
                      Padding(
                        padding: const EdgeInsets
                            .fromLTRB(0, 0, 5, 0),
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .rial,
                          style:
                          CustomTextStyle(
                            fontSize: 15,
                            color: const Color(
                                0xff00cccc),
                          ).getTextStyle(),
                          textAlign:
                          TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      Text(
                        todayAds.space,
                        style:
                        CustomTextStyle(

                          fontSize: 15,
                          color: const Color(
                              0xff000000),
                        ).getTextStyle(),
                        textAlign:
                        TextAlign.right,
                      ),
                      Padding(
                        padding: const EdgeInsets
                            .fromLTRB(0, 0, 5, 0),
                        child: Text(
                          AppLocalizations
                              .of(
                              context)
                              .m2,
                          style:
                          CustomTextStyle(

                            fontSize: 15,
                            color: const Color(
                                0xff000000),
                          ).getTextStyle(),
                          textAlign:
                          TextAlign.right,
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
                        if (todayAds
                            .video.isNotEmpty)
                          Padding(
                            padding:
                            const EdgeInsets
                                .fromLTRB(
                                0, 0, 5, 0),
                            child: Icon(
                              Icons
                                  .videocam_outlined,
                              color: Color(
                                  0xff00cccc),
                              size: 30,
                            ),
                          ),
                        if (todayAds
                            .ads_city !=
                            null ||
                            todayAds
                                .ads_neighborhood !=
                                null)
                          Text(
                            '${todayAds.ads_city} - ${todayAds
                                .ads_neighborhood}',
                            style: CustomTextStyle(
                              fontSize: 8,
                              color: const Color(
                                  0xff000000),
                            ).getTextStyle(),
                            textAlign:
                            TextAlign.right,
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
  }
}