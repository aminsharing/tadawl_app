import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';

class UserRegisteredDate extends StatelessWidget {
  const UserRegisteredDate({Key key, @required this.timeRegistered}) : super(key: key);
  final String timeRegistered;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              5, 0, 15, 0),
          child: Text(
            AppLocalizations.of(context)
                .registered,
            style: CustomTextStyle(
              fontSize: 15,
              color: const Color(0xff989696),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              15, 0, 15, 0),
          child: Text(
            DateFormat('yyyy-MM-dd').format(
                DateTime.parse(timeRegistered)),
            style: CustomTextStyle(
              fontSize: 15,
              color: const Color(0xff989696),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
