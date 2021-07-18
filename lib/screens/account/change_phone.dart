import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/user_provider/change_phone_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/my_account.dart';

String patternPhone =
    r'(^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)';
RegExp regExpPhone = RegExp(patternPhone);

class ChangePhone extends StatelessWidget {
  ChangePhone({
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> _changePhoneKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangePhoneProvider>(builder: (context, changePhone, child) {

      print("ChangePhone -> ChangePhoneProvider");

      Widget _buildPhone() {
        return TextFormField(
          decoration:
          InputDecoration(labelText: AppLocalizations.of(context).newPhone),
          style: CustomTextStyle(

            fontSize: 15,
            color: const Color(0xff989696),
          ).getTextStyle(),
          keyboardType: TextInputType.number,
          validator: (String value) {
            if (value.isEmpty) {
              return AppLocalizations.of(context).reqNewPhone;
            } else if (!regExpPhone.hasMatch(value)) {
              return AppLocalizations.of(context).reqSaudiMob;
            }

            return null;
          },
          onSaved: (String value) {
            changePhone.setNewPhone(value);
          },
        );
      }

      var mediaQuery = MediaQuery.of(context);
      Provider.of<UserMutualProvider>(context, listen: false).getSession();

      return Scaffold(
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
            AppLocalizations.of(context).changePhone,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff00cccc),
        ),
        backgroundColor: const Color(0xffffffff),
        body: Form(
          key: _changePhoneKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: mediaQuery.size.width * 0.7,
                        child: _buildPhone(),
                      ),
                      Icon(
                        Icons.phone_enabled,
                        color: Color(0xff00cccc),
                        size: 40,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: TextButton(
                    onPressed: () async {
                      if (!_changePhoneKey.currentState.validate()) {
                        return;
                      }

                      _changePhoneKey.currentState.save();

                      await Provider.of<UserMutualProvider>(context, listen: false).getSession();

                      var url =
                          'https://tadawl.com.sa/API/api_app/login/change_phone.php';
                      var response = await http.post(url, body: {
                        'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
                        'oldPhone': Provider.of<UserMutualProvider>(context, listen: false).phone,
                        'newPhone': changePhone.newPhone,
                      });

                      var data = json.decode(response.body);

                      if (data == 'error') {
                        await Fluttertoast.showToast(
                            msg: 'هناك خطاء راجع الإدارة',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 15.0);
                      } else if (data == 'successful') {
                        changePhone.saveSession(changePhone.newPhone);
                        await Fluttertoast.showToast(
                            msg: 'لقد تم تغيير رقم الجوال بنجاح',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 15.0);

                        var userMutual = Provider.of<UserMutualProvider>(context, listen: false);
                        userMutual.getAvatarList(context, changePhone.newPhone);
                        userMutual.getUserAdsList(context, changePhone.newPhone);
                        userMutual.getEstimatesInfo(context, changePhone.newPhone);
                        userMutual.getSumEstimatesInfo(context, changePhone.newPhone);
                        userMutual.checkOfficeInfo(context, changePhone.newPhone);
                        userMutual.setUserPhone(changePhone.newPhone);

                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyAccount()),
                          );
                        });
                      }
                    },
                    child: Container(
                      width: mediaQuery.size.width * 0.8,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border:
                            Border.all(color: const Color(0xff3f9d28), width: 2),
                        color: const Color(0xffffffff),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).continuee,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff3f9d28),
                          ).getTextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
    );
  }
}
