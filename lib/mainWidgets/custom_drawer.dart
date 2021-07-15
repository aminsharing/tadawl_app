import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/l10n/l10n.dart';
import 'package:tadawl_app/screens/account/favourite.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/my_account.dart';
import 'package:tadawl_app/screens/account/my_ads.dart';
import 'package:tadawl_app/screens/account/requests.dart';
import 'package:tadawl_app/screens/ads/add_ads.dart';
import 'package:tadawl_app/screens/ads/advertising_fee.dart';
import 'package:tadawl_app/screens/ads/exclusive_marketing.dart';
import 'package:tadawl_app/screens/ads/special_offers.dart';
import 'package:tadawl_app/screens/ads/today_ads.dart';
import 'package:tadawl_app/screens/general/about.dart';
import 'package:tadawl_app/screens/general/contact.dart';
import 'package:tadawl_app/screens/general/coupon_request.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider.dart';
import 'package:tadawl_app/screens/account/discussion_list.dart';
import 'package:tadawl_app/screens/account/real_estate_offices.dart';
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
    return Consumer<UserProvider>(builder: (context, customDrawer, child) {

      customDrawer.getSession();
      var _phone = customDrawer.phone;
      if(customDrawer.users.isEmpty){
        customDrawer.getUsersList(context, _phone);
      }
      var mediaQuery = MediaQuery.of(context);
      var provider = Provider.of<LocaleProvider>(context, listen: false);
      var _lang = provider.locale.toString();

      return Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          leading: _lang != 'en_US'
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      provider.setLocale(L10n.all.first);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Text(
                      'English',
                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      provider.setLocale(L10n.all.last);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Text(
                      'عربي',
                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
          backgroundColor: Color(0xff00cccc),
          toolbarHeight: 50,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextButton(
              onPressed: _launchURLSnapchat,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/img13.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: TextButton(
                onPressed: _launchURLTwitter,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/images/twitter.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          // MaterialPageRoute(builder: (context) => Contact()),
                          PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Contact()),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context).contactUs,
                        style: CustomTextStyle(

                          fontSize: 13,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          // MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                          PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: PrivacyPolicy()),

                        );
                      },
                      child: Text(
                        AppLocalizations.of(context).privacyPolicy,
                        style: CustomTextStyle(

                          fontSize: 13,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          // MaterialPageRoute(builder: (context) => About()),
                          PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: About()),

                        );
                      },
                      child: Text(
                        AppLocalizations.of(context).about,
                        style: CustomTextStyle(

                          fontSize: 13,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xffffffff),
        body: Container(
          color: Color(0xffffffff),
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (_phone != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      if (customDrawer.users.isNotEmpty)
                        for (int i = 0; i < customDrawer.countUsers(); i++)
                          customDrawer.wait
                              ?
                          Padding(
                                  padding: EdgeInsets.all(50),
                                  child: CircularProgressIndicator())
                              :
                          TextButton(
                                  onPressed: () {
                                    customDrawer.setWaitState(true);
                                    customDrawer.getAvatarList(context, _phone);
                                    customDrawer.getUserAdsList(context, _phone);
                                    customDrawer.getEstimatesInfo(context, _phone);
                                    customDrawer.getSumEstimatesInfo(context, _phone);
                                    customDrawer.checkOfficeInfo(context, _phone);

                                    customDrawer.setUserPhone(_phone);

                                    Future.delayed(Duration(seconds: 1), () {
                                      Navigator.push(
                                        context,
                                        // MaterialPageRoute(builder: (context) => MyAccount()),
                                        PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: MyAccount()),

                                      );
                                      customDrawer.setWaitState(false);
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      customDrawer.users[i].image == '' || customDrawer.users[i].image == null
                                          ? Container(
                                              width: 150.0,
                                              height: 150.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: const AssetImage('assets/images/avatar.png'),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 150.0,
                                              height: 150.0,
                                              child: CachedNetworkImage(
                                                  imageUrl: 'https://tadawl.com.sa/API/assets/images/avatar/${customDrawer.users[i].image}',
                                                // TODO CHANGED: to show to user when image load error
                                                errorWidget: (context,error ,a){
                                                    return Center(child: Text('خطأ في التحميل'));
                                                },
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          customDrawer.users[i].username ?? 'UserName',
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff00cccc),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                      else
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Center(
                              child: Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              backgroundColor: Color(0xff00cccc),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xffffffff)),
                            ),
                          )),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                          Navigator.push(
                              context,
                              // MaterialPageRoute(builder: (context) => AddAds()),
                            PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: AddAds()),

                          );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.add_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).addAds,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              customDrawer.getUserAdsList(context, customDrawer.phone);
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => MyAds()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: MyAds()),

                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.library_books_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).myAds,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(3);
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => DiscussionList()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: DiscussionList()),

                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.message_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).messages,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Favourite()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Favourite()),

                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.star_border_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).favourite,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => RealEstateEmptyingService()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: RealEstateEmptyingService()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.account_balance,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .realEstateEmptying,
                                      style: CustomTextStyle(

                                        fontSize: 13,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => LeaseContracts()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: LeaseContracts()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.recent_actors_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .leaseContracts,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => ExclusiveMarketing()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: ExclusiveMarketing()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.apartment_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .exclusiveMarketing,
                                      style: CustomTextStyle(

                                        fontSize: 12,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => ConstructionContracting()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: ConstructionContracting()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.hotel,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .contractConstruction,
                                      style: CustomTextStyle(

                                        fontSize: 10,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Provider.of<AdsProvider>(context, listen: false).getAdsSpecialList(context);
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => SpecialOffers()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: SpecialOffers()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.local_fire_department_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .specialOffers,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => TodayAds()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: TodayAds()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).todayAds,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => AdvertisingFee()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: AdvertisingFee()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.payments_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).advFees,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Requests()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Requests()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.notifications_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).requests,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => CouponRequest()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: CouponRequest()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.credit_card_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .couponRequest,
                                      style: CustomTextStyle(

                                        fontSize: 13,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(2);
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => RealEstateOffices()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: RealEstateOffices()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.business_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).reMenu,
                                      style: CustomTextStyle(

                                        fontSize: 13,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Login()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Login()),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context).login,
                              style: CustomTextStyle(

                                fontSize: 20,
                                color: const Color(0xff00cccc),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.meeting_room,
                              color: Color(0xff00cccc),
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Login()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Login()),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Login()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Login()),

                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.add_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).addAds,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Login()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Login()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.library_books_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).myAds,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Login()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Login()),

                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.message_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).messages,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Login()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Login()),

                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.star_border_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).favourite,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => RealEstateEmptyingService()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: RealEstateEmptyingService()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.account_balance,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .realEstateEmptying,
                                      style: CustomTextStyle(

                                        fontSize: 13,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => LeaseContracts()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: LeaseContracts()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.recent_actors_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .leaseContracts,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => ExclusiveMarketing()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: ExclusiveMarketing()),

                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.apartment_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .exclusiveMarketing,
                                      style: CustomTextStyle(

                                        fontSize: 12,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => ConstructionContracting()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: ConstructionContracting()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.hotel,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .contractConstruction,
                                      style: CustomTextStyle(

                                        fontSize: 10,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => SpecialOffers()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: SpecialOffers()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.local_fire_department_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .specialOffers,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => TodayAds()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: TodayAds()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).todayAds,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => AdvertisingFee()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: AdvertisingFee()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.payments_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).advFees,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => Login()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: Login()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.notifications_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).requests,
                                      style: CustomTextStyle(

                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => CouponRequest()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: CouponRequest()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.credit_card_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .couponRequest,
                                      style: CustomTextStyle(

                                        fontSize: 13,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(2);
                              Navigator.push(
                                context,
                                // MaterialPageRoute(builder: (context) => RealEstateOffices()),
                                PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 10), child: RealEstateOffices()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 120,
                                height: 78,
                                color: Color(0xff00cccc),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 30.0,
                                        child: Icon(
                                          Icons.business_rounded,
                                          color: Color(0xffffffff),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).reMenu,
                                      style: CustomTextStyle(

                                        fontSize: 13,
                                        color: const Color(0xffffffff),
                                      ).getTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

void _launchURLSnapchat() async {
  const url = 'https://www.snapchat.com/add/tadawl_comsa';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchURLTwitter() async {
  const url = 'https://twitter.com/TADAWLAPP';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
