import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/QFModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class AdQFTable extends StatelessWidget {
  const AdQFTable({
    Key? key,
    required this.adsQF,
  }) : super(key: key);
  final List<QFModel> adsQF;

  @override
  Widget build(BuildContext context) {
    var _lang = Provider.of<LocaleProvider>(context, listen: false).locale.toString();

    return Table(
      border: TableBorder.all(
          color: Color(0xffffffff), width: 2),
      defaultVerticalAlignment:
      TableCellVerticalAlignment.middle,
      defaultColumnWidth: FractionColumnWidth(0.5),
      children: [
        for (var i = 0; i < adsQF.length; i++)
          if (adsQF[i].quantity != '0' &&
              adsQF[i].id_QFAT == '13')
            TableRow(
              decoration: BoxDecoration(
                color: i.isEven
                    ? Color(0xffffffff)
                    : Color(0xfff2f2f2),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Text(
                    _lang != 'en_US'
                        ? adsQF[i].title ?? ''
                        : adsQF[i].eng_title ?? '',
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        adsQF[i].quantity!,
                        style: CustomTextStyle(
                          fontSize: 13,
                          color:
                          const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        AppLocalizations.of(context)!.m,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color:
                          const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            )
          else if (adsQF[i].quantity != '-1')
            if (adsQF[i].quantity != '0' &&
                adsQF[i].id_QFAT == '11')
              TableRow(
                decoration: BoxDecoration(
                  color: i.isEven
                      ? Color(0xffffffff)
                      : Color(0xfff2f2f2),
                ),
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      _lang != 'en_US'
                          ? adsQF[i].title ?? ''
                          : adsQF[i].eng_title ?? '',
                      style: CustomTextStyle(
                        fontSize: 15,
                        color:
                        const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                        5, 5, 5, 5),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          adsQF[i].quantity!,
                          style: CustomTextStyle(
                            fontSize: 15,
                            color: const Color(
                                0xff989696),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          AppLocalizations.of(context)!.year,
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
              )
            else if (adsQF[i].quantity != '0' &&
                adsQF[i].id_QFAT == '10')
              TableRow(
                decoration: BoxDecoration(
                  color: i.isEven
                      ? Color(0xffffffff)
                      : Color(0xfff2f2f2),
                ),
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      _lang != 'en_US'
                          ? adsQF[i].title ?? ''
                          : adsQF[i].eng_title ?? '',
                      style: CustomTextStyle(
                        fontSize: 15,
                        color:
                        const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                        5, 5, 5, 5),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        if (adsQF[i].quantity == '1')
                          Text(
                            AppLocalizations.of(context)!.groundFloor,
                            style: CustomTextStyle(
                              fontSize: 15,
                              color: const Color(
                                  0xff989696),
                            ).getTextStyle(),
                            textAlign:
                            TextAlign.center,
                          )
                        else if (adsQF[i].quantity == '2')
                          Text(
                            AppLocalizations.of(context)!.first,
                            style:
                            CustomTextStyle(

                              fontSize: 15,
                              color: const Color(
                                  0xff989696),
                            ).getTextStyle(),
                            textAlign:
                            TextAlign.center,
                          )
                        else
                          Text(
                            adsQF[i].quantity!,
                            style:
                            CustomTextStyle(

                              fontSize: 15,
                              color: const Color(
                                  0xff989696),
                            ).getTextStyle(),
                            textAlign:
                            TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ],
              )
            else if (adsQF[i].quantity != '0')
                TableRow(
                  decoration: BoxDecoration(
                    color: i.isEven
                        ? Color(0xffffffff)
                        : Color(0xfff2f2f2),
                  ),
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(
                          5, 5, 5, 5),
                      child: Text(
                        _lang != 'en_US'
                            ? adsQF[i].title ?? ''
                            : adsQF[i].eng_title ?? '',
                        style: CustomTextStyle(
                          fontSize: 15,
                          color:
                          const Color(0xff989696),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(
                          5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            adsQF[i].quantity!,
                            style: CustomTextStyle(
                              fontSize: 15,
                              color: const Color(
                                  0xff989696),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
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