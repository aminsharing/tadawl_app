import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_phone_provider.dart';
import 'package:tadawl_app/screens/general/home.dart';

class VerifyPhone extends StatelessWidget {
  VerifyPhone({
    Key key,
    @required this.oldPhone,
    @required this.newPhone
  }) : super(key: key);
  final String oldPhone;
  final String newPhone;
  final GlobalKey<FormState> _formVerAccountKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00cccc),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)
              .verAccount,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: SizedBox(
                    width: mediaQuery.size.width * 0.7,
                    height: 70,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText:
                          AppLocalizations.of(context).enterVR),
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context).reqVR;
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        Provider.of<ChangePhoneProvider>(context, listen: false).setVerCode(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Icon(
                    Icons.verified_user_rounded,
                    color: Color(0xff00cccc),
                    size: 40,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                if (!_formVerAccountKey.currentState.validate()) {
                  return;
                }
                _formVerAccountKey.currentState.save();
                var url = 'https://www.tadawl-store.com/API/api_app/login/change_phone_2.php';
                var response = await http.post(url, body: {
                  'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
                  'oldPhone': oldPhone,
                  'newPhone': newPhone,
                  'verCode': Provider.of<ChangePhoneProvider>(context, listen: false).verificationCode,
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
                  final locale = Provider.of<LocaleProvider>(context, listen: false);
                  await Provider.of<ChangePhoneProvider>(context, listen: false).saveSession(newPhone).then((value) {
                    locale.getSession().then((value) async{
                      await Fluttertoast.showToast(
                          msg: 'لقد تم تغيير رقم الجوال بنجاح',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 15.0);
                      locale.setCurrentPage(0);
                      await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home()
                          ), (route) => false);
                    });
                  });

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
                      AppLocalizations.of(context).verAccount,
                      style: CustomTextStyle(

                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
