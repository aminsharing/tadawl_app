import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/user_provider/favourite_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/change_pass.dart';
import 'package:tadawl_app/screens/account/change_phone.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/offices_Vr.dart';
import 'package:tadawl_app/screens/account/update_my_information.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Constants {
  static const String updateMyInfo = 'تحديث معلوماتي';
  static const String changePass = 'تغيير كلمة المرور';
  static const String changePhone = 'تغيير رقم الجوال';
  static const String logout = 'تسجيل الخروج';
  static const List<String> choices = <String>[
    updateMyInfo,
    changePass,
    changePhone,
    logout
  ];
}

class EngConstants {
  static const String updateMyInfo = 'Update My Info';
  static const String changePass = 'Change Password';
  static const String changePhone = 'Change Phone';
  static const String logout = 'Logout';
  static const List<String> choices = <String>[
    updateMyInfo,
    changePass,
    changePhone,
    logout
  ];
}

class UserConstants {
  static const String followAccount = 'متابعة';
  static const String banAccount = 'حظر المراسلة';
  static const List<String> choices = <String>[
    followAccount,
    banAccount,
  ];
}

class EngUserConstants {
  static const String followAccount = 'Follow';
  static const String banAccount = 'Ban Messaging';
  static const List<String> choices = <String>[
    followAccount,
    banAccount,
  ];
}

class MyAccount extends StatelessWidget {
  MyAccount({
    Key key,
  }) : super(key: key);

  // final GlobalKey<ScaffoldState> _scaffoldKey10 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyAccountProvider, UserMutualProvider>(builder: (context, avatar, userMutual, child) {


      print("MyAccount -> MyAccountProvider");
      print("MyAccount -> UserMutualProvider");

      var mediaQuery = MediaQuery.of(context);
      var provider = Provider.of<LocaleProvider>(context, listen: false);
      var _lang = provider.locale.toString();
      if (_lang != 'en_US') {
        Jiffy.locale('ar');
      } else if (_lang == 'en_US') {
        Jiffy.locale('en');
      }

      void sendEstimate() async {
        Future.delayed(Duration(milliseconds: 0), () {
          Api().sendEstimateFunc(
              context, userMutual.phone, userMutual.userPhone, userMutual.rating, userMutual.commentRating);
        });

        userMutual.getAvatarList(context, userMutual.userPhone ?? userMutual.phone);
        userMutual.getUserAdsList(context, userMutual.userPhone ?? userMutual.phone);
        userMutual.getEstimatesInfo(context, userMutual.userPhone ?? userMutual.phone);
        userMutual.getSumEstimatesInfo(context, userMutual.userPhone ?? userMutual.phone);
        userMutual.checkOfficeInfo(context, userMutual.userPhone ?? userMutual.phone);
        userMutual.setUserPhone(userMutual.userPhone ?? userMutual.phone);

        Future.delayed(Duration(seconds: 0), () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyAccount()),
          );
        });
      }

      void _showRatingDialog() {
        final _dialog = RatingDialog(
          title: AppLocalizations.of(context).ratingDialog,
          commentHint: AppLocalizations.of(context).ratingCommentHint,
          message: AppLocalizations.of(context).ratingHint,
          image: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: const AssetImage('assets/images/avatar.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          submitButton: AppLocalizations.of(context).send,
          onSubmitted: (response) {
            userMutual.setRating(response.rating.toString());
            userMutual.setCommentRating(response.comment.toString());
            sendEstimate();
          },
        );
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => _dialog,
        );
      }

      void _callNumber() async {
        if (userMutual.estimates.isNotEmpty) {
          for (var i = 0; i < userMutual.countEstimates(); i++) {
            if (userMutual.estimates[i].phone_user == userMutual.phone &&
                userMutual.estimates[i].phone_user_estimated == userMutual.userPhone) {
              userMutual.setCalled();
            }
          }
          if (userMutual.called == 1) {
          } else {
            _showRatingDialog();
          }
        } else {
          _showRatingDialog();
        }
        if (userMutual.userPhone == userMutual.phone) {
          var number = '+${userMutual.phone}';
          await FlutterPhoneDirectCaller.callNumber(number);
        } else {
          var number = '+${userMutual.userPhone}';
          await FlutterPhoneDirectCaller.callNumber(number);
        }
      }


      Future<void> choiceAction2(String choice) async {
        if (choice == 'متابعة') {
        } else {}
      }

      Future<void> choiceAction(String choice) async {
        if (choice == 'تحديث معلوماتي' || choice == 'Update My Info') {
          userMutual.setInitMembershipType();
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => UpdateMyInformation()),
          );
        } else if (choice == 'تغيير كلمة المرور' || choice == 'Change Password') {
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangePass()),
          );
        } else if (choice == 'تغيير رقم الجوال' || choice == 'Change Phone') {
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangePhone()),
          );
        } else {
          await userMutual.logout();
          await Fluttertoast.showToast(
              msg: 'تم تسجيل الخروج',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 15.0);
          Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
          Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
          Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
          await Navigator.push(context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        }
      }


      if (userMutual.userPhone == userMutual.phone) {
        userMutual.getUsersList(context, userMutual.phone);
        userMutual.getUserAdsList(context, userMutual.phone);
        //avatar.getEstimatesInfo(context, avatar.phone);
        //avatar.getSumEstimatesInfo(context, avatar.phone);
        //userMutual.checkOfficeInfo(context, avatar.phone);
      }
      else {
        userMutual.getAvatarList(context, userMutual.userPhone);
        userMutual.getUserAdsList(context, userMutual.userPhone);
        //avatar.getEstimatesInfo(context, userMutual.userPhone);
        //avatar.getSumEstimatesInfo(context, userMutual.userPhone);
        //userMutual.checkOfficeInfo(context, userMutual.userPhone);
      }

      if (userMutual.avatars.isEmpty && userMutual.userPhone != userMutual.phone) {
        userMutual.setUserPhone(userMutual.userPhone);
        return Center(
            child: AnimatedSplashScreen(
              duration: 300,
              splash: Center(child: CircularProgressIndicator()),
              nextScreen: MyAccount(),
        ));
      }
      else {
        return WillPopScope(
          onWillPop: () async{
            avatar.clearExpendedListCount();
            return true;
          },
          child: Scaffold(
            backgroundColor: const Color(0xffffffff),
            appBar: AppBar(
              toolbarHeight: 80.0,
              leadingWidth: 100,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xffffffff),
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                AppLocalizations.of(context).myAccount,
                style: CustomTextStyle(

                  fontSize: 20,
                  color: const Color(0xffffffff),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
              actions: [
                Column(
                  children: [
                    if (userMutual.userPhone == userMutual.phone)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: PopupMenuButton<String>(
                          icon: Icon(
                            Icons.settings,
                            color: Color(0xffffffff),
                            size: 40,
                          ),
                          onSelected: choiceAction,
                          itemBuilder: (BuildContext context) {
                            if (_lang != 'en_US') {
                              return Constants.choices.map((String choice) {
                                if (choice == Constants.logout) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xffff0000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.exit_to_app_rounded,
                                            color: Color(0xffff0000),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice == Constants.changePass) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.vpn_key_rounded,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice == Constants.changePhone) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.phone_enabled_rounded,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice == Constants.updateMyInfo) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(
                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.person_pin_rounded,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }).toList();
                            }
                            else {
                              return EngConstants.choices.map((String choice) {
                                if (choice == EngConstants.logout) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xffff0000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.exit_to_app_rounded,
                                            color: Color(0xffff0000),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice == EngConstants.changePass) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.vpn_key_rounded,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice == EngConstants.changePhone) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.phone_enabled_rounded,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice == EngConstants.updateMyInfo) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.person_pin_rounded,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }).toList();
                            }
                          },
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: PopupMenuButton<String>(
                          icon: Icon(
                            Icons.settings,
                            color: Color(0xffffffff),
                            size: 40,
                          ),
                          onSelected: choiceAction2,
                          itemBuilder: (BuildContext context) {
                            if (_lang != 'en_US') {
                              return UserConstants.choices.map((String choice) {
                                if (choice == UserConstants.banAccount) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xffff0000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.do_disturb_alt_rounded,
                                            color: Color(0xffff0000),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice ==
                                    UserConstants.followAccount) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.person_add,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }).toList();
                            } else {
                              return EngUserConstants.choices
                                  .map((String choice) {
                                if (choice == EngUserConstants.banAccount) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xffff0000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.do_disturb_alt_rounded,
                                            color: Color(0xffff0000),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (choice ==
                                    EngUserConstants.followAccount) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Icon(
                                            Icons.person_add,
                                            color: Color(0xff989898),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      children: [
                                        Text(
                                          choice,
                                          style: CustomTextStyle(

                                            fontSize: 20,
                                            color: const Color(0xff989898),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }).toList();
                            }
                          },
                        ),
                      ),
                  ],
                )
              ],
              backgroundColor: Color(0xff00cccc),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: mediaQuery.size.width,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (userMutual.userPhone == userMutual.phone)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        userMutual.users.first.image == '' || userMutual.users.first.image == null
                                      ? Container(
                                                width: 150.0,
                                                height: 150.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                    image: const AssetImage(
                                                        'assets/images/avatar.png'),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 150.0,
                                                height: 150.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          'https://tadawl.com.sa/API/assets/images/avatar/${userMutual.users.first.image}'),
                                                      fit: BoxFit.contain),
                                                ),
                                              ),
                                        if (userMutual.estimates.isNotEmpty)
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/main/estimate_user',
                                                  arguments: {
                                                    'phone': userMutual.userPhone ??
                                                        userMutual.phone,
                                                  });
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
                                                    '(${userMutual.countEstimates()})',
                                                    style: CustomTextStyle(

                                                      fontSize: 10,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                if (userMutual.sumEstimates.isNotEmpty)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: RatingBar(
                                                      rating: (double.parse(userMutual
                                                                  .sumEstimates
                                                                  .first
                                                                  .sum_estimates) /
                                                          userMutual
                                                                  .countEstimates())
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
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
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
                                              Navigator.pushNamed(
                                                  context, '/main/estimate_user',
                                                  arguments: {
                                                    'phone': userMutual.userPhone ??
                                                        userMutual.phone,
                                                  });
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
                                                    '(0)',
                                                    style: CustomTextStyle(

                                                      fontSize: 10,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                          ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: Text(
                                            userMutual.users.first.username ??
                                                'UserName',
                                            style: CustomTextStyle(

                                              fontSize: 15,
                                              color: const Color(0xff00cccc),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 0, 15, 0),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .registered,
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color: const Color(0xff989696),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0),
                                              child: Text(
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.parse(userMutual.users
                                                        .first.timeRegistered)),
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color: const Color(0xff989696),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 0, 15, 0),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .lastSeen,
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color: const Color(0xff989696),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            if (userMutual.phone != null)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 15, 0),
                                                  child: Text(
                                                    Jiffy(DateTime.now()).fromNow(),
                                                    style: CustomTextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  ))
                                            else
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 0, 0),
                                                  child: Text(
                                                    Jiffy(DateTime.parse(userMutual
                                                                    .users
                                                                    .first
                                                                    .lastActive ??
                                                                '')
                                                            .add(Duration(
                                                                hours: 3)))
                                                        .fromNow(),
                                                    style: CustomTextStyle(

                                                      fontSize: 15,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  )),
                                          ],
                                        ),
                                        if (userMutual.userPhone != userMutual.phone)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 30, 0, 30),
                                            child: TextButton(
                                              onPressed: _callNumber,
                                              child: Container(
                                                width:
                                                    mediaQuery.size.width * 0.4,
                                                height: 50.0,
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
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        else
                                          Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        userMutual.avatars.isNotEmpty
                                            ? userMutual.avatars.first.image == null || userMutual.avatars.first.image == ''
                                                ? Container(
                                                    width: 150.0,
                                                    height: 150.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: const AssetImage(
                                                            'assets/images/avatar.png'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 150.0,
                                                    height: 150.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                              'https://tadawl.com.sa/API/assets/images/avatar/${userMutual.avatars.first.image}'),
                                                          fit: BoxFit.contain),
                                                    ),
                                                  )
                                            : Container(
                                                width: 150.0,
                                                height: 150.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: const AssetImage(
                                                        'assets/images/avatar.png'),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                        if (userMutual.estimates.isNotEmpty)
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/main/estimate_user',
                                                  arguments: {
                                                    'phone': userMutual.userPhone ??
                                                        userMutual.phone,
                                                  });
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
                                                    '(${userMutual.countEstimates()})',
                                                    style: CustomTextStyle(

                                                      fontSize: 10,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                if (userMutual
                                                    .sumEstimates.isNotEmpty)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: RatingBar(
                                                      rating: (double.parse(userMutual
                                                                  .sumEstimates
                                                                  .first
                                                                  .sum_estimates) /
                                                          userMutual
                                                                  .countEstimates())
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
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
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
                                              Navigator.pushNamed(
                                                  context, '/main/estimate_user',
                                                  arguments: {
                                                    'phone': userMutual.userPhone ??
                                                        userMutual.phone,
                                                  });
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
                                                    '(0)',
                                                    style: CustomTextStyle(

                                                      fontSize: 10,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                          ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: Text(
                                            userMutual.avatars.first.username ??
                                                'UserName',
                                            style: CustomTextStyle(

                                              fontSize: 15,
                                              color: const Color(0xff00cccc),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 0, 15, 0),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .registered,
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color: const Color(0xff989696),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0),
                                              child: Text(
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.parse(userMutual.avatars
                                                        .first.timeRegistered)),
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color: const Color(0xff989696),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  5, 0, 15, 0),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .lastSeen,
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color: const Color(0xff989696),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            if (userMutual.phone != null)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 15, 0),
                                                  child: Text(
                                                    Jiffy(DateTime.now())
                                                        .fromNow(),
                                                    style: CustomTextStyle(

                                                      fontSize: 13,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  ))
                                            else
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 0, 0),
                                                  child: Text(
                                                    Jiffy(DateTime.parse(userMutual
                                                                    .avatars
                                                                    .first
                                                                    .lastActive ??
                                                                '')
                                                            .add(Duration(
                                                                hours: 3)))
                                                        .fromNow(),
                                                    style: CustomTextStyle(

                                                      fontSize: 15,
                                                      color:
                                                          const Color(0xff989696),
                                                    ).getTextStyle(),
                                                    textAlign: TextAlign.center,
                                                  )),
                                          ],
                                        ),
                                        if (userMutual.userPhone != userMutual.phone)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 30, 0, 30),
                                            child: TextButton(
                                              onPressed: _callNumber,
                                              child: Container(
                                                width:
                                                    mediaQuery.size.width * 0.4,
                                                height: 50.0,
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
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        else
                                          Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width,
                    height: userMutual.userPhone != userMutual.phone ? 200 : 100,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (userMutual.userPhone != userMutual.phone)
                            for (var i = 0; i < userMutual.countAvatars(); i++)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  if (userMutual.userPhone != userMutual.phone)
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                      child: TextButton(
                                        onPressed: () {
                                          if(userMutual.phone == null){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                          }else{
                                            Provider.of<MsgProvider>(context, listen: false).setRecAvatarUserName(userMutual.avatars.first.username);
                                            Navigator.pushNamed(
                                                context, '/main/discussion_main',
                                                arguments: {
                                                  'phone_user': userMutual.userPhone,
                                                });
                                          }
                                        },
                                        child: Container(
                                          width: mediaQuery.size.width * 0.6,
                                          height: 50.0,
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 0, 0),
                                                child: Icon(
                                                  Icons.comment_rounded,
                                                  color: Color(0xff00cccc),
                                                  size: 40,
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)
                                                    .sendMess,
                                                style: CustomTextStyle(
                                                  fontSize: 15,
                                                  color: const Color(0xff00cccc),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).aboutMe,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          userMutual.avatars[i].about ?? '',
                                          style: CustomTextStyle(

                                            fontSize: 13,
                                            color: const Color(0xff989696),
                                          ).getTextStyle(),
                                          //textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          else
                            for (var i = 0; i < userMutual.countUsers(); i++)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  if (userMutual.userPhone != userMutual.phone)
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                      child: TextButton(
                                        onPressed: () {
                                          Provider.of<MsgProvider>(context, listen: false).setRecAvatarUserName(userMutual.users.first.username);
                                          Navigator.pushNamed(
                                              context, '/main/discussion_main',
                                              arguments: {
                                                'phone_user': userMutual.userPhone,
                                              });
                                        },
                                        child: Container(
                                          width: mediaQuery.size.width * 0.6,
                                          height: 50.0,
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 0, 0),
                                                child: Icon(
                                                  Icons.comment_rounded,
                                                  color: Color(0xff00cccc),
                                                  size: 40,
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)
                                                    .sendMess,
                                                style: CustomTextStyle(

                                                  fontSize: 15,
                                                  color: const Color(0xff00cccc),
                                                ).getTextStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).aboutMe,
                                          style: CustomTextStyle(

                                            fontSize: 15,
                                            color: const Color(0xff000000),
                                          ).getTextStyle(),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          userMutual.users[i].about ?? '',
                                          style: CustomTextStyle(

                                            fontSize: 13,
                                            color: const Color(0xff989696),
                                          ).getTextStyle(),
                                          //textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                  if (userMutual.offices.isNotEmpty)
                    Column(
                      children: [
                        if (userMutual.offices.first.state == '1')
                          Container(
                            width: mediaQuery.size.width * 0.5,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xff3f9d28), width: 1),
                              color: const Color(0xff3f9d28),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context).certifiedOffice,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xffffffff),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Icon(
                                    Icons.verified,
                                    color: Color(0xffffffff),
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (userMutual.offices.first.state == '0')
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Text(
                              AppLocalizations.of(context).certifiedOfficeAwait,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff989696),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Text(
                            AppLocalizations.of(context).member,
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff989696),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (userMutual.userPhone == userMutual.phone)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OfficesVR()),
                              );
                            },
                            child: Container(
                              width: mediaQuery.size.width * 0.6,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: const Color(0xff00cccc), width: 1),
                                color: const Color(0xffffffff),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)
                                      .officesAccreditation,
                                  style: CustomTextStyle(

                                    fontSize: 15,
                                    color: const Color(0xff00cccc),
                                  ).getTextStyle(),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (userMutual.userPhone == userMutual.phone)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: mediaQuery.size.width,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffdddddd),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleButtons(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 5, 50, 5),
                                  child: Text(
                                    AppLocalizations.of(context).ads,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 5, 50, 5),
                                  child: Text(
                                    AppLocalizations.of(context).payments,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                  avatar.updateSelected(index);
                              },
                              isSelected: avatar.isSelected,
                              color: const Color(0xff8d8d8d),
                              selectedColor: const Color(0xff00cccc),
                              fillColor: const Color(0xffdddddd),
                              borderWidth: 2,
                              borderColor: const Color(0xffdddddd),
                              selectedBorderColor: const Color(0xffdddddd),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if ((userMutual.userPhone == userMutual.phone) && (avatar.selectedNav == 1))
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '...',
                          style: CustomTextStyle(

                            fontSize: 15,
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  if ((userMutual.userPhone == userMutual.phone) && (avatar.selectedNav == 0))
                    Column(
                      children: [
                        if (userMutual.userAds.isNotEmpty)
                          Container(
                            height: userMutual.countUserAds() == avatar.expendedListCount ? avatar.expendedListCount * ((mediaQuery.size.height*.2)+15) : (avatar.expendedListCount * (mediaQuery.size.height*.2)) - 40,
                            child: ListView.builder(
                              itemCount: userMutual.countUserAds() > avatar.expendedListCount-1 ? avatar.expendedListCount : userMutual.countUserAds(),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i){
                                  if(i != userMutual.countUserAds() -1){
                                    if(i == avatar.expendedListCount-1){
                                      return GestureDetector(
                                        onTap: (){
                                          if(userMutual.countUserAds() < avatar.expendedListCount){
                                            avatar.setExpendedListCount(avatar.expendedListCount+5);
                                          }else{
                                            avatar.setExpendedListCount(userMutual.countUserAds());
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
                                      Provider.of<MutualProvider>(context, listen: false)
                                          .getAllAdsPageInfo(
                                          context, userMutual.userAds[i].idDescription);
                                      Provider.of<MutualProvider>(context, listen: false).getSimilarAdsList(context, userMutual.userAds[i].idCategory, userMutual.userAds[i].idDescription);


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
                                      height: mediaQuery.size.height*.2,
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
                                              width: mediaQuery.size.width*.4,
                                              height: mediaQuery.size.height*.2,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: CachedNetworkImageProvider(
                                                      'https://tadawl.com.sa/API/assets/images/ads/' +
                                                          userMutual.userAds[i]
                                                              .ads_image ??
                                                          ''),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  Provider.of<MutualProvider>(context, listen: false).randdLeft,
                                                  Provider.of<MutualProvider>(context, listen: false).randdTop,
                                                  5, 5),
                                              child: Opacity(
                                                opacity: 0.7,
                                                child: Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: const CachedNetworkImageProvider(
                                                          'https://tadawl.com.sa/API/assets/images/logo22.png'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (userMutual.userAds[i].idSpecial == '1')
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  child: Icon(
                                                    Icons.verified,
                                                    color: Color(0xffe6e600),
                                                    size: 30,
                                                  ),
                                                ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                child: (
                                                    Provider.of<MutualProvider>(context, listen: false).busy == true && Provider.of<MutualProvider>(context, listen: false).number == i)
                                                    ?
                                                CircularProgressIndicator()
                                                    :
                                                DateTime.now().difference(DateTime.parse(userMutual.userAds[i].timeUpdated)).inMinutes - 180 > 60
                                                    ?
                                                TextButton(
                                                  onPressed: () {
                                                    Provider.of<MutualProvider>(context, listen: false).setNumber(i);
                                                    Provider.of<FavouriteProvider>(context, listen: false).update();
                                                    Provider.of<MutualProvider>(context, listen: false).updateAds(context, userMutual.userAds[i].idDescription).then((value) {
                                                      if(value){
                                                        userMutual.getUserAdsList(context,userMutual.phone);
                                                        Provider.of<FavouriteProvider>(context, listen: false).update();
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    width: mediaQuery.size.width *
                                                        0.15,
                                                    height: 35.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: const Color(
                                                              0xff3f9d28)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        AppLocalizations.of(
                                                            context)
                                                            .updateAds,
                                                        style:
                                                        CustomTextStyle(

                                                          fontSize: 15,
                                                          color: const Color(
                                                              0xff3f9d28),
                                                        ).getTextStyle(),
                                                        textAlign:
                                                        TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    :
                                                TextButton(
                                                  onPressed: (){
                                                    Fluttertoast.showToast(
                                                        msg:
                                                        'ستتمكن من التحديث بعد ${24-(DateTime.now().difference(DateTime.parse(userMutual.userAds[i].timeUpdated)).inMinutes - 180)} دقيقة',
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        textColor: Colors.white,
                                                        fontSize: 15.0);
                                                  },
                                                  child: Container(
                                                        width: mediaQuery.size.width *
                                                            0.15,
                                                        height: 35.0,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: Colors.grey),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                context)
                                                                .updateAds,
                                                            style:
                                                            CustomTextStyle(

                                                              fontSize: 15,
                                                              color: Colors.grey,
                                                            ).getTextStyle(),
                                                            textAlign:
                                                            TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                              ),
                                              if (userMutual.userAds[i].video.isNotEmpty)
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      15, 5, 15, 5),
                                                  child: Icon(
                                                    Icons.videocam_outlined,
                                                    color: Color(0xff00cccc),
                                                    size: 30,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 5, 0),
                                                      child: Text(
                                                        userMutual.userAds[i].title,
                                                        style: CustomTextStyle(

                                                          fontSize: 13,
                                                          color:
                                                          const Color(0xff000000),
                                                        ).getTextStyle(),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                      child: Text(
                                                        userMutual.userAds[i].price,
                                                        style: CustomTextStyle(

                                                          fontSize: 15,
                                                          color:
                                                          const Color(0xff00cccc),
                                                        ).getTextStyle(),
                                                        // textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                      child: Text(
                                                        AppLocalizations.of(context)
                                                            .rial,
                                                        style: CustomTextStyle(

                                                          fontSize: 15,
                                                          color:
                                                          const Color(0xff00cccc),
                                                        ).getTextStyle(),
                                                        // textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 15, 0),
                                                      child: Text(
                                                        userMutual.userAds[i].space,
                                                        style: CustomTextStyle(

                                                          fontSize: 15,
                                                          color:
                                                          const Color(0xff000000),
                                                        ).getTextStyle(),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 5, 0),
                                                      child: Text(
                                                        AppLocalizations.of(context).m2,
                                                        style: CustomTextStyle(

                                                          fontSize: 15,
                                                          color:
                                                          const Color(0xff000000),
                                                        ).getTextStyle(),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      5, 0, 10, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      if (userMutual.userAds[i].ads_city !=
                                                          null ||
                                                          userMutual.userAds[i]
                                                              .ads_neighborhood !=
                                                              null)
                                                        Text(
                                                          '${userMutual.userAds[i].ads_city} - ${userMutual.userAds[i].ads_neighborhood}',
                                                          style: CustomTextStyle(

                                                            fontSize: 8,
                                                            color:
                                                            const Color(0xff000000),
                                                          ).getTextStyle(),
                                                          textAlign: TextAlign.right,
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
                        else
                          Container(),
                      ],
                    ),
                  if (userMutual.userPhone != userMutual.phone)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        width: mediaQuery.size.width,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffdddddd),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                              child: Text(
                                AppLocalizations.of(context).ads,
                                style: CustomTextStyle(

                                  fontSize: 15,
                                  color: const Color(0xff00cccc),
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (userMutual.userPhone != userMutual.phone)
                    Column(
                      children: [
                        if (userMutual.userAds.isNotEmpty)
                          Container(
                            height: userMutual.countUserAds() > 3 ? userMutual.countUserAds() == avatar.expendedListCount ? avatar.expendedListCount * 165.0 : (avatar.expendedListCount * 150.0) - 50 : userMutual.countUserAds() * 165.0,
                            child: ListView.builder(
                              itemCount: userMutual.countUserAds() > avatar.expendedListCount-1 ? avatar.expendedListCount : userMutual.countUserAds(),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i){
                                if(i != userMutual.countUserAds() -1){
                                  if(i == avatar.expendedListCount-1){
                                    return GestureDetector(
                                      onTap: (){
                                        if(userMutual.countUserAds() < avatar.expendedListCount){
                                          avatar.setExpendedListCount(avatar.expendedListCount+5);
                                        }else{
                                          avatar.setExpendedListCount(userMutual.countUserAds());
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
                                    Provider.of<MutualProvider>(context, listen: false)
                                        .getAllAdsPageInfo(
                                        context, userMutual.userAds[i].idDescription);
                                    Provider.of<MutualProvider>(context, listen: false).getSimilarAdsList(context, userMutual.userAds[i].idCategory, userMutual.userAds[i].idDescription);

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
                                                    'https://tadawl.com.sa/API/assets/images/ads/' +
                                                        userMutual.userAds[i]
                                                            .ads_image ??
                                                        ''),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                Provider.of<MutualProvider>(context, listen: false).randdLeft,
                                                Provider.of<MutualProvider>(context, listen: false).randdTop,
                                                5, 5),
                                            child: Opacity(
                                              opacity: 0.7,
                                              child: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: const CachedNetworkImageProvider(
                                                        'https://tadawl.com.sa/API/assets/images/logo22.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  if (userMutual.userAds[i].idSpecial ==
                                                      '1')
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 10, 0),
                                                      child: Icon(
                                                        Icons.verified,
                                                        color: Color(0xffe6e600),
                                                        size: 30,
                                                      ),
                                                    ),
                                                  Text(
                                                    userMutual.userAds[i].title,
                                                    style: CustomTextStyle(

                                                      fontSize: 20,
                                                      color: const Color(0xff000000),
                                                    ).getTextStyle(),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    userMutual.userAds[i].price,
                                                    style: CustomTextStyle(

                                                      fontSize: 15,
                                                      color: const Color(0xff00cccc),
                                                    ).getTextStyle(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 5, 0),
                                                    child: Text(
                                                      AppLocalizations.of(context)
                                                          .rial,
                                                      style: CustomTextStyle(

                                                        fontSize: 15,
                                                        color:
                                                        const Color(0xff00cccc),
                                                      ).getTextStyle(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    userMutual.userAds[i].space,
                                                    style: CustomTextStyle(

                                                      fontSize: 15,
                                                      color: const Color(0xff000000),
                                                    ).getTextStyle(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 5, 0),
                                                    child: Text(
                                                      AppLocalizations.of(context).m2,
                                                      style: CustomTextStyle(

                                                        fontSize: 15,
                                                        color:
                                                        const Color(0xff000000),
                                                      ).getTextStyle(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    5, 0, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    if (userMutual
                                                        .userAds[i].video.isNotEmpty)
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.fromLTRB(
                                                            0, 0, 5, 0),
                                                        child: Icon(
                                                          Icons.videocam_outlined,
                                                          color: Color(0xff00cccc),
                                                          size: 30,
                                                        ),
                                                      ),
                                                    if (userMutual.userAds[i].ads_city !=
                                                        null ||
                                                        userMutual.userAds[i]
                                                            .ads_neighborhood !=
                                                            null)
                                                      Text(
                                                        '${userMutual.userAds[i].ads_city} - ${userMutual.userAds[i].ads_neighborhood}',
                                                        style: CustomTextStyle(

                                                          fontSize: 8,
                                                          color:
                                                          const Color(0xff000000),
                                                        ).getTextStyle(),
                                                        textAlign: TextAlign.right,
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
                        else
                          Container(),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
