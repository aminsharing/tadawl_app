import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/search_on_map.dart';
import 'package:tadawl_app/provider/ads_provider/search_drawer_provider.dart';

class TwoWeeksSwitch extends StatelessWidget {
  const TwoWeeksSwitch({
    Key? key,
    required this.selectedPage
  }) : super(key: key);
  final SelectedPage selectedPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              AppLocalizations.of(context)!.twoWeeksAgoAds,
              style: CustomTextStyle(
                fontSize: 15,
                color: const Color(0xff818181),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          Consumer<SearchDrawerProvider>(builder: (context, searchDrawer, child) {
            return FlutterSwitch(
              activeColor: const Color(0xff04B404),
              width: 40.0,
              height: 20.0,
              valueFontSize: 15.0,
              toggleSize: 15.0,
              value: searchDrawer.isTwoWeeksAgoSearchDrawer,
              borderRadius: 15.0,
              padding: 2.0,
              showOnOff: false,
              onToggle: (val) {
                searchDrawer.setIsTwoWeekSearchDrawer(val);
                if(selectedPage == SelectedPage.mainPage){
                  if(val){
                    searchDrawer.setFilter(2);
                  }else{
                    searchDrawer.setFilter(null);
                  }
                  searchDrawer.getAdsList(context);
                }else if(selectedPage == SelectedPage.menu){
                  if(val){
                    searchDrawer.setMenuFilter(2);
                  }else{
                    searchDrawer.setMenuFilter(null);
                  }
                  searchDrawer.getMenuList(context);
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
