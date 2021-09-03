import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/screens/general/home.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_pass_provider.dart';

class ChangePass extends StatelessWidget {
  ChangePass({
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> _changePassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<ChangePassProvider>(builder: (context, changePass, child) {



      var mediaQuery = MediaQuery.of(context);


      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
            AppLocalizations
                .of(context)!
                .changePass,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff1f2835),
        ),
        backgroundColor: const Color(0xffffffff),
        body: Form(
          key: _changePassKey,
          child: SingleChildScrollView(
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
                          decoration:
                          InputDecoration(labelText: AppLocalizations.of(context)!.newPass),
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.reqNewPass;
                            } else if (value.length < 8) {
                              return AppLocalizations.of(context)!.reqPassless8;
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            changePass.setNewPass(value);
                          },
                        ),
                      ),
                      Icon(
                        Icons.vpn_key_rounded,
                        color: Color(0xff04B404),
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
                              labelText: AppLocalizations.of(context)!.configNewPass),
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.reqConfirmNewPass;
                            } else if (value.length < 8) {
                              return AppLocalizations.of(context)!.reqPassless8;
                            } //else if (value != changePass.newPass) {
                            //  return AppLocalizations.of(context).notMatch;
                            //}
                            return null;
                          },
                          onSaved: (String? value) {
                            changePass.setReNewPass(value);
                          },
                        ),
                      ),
                      Icon(
                        Icons.vpn_key_rounded,
                        color: Color(0xff04B404),
                        size: 40,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: TextButton(
                    onPressed: () async {
                      if (!_changePassKey.currentState!.validate()) {
                        return;
                      } else {
                        _changePassKey.currentState!.save();
                        var url =
                            'https://tadawl-store.com/API/api_app/login/change_pass.php';
                        var response = await http.post(Uri.parse(url), body: {
                          'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
                          'phone': locale.phone,
                          'newPass': changePass.newPass,
                          'reNewPass': changePass.reNewPass,
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
                              msg: 'هناك خطاء راجع الإدارة',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 15.0);
                        } else if (data == 'successful') {
                          await Fluttertoast.showToast(
                              msg: 'لقد تم تغيير كلمة المرور بنجاح',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 15.0);

                          Future.delayed(Duration(seconds: 1), () {
                            locale.setCurrentPage(0);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                                    (route) => false
                            );
                          });
                        }
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
                      child: Center(
                        child: Text(
                            AppLocalizations
                                .of(context)!
                                .changePass,
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
