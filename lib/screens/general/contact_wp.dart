import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactWp extends StatelessWidget {
  ContactWp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80.0,
        leadingWidth: 70,
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
          AppLocalizations.of(context).contactUs,
          style: CustomTextStyle(
            fontSize: 20,
            color: const Color(0xffffffff),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff1f2835),
      ),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context).contactUsDet,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => directSupport(context),
                    child: Text(
                      AppLocalizations.of(context).support,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                    ),
                  ),
                  TextButton(
                    child: Icon(
                      Icons.message_rounded,
                      color: Color(0xff04B404),
                      size: 30,
                    ),
                    onPressed: () => directSupport(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: launchWhatsApp,
                    child: Text(
                      AppLocalizations.of(context).watsappUs,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff000000),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    onPressed: launchWhatsApp,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/images/img15.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: launchWhatsApp,
                  //   child: Text(
                  //     '0552525000 ',
                  //     style: CustomTextStyle(
                  //
                  //       fontSize: 15,
                  //       color: const Color(0xff989696),
                  //     ).getTextStyle(),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
            //   child: TextButton(
            //     onPressed: launchWhatsApp,
            //     child: Container(
            //       width: 100,
            //       height: 50.0,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10.0),
            //         border:
            //         Border.all(color: const Color(0xff00cccc), width: 1),
            //         color: const Color(0xffffffff),
            //       ),
            //       child: Align(
            //         alignment: Alignment.center,
            //         child: Text(
            //           AppLocalizations.of(context).contactUs,
            //           style: CustomTextStyle(
            //             fontSize: 20,
            //             color: const Color(0xff00cccc),
            //           ).getTextStyle(),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: '+966552525000',
    text: 'تطبيق تداول العقاري، أود التواصل معكم للمساعدة',
  );
  await launch('$link');
}

void directSupport(BuildContext context) async {
  final locale = Provider.of<LocaleProvider>(context, listen: false);
  if(locale.phone == '966552525000'){
    await Fluttertoast.showToast(
        msg: 'لا يمكن لصاحب التطبيق التواصل مع الدعم الفني',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0);
  }else {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ChangeNotifierProvider<MsgProvider>(
                create: (context) => MsgProvider(context, locale.phone, customMsg: 'أود التواصل معكم للمساعدة',),
                child: Discussion(
                  '966552525000',
                  username: 'تطبيق تداول العقاري',
                ),
              )
      )
  );
  }
}