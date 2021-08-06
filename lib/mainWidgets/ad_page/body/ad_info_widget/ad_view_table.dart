import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdViewTable extends StatelessWidget {
  const AdViewTable({
    Key key,
    @required this.views,
    @required this.idDescription,
  }) : super(key: key);
  final String views;
  final String idDescription;


  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
          color: Color(0xffffffff), width: 2),
      defaultVerticalAlignment:
      TableCellVerticalAlignment.middle,
      defaultColumnWidth: FractionColumnWidth(0.5),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Color(0xfff2f2f2),
          ),
          children: [
            Padding(
              padding:
              const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                AppLocalizations.of(context).views,
                style: CustomTextStyle(
                  fontSize: 15,
                  color: const Color(0xff989696),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    views ?? '',
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
// views score ............................
        TableRow(
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          children: [
            Padding(
              padding:
              const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                AppLocalizations.of(context).advID,
                style: CustomTextStyle(
                  fontSize: 15,
                  color: const Color(0xff989696),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    idDescription ?? '',
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
// ads number ........................
      ],
    );
  }
}
