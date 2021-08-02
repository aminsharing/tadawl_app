import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:tadawl_app/provider/user_provider/change_pass_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';

class Stage2 extends StatelessWidget {
  Stage2({Key key}) : super(key: key);
  final GlobalKey<FormState> _formVerAccountKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    Provider.of<UserMutualProvider>(context, listen: false).getSession();
    var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00cccc),
        title: Text(
          AppLocalizations.of(context)
              .configNewPass,
          style: CustomTextStyle(
            fontSize: 20,
            color: const Color(0xffffffff),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: _formVerAccountKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: mediaQuery.size.width * 0.7,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).newPass),
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context).reqNewPass;
                        } else if (value.length < 8) {
                          return AppLocalizations.of(context).reqPassless8;
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        Provider.of<ChangePassProvider>(context, listen: false).setNewPass(value);
                      },
                    ),
                  ),
                  Icon(
                    Icons.vpn_key_rounded,
                    color: Color(0xff00cccc),
                    size: 40,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: mediaQuery.size.width * 0.7,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).confirmNewPass),
                      style: CustomTextStyle(

                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context).reqConfirmNewPass;
                        } else if (value.length < 8) {
                          return AppLocalizations.of(context).reqPassless8;
                        } //else if (value != verifyAcc.newPass) {
                        // return AppLocalizations.of(context).notMatch;
                        // }
                        return null;
                      },
                      onSaved: (String value) {
                        Provider.of<ChangePassProvider>(context, listen: false).setReNewPass(value);
                      },
                    ),
                  ),
                  Icon(
                    Icons.vpn_key_outlined,
                    color: Color(0xff00cccc),
                    size: 40,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                if (!_formVerAccountKey.currentState.validate()) {
                  return;
                }
                _formVerAccountKey.currentState.save();
                var url = 'https://www.tadawl.com.sa/API/api_app/login/config_pass.php';
                var response = await http.post(url, body: {
                  'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
                  'phone': _phone,
                  'password': Provider.of<ChangePassProvider>(context, listen: false).newPass,
                  'rePassword': Provider.of<ChangePassProvider>(context, listen: false).reNewPass,
                });
                var data = json.decode(response.body);
                if (data == 'nomatch') {
                  await Fluttertoast.showToast(
                      msg: 'كلمة المرور والتأكيد غير متطابقان',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 15.0);
                }
                else if (data == 'error') {
                  await Fluttertoast.showToast(
                      msg: 'رقم الجوال غير موجود',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 15.0);
                } else if (data == 'successful') {
                  await Fluttertoast.showToast(
                      msg: 'تم تسجيل الدخول بنجاح',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 15.0);

                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MainPage()),
                    ModalRoute.withName('/MainPage')
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  width: mediaQuery.size.width * 0.8,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xff00cccc),
                    border: Border.all(
                        width: 1.0, color: const Color(0xff00cccc)),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).continuee,
                      style: CustomTextStyle(
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
