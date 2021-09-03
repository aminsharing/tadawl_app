import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/BFModel.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class AdBFTable extends StatelessWidget {
  const AdBFTable({
    Key? key,
    required this.adsBF,
  }) : super(key: key);
  final List<BFModel> adsBF;

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
        for (var i = 0; i < adsBF.length; i++)
          if (adsBF[i].state == 'true')
            TableRow(
              decoration: BoxDecoration(
                color: i.isOdd
                    ? Color(0xffffffff)
                    : Color(0xfff2f2f2),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5, 5, 5, 5),
                  child: Text(
                    _lang != 'en_US'
                        ? adsBF[i].title ?? ''
                        : adsBF[i].eng_title ??
                        '',
                    style: CustomTextStyle(

                      fontSize: 15,
                      color: const Color(0xff989696),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5, 0, 5, 0),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                        5, 0, 5, 0),
                    child: Icon(
                      Icons.done_rounded,
                      color: Color(0xff00cccc),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
// boolean features ads ..............
      ],
    );
  }
}