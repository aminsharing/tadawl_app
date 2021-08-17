import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
import 'package:tadawl_app/screens/account/estimateUser.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/my_account.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key key,
    @required this.myAccountProvider,
  }) : super(key: key);
  final MyAccountProvider myAccountProvider;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
    final myAccountProv = Provider.of<MyAccountProvider>(context, listen: false);
    // final msgProv = Provider.of<MsgProvider>(context, listen: false);

    return Consumer2<AdPageProvider, MutualProvider>(builder: (context, adsPage, mutualProv, child) {
      if (mutualProv.adsUser != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).advertiserInformation,
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            myAccountProv.wait
                ?
            Padding(
                padding: EdgeInsets.all(50),
                child: CircularProgressIndicator())
                :
            TextButton(
              onPressed: () {
                adsPage.stopVideoAdsPage();
                // myAccountProv.goToAvatar(context, mutualProv.adsUser.phone).then((value) {
                //   myAccountProv.setWaitState(false);
                // });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        ChangeNotifierProvider<MyAccountProvider>.value(
                            value: myAccountProvider,
                            child: MyAccount(
                              myAccountProvider: myAccountProvider,
                              phone: locale.phone,
                            )
                        )
                    )
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: mediaQuery.size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: mutualProv.adsUser.image == null || mutualProv.adsUser.image.isEmpty
                                      ?
                                  const AssetImage('assets/images/avatar.png')
                                      :
                                  CachedNetworkImageProvider('https://tadawl-store.com/API/assets/images/avatar/${mutualProv.adsUser.image}'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  adsPage.stopVideoAdsPage();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          ChangeNotifierProvider<MyAccountProvider>.value(
                                            value: myAccountProvider,
                                            child: Estimate(),
                                          )
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 15, 0),
                                      child: Text(
                                        myAccountProv.estimates.isNotEmpty
                                            ?
                                        '(${myAccountProv.estimates.length})'
                                            :
                                        '(0)',
                                        style: CustomTextStyle(
                                          fontSize: 15,
                                          color:
                                          const Color(0xff000000),
                                        ).getTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: RatingBar(
                                          rating:
                                          (
                                              double.parse(myAccountProv.sumEstimates == null ? '0' : myAccountProv.sumEstimates.sum_estimates?? '0') /
                                              double.parse('${myAccountProv.estimates.length}')
                                          ).toDouble(),
                                          icon: Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          starCount: 5,
                                          spacing: 1.0,
                                          size: 15,
                                          isIndicator: true,
                                          allowHalfRating: true,
                                          color: Colors.amber,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      5, 0, 5, 0),
                                  child: Text(
                                    mutualProv.adsUser.username ??
                                        'UserName',
                                    style: CustomTextStyle(
                                      fontSize: 15,
                                      color: const Color(0xff00cccc),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Icon(
                                  Icons.account_circle_rounded,
                                  color: Color(0xff00cccc),
                                  size: 40,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                              height: 40,
                            ),
                            Row(
                              children: [
                                if (mutualProv.adsUser.phone !=
                                    locale.phone)
                                  TextButton(
                                    onPressed: () {
                                      adsPage.stopVideoAdsPage();
                                      if (locale.phone == null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Login()));
                                      } else {
                                        // msgProv.setRecAvatarUserName(mutualProv.adsUser.username);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider<MsgProvider>(
                                                      create: (_) => MsgProvider(locale.phone, mutualProv.adsUser.phone, adsId: mutualProv.adsPage.idAds,),
                                                      child: Discussion(
                                                        mutualProv.adsUser.phone,
                                                        username: mutualProv.adsUser.username,
                                                      ),
                                                    )
                                            ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width:
                                      mediaQuery.size.width * 0.15,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color:
                                            const Color(0xff00cccc),
                                            width: 1),
                                        color: const Color(0xffffffff),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.comment_rounded,
                                            color: Color(0xff00cccc),
                                            size: 35,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (mutualProv.adsUser.phone !=
                                    locale.phone)
                                  TextButton(
                                    onPressed: () {
                                      if (adsPage
                                          .videoControllerAdsPage !=
                                          null) {
                                        adsPage.stopVideoAdsPage();
                                      }
                                      myAccountProv.callNumber(
                                          context,
                                          mutualProv.adsUser.phone
                                      );
                                    },
                                    child: Container(
                                      width:
                                      mediaQuery.size.width * 0.15,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color:
                                            const Color(0xff3f9d28),
                                            width: 1),
                                        color: const Color(0xffffffff),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.phone_enabled,
                                          color: Color(0xff3f9d28),
                                          size: 35,
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
              ),
            ),
          ],
        );
      }
      else {
        return Container();
      }
    });
  }
}
