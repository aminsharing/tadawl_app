import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdTimestampWidget extends StatelessWidget {
  AdTimestampWidget({Key key, this.timeAdded}) : super(key: key);

  final String timeAdded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              AppLocalizations.of(context).advPosted,
              style: CustomTextStyle(

                fontSize: 15,
                color: const Color(0xff989696),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                Jiffy(DateTime.parse(timeAdded ?? '').add(Duration(hours: 3)))
                    .fromNow(),
                style: CustomTextStyle(

                  fontSize: 15,
                  color: const Color(0xff989696),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
