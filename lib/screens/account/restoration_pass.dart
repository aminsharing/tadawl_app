import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/user_provider/change_phone_provider.dart';
import 'package:tadawl_app/screens/account/new_account.dart';
import 'package:tadawl_app/screens/account/verifyAccount.dart';

String pattternPhone = r'(^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)';
RegExp regExpPhone = RegExp(pattternPhone);

class RestorationPass extends StatelessWidget {
  RestorationPass({
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> _restorationPassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ChangeNotifierProvider<ChangePhoneProvider>(
      create: (_) => ChangePhoneProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff00cccc),
          centerTitle: true,
          title: Text(
            AppLocalizations
                .of(context)
                .restorationPass,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
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
        backgroundColor: const Color(0xffffffff),
        body: Form(
          key: _restorationPassKey,
          child: SingleChildScrollView(
            child: Consumer<ChangePhoneProvider>(builder: (context, restorationPass, child) {
              print("RestorationPass -> ChangePhoneProvider");
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: mediaQuery.size.width * 0.7,
                          child: TextFormField(
                            decoration:
                            InputDecoration(labelText: AppLocalizations.of(context).mobileNumber),
                            style: CustomTextStyle(

                              fontSize: 15,
                              color: const Color(0xff989696),
                            ).getTextStyle(),
                            keyboardType: TextInputType.phone,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context).reqMob;
                              } else if (!regExpPhone.hasMatch(value)) {
                                return AppLocalizations.of(context).reqSaudiMob;
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              Provider.of<ChangePhoneProvider>(context, listen: false).setCurrentPhone(value);
                            },
                          ),
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
                          if (!_restorationPassKey.currentState.validate()) {
                            return;
                          }
                          _restorationPassKey.currentState.save();
                          var url = 'https://www.tadawl-store.com/API/api_app/login/restoration_pass.php';

                          var response = await http.post(url, body: {
                            'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
                            'phone': restorationPass.currentPhone,
                          });
                          var data = json.decode(response.body);
                          if (data == 'false') {
                            await Fluttertoast.showToast(
                                msg:
                                'رقم الجوال غير موجود، لماذا لا تجرب تسجيل حساب جديد',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 15.0);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewAcount()),
                            );
                          }
                          else if (data == 'succesful') {
                            await Fluttertoast.showToast(
                                msg: 'لقد تم إرسال رمز اتفعيل إلى رقم جوالك',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 15.0);
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyAccount(currentPhone: restorationPass.currentPhone,)),
                            );
                          }
                        },
                        child: Container(
                          width: mediaQuery.size.width * 0.8,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                            Border.all(color: const Color(0xff3f9d28), width: 1),
                            color: const Color(0xffffffff),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations
                                  .of(context)
                                  .restorationPass,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color: const Color(0xff3f9d28),
                              ).getTextStyle(),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
