import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/payment_of_fees/bank_payment.dart';
import 'package:tadawl_app/mainWidgets/payment_of_fees/e_payment.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';

class PaymentOfFees extends StatelessWidget {
  PaymentOfFees({
    Key? key,
    required this.price,
    required this.type
  }) : super(key: key);
  final String? price;
  final String? type;

  @override
  Widget build(BuildContext context) {
      var mediaQuery = MediaQuery.of(context);
      // ignore: omit_local_variable_types
      // Map data = {};
      // var price, type;
      //String cardNumber, cardName, cvvNumber, year, month;

      // data = ModalRoute.of(context).settings.arguments;
      // price = data['price'];
      // type = data['type'];

      //payFee.initStateSelected();

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
            AppLocalizations.of(context)!.payFees,
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
          child: Consumer<AdvFeeProvider>(builder: (context, payFee, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: mediaQuery.size.width,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ToggleButtons(
                          onPressed: (int index) {
                            payFee.updateSelected3(index);
                          },
                          isSelected: payFee.isSelected3,
                          color: const Color(0xff8d8d8d),
                          selectedColor: const Color(0xffffffff),
                          fillColor: const Color(0xff3f9d28),
                          borderRadius: BorderRadius.circular(5),
                          borderWidth: 2,
                          borderColor: const Color(0xff3f9d28),
                          selectedBorderColor: const Color(0xff3f9d28),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                AppLocalizations.of(context)!.transferBank,
                                style: CustomTextStyle(
                                  fontSize: 15,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                AppLocalizations.of(context)!.onlinePay,
                                style: CustomTextStyle(
                                  fontSize: 15,
                                ).getTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: const Color(0xffa8a8a8),
                  height: 10,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                if (payFee.selectedNav3 == 1)
                  EPayment(price: price, type: type,),
                if (payFee.selectedNav3 == 0)
                  BankPayment(payFee: payFee,),
              ],
            );
          }),
        ),
      );
  }
}
