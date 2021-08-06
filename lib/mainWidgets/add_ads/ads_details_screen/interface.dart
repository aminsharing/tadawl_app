import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/constans.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class Interface extends StatelessWidget {
  const Interface({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mutualProv = Provider.of<MutualProvider>(context, listen: false);
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();
    return Padding(
      padding:
      const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                20, 10, 20, 0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).interface,
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff000000),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.grey),
                borderRadius:
                BorderRadius.circular(0)),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: Consumer<AddAdProvider>(builder: (context, addAd, _) {
                  print("Interface -> AddAdProvider");
                  return DropdownButton<String>(
                    hint: Text(
                      AppLocalizations.of(context).interface,
                      style: CustomTextStyle(
                        fontSize: 15,
                        color: const Color(0xff989696),
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    value: addAd.interfaceSelectedAddAds ?? (int.tryParse(mutualProv.adsPage.first.idInterface)?? '1').toString(),
                    onChanged: (String newValue) {
                      addAd.setInterfaceSelectedAddAds(newValue);
                    },
                    items: (_lang != 'en_US'?InterfaceCons:EnInterfaceCons).map(
                            (Map map) {
                          return DropdownMenuItem<
                              String>(
                            value: map['id_type'].toString(),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  //margin: EdgeInsets.only(left: 10),
                                  //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    map['type'],
                                    style: CustomTextStyle(
                                      fontSize: 15,
                                      color: const Color(0xff989696),
                                    ).getTextStyle(),
                                    textAlign:
                                    TextAlign
                                        .center,
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
    );
  }
}
