import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';

class UserPhone extends StatelessWidget {
  const UserPhone({
    Key? key,
    required this.userPhone,
    required this.isMine,
  }) : super(key: key);
  final String? userPhone;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              AppLocalizations.of(context)!.phone,
              style: CustomTextStyle(
                fontSize: 15,
                color: const Color(0xff989696),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: isMine ? null : () => _call(userPhone??''),
            child: Text(
              (userPhone??'').replaceAll('966', '0'),
              style: CustomTextStyle(
                fontSize: 15,
                color: isMine ? const Color(0xff989696) : Colors.blue,
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  void _call(String phone) async{
    var number = '+$phone';
    if(number.isNotEmpty){
      try{
        await FlutterPhoneDirectCaller.callNumber(number);
      }catch(e){
        await Fluttertoast.showToast(msg: 'هنالك خطأ $e');
      }
    }
  }

}
