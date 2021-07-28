import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_1.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_10.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_11.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_12.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_13.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_14.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_15.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_16.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_17.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_18.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_19.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_2.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_20.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_21.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_3.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_4.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_5.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_6.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_7.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_8.dart';
import 'package:tadawl_app/mainWidgets/search_drawer/selected_category_9.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/menu_provider.dart';
import 'package:tadawl_app/provider/map_provider.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:tadawl_app/screens/ads/search_ads.dart';

class SearchDrawer extends StatefulWidget {
  SearchDrawer({
    Key key,
  }) : super(key: key);
  @override
  _SearchDrawerState createState() => _SearchDrawerState();
}

class _SearchDrawerState extends State<SearchDrawer> {
  // final GlobalKey<FormState> _searchDrawerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (context, searchDrawer, child) {

      print("SearchDrawer -> MainPageProvider");

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 75.0,
                decoration: BoxDecoration(
                  color: const Color(0xff00cccc),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff818181)),
                ),
              ),
              // top cyan bar .................................

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: SearchMapPlaceWidget(
                    language: 'ar',
                    hasClearButton: true,
                    iconColor: Color(0xff00cccc),
                    placeType: PlaceType.cities,
                    placeholder: AppLocalizations.of(context).currentMapLocation,
                    apiKey: 'AIzaSyAaY9NEnamyi3zfnKhAZXxjLml_5gf1G7g',
                    onSelected: (Place place) async {
                      Provider.of<MapProvider>(context, listen: false).getLocPer();
                      await Provider.of<MapProvider>(context, listen: false).getLoc();
                      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
                      var geolocation = await place.geolocation;
                      searchDrawer.setRegionPosition(CameraPosition(target: geolocation.coordinates, zoom: 15));
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    },
                  ),
                ),
              ),

              // choose location ..............................
              Padding(
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
                            // TODO Add Consumer to here
                            child: DropdownButton<String>(
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
                              items: Provider.of<LocaleProvider>(context, listen: false).locale.toString() != 'en_US'
                                  ?
                              searchDrawer.categories.map((Map map) {
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
                                    }).toList()
                                  :
                              searchDrawer.enCategories.map((Map map) {
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // choose category ..............................
              // TODO Add Consumer to here
              if (searchDrawer.selectedCategory == '0')
                Container()
              else if (searchDrawer.selectedCategory == '1')
                SelectedCategory1()
              else if (searchDrawer.selectedCategory == '2')
                SelectedCategory2()
              else if (searchDrawer.selectedCategory == '3')
                SelectedCategory3()
              else if (searchDrawer.selectedCategory == '4')
                SelectedCategory4()
              else if (searchDrawer.selectedCategory == '5')
                SelectedCategory5()
              else if (searchDrawer.selectedCategory == '6')
                SelectedCategory6()
              else if (searchDrawer.selectedCategory == '7')
                SelectedCategory7()
              else if (searchDrawer.selectedCategory == '8')
                SelectedCategory8()
              else if (searchDrawer.selectedCategory == '9')
                SelectedCategory9()
              else if (searchDrawer.selectedCategory == '10')
                SelectedCategory10()
              else if (searchDrawer.selectedCategory == '11')
                SelectedCategory11()
              else if (searchDrawer.selectedCategory == '12')
                SelectedCategory12()
              else if (searchDrawer.selectedCategory == '13')
                SelectedCategory13()
              else if (searchDrawer.selectedCategory == '14')
                SelectedCategory14()
              else if (searchDrawer.selectedCategory == '15')
                SelectedCategory15()
              else if (searchDrawer.selectedCategory == '16')
                SelectedCategory16()
              else if (searchDrawer.selectedCategory == '17')
                SelectedCategory17()
              else if (searchDrawer.selectedCategory == '18')
                SelectedCategory18()
              else if (searchDrawer.selectedCategory == '19')
                SelectedCategory19()
              else if (searchDrawer.selectedCategory == '20')
                SelectedCategory20()
              else if (searchDrawer.selectedCategory == '21')
                SelectedCategory21(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                // TODO Add Consumer to here
                child: searchDrawer.waitMainPage == true
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
                          Provider.of<MenuProvider>(context, listen: false)
                          .setFilterSearchDrawer(4);
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
                                      ? Center(
                                          child: Text(
                                            ' ${AppLocalizations.of(context).search}  ${Provider.of<MenuProvider>(context, listen: false).countMenuAds()}  ${AppLocalizations.of(context).advertisement}  ',
                                            style: CustomTextStyle(

                                              fontSize: 12,
                                              color: const Color(0xff00cccc),
                                            ).getTextStyle(),
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              // search button ................................
              Padding(
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
                    // TODO Add Consumer to here
                    FlutterSwitch(
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
                        if (searchDrawer.isTwoWeeksAgoSearchDrawer == true) {
                          Provider.of<MenuProvider>(context, listen: false)
                          .setFilterSearchDrawer(2);
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
                        } else if (searchDrawer.isTwoWeeksAgoSearchDrawer ==
                            false) {

                          Provider.of<MenuProvider>(context, listen: false)
                              .setFilterSearchDrawer(null);
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
                        }
                      },
                    ),
                  ],
                ),
              ),
              // two weeks ago switch .........................
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchAds()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff3f9d28)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context).speedSearch,
                            style: CustomTextStyle(

                              fontSize: 17,
                              color: const Color(0xff3f9d28),
                            ).getTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xff3f9d28),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // quick search button ..........................
            ],
          ),
        ),
      );
    });
  }
}
