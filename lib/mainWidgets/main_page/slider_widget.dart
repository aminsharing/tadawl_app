import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({Key key, this.mainPage}) : super(key: key);

  final MainPageProvider mainPage;


  @override
  Widget build(BuildContext context) {
    var _lang = Provider.of<LocaleProvider>(context, listen: false).locale.toString();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Row(
        mainAxisAlignment: _lang != 'en_US'
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (mainPage.slider_state == 0)
            Container(
              width: 80.0,
              height: MediaQuery.of(context).size.height * 0.064,
              decoration: BoxDecoration(
                boxShadow: [],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: const Color(0xff00cccc),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        mainPage.setSliderState(1);
                      },
                      child: Icon(
                          _lang != 'en_US'
                              ? Icons.arrow_back_ios_rounded
                              : Icons.arrow_forward_ios_rounded,
                          color: Color(0xff1f2835),
                          size: 30),
                    ),
                  ],
                ),
              ),
            )
          else if (mainPage.slider_state == 1)
            Container(
              width: 100.0,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                boxShadow: [],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: const Color(0xff1f2835),
              ),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      mainPage.setSliderState(0);
                    },
                    child: Icon(
                        _lang != 'en_US'
                            ? Icons.arrow_forward_ios_rounded
                            : Icons.arrow_back_ios_rounded,
                        color: Color(0xff00cccc),
                        size: 30),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        width: 100.0,
                        height:
                        MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.0,
                              height:
                              MediaQuery.of(context).size.height *
                                  0.73,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                color: const Color(0x00000000),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    if (_lang != 'en_US')
                                      Column(
                                        children: [
                                          for (var i = 0; i < mainPage.categories.length; i++)
                                            TextButton(
                                              onPressed: () {

                                                mainPage.setIdCategorySearch(mainPage.categories[i]['id_category']);
                                                Provider.of<MenuProvider>(context,listen: false)
                                                    .setFilterSearchDrawer(1);
                                                Provider.of<MenuProvider>(context,listen: false)
                                                    .setMenuMainFilterAds(2);
                                                Provider.of<MenuProvider>(context,listen: false)
                                                    .getAdsInfo(context,
                                                    mainPage.idCategorySearch,
                                                    mainPage.selectedCategory,
                                                    mainPage.minPriceSearchDrawer,
                                                    mainPage.maxPriceSearchDrawer,
                                                    mainPage.minSpaceSearchDrawer,
                                                    mainPage.maxSpaceSearchDrawer,
                                                    mainPage.selectedTypeAqarSearchDrawer,
                                                    mainPage.interfaceSelectedSearchDrawer,
                                                    mainPage.selectedPlanSearchDrawer,
                                                    mainPage.ageOfRealEstateSelectedSearchDrawer,
                                                    mainPage.selectedApartmentsSearchDrawer,
                                                    mainPage.floorSelectedSearchDrawer,
                                                    mainPage.selectedLoungesSearchDrawer,
                                                    mainPage.selectedRoomsSearchDrawer,
                                                    mainPage.storesSelectedSearchDrawer,
                                                    mainPage.streetWidthSelectedSearchDrawer,
                                                    mainPage.selectedToiletsSearchDrawer,
                                                    mainPage.treesSelectedSearchDrawer,
                                                    mainPage.wellsSelectedSearchDrawer,
                                                    mainPage.bool_feature1SearchDrawer.toString(),
                                                    mainPage.bool_feature2SearchDrawer.toString(),
                                                    mainPage.bool_feature3SearchDrawer.toString(),
                                                    mainPage.bool_feature4SearchDrawer.toString(),
                                                    mainPage.bool_feature5SearchDrawer.toString(),
                                                    mainPage.bool_feature6SearchDrawer.toString(),
                                                    mainPage.bool_feature7SearchDrawer.toString(),
                                                    mainPage.bool_feature8SearchDrawer.toString(),
                                                    mainPage.bool_feature9SearchDrawer.toString(),
                                                    mainPage.bool_feature10SearchDrawer.toString(),
                                                    mainPage.bool_feature11SearchDrawer.toString(),
                                                    mainPage.bool_feature12SearchDrawer.toString(),
                                                    mainPage.bool_feature13SearchDrawer.toString(),
                                                    mainPage.bool_feature14SearchDrawer.toString(),
                                                    mainPage.bool_feature15SearchDrawer.toString(),
                                                    mainPage.bool_feature16SearchDrawer.toString(),
                                                    mainPage.bool_feature17SearchDrawer.toString(),
                                                    mainPage.bool_feature18SearchDrawer.toString(),
                                                    showOnMap: true
                                                );
                                                if(mainPage.showDiaogSearchDrawer){
                                                  mainPage.setShowDiogFalse();
                                                }
                                              },
                                              child: Text(
                                                mainPage.categories[i]
                                                ['name'],
                                                style: CustomTextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: const Color(
                                                      0xffffffff),
                                                ).getTextStyle(),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                        ],
                                      )
                                    else
                                      for (var i = 0; i < mainPage.enCategories.length; i++)
                                        Column(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                mainPage.setIdCategorySearch(
                                                    mainPage.enCategories[i]['id_category']);
                                                Provider.of<MenuProvider>(context,listen: false)
                                                    .setFilterSearchDrawer(1);
                                                Provider.of<MenuProvider>(context,listen: false)
                                                    .setMenuMainFilterAds(2);
                                                Provider.of<MenuProvider>(context,listen: false)
                                                    .getAdsInfo(
                                                    context,
                                                    mainPage.idCategorySearch,
                                                    mainPage
                                                        .selectedCategory,
                                                    mainPage
                                                        .minPriceSearchDrawer,
                                                    mainPage
                                                        .maxPriceSearchDrawer,
                                                    mainPage
                                                        .minSpaceSearchDrawer,
                                                    mainPage
                                                        .maxSpaceSearchDrawer,
                                                    mainPage
                                                        .selectedTypeAqarSearchDrawer,
                                                    mainPage
                                                        .interfaceSelectedSearchDrawer,
                                                    mainPage
                                                        .selectedPlanSearchDrawer,
                                                    mainPage
                                                        .ageOfRealEstateSelectedSearchDrawer,
                                                    mainPage
                                                        .selectedApartmentsSearchDrawer,
                                                    mainPage
                                                        .floorSelectedSearchDrawer,
                                                    mainPage
                                                        .selectedLoungesSearchDrawer,
                                                    mainPage
                                                        .selectedRoomsSearchDrawer,
                                                    mainPage
                                                        .storesSelectedSearchDrawer,
                                                    mainPage
                                                        .streetWidthSelectedSearchDrawer,
                                                    mainPage
                                                        .selectedToiletsSearchDrawer,
                                                    mainPage
                                                        .treesSelectedSearchDrawer,
                                                    mainPage
                                                        .wellsSelectedSearchDrawer,
                                                    mainPage
                                                        .bool_feature1SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature2SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature3SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature4SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature5SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature6SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature7SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature8SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature9SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature10SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature11SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature12SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature13SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature14SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature15SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature16SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature17SearchDrawer
                                                        .toString(),
                                                    mainPage
                                                        .bool_feature18SearchDrawer
                                                        .toString(),
                                                    showOnMap: true
                                                );
                                                if(mainPage.showDiaogSearchDrawer){
                                                  mainPage.setShowDiogFalse();
                                                }
                                              },
                                              child: Text(
                                                mainPage.enCategories[
                                                i]['name'],
                                                style: CustomTextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 13,
                                                  color: const Color(
                                                      0xffffffff),
                                                ).getTextStyle(),
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
