import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/UserModel.dart';
import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/screens/account/login.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key key, this.adsPage, this.adsUser}) : super(key: key);

  final AdsProvider adsPage;
  final List<UserModel> adsUser;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var _phone = Provider.of<UserProvider>(context, listen: false).phone;

      if (adsUser.first != null) {
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
          Provider.of<UserProvider>(context, listen: false).wait
              ? Padding(
                  padding: EdgeInsets.all(50),
                  child: CircularProgressIndicator())
              : TextButton(
                  onPressed: () {
                    adsPage.stopVideoAdsPage();
                    Provider.of<UserProvider>(context, listen: false)
                        .goToAvatar(context, adsUser.first.phone);
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
                                adsUser.first.image != null ||
                                        adsUser.first.image != ' '
                                    ? Container(
                                        width: 120.0,
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                'https://tadawl.com.sa/API/assets/images/avatar/${adsUser.first.image}'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 120.0,
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: const AssetImage(
                                                'assets/images/avatar.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                if (Provider.of<UserProvider>(context,
                                        listen: false)
                                    .estimates
                                    .isNotEmpty)
                                  TextButton(
                                    onPressed: () {
                                      adsPage.stopVideoAdsPage();
                                      Navigator.pushNamed(
                                          context, '/main/estimate_user',
                                          arguments: {
                                            'phone':
                                                adsUser.first.phone ??
                                                    _phone,
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 15, 0),
                                          child: Text(
                                            Provider.of<UserProvider>(context,
                                                        listen: false)
                                                    .estimates
                                                    .isNotEmpty
                                                ? '(${Provider.of<UserProvider>(context, listen: false).countEstimates()})'
                                                : '0',
                                            style: CustomTextStyle(
                                              fontSize: 15,
                                              color: const Color(0xff000000),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        if (Provider.of<UserProvider>(context,
                                                listen: false)
                                            .sumEstimates
                                            .isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: RatingBar(
                                              rating: (double.parse(Provider.of<
                                                                  UserProvider>(
                                                              context,
                                                              listen: false)
                                                          .sumEstimates
                                                          .first
                                                          .sum_estimates) /
                                                      double.parse(
                                                          '${Provider.of<UserProvider>(context, listen: false).countEstimates()}'))
                                                  .toDouble(),
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
                                          )
                                        else
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: RatingBar(
                                              rating: 3,
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
                                  )
                                else
                                  TextButton(
                                    onPressed: () {
                                      adsPage.stopVideoAdsPage();
                                      Navigator.pushNamed(
                                          context, '/main/estimate_user',
                                          arguments: {
                                            'phone':
                                                adsUser.first.phone ??
                                                    _phone,
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 15, 0),
                                          child: Text(
                                            '(0)',
                                            style: CustomTextStyle(
                                              fontSize: 10,
                                              color: const Color(0xff989696),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: RatingBar(
                                            rating: 5,
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
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Text(
                                        adsUser.first.username ??
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
                                    if (adsUser.first.phone != _phone)
                                      TextButton(
                                        onPressed: () {
                                          adsPage.stopVideoAdsPage();
                                          if (_phone == null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()));
                                          } else {
                                            Provider.of<MsgProvider>(context,
                                                    listen: false)
                                                .setRecAvatarUserName(adsUser.first.username);
                                            Navigator.pushNamed(context,
                                                '/main/discussion_main',
                                                arguments: {
                                                  'phone_user': adsUser.first.phone,
                                                });
                                          }
                                        },
                                        child: Container(
                                          width: mediaQuery.size.width * 0.15,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                color: const Color(0xff00cccc),
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
                                    if (adsUser.first.phone != _phone)
                                      TextButton(
                                        onPressed: () {
                                          if (adsPage.videoControllerAdsPage !=
                                              null) {
                                            adsPage.stopVideoAdsPage();
                                          }
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .callNumber(context,
                                                  adsUser.first.phone);
                                        },
                                        child: Container(
                                          width: mediaQuery.size.width * 0.15,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                color: const Color(0xff3f9d28),
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
    } else {
      return Container();
    }
  }
}
