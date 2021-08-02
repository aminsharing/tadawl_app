import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      // TODO Add Consumer to here
      child: Consumer2<MainPageProvider, MenuProvider>(builder: (context, searchDrawer, menu, child) {
        print("SearchButton -> MainPageProvider");
        print("SearchButton -> MenuProvider");
        return menu.menuAds.isEmpty
            ?
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff00cccc),
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xff1f2835)),
              ),
            ),
          ),
        )
            :
        TextButton(
          onPressed: () {
            // _searchDrawerKey.currentState.save();
            menu
                .setFilterSearchDrawer(4);
            menu
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
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffffffff),
              border: Border.all(
                  width: 1.0, color: const Color(0xff00cccc)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        AppLocalizations.of(context).search,
                        style: CustomTextStyle(
                          fontSize: 20,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    searchDrawer.ads.isNotEmpty
                        ? 
                    Center(
                      child: Text(
                        ' ${AppLocalizations.of(context).search}  ${menu.countMenuAds()}  ${AppLocalizations.of(context).advertisement}  ',
                        style: CustomTextStyle(
                          fontSize: 12,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    )
                        : 
                    Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
