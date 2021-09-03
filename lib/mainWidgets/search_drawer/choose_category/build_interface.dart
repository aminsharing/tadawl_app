import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/constans.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class BuildInterface extends StatelessWidget {
  const BuildInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.interface,
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
                    child: Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
                      return DropdownButton<String>(
                        hint: Text(
                          AppLocalizations.of(context)!.interface,
                          style: CustomTextStyle(

                            fontSize: 15,
                            color: const Color(0xff989696),
                          ).getTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        value:
                        searchDrawer.interfaceSelectedSearchDrawer ?? '0',
                        onChanged: (String? newValue) {
                          searchDrawer
                              .setInterfaceSelectedSearchDrawer(newValue);
                        },
                        items:
                        (Provider.of<LocaleProvider>(context, listen: false).locale.toString() != 'en_US'
                            ?
                        InterfaceCons
                            :
                        EnInterfaceCons
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
