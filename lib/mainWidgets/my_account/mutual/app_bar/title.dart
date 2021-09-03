import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAccountTitle extends StatelessWidget {
  const MyAccountTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.myAccount,
      style: CustomTextStyle(
        fontSize: 20,
        color: const Color(0xffffffff),
      ).getTextStyle(),
      textAlign: TextAlign.center,
    );
  }
}
