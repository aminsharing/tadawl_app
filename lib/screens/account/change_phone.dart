import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/change_phone_provider.dart';
import 'package:tadawl_app/screens/general/home.dart';

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
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<ChangePhoneProvider>(builder: (context, changePhone, child) {


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

                      var url =
                          'https://tadawl-store.com/API/api_app/login/change_phone.php';
                      var response = await http.post(url, body: {
                        'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
                        'oldPhone': locale.phone,
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
                        await changePhone.saveSession(changePhone.newPhone).then((value) {
                          locale.getSession().then((value) async{
                            await Fluttertoast.showToast(
                                msg: 'لقد تم تغيير رقم الجوال بنجاح',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 15.0);

                            // var userMutual = Provider.of<UserMutualProvider>(context, listen: false);
                            // userMutual.getAvatarList(changePhone.newPhone);
                            // userMutual.getUserAdsList(changePhone.newPhone);
                            // userMutual.getEstimatesInfo(changePhone.newPhone);
                            // userMutual.getSumEstimatesInfo(changePhone.newPhone);
                            // userMutual.checkOfficeInfo(changePhone.newPhone);
                            // userMutual.setUserPhone(changePhone.newPhone);

                            // final MyAccountProvider myAccountProvider = MyAccountProvider(locale.phone);
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           ChangeNotifierProvider<MyAccountProvider>(
                            //             create: (_) => myAccountProvider,
                            //             child: MyAccount(myAccountProvider: myAccountProvider, phone: locale.phone,),
                            //           )
                            //   ),
                            // );
                            locale.setCurrentPage(0);
                            await Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()
                                ), (route) => false);

                            // Future.delayed(Duration(seconds: 1), () {
                            //   if (userMutual.userPhone == locale.phone){
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               OwenAccount()),
                            //     );
                            //   }else{
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               OtherAccount()),
                            //     );
                            //   }
                            // });
                          });
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
