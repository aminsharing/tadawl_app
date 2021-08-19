import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpaceTable extends StatelessWidget {
  const SpaceTable({
    Key key,
    @required this.adsPage,
  }) : super(key: key);
  final AdsModel adsPage;



  @override
  Widget build(BuildContext context) {
    final interfaces = <String>[
      AppLocalizations.of(context).north,
      AppLocalizations.of(context).east,
      AppLocalizations.of(context).west,
      AppLocalizations.of(context).south,
      AppLocalizations.of(context).northeast,
      AppLocalizations.of(context).southeast,
      AppLocalizations.of(context).southwest,
      AppLocalizations.of(context).northwest,
      AppLocalizations.of(context).threeRoads,
      AppLocalizations.of(context).fourRoads,
    ];

    return Table(
      border: TableBorder.all(
          color: Color(0xffffffff), width: 2),
      defaultVerticalAlignment:
      TableCellVerticalAlignment.middle,
      defaultColumnWidth: FractionColumnWidth(0.5),
      children: [
        if (adsPage.idTypeAqar != '0' &&
            adsPage.idTypeAqar != '-1' &&
            adsPage.idTypeAqar != 'null')
          TableRow(
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
            ),
            children: [
              Padding(
                padding:
                const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  AppLocalizations.of(context).aqarType,
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
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0, 5, 5, 5),
                      child: Text(
                        adsPage.idTypeAqar == '1'?
                        AppLocalizations.of(context).commHousing:
                        adsPage.idTypeAqar == '2'?
                        AppLocalizations.of(context).commercial:
                        adsPage.idTypeAqar == '3'?
                        AppLocalizations.of(context).housing:'',
                        style: CustomTextStyle(
                          fontSize: 15,
                          color:
                          const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (
            adsPage.idInterface != '12' &&
            adsPage.idInterface != '0' &&
            adsPage.idInterface != '1' &&
            adsPage.idInterface != 'null')
          TableRow(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            children: [
              Padding(
                padding:
                const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  AppLocalizations.of(context).interface,
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff989696),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                      child: Text(
                        interfaces[int.tryParse(adsPage.idInterface)-2],
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (adsPage.space != 'null')
          TableRow(
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
            ),
            children: [
              Padding(
                padding:
                const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  AppLocalizations.of(context).space,
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
                      adsPage.space ?? '',
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Text(
                        AppLocalizations.of(context).m2,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}