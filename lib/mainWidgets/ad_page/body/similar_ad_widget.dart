import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SimilarAdWidget extends StatelessWidget {
  SimilarAdWidget({Key key, this.adsPage}) : super(key: key);

  final MutualProvider adsPage;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).similarAds,
                style: CustomTextStyle(

                  fontSize: 20,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // TODO CHANGED: conver for loop to [ListView.builder()] and show arrow to load more
        adsPage.adsSimilar.isNotEmpty
            ?
        Container(
          width: mediaQuery.size.width,
          // height: adsPage.countAdsSimilar() < 3 ? adsPage.countAdsSimilar() < 2 ? 165 : 330 : 500 ,
          height: adsPage.countAdsSimilar() > 3 ? adsPage.countAdsSimilar() == adsPage.expendedListCount ? adsPage.expendedListCount * 165.0 : (adsPage.expendedListCount * 150.0) - 50 : adsPage.countAdsSimilar() * 165.0,
          child: ListView.builder(
            // itemCount: adsPage.countAdsSimilar() > 3 ? 3 : adsPage.countAdsSimilar(),
            itemCount: adsPage.countAdsSimilar() > adsPage.expendedListCount-1 ? adsPage.expendedListCount : adsPage.countAdsSimilar(),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i){
              if(i != adsPage.countAdsSimilar() -1){
                if(i == adsPage.expendedListCount-1){
                  return GestureDetector(
                    onTap: (){
                      if(adsPage.countAdsSimilar() < adsPage.expendedListCount){
                        adsPage.setExpendedListCount(adsPage.expendedListCount+5);
                      }else{
                        adsPage.setExpendedListCount(adsPage.countAdsSimilar());
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
                  final adPageProv = Provider.of<AdPageProvider>(context, listen: false);
                  adPageProv
                      .stopVideoAdsPage();
                  adsPage.getAdsPageList(context,
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getImagesAdsPageList(context,
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getUserAdsPageInfo(context,
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getAdsVRInfo(context,
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getBFAdsPageList(context,
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getQFAdsPageList(context,
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getViewsChartInfo(context,
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getNavigationAdsPageList(context);
                  adsPage.setIdDescription(
                      adsPage.adsSimilar[i].idDescription);
                  adsPage.getSimilarAdsList(context, adsPage.adsSimilar[i].idCategory, adsPage.adsSimilar[i].idDescription);

                  Future.delayed(Duration(seconds: 0), () {
                    Navigator.pushReplacement(
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
                        color: Color(0xffcccccc),
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
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
                      Container(
                        width: 180.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                'https://tadawl.com.sa/API/assets/images/ads/' +
                                    adsPage
                                        .adsSimilar[i]
                                        .ads_image ??
                                    ''),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                if (adsPage.adsSimilar[i]
                                    .idSpecial ==
                                    '1')
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .fromLTRB(
                                        10, 0, 5, 0),
                                    child: Icon(
                                      Icons.verified,
                                      color:
                                      Color(0xffe6e600),
                                      size: 30,
                                    ),
                                  ),
                                Text(
                                  adsPage
                                      .adsSimilar[i].title,
                                  style:
                                  CustomTextStyle(

                                    fontSize: 20,
                                    color: const Color(
                                        0xff000000),
                                  ).getTextStyle(),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Text(
                                  adsPage
                                      .adsSimilar[i].price,
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
                                    AppLocalizations.of(
                                        context)
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
                              MainAxisAlignment.start,
                              children: [
                                Text(
                                  adsPage
                                      .adsSimilar[i].space,
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
                                    AppLocalizations.of(
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
                                  10, 0, 5, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  if (adsPage.adsSimilar[i]
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
                                  if (adsPage.adsSimilar[i]
                                      .ads_city !=
                                      null ||
                                      adsPage.adsSimilar[i]
                                          .ads_neighborhood !=
                                          null)
                                    Text(
                                      '${adsPage.adsSimilar[i].ads_city} - ${adsPage.adsSimilar[i].ads_neighborhood}',
                                      style: CustomTextStyle(
                                        fontSize: 10,
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
            },
          ),
        )
            :
        Container(),
      ],
    );
  }
}
