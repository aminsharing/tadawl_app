import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/constans.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
                    return DropdownButton<String>(
                      hint: Text(
                        AppLocalizations.of(context).chooseCategory,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                      value: searchDrawer.selectedCategory,
                      onChanged: (String newValue) {
                        if (newValue == '0') {
                          searchDrawer.setSelectedCategory(newValue);
                        } else {
                          searchDrawer.setSelectedCategory(newValue);
                        }
                      },
                      items:
                      (Provider.of<LocaleProvider>(context, listen: false).locale.toString() != 'en_US'
                          ?
                      categoriesCons()
                              :
                      enCategoriesCons()).map((Map map) {
                        return DropdownMenuItem<String>(
                          value: map['id_category'].toString(),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  map['name'],
                                  style: CustomTextStyle(
                                    fontSize: 15,
                                    color:
                                    const Color(0xff00cccc),
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
    );
  }
}
