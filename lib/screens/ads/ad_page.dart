import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_description_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_header_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_info_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_location_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_qr_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_statistics_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_times_and_update_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/appBar/app_bar_title_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/avatar_widget_helper.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/network_coverage_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/similar_ad_widget.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_helper_provider.dart';
//import 'package:tadawl_app/mainWidgets/openMap.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';


class AdPage extends StatelessWidget {
  AdPage({
    Key key,
    @required this.ads,
    @required this.selectedScreen,
    @required this.index,
  }) : super(key: key);
  final List<AdsModel> ads;
  final SelectedScreen selectedScreen;
  final int index;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = locale.locale.toString();
    return Consumer<AdPageProvider>(builder: (context, adsPage, child) {
      return WillPopScope(
        onWillPop: () async{
          adsPage.clearAdsUser();
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            actions: [
              if(adsPage.adsUser != null)
                if(adsPage.adsUser.phone == locale.phone)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xff04B404),
                        size: 40,
                      ),
                      onSelected: (String choice) {
                        adsPage.choiceAction(context, choice, adsPage.idDescription, ads, index, selectedScreen);
                      },
                      itemBuilder: (BuildContext context) {
                        return (_lang != 'en_US'?Constants.choices:EngConstants.choices).map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                              style: CustomTextStyle(
                                fontSize: 20,
                                color: choice == (_lang != 'en_US'?Constants.deleteAd:EngConstants.deleteAd) ? const Color(0xffff0000) : const Color(0xff989898),
                              ).getTextStyle(),
                              textAlign: TextAlign.left,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
            ],
            leadingWidth: 70.0,
            toolbarHeight: 70.0,
            title: AppBarTitleWidget(),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                if (adsPage.videoControllerAdsPage != null) {
                  adsPage.stopVideoAdsPage();
                }
                adsPage.clearAdsUser();
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color(0xff1f2835),
          ),
          body: Stack(
            children: [
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  controller: adsPage.scrollController,
                  dragStartBehavior: DragStartBehavior.down,
                  children: [
                    if (adsPage.adsPage != null)
                      Column(
                        children: [
                          AdHeaderWidget(),
                          AdInfoWidget(ads: ads, index: index),
// ads add timestamp ....................
// last update ads timestamp ....................
                          AdTimesAndUpdateWidget(),
// end ads add timestamp ....................
// end last update ads timestamp ....................
// description ...................
                          AdDescriptionWidget(),
// end description ...................
//  avatar .............
                          AvatarWidgetHelper(phone: adsPage.adsPage.phone_faved_user,),
// end avatar .............
//  statistics ads ........................
                          AdStatisticsWidget(),
//  end statistics ads ........................
//  network coverage ...................
                          NetworkCoverageWidget(),
// end network coverage ...................
//  location .....................
                          AdLocationWidget(),
// end location .....................
// qr share ..........................................
                          AdQRWidget(),
// end qr share ..........................................
//  similar ads ..............
                          SimilarAdWidget(),
// end similar ads ..............
                        ],
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: Color(0xff00cccc),
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xffffffff)),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: mediaQuery.size.width,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        if (ads.isNotEmpty)
                          Row(
                            mainAxisAlignment:
                            adsPage.idDescription == ads.first.idDescription ?
                            MainAxisAlignment.end :MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < ads.length; i++)
                                if (ads[i].idDescription == adsPage.idDescription &&
                                    ads[i].idDescription != ads.first.idDescription)
                                  Container(
                                    width: 50.0,
                                    child: InkWell(
                                      onTap: () {
                                        adsPage.stopVideoAdsPage();
                                        // adsPage.getAllAdsPageInfo(context, ads[i - 1].idDescription);
                                        // adsPage.getSimilarAdsList(context, ads[i - 1].idCategory, ads[i - 1].idDescription);
                                        // Future.delayed(Duration(seconds: 0), () {
                                        //   Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             ChangeNotifierProvider<AdPageProvider>(
                                        //               create: (_) => AdPageProvider(context, ads[i - 1].idDescription, ads[i - 1].idCategory),
                                        //               child: AdPage(ads: ads, selectedScreen: SelectedScreen.menu),
                                        //             )
                                        //             ),
                                        //   );
                                        // });
                                        Provider.of<AdPageHelperProvider>(context, listen: false).previousIndex();
                                      },
                                      child: Transform.rotate(
                                        angle: 180.0-45.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xff2d3872), width: 1),
                                            shape: BoxShape.circle,
                                            color: const Color(0xff1f2835),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xffffffff),
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              for (var i = 0; i < ads.length; i++)
                                if (ads[i].idDescription == adsPage.idDescription &&
                                    ads[i].idDescription != ads.last.idDescription)
                                  Container(
                                    width: 50.0,
                                    child: InkWell(
                                      onTap: () {
                                        adsPage.stopVideoAdsPage();
                                        // adsPage.getAllAdsPageInfo(context, ads[i + 1].idDescription);
                                        // adsPage.getSimilarAdsList(context, ads[i + 1].idCategory, ads[i + 1].idDescription);
                                        // Future.delayed(Duration(seconds: 0), () {
                                        //   Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             ChangeNotifierProvider<AdPageProvider>(
                                        //               create: (_) => AdPageProvider(context, ads[i + 1].idDescription, ads[i + 1].idCategory),
                                        //               child: AdPage(ads: ads, selectedScreen: SelectedScreen.menu),
                                        //             )
                                        //
                                        //     ),
                                        //   );
                                        // });
                                        Provider.of<AdPageHelperProvider>(context, listen: false).nextIndex();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: const Color(0xff2d3872), width: 1),
                                          shape: BoxShape.circle,
                                          color: const Color(0xff1f2835),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xffffffff),
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


class Constants {
  static const String editGallery = 'تعديل الصور والفيديو';
  static const String editLocation = 'تعديل الموقع';
  static const String editDetails = 'تعديل التفاصيل';
  static const String deleteAd = 'حذف الإعلان';
  static const List<String> choices = <String>[
    editGallery,
    editLocation,
    editDetails,
    deleteAd,
  ];
}

class EngConstants {
  static const String editGallery = 'Update Images and Videos';
  static const String editLocation = 'Update Location';
  static const String editDetails = 'Update Details';
  static const String deleteAd = 'Delete Ad';
  static const List<String> choices = <String>[
    editGallery,
    editLocation,
    editDetails,
    deleteAd,
  ];
}