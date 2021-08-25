import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/advertising_fee/fee_card.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class SelectedNav0 extends StatelessWidget {
  const SelectedNav0({Key key, @required this.advFeeProvider}) : super(key: key);
  final AdvFeeProvider advFeeProvider;

  void launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+966552525000',
      text: 'حلول التسويق للمطورين العقاريين',
    );
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var selectedNav2 = <String>[
      AppLocalizations.of(context).rule1,
      AppLocalizations.of(context).rule2,
      AppLocalizations.of(context).rule3,
      AppLocalizations.of(context).rule4,
      AppLocalizations.of(context).rule5,
      AppLocalizations.of(context).rule6,
      AppLocalizations.of(context).rule7,
    ];
    var selectedNav1 = <String>[
      AppLocalizations.of(context).rule8,
      AppLocalizations.of(context).rule9,
      AppLocalizations.of(context).rule10,
      AppLocalizations.of(context).rule11,
      AppLocalizations.of(context).rule12,
      AppLocalizations.of(context).rule13,
      AppLocalizations.of(context).rule14,
    ];

    var selectedNav0 = <String>[
      AppLocalizations.of(context).rule15,
      AppLocalizations.of(context).rule16,
    ];

    return Consumer<AdvFeeProvider>(builder: (context, advFee, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ToggleButtons(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      AppLocalizations.of(context).basicMembership,
                      style: CustomTextStyle(

                        fontSize: 15,
                      ).getTextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      AppLocalizations.of(context).proMembership,
                      style: CustomTextStyle(

                        fontSize: 15,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      AppLocalizations.of(context).specialMembership,
                      style: CustomTextStyle(

                        fontSize: 15,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                onPressed: (int index) {
                  advFee.updateSelected2(index);
                },
                isSelected: advFee.isSelected2,
                color: const Color(0xff8d8d8d),
                selectedColor: const Color(0xffffffff),
                fillColor: const Color(0xff1f2835),
                borderRadius: BorderRadius.circular(30),
                borderWidth: 1,
                borderColor: const Color(0xffdddddd),
                selectedBorderColor: const Color(0xffdddddd),
              ),
            ],
          ),
          if (advFee.selectedNav2 == 2)
            FeeCard(
              selectedNav: selectedNav2,
              price: '2500',
              type: 'العضوية المميزة',
              cardType: CardType.big,
              advFeeProvider: advFeeProvider,
            ),
          if (advFee.selectedNav2 == 1)
            FeeCard(
              selectedNav: selectedNav1,
              price: '1900',
              type: 'العضوية الاحترافية',
              cardType: CardType.big,
              advFeeProvider: advFeeProvider,
            ),
          if (advFee.selectedNav2 == 0)
            FeeCard(
              selectedNav: selectedNav0,
              price: '750',
              type: 'العضوية الأساسية',
              cardType: CardType.big,
              advFeeProvider: advFeeProvider,
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.8,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffececec),
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: launchWhatsApp,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(
                                  5, 0, 5, 0),
                              child: Icon(
                                Icons.emoji_objects_rounded,
                                color: Color(0xffffd633),
                                size: 25,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)
                                    .marketingSol,
                                style: CustomTextStyle(
                                  fontSize: 13,
                                  color:
                                  const Color(0xffa8a8a8),
                                ).getTextStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: launchWhatsApp,
                        child: Container(
                          width: 100,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            border: Border.all(
                                color:
                                const Color(0xff3f9d28),
                                width: 2),
                            color: const Color(0xffffffff),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context).clickHere,
                              style: CustomTextStyle(

                                fontSize: 15,
                                color:
                                const Color(0xff3f9d28),
                              ).getTextStyle(),
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
      );
    });
  }
}
