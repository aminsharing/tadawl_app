import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';

class EPayment extends StatelessWidget {
  const EPayment({
    Key? key,
    required this.price,
    required this.type
  }) : super(key: key);
  final String? price;
  final String? type;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<AdvFeeProvider>(
      builder: (context, payment, _){
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.cost +
                        ' $price ' +
                        AppLocalizations.of(context)!.to +
                        ' $type ',
                    style: CustomTextStyle(
                      fontSize: 13,
                      color: const Color(0xffa8a8a8),
                    ).getTextStyle(),
                    // textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.enterCoupon,
                        style: CustomTextStyle(
                          fontSize: 13,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Container(
                    child: SizedBox(
                      width: 120,
                      height: 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.coupon,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        style: CustomTextStyle(
                          fontSize: 10,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.reqCoupon;
                          }
                          return null;
                        },
                        // onSaved: (String value) {
                        //   cvvNumber = value;
                        // },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      width: 60,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xff00cccc),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.apply,
                          style: CustomTextStyle(
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.cardNumber,
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.cardNumber,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                style: CustomTextStyle(
                  fontSize: 10,
                  color: const Color(0xff989696),
                ).getTextStyle(),
                keyboardType: TextInputType.number,
                controller: payment.cardNumberText,
                minLines: 1,
                maxLines: 1,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.reqCardNumber;
                  }
                  return null;
                },
                // onSaved: (String value) {
                //  cardNumber = value;
                // },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.cardNumberName,
                    style: CustomTextStyle(

                      fontSize: 15,
                      color: const Color(0xff000000),
                    ).getTextStyle(),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText:
                  AppLocalizations.of(context)!.cardNumberName,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                style: CustomTextStyle(

                  fontSize: 10,
                  color: const Color(0xff989696),
                ).getTextStyle(),
                controller: payment.cardHolderText,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 1,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!
                        .reqCardNumberName;
                  }
                  return null;
                },
                // onSaved: (String value) {
                //   cardName = value;
                // },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.cvv,
                              style: CustomTextStyle(
                                fontSize: 15,
                                color: const Color(0xff000000),
                              ).getTextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        Container(
                          child: SizedBox(
                            width: 120,
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText:
                                AppLocalizations.of(context)!.cvv,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(5.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              style: CustomTextStyle(
                                fontSize: 10,
                                color: const Color(0xff989696),
                              ).getTextStyle(),
                              controller: payment.CVVText,
                              keyboardType: TextInputType.number,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .reqCvv;
                                }
                                return null;
                              },
                              // onSaved: (String value) {
                              //   cvvNumber = value;
                              //  },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.endDate,
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
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Container(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!.year,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(5.0),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  style: CustomTextStyle(
                                    fontSize: 10,
                                    color: const Color(0xff989696),
                                  ).getTextStyle(),
                                  controller: payment.expiryYearText,
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(
                                          context)!
                                          .reqYear;
                                    }
                                    return null;
                                  },
                                  // onSaved: (String value) {
                                  //   year = value;
                                  // },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!
                                      .month,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                style: CustomTextStyle(

                                  fontSize: 10,
                                  color: const Color(0xff989696),
                                ).getTextStyle(),
                                controller: payment.expiryMonthText,
                                keyboardType: TextInputType.number,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .reqMonth;
                                  }
                                  return null;
                                },
                                //  onSaved: (String value) {
                                //   month = value;
                                // },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                if (locale.phone != null) {
                  payment.amount = price!;
                  payment.pay(context);
                  // TODO Add payment method
                }
                else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
              },
              child: Container(
                width: 70,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: const Color(0xff3f9d28), width: 2),
                  color: const Color(0xffffffff),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.pay,
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff3f9d28),
                    ).getTextStyle(),
                  ),
                ),
              ),
            ),
            if(payment.resultText != null)
              Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      payment.resultText!.description!,
                      style: CustomTextStyle(
                        fontSize: 13,
                        color: payment.resultText!.code == '000.100.110' ? Colors.green : Colors.red,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.rule22,
                      style: CustomTextStyle(

                        fontSize: 13,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 99.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                        const AssetImage('assets/images/img18.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: 99.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                        const AssetImage('assets/images/img6.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: 99.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                        const AssetImage('assets/images/img19.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
