import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class BuildWells extends StatelessWidget {
  const BuildWells({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).wells,
              style: CustomTextStyle(

                fontSize: 10,
                color: const Color(0xff000000),
              ).getTextStyle(),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: Consumer<MainPageProvider>(builder: (context, searchDrawer, child) {
                      print("BuildWells -> MainPageProvider");
                      return DropdownButton<String>(
                        hint: Text(
                          AppLocalizations.of(context).wells,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        value: searchDrawer.wellsSelectedSearchDrawer ?? '0',
                        onChanged: (String newValue) {
                          searchDrawer.setWellsSearchDrawer(newValue);
                        },
                        items:
                        (Provider.of<LocaleProvider>(context, listen: false).locale.toString() != 'en_US'
                            ?
                        searchDrawer.Wells
                            :
                        searchDrawer.EnWells
                        ).map((Map map) {
                          return DropdownMenuItem<String>(
                            value: map['id_type'].toString(),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    map['type'],
                                    style: CustomTextStyle(

                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
