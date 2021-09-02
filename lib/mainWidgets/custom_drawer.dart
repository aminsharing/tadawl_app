import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer/custom_drawer_header.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer/drawer_button.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer/nav_button.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/special_offers_provider.dart';
import 'package:tadawl_app/provider/ads_provider/today_ads_provider.dart';
import 'package:tadawl_app/provider/general_provider.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';
import 'package:tadawl_app/provider/request_provider.dart';
import 'package:tadawl_app/provider/user_provider/favourite_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/favourite.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/my_ads.dart';
import 'package:tadawl_app/screens/account/requests.dart';
import 'package:tadawl_app/screens/ads/add_ad.dart';
import 'package:tadawl_app/screens/ads/advertising_fee.dart';
import 'package:tadawl_app/screens/ads/exclusive_marketing.dart';
import 'package:tadawl_app/screens/ads/special_offers.dart';
import 'package:tadawl_app/screens/ads/today_ads.dart';
import 'package:tadawl_app/screens/general/about.dart';
import 'package:tadawl_app/screens/general/contact_wp.dart';
import 'package:tadawl_app/screens/general/coupon_request.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/account/discussion_list.dart';
import 'package:tadawl_app/screens/account/real_estate_offices.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:tadawl_app/screens/general/hotels.dart';
import 'package:tadawl_app/screens/general/lease_contracts.dart';
import 'package:tadawl_app/screens/general/privacy_policy.dart';
import 'package:tadawl_app/screens/general/real_estate_emptying_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    var mediaQuery = MediaQuery.of(context);
    var locale = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = locale.locale.toString();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextButton(
            onPressed: () {
              if(_lang != 'en_US'){
                locale.setLocale(L10n.all.first);
              }else{
                locale.setLocale(L10n.all.last);
              }
              locale.setCurrentPage(0);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                      (route) => false
              );
            },
            child: Text(
              _lang != 'en_US'
                  ?
              'English'
                  :
              'عربي',
              style: CustomTextStyle(
                fontSize: 15,
                color: const Color(0xffffffff),
              ).getTextStyle(),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        backgroundColor: const Color(0xff1f2835),
        toolbarHeight: 50,
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: GestureDetector(
              onTap: _launchURLTwitter,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: const AssetImage('assets/images/twitter.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: GestureDetector(
              onTap: _launchURLSnapchat,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: const AssetImage('assets/images/img13.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xffffffff),
      body: Container(
        color: Color(0xffffffff),
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          onPressed: _launchURLTadawl,
                        ),
                      ],
                    ),
                  ),
                  CustomDrawerHeader(locale.phone),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerButton(
                          icon: Icons.add_outlined,
                          text: AppLocalizations.of(context).addAds,
                        onPressed: () {
                            if(locale.phone != null){
                              Navigator.pushReplacement(
                                context,
                                PageTransition(type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 10),
                                  child: AddAds()),
                              );
                            }else{
                              Navigator.push(
                                context,
                                PageTransition(type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 10),
                                  child: Login(),),
                              );
                            }

                        },
                      ),
                      DrawerButton(
                          icon: Icons.library_books_rounded,
                          text: AppLocalizations.of(context).myAds,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: locale.phone != null ?
                                ChangeNotifierProvider<MyAccountProvider>(
                                  create: (_) => MyAccountProvider(locale.phone),
                                  child: MyAds(),
                                )
                                    :
                                Login(),),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerButton(
                          icon: Icons.message_rounded,
                          text: AppLocalizations.of(context).messages,
                          onPressed: () {
                            if(locale.phone != null){
                              locale.setCurrentPage(3);
                              Navigator.pushReplacement(
                                context,
                                PageTransition(type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 10),
                                  child: DiscussionList(),
                                ),
                              );
                            }else{
                              Navigator.push(
                                context,
                                PageTransition(type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 10),
                                  child: Login(),
                                ),
                              );
                            }

                          },
                      ),
                      DrawerButton(
                          icon: Icons.star_border_outlined,
                          text: AppLocalizations.of(context).favourite,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: locale.phone != null
                                    ?
                                ChangeNotifierProvider<FavouriteProvider>(
                                  create: (_) => FavouriteProvider(locale.phone),
                                  child: Favourite(),
                                )
                                    :
                                Login(),),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerButton(
                          icon: Icons.account_balance,
                          text: AppLocalizations.of(context).realEstateEmptying,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: RealEstateEmptyingService(),),
                          );
                        },
                      ),
                      DrawerButton(
                          icon: Icons.recent_actors_outlined,
                          text: AppLocalizations.of(context).leaseContracts,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: LeaseContracts(),),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerButton(
                          icon: Icons.apartment_outlined,
                          text: AppLocalizations.of(context).exclusiveMarketing,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: ExclusiveMarketing(),),
                          );
                        },
                      ),
                      DrawerButton(
                          icon: Icons.hotel,
                          text: AppLocalizations.of(context).contractConstruction,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: ConstructionContracting(),),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerButton(
                          icon: Icons.local_fire_department_rounded,
                          text: AppLocalizations.of(context).specialOffers,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: ChangeNotifierProvider<SpecialOffersProvider>(
                                  create: (_) => SpecialOffersProvider(context),
                                  child: SpecialOffers(),
                                ),),
                          );
                        },
                      ),
                      DrawerButton(
                          icon: Icons.calendar_today_outlined,
                          text: AppLocalizations.of(context).todayAds,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: ChangeNotifierProvider<TodayAdsProvider>(
                                  create: (_) => TodayAdsProvider(context),
                                  child: TodayAds(),
                                ),),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerButton(
                          icon: Icons.payments_rounded,
                          text: AppLocalizations.of(context).advFees,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: AdvertisingFee(),),
                          );
                        },
                      ),
                      DrawerButton(
                          icon: Icons.notifications_rounded,
                          text: AppLocalizations.of(context).requests,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: locale.phone != null
                                    ?
                                ChangeNotifierProvider<RequestProvider>(
                                  create: (_) => RequestProvider(),
                                  child: Requests(),
                                )
                                    :
                                Login(),),
                          );
                        },
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerButton(
                          icon: Icons.credit_card_rounded,
                          text: AppLocalizations.of(context).couponRequest,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 10),
                                child: CouponRequest(),),
                          );
                        },
                      ),
                      DrawerButton(
                          icon: Icons.business_rounded,
                          text: AppLocalizations.of(context).reMenu,
                          onPressed: (){
                            locale.setCurrentPage(2);
                            Navigator.push(
                              context,
                              PageTransition(type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 10),
                                  child: RealEstateOffices()),
                            );
                          },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        color: Color(0xffffffff),
        child: Column(
          children: [
            Divider(
              color: Color(0xff989898),
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavButton(
                    text: AppLocalizations.of(context).contactUs,
                    page: ChangeNotifierProvider<GeneralProvider>(
                      create: (_) => GeneralProvider(),
                      child: ContactWp(),
                    ),
                  ),
                  NavButton(
                    text: AppLocalizations.of(context).privacyPolicy,
                    page: ChangeNotifierProvider<GeneralProvider>(
                      create: (_) => GeneralProvider(),
                      child: PrivacyPolicy(),
                    ),
                  ),
                  NavButton(
                    text: AppLocalizations.of(context).about,
                    page: About(),
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

void _launchURLSnapchat() async {
  const url = 'https://www.snapchat.com/add/tadawl_comsa';
  await launch(url);
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
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

void _launchURLTadawl() async {
  const url = 'https://tadawl-store.com/';
  await launch(url);
}