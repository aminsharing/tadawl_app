import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_phone_provider.dart';
import 'package:tadawl_app/provider/user_provider/login_provider.dart';
import 'package:tadawl_app/screens/account/new_account.dart';
import 'package:tadawl_app/screens/account/restoration_pass.dart';
import 'package:tadawl_app/screens/account/verifyAccount.dart';
import 'package:tadawl_app/screens/general/home.dart';

String phone;
String password;
String patternPhone =
    r'(^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)';
RegExp regExpPhone = RegExp(patternPhone);

class Login extends StatelessWidget {
  Login({
    Key key,
  }) : super(key: key);

  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  String filterPhone(var Phone) {
    if (Phone.toString().length == 10 && Phone.toString().startsWith('05')) {
      Phone = Phone.toString().replaceFirst('0', '966');
      return Phone;
    }
    else if (Phone.toString().startsWith('5')) {
      Phone = Phone.toString().replaceFirst('5', '9665');
      return Phone;
    }
    else if (Phone.toString().startsWith('00')) {
      Phone = Phone.toString().replaceFirst('00', '');
      return Phone;
    }
    else if (Phone.toString().startsWith('+')) {
      Phone = Phone.toString().replaceFirst('+', '');
      return Phone;
    }
    else {
      return Phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context);
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 70,
          title: Text(
            AppLocalizations
                .of(context)
                .login,
            style: CustomTextStyle(
              fontSize: 30,
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
              //mainChat.closeStreamChat();
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xff1f2835),
        ),
        backgroundColor: const Color(0xffffffff),
        body: Container(
          child: Form(
            key: _formLoginKey,
            child: SingleChildScrollView(
              child: Consumer<LoginProvider>(builder: (context, login, child) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: ListTile(
                        leading: Icon(
                          Icons.phone_enabled,
                          color: Color(0xff04B404),
                          size: 30,
                        ),
                        title: TextFormField(
                          decoration:
                          InputDecoration(
                            labelText: translate.mobileNumber,
                          ),
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          keyboardType: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return translate.reqMob;
                            }
                            else if (!regExpPhone.hasMatch(value)) {
                              return translate.reqSaudiMob;
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            var valueFiltered = filterPhone(value);
                            phone = valueFiltered;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Consumer<LoginProvider>(builder: (context, login, child) {
                        return ListTile(
                          leading: Icon(
                            Icons.vpn_key,
                            color: Color(0xff04B404),
                            size: 30,
                          ),
                          trailing: InkWell(
                            child: Icon(
                              login.passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xff3f9d28),
                            ),
                            onTap: () {
                              login.setPasswordVisibleState(!login.passwordVisible);
                            },
                          ),
                          title: Stack(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(labelText: translate.pass),
                                obscureText: !login.passwordVisible,
                                style: CustomTextStyle(
                                  fontSize: 15,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                textDirection: TextDirection.ltr,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return translate.reqPass;
                                  } else if (value.length < 8) {
                                    return translate.reqPassless8;
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  password = value;
                                },
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff3f9d28)),
                        ),
                        child: TextButton(
                          child: Center(
                            child: Text(
                              AppLocalizations
                                  .of(context)
                                  .login,
                              style: CustomTextStyle(
                                fontSize: 20,
                                color: const Color(0xff3f9d28),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onPressed: () async {
                            if (!_formLoginKey.currentState.validate()) {
                              return;
                            }
                            _formLoginKey.currentState.save();
                            var url = 'https://www.tadawl-store.com/API/api_app/login/login.php';
                            var response = await http.post(url, body: {
                              'phone': phone,
                              'password': password,
                              'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@'
                            });
                            var data = json.decode(response.body);
                            if (data == 'false') {
                              await Fluttertoast.showToast(
                                  msg: 'كلمة المرور غير صحيحة',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 15.0);
                            } else if (data == 'error') {
                              await Fluttertoast.showToast(
                                  msg:
                                  'أنت لا تملك حساب لماذا لا تجرب تسجيل مستخدم جديد؟',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 15.0);

                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<ChangePhoneProvider>(
                                          create: (_) => ChangePhoneProvider(),
                                          child: NewAcount(),
                                        )
                                ),
                              );
                            } else if (data == 'successful') {
                              await login.saveSession(phone).then((value) {
                                locale.getSession().then((value) async{
                                  await Fluttertoast.showToast(
                                      msg: 'تم تسجيل الدخول بنجاح',
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
                                          builder: (context) => Home(),
                                      ),
                                          (route) => false
                                  );
                                });
                              });

                            } else if (data == 'not verified') {
                              await Fluttertoast.showToast(
                                  msg: 'لم يتم تفعيل الحساب بعد',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 15.0);

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyAccount(currentPhone: phone,)),
                              );

                            }
                            ;
                          },
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestorationPass()),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .forgetPass,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff3f9d28),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .notReg,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff6b6b6b),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff00cccc)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewAcount()
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations
                                  .of(context)
                                  .newAccount,
                              style: CustomTextStyle(
                                fontSize: 20,
                                color: const Color(0xff00cccc),
                              ).getTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
