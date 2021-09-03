import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/advertising_fee/fee_card.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class SelectedNav1 extends StatelessWidget {
  const SelectedNav1({Key? key, required this.advFeeProvider}) : super(key: key);
  final AdvFeeProvider advFeeProvider;

  void launchWhatsApp2() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+966552525000',
      text: 'خدمات التسويق الحصري',
    );
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffffffff),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FeeCard(
                      selectedNav: [AppLocalizations.of(context)!.rentalFees,AppLocalizations.of(context)!.rule17],
                      price: '60',
                      type: 'رسوم التأجير',
                      cardType: CardType.medium,
                      advFeeProvider: advFeeProvider,
                    ),
                    FeeCard(
                        selectedNav: [AppLocalizations.of(context)!.sellingFees,AppLocalizations.of(context)!.rule18],
                        price: '475',
                        type: 'رسوم البيع',
                        cardType: CardType.medium,
                      advFeeProvider: advFeeProvider,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.8,
                  height: 170.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 0, 0, 0),
                              child: Icon(
                                Icons.error_outlined,
                                color: Color(0xffffd633),
                                size: 25,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.explanatoryPoints,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 0, 5, 0),
                              child: Text(
                                '-',
                                style: CustomTextStyle(
                                  fontSize: 10,
                                  color: const Color(0xffa8a8a8),
                                ).getTextStyle(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.rule19,
                                style: CustomTextStyle(
                                  fontSize: 10,
                                  color: const Color(0xffa8a8a8),
                                ).getTextStyle(),
                                // textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5, 0, 5, 0),
                              child: Text(
                                '-',
                                style: CustomTextStyle(
                                  fontSize: 10,
                                  color: const Color(0xffa8a8a8),
                                ).getTextStyle(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.rule20,
                                style: CustomTextStyle(
                                  fontSize: 10,
                                  color: const Color(0xffa8a8a8),
                                ).getTextStyle(),
                                // textAlign: TextAlign.end,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.8,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffececec),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: launchWhatsApp2,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10, 0, 5, 0),
                              child: Icon(
                                Icons.emoji_objects_rounded,
                                color: Color(0xffffd633),
                                size: 30,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)!.xMark,
                                style: CustomTextStyle(
                                  fontSize: 13,
                                  color: const Color(0xffa8a8a8),
                                ).getTextStyle(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: launchWhatsApp2,
                        child: Container(
                          width: 100,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            border: Border.all(
                                color: const Color(0xff3f9d28),
                                width: 2),
                            color: const Color(0xffffffff),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.clickHere,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff3f9d28),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.rule21,
                    style: CustomTextStyle(
                      fontSize: 10,
                      color: const Color(0xffa8a8a8),
                    ).getTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
