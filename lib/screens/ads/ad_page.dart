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
import 'package:tadawl_app/mainWidgets/ad_page/appBar/app_bar_action_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/appBar/app_bar_title_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/avatar_widget_helper.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/network_coverage_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/similar_ad_widget.dart';
//import 'package:tadawl_app/mainWidgets/openMap.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';


class AdPage extends StatelessWidget {
  AdPage({
    Key key,
  }) : super(key: key);


  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider<AdPageProvider>(
      create: (_) => AdPageProvider(),
      child: Consumer2<AdPageProvider, MutualProvider>(builder: (context, adsPage, mutualProv, child) {
        // if( mutualProv.adsPage.isNotEmpty){
        //   adsPage.getIsFav(context, mutualProv.adsPage.first.idDescription);
        // }


        return Scaffold(
          backgroundColor: const Color(0xffffffff),
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            actions: [AppBarActionWidget()],
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
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color(0xff00cccc),
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
                    if (mutualProv.adsPage != null)
                      Column(
                        children: [
                          AdHeaderWidget(),
                          AdInfoWidget(),
// ads add timestamp ....................
// last update ads timestamp ....................
                          AdTimesAndUpdateWidget(),
// end ads add timestamp ....................
// end last update ads timestamp ....................
// description ...................
                          AdDescriptionWidget(),
// end description ...................
//  avatar .............
                          AvatarWidgetHelper(phone: mutualProv.adsPage.phone_faved_user,),
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
                        if (mutualProv.adsNavigation.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < mutualProv.adsNavigation.length; i++)
                                if (mutualProv.adsNavigation[i].idDescription == mutualProv.idDescription &&
                                    mutualProv.adsNavigation[i].idDescription != mutualProv.adsNavigation.first.idDescription)
                                  Container(
                                    width: 50.0,
                                    child: InkWell(
                                      onTap: () {
                                        adsPage.stopVideoAdsPage();
                                        mutualProv.getAllAdsPageInfo(context, mutualProv.adsNavigation[i - 1].idDescription);
                                        mutualProv.getSimilarAdsList(context, mutualProv.adsNavigation[i - 1].idCategory, mutualProv.adsNavigation[i - 1].idDescription);
                                        Future.delayed(Duration(seconds: 0), () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AdPage()),
                                          );
                                        });
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
                              for (var i = 0; i < mutualProv.adsNavigation.length; i++)
                                if (mutualProv.adsNavigation[i].idDescription == mutualProv.idDescription &&
                                    mutualProv.adsNavigation[i].idDescription != mutualProv.adsNavigation.last.idDescription)
                                  Container(
                                    width: 50.0,
                                    child: InkWell(
                                      onTap: () {
                                        adsPage.stopVideoAdsPage();
                                        mutualProv.getAllAdsPageInfo(context, mutualProv.adsNavigation[i + 1].idDescription);
                                        mutualProv.getSimilarAdsList(context, mutualProv.adsNavigation[i + 1].idCategory, mutualProv.adsNavigation[i + 1].idDescription);

                                        Future.delayed(Duration(seconds: 0), () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AdPage()),
                                          );
                                        });
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
        );
      }),
    );
  }
}


