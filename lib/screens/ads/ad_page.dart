import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_description_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_header_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_info_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_location_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_qr_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_statistics_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/ad_timestamp_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/appBar/app_bar_action_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/appBar/app_bar_title_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/avatar_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/last_update_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/network_coverage_widget.dart';
import 'package:tadawl_app/mainWidgets/ad_page/body/similar_ad_widget.dart';
//import 'package:tadawl_app/mainWidgets/openMap.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';


class AdPage extends StatelessWidget {
  AdPage({
    Key key,
  }) : super(key: key);


  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer2<AdPageProvider, MutualProvider>(builder: (context, adsPage, mutualProv, child) {

      print("AdPage -> AdPageProvider");
      print("AdPage -> MutualProvider");

      // ignore: missing_return
      Future<bool> _onBackPressed() async {
        adsPage.clearFav();
        if (adsPage.videoControllerAdsPage != null) {
          await adsPage.stopVideoAdsPage();
        }
        _scrollController.dispose();
        mutualProv.clearExpendedListCount();
        Navigator.pop(context);
      }


    // if( mutualProv.adsPage.isNotEmpty){
    //   adsPage.getIsFav(context, mutualProv.adsPage.first.idDescription);
    // }


      var provider = Provider.of<LocaleProvider>(context, listen: false);
      var _lang = provider.locale.toString();
      if (_lang != 'en_US') {
        Jiffy.locale('ar');
      }
      else if (_lang == 'en_US') {
        Jiffy.locale('en');
      }

      Future<Null> _refresh() async{
        adsPage.update();
      }
      var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;

      return RefreshIndicator(
        onRefresh: _refresh,
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
            backgroundColor: const Color(0xffffffff),
            key: _scaffoldKey,
            appBar: AppBar(
          centerTitle: true,
              actions: [AppBarActionWidget(adsPage: mutualProv)],
              leadingWidth: 100.0,
              toolbarHeight: 100.0,
              title: AppBarTitleWidget(adsPage: adsPage, mutualProv: mutualProv,),
              leading: Padding(
                padding: const EdgeInsets.all(15.0),
                child: IconButton(
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
              ),
              backgroundColor: Color(0xff00cccc),
            ),
            body: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              dragStartBehavior: DragStartBehavior.down,
              children: [
                if (mutualProv.adsPage.isNotEmpty)
                  Column(
                    children: [
                      AdHeaderWidget(adsPage: adsPage, mutualProv: mutualProv),
                      AdInfoWidget(adsPage: adsPage, mutualProv: mutualProv),
// ads add timestamp ....................
                      AdTimestampWidget(timeAdded: mutualProv.adsPage.first.timeAdded,),
// end ads add timestamp ....................
// last update ads timestamp ....................
                      LastUpdateWidget(timeUpdated: mutualProv.adsPage.first.timeUpdated,),
// end last update ads timestamp ....................
// description ...................
                      AdDescriptionWidget(adsPage: adsPage, ads: mutualProv.adsPage, adsUser: mutualProv.adsUser,),
// end description ...................

//  avatar .............
                      if (mutualProv.adsUser.isNotEmpty)
                        AvatarWidget(adsPage: adsPage, adsUser: mutualProv.adsUser,),
// end avatar .............

//  statistics ads ........................
                      if (mutualProv.adsUser.isNotEmpty)
                        if (mutualProv.adsUser.first.phone == _phone)
                          AdStatisticsWidget(adsViews: mutualProv.adsViews,),
//  end statistics ads ........................
//  network coverage ...................
                      NetworkCoverageWidget(adsPage: adsPage,),
// end network coverage ...................
//  location .....................
                      AdLocationWidget(adsPage: adsPage, ads: mutualProv.adsPage,),
// end location .....................
// qr share ..........................................
                      AdQRWidget(adsPage: adsPage, qrData: mutualProv.qrData,),
// end qr share ..........................................
//  similar ads ..............
                      SimilarAdWidget(adsPage: mutualProv,),
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
            bottomNavigationBar: SizedBox(
              height: 65,
              child: Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height,
                decoration: BoxDecoration(
                  color: const Color(0xff00cccc),
                  border: Border.all(width: 1.0, color: const Color(0xff00cccc)),
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
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xffffffff),
                                      size: 30,
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
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xffffffff),
                                      size: 30,
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
          ),
        ),
      );
    });
  }
}


