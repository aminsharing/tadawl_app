import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';

class BuildLounges extends StatelessWidget {
  const BuildLounges({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).lounges,
              style: CustomTextStyle(

                fontSize: 10,
                color: const Color(0xff000000),
              ).getTextStyle(),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<MainPageProvider>(builder: (context, searchDrawer, child) {
              print("BuildLounges -> MainPageProvider");
              return ToggleButtons(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      '+3',
                      style: CustomTextStyle(

                        fontSize: 10,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      '+2',
                      style: CustomTextStyle(

                        fontSize: 10,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      '+1',
                      style: CustomTextStyle(

                        fontSize: 10,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      AppLocalizations.of(context).all,
                      style: CustomTextStyle(

                        fontSize: 10,
                      ).getTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                onPressed: (int index) {
                  searchDrawer.setLoungesSearchDrawer(index);
                },
                isSelected: searchDrawer.loungesSearchDrawer,
                color: const Color(0xff00cccc),
                selectedColor: const Color(0xffffffff),
                fillColor: const Color(0xff00cccc),
                borderColor: const Color(0xff00cccc),
                selectedBorderColor: const Color(0xff00cccc),
                borderWidth: 1,
              );
            }),
          ],
        ),
      ),
    ]);
  }
}
