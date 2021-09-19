import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/transfer_form_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/transfer_form.dart';

class BankPayment extends StatelessWidget {
  const BankPayment({Key? key, required this.payFee}) : super(key: key);
  final AdvFeeProvider payFee;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.tadawlAppCC,
              style: CustomTextStyle(

                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.bankAccounts,
              style: CustomTextStyle(

                fontSize: 13,
                color: const Color(0xffa8a8a8),
              ).getTextStyle(),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  payFee.updateSelectedNav4(1);
                },
                child: Container(
                  width: 150.0,
                  height: 81.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: payFee.selectedNav4 == 1
                            ? Color(0xff000000).withOpacity(0.5)
                            : Color(0xffa6a6a6).withOpacity(0.3),
                        offset: const Offset(
                          2.0,
                          2.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    image: DecorationImage(
                      image: const AssetImage(
                          'assets/images/ahli.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  payFee.updateSelectedNav4(2);
                },
                child: Container(
                  width: 150.0,
                  height: 81.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: payFee.selectedNav4 == 2
                            ? Color(0xff000000).withOpacity(0.5)
                            : Color(0xffa6a6a6).withOpacity(0.3),
                        offset: const Offset(
                          2.0,
                          2.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    image: DecorationImage(
                      image: const AssetImage(
                          'assets/images/rajhi.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (payFee.selectedNav4 == 1)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.accountNumber,
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: '01400004728810'),
                      );
                    },
                    child: Text(
                      '01400004728810',
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.iBANnumber,
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                            text: 'SA1810000001400004728810'),
                      );
                    },
                    child: Text(
                      'SA1810000001400004728810',
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.rule23,
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (payFee.selectedNav4 == 2)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.accountNumber,
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: '558608016024859'),
                      );
                    },
                    child: Text(
                      '558608016024859',
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.iBANnumber,
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                            text: 'SA4380000558608016024859'),
                      );
                    },
                    child: Text(
                      'SA4380000558608016024859',
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.rule23,
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff8d8d8d),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: mediaQuery.size.width * 0.9,
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffececec),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                5, 0, 5, 0),
                            child: Icon(
                              Icons.emoji_objects_rounded,
                              color: Color(0xffffd633),
                              size: 25,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.rule24,
                              style: CustomTextStyle(

                                fontSize: 11,
                                color: const Color(0xffa8a8a8),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (locale.phone != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider<TransferFormProvider>(
                                            create: (_) => TransferFormProvider(),
                                            child: TransferForm(),
                                          ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Login()),
                                );
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: const Color(0xff3f9d28),
                                    width: 1),
                                color: const Color(0xffffffff),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .clickHere,
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color:
                                      const Color(0xff3f9d28),
                                    ).getTextStyle(),
                                  ),
                                ),
                              ),
                            ),
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
      ],
    );
  }
}
