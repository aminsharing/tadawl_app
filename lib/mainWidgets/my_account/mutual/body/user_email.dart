import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class UserEmail extends StatelessWidget {
  const UserEmail({
    Key? key,
    required this.userEmail,
    required this.isMine,
  }) : super(key: key);
  final String? userEmail;
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
              AppLocalizations.of(context)!.email,
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
            onTap: isMine ? null : () => _lunchEmail(userEmail??''),
            child: Text(
              userEmail??'',
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

  void _lunchEmail(String email)async{
    if(email.isNotEmpty){
      // ignore: omit_local_variable_types
      final Uri _emailLaunchUri = Uri(
          scheme: 'mailto',
          path: email,
          queryParameters: {'subject': 'تطبيق تداول العقاري'});

      try{
        await launch(_emailLaunchUri.toString());
      }catch(e){
        await Fluttertoast.showToast(msg: 'هنالك خطأ $e');
      }
    }
  }
}
