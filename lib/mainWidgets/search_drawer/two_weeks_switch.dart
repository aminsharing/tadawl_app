import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';

class TwoWeeksSwitch extends StatelessWidget {
  const TwoWeeksSwitch({Key key}) : super(key: key);

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
              AppLocalizations.of(context).twoWeeksAgoAds,
              style: CustomTextStyle(
                fontSize: 15,
                color: const Color(0xff818181),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          Consumer<MainPageProvider>(builder: (context, searchDrawer, child) {
            return FlutterSwitch(
              activeColor: const Color(0xff00cccc),
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
                Provider.of<MenuProvider>(context, listen: false)
                    .setFilterSearchDrawer(searchDrawer.isTwoWeeksAgoSearchDrawer ? 2 : null);
                Provider.of<MenuProvider>(context, listen: false)
                    .getAdsInfo(
                  context,
                  searchDrawer.idCategorySearch,
                  searchDrawer.selectedCategory,
                  searchDrawer.minPriceSearchDrawer,
                  searchDrawer.maxPriceSearchDrawer,
                  searchDrawer.minSpaceSearchDrawer,
                  searchDrawer.maxSpaceSearchDrawer,
                  searchDrawer.selectedTypeAqarSearchDrawer,
                  searchDrawer.interfaceSelectedSearchDrawer,
                  searchDrawer.selectedPlanSearchDrawer,
                  searchDrawer.ageOfRealEstateSelectedSearchDrawer,
                  searchDrawer.selectedApartmentsSearchDrawer,
                  searchDrawer.floorSelectedSearchDrawer,
                  searchDrawer.selectedLoungesSearchDrawer,
                  searchDrawer.selectedRoomsSearchDrawer,
                  searchDrawer.storesSelectedSearchDrawer,
                  searchDrawer.streetWidthSelectedSearchDrawer,
                  searchDrawer.selectedToiletsSearchDrawer,
                  searchDrawer.treesSelectedSearchDrawer,
                  searchDrawer.wellsSelectedSearchDrawer,
                  searchDrawer.bool_feature1SearchDrawer.toString(),
                  searchDrawer.bool_feature2SearchDrawer.toString(),
                  searchDrawer.bool_feature3SearchDrawer.toString(),
                  searchDrawer.bool_feature4SearchDrawer.toString(),
                  searchDrawer.bool_feature5SearchDrawer.toString(),
                  searchDrawer.bool_feature6SearchDrawer.toString(),
                  searchDrawer.bool_feature7SearchDrawer.toString(),
                  searchDrawer.bool_feature8SearchDrawer.toString(),
                  searchDrawer.bool_feature9SearchDrawer.toString(),
                  searchDrawer.bool_feature10SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature11SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature12SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature13SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature14SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature15SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature16SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature17SearchDrawer
                      .toString(),
                  searchDrawer.bool_feature18SearchDrawer
                      .toString(),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
