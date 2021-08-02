import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CertifiedOffice extends StatelessWidget {
  const CertifiedOffice({Key key, @required this.state}) : super(key: key);
  final String state;


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Column(
        children: [
          if (state == '1')
            Container(
              width: mediaQuery.size.width * 0.5,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: const Color(0xff3f9d28), width: 1),
                color: const Color(0xff3f9d28),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).certifiedOffice,
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xffffffff),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Icon(
                      Icons.verified,
                      color: Color(0xffffffff),
                      size: 40,
                    ),
                  ),
                ],
              ),
            )
          else if (state == '0')
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(
                AppLocalizations.of(context).certifiedOfficeAwait,
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
