import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/map_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_pass_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_phone_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/change_pass.dart';
import 'package:tadawl_app/screens/account/change_phone.dart';
import 'package:tadawl_app/screens/account/update_my_information.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';

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


class AccountActions extends StatelessWidget {
  const AccountActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();

    Future<void> choiceAction(String choice) async {
      final userMutualProv = Provider.of<UserMutualProvider>(context, listen: false);
      final mainPageProv = Provider.of<MainPageProvider>(context, listen: false);
      final bottomProv = Provider.of<BottomNavProvider>(context, listen: false);
      if (choice == 'تحديث معلوماتي' || choice == 'Update My Info') {
        userMutualProv.setInitMembershipType();
        await Navigator.push(context,
          MaterialPageRoute(builder: (context) => UpdateMyInformation()),
        );
      } else if (choice == 'تغيير كلمة المرور' || choice == 'Change Password') {
        await Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              ChangeNotifierProvider<ChangePassProvider>(
                create: (_) => ChangePassProvider(),
                child: ChangePass(),
              )

          ),
        );
      } else if (choice == 'تغيير رقم الجوال' || choice == 'Change Phone') {
        await Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
            ChangeNotifierProvider<ChangePhoneProvider>(
              create: (_) => ChangePhoneProvider(),
              child: ChangePhone(),
            )
          ),
        );
      } else {
        await userMutualProv.logout();
        await Fluttertoast.showToast(
            msg: 'تم تسجيل الخروج',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
        mainPageProv.removeMarkers();
        bottomProv.setCurrentPage(0);
        mainPageProv.setRegionPosition(null);
        mainPageProv.setInItMainPageDone(0);
        await Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => MainPage()),
          ModalRoute.withName('/MainPage')
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.settings,
          color: Color(0xffffffff),
          size: 40,
        ),
        onSelected: choiceAction,
        itemBuilder: (BuildContext context) {
            return (_lang != 'en_US' ?
            Constants.choices
                :
            EngConstants.choices
            ).map((String choice) {
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
                        color: choice == Constants.logout ? const Color(0xffff0000) : const Color(0xff989898),
                      ).getTextStyle(),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          10, 0, 10, 0),
                      child: Icon(
                        choice == Constants.updateMyInfo ?
                        Icons.person_pin_rounded :
                        choice == Constants.changePass
                            ?
                        Icons.vpn_key_rounded
                            :
                        choice == Constants.changePhone
                            ?
                        Icons.phone_enabled_rounded
                            :
                        Icons.exit_to_app_rounded,
                        color: choice == Constants.logout ? const Color(0xffff0000) : const Color(0xff989898),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
        },
      ),
    );
  }
}