import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/adv_fee_provider.dart';
import 'package:tadawl_app/screens/ads/payment_of_fees.dart';

class UpgradeAdScreen extends StatefulWidget {
  const UpgradeAdScreen({Key? key}) : super(key: key);

  @override
  _UpgradeAdScreenState createState() => _UpgradeAdScreenState();
}

class _UpgradeAdScreenState extends State<UpgradeAdScreen> {
  int _currentValue = 50;

  Map<int, String> payOf = {
    50 : '150 مشاهدة',
    100 : '300 مشاهدة',
    170 : '600 مشاهدة',
    250 : '1000 مشاهدة',
  };

  Map<int, String> dayOf = {
    50 : '2 أيام',
    100 : '3 أيام',
    170 : '5 أيام',
    250 : '7 أيام',
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ترقية الإعلان',
          style: CustomTextStyle().getTextStyle(),
        ),
        centerTitle: true,
        leadingWidth: 70.0,
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff1f2835),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'خطة ترقية الإعلان',
                style: CustomTextStyle().getTextStyle(),
              ),
            ),
          ),
          CustomRadio(
            text: 'الحصول على 150 مشاهدة',
            value: 50,
            currentValue: _currentValue,
            onChanged: (int? value) {
              setState(() {
                _currentValue = value!;
              });
            },
          ),
          CustomRadio(
            text: 'الحصول على 300 مشاهدة',
            value: 100,
            currentValue: _currentValue,
            onChanged: (int? value) {
              setState(() {
                _currentValue = value!;
              });
            },
          ),
          CustomRadio(
            text: 'الحصول على 600 مشاهدة',
            value: 170,
            currentValue: _currentValue,
            onChanged: (int? value) {
              setState(() {
                _currentValue = value!;
              });
            },
          ),
          CustomRadio(
            text: 'الحصول على 1000 مشاهدة',
            value: 250,
            currentValue: _currentValue,
            onChanged: (int? value) {
              setState(() {
                _currentValue = value!;
              });
            },
          ),
          SizedBox(height: 10.0,),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'التفاصيل:',
                style: CustomTextStyle().getTextStyle(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'الوقت المتوقع: ${dayOf[_currentValue]} (يختلف حسب الموقع)',
              style: CustomTextStyle().getTextStyle(),
            ),
          ),
          SizedBox(height: 10.0,),
          TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    ChangeNotifierProvider<AdvFeeProvider>.value(
                        value: AdvFeeProvider(),
                        child: PaymentOfFees(
                          type: payOf[_currentValue],
                          price: _currentValue.toString(),
                        )
                    )
                    )
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      width: 1.0,
                      color: const Color(0xff04B404)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'إستمرار',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle(
                      color: const Color(0xff04B404).withOpacity(0.8),
                    ).getTextStyle(),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
class CustomRadio extends StatelessWidget {
  CustomRadio({
    Key? key,
    required this.text,
    required this.value,
    required this.currentValue,
    required this.onChanged,
  }) : super(key: key);
  final String text;
  final int value;
  final int currentValue;
  final ValueChanged<int?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: CustomTextStyle(
          fontSize: 15
        ).getTextStyle(),
      ),
      leading: Radio<int>(
        value: value,
        groupValue: currentValue,
        fillColor: MaterialStateProperty.all(const Color(0xff04B404)),
        onChanged: onChanged,
      ),
    );
  }
}
