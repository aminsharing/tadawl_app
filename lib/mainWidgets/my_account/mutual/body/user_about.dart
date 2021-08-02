import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAbout extends StatelessWidget {
  const UserAbout({Key key, @required this.about}) : super(key: key);
  final String about;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(
            AppLocalizations.of(context).aboutMe,
            style: CustomTextStyle(
              fontSize: 15,
              color: const Color(0xff000000),
            ).getTextStyle(),
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            width: mediaQuery.size.width - 40,
            child: Text(
              about ?? '',
              style: CustomTextStyle(
                fontSize: 13,
                color: const Color(0xff989696),
              ).getTextStyle(),
              //textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
