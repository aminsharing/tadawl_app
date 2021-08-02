import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/screens/ads/payment_of_fees.dart';

enum CardType{
  big,
  medium,
  small
}

class FeeCard extends StatelessWidget {
  const FeeCard({
    Key key,
    @required this.selectedNav,
    @required this.price,
    @required this.type,
    @required this.cardType,
    this.title,
  }) : super(key: key);

  final List<String> selectedNav;
  final String price, type, title;
  final CardType cardType;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: cardType == CardType.big ? mediaQuery.size.width * 0.8 : mediaQuery.size.width * 0.4,
                height: cardType == CardType.small ? 180.0 : cardType == CardType.medium ? 230.0 : type == 'العضوية الأساسية' ? 300 : 450.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffececec),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(
                      selectedNav.length,
                          (index) =>
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 10, 15, 0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                      5, 0, 0, 0),
                                  child: Icon(
                                    Icons.verified_outlined,
                                    color: Color(0xff00cccc),
                                    size: 25,
                                  ),
                                ),
                                Text(
                                  selectedNav[index],
                                  style: CustomTextStyle(
                                    fontSize: 10,
                                    color: const Color(0xffa8a8a8),
                                  ).getTextStyle(),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                                5, 0, 0, 0),
                            child: Text(
                              price,
                              style: CustomTextStyle(
                                fontSize: 20,
                                color:
                                const Color(0xff00cccc),
                              ).getTextStyle(),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context).rial,
                            style: CustomTextStyle(
                              fontSize: 20,
                              color: const Color(0xff00cccc),
                            ).getTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cardType == CardType.small
                                ?
                            title
                                :
                            AppLocalizations.of(context).annual,
                            style: CustomTextStyle(
                              fontSize: 13,
                              color: const Color(0xffa8a8a8),
                            ).getTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  PaymentOfFees(price: price, type: type)));
                            },
                            child: Container(
                              width: cardType == CardType.big ? 140.0 : 100.0,
                              height: cardType == CardType.big ? 50.0 : 40.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                border: Border.all(color: const Color(0xff00cccc), width: 2),
                                color:
                                const Color(0xffffffff),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  cardType == CardType.big
                                      ?
                                  AppLocalizations.of(context).subscribe
                                      :
                                  AppLocalizations.of(context).payFees,
                                  style: CustomTextStyle(

                                    fontSize: cardType == CardType.big ? 20 : 15,
                                    color: const Color(
                                        0xff00cccc),
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
          ),
        ],
      ),
    );
  }
}
