import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';

class UserLastSeen extends StatelessWidget {
  const UserLastSeen({Key? key, required this.lastSeen}) : super(key: key);
  final String lastSeen;

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
            AppLocalizations.of(context)!
                .lastSeen,
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
                lastSeen,
                style: CustomTextStyle(
                  fontSize: 13,
                  color:
                  const Color(0xff989696),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ))
      ],
    );
  }
}
