import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_info_widget/ad_bf_table.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_info_widget/ad_view_table.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_info_widget/space_table.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/aqar_vr_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/ads/aqar_vr.dart';
import 'package:tadawl_app/screens/ads/update_details.dart';
import 'package:tadawl_app/screens/ads/upgrade_ad_screen.dart';
import 'ad_info_widget/ad_qf_table.dart';

class AdInfoWidget extends StatelessWidget {
  AdInfoWidget({
    Key key,
    @required this.ads
  }) : super(key: key);
  final List<AdsModel> ads;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);

    return Consumer<AdPageProvider>(builder: (context, adsPage, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    adsPage.stopVideoAdsPage();
                    Share.share('${adsPage.qrData}');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${adsPage.adsPage.ads_city??'غير محدد'} - ${adsPage.adsPage.ads_neighborhood??'غير محدد'}',
                        style: CustomTextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        '${adsPage.adsPage.ads_road??'غير محدد'}',
                        style: CustomTextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: Icon(
                    Icons.share,
                    color: Colors.grey,
                    size: 40,
                  ),
                  onPressed: () {
                    adsPage.stopVideoAdsPage();
                    Share.share('${adsPage.qrData}');
                  },
                ),
              ],
            ),
          ),
          if (adsPage.adsUser != null)
            if (adsPage.adsUser.phone == locale.phone)
              Wrap(
                children: [
                  GestureDetector(
                    onTap: (){
                      // TODO Add upgrade ads function
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpgradeAdScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                      child: Container(
                        width: mediaQuery.size.width * .3,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          border: Border.all(
                              width: 1.0, color: const Color(0xffe6e600)),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).advUpgrade,
                            style: CustomTextStyle(
                              fontSize: 16,
                              color: const Color(0xff989696),
                              // color: const Color(0xffe6e600),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if(adsPage.adsVR.isEmpty)
                    Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                    child: GestureDetector(
                      onTap: () {
                        adsPage.stopVideoAdsPage();
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ChangeNotifierProvider<AqarVRProvider>(
                              create: (_) => AqarVRProvider(),
                              child: AqarVR(),
                            )
                        ));
                      },
                      child: Container(
                        width: mediaQuery.size.width * .3,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          border: Border.all(
                              width: 1.0,
                              color: const Color(0xff00cccc)),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).reVR,
                            style: CustomTextStyle(
                              fontSize: 16,
                              color: const Color(0xff989696),
                              // color: const Color(0xff00cccc),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                    child: GestureDetector(
                      onTap: () {
                        if(adsPage.videoControllerAdsPage != null) {
                          adsPage.videoControllerAdsPage.pause();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                UpdateDetails(
                                  adsPage.idDescription,
                                  ads: ads,
                                  adsBF: adsPage.adsBF,
                                  adsQF: adsPage.adsQF,
                                  adsPage: adsPage.adsPage,
                                )
                            )
                        );
                      },
                      child: Container(
                        width: mediaQuery.size.width * .3,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          border: Border.all(
                              width: 1.0,
                              color: const Color(0xff04B404)),
                        ),
                        child: Center(
                          child: Text(
                            'تعديل الإعلان',
                            style: CustomTextStyle(
                              fontSize: 16,
                              color: const Color(0xff989696),
                              // color: const Color(0xff00cccc),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          if (adsPage.adsVR.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
              child: Column(
                children: [
                  if (adsPage.adsVR.first.state_aqar == '1')
                    Container(
                      width: mediaQuery.size.width,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: const Color(0xff3f9d28),
                            width: 1),
                        color: const Color(0xff3f9d28),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 0, 15, 0),
                            child: Icon(
                              Icons.verified,
                              color: Color(0xffffffff),
                              size: 35,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context).verAqar,
                            style: CustomTextStyle(
                              fontSize: 15,
                              color: const Color(0xffffffff),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else if (adsPage.adsVR.first.state_aqar == '0')
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        AppLocalizations.of(context).rule33,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          /// زر اجعل العقار فريداً
          // if (adsPage.adsUser != null)
          //   if (adsPage.adsUser.phone == locale.phone)
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
          //       child: TextButton(
          //         onPressed: () {
          //           adsPage.stopVideoAdsPage();
          //           return showDialog(
          //             context: context,
          //             builder: (context) => AlertDialog(
          //               title: Text(
          //                 AppLocalizations.of(context).uniqueAdv,
          //                 style: CustomTextStyle(
          //                   fontSize: 20,
          //                   color: const Color(0xff00cccc),
          //                 ).getTextStyle(),
          //                 textAlign: TextAlign.right,
          //               ),
          //               content: Text(
          //                 AppLocalizations.of(context).rule34,
          //                 style: CustomTextStyle(
          //                   fontSize: 15,
          //                   color: const Color(0xff000000),
          //                 ).getTextStyle(),
          //                 textAlign: TextAlign.right,
          //                 textDirection: TextDirection.rtl,
          //               ),
          //               actions: <Widget>[
          //                 Padding(
          //                   padding: const EdgeInsets.fromLTRB(
          //                       5, 0, 20, 0),
          //                   child: GestureDetector(
          //                     onTap: () {
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(builder: (context) =>
          //                               ChangeNotifierProvider<AqarVRProvider>(
          //                                 create: (_) => AqarVRProvider(),
          //                                 child: AqarVR(),
          //                               )
          //                           ));
          //                     },
          //                     child: Text(
          //                       AppLocalizations.of(context).reVR,
          //                       style: CustomTextStyle(
          //                         fontSize: 15,
          //                         color: const Color(0xff00cccc),
          //                       ).getTextStyle(),
          //                       textAlign: TextAlign.left,
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
          //                   child: GestureDetector(
          //                     onTap: () =>
          //                         Navigator.of(context).pop(false),
          //                     child: Text(
          //                       AppLocalizations.of(context).undo,
          //                       style: CustomTextStyle(
          //                         fontSize: 15,
          //                         color: const Color(0xff000000),
          //                       ).getTextStyle(),
          //                       textAlign: TextAlign.right,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: double.infinity,
          //           height: 40.0,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10.0),
          //             border: Border.all(
          //                 width: 1.0,
          //                 color: const Color(0xff3f9d28)),
          //           ),
          //           child: Center(
          //             child: Text(
          //               AppLocalizations.of(context).makeUnique,
          //               style: CustomTextStyle(
          //                 fontSize: 15,
          //                 color: const Color(0xff3f9d28),
          //               ).getTextStyle(),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SpaceTable(adsPage: adsPage.adsPage,),
// space ......................
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                if (adsPage.adsQF.isNotEmpty)
                  AdQFTable(adsQF: adsPage.adsQF,),
// quatity features ads ...........................
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                if (adsPage.adsBF.isNotEmpty)
                  AdBFTable(adsBF: adsPage.adsBF),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                AdViewTable(
                  views: adsPage.adsPage.views,
                  idDescription: adsPage.adsPage.idAds,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}





