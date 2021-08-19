import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/ads_price_screen.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';

import 'ads_details_screen/sliders/age_of_real_estate.dart';
import 'ads_details_screen/sliders/apartments.dart';
import 'ads_details_screen/comm_housing.dart';
import 'ads_details_screen/family_or_single.dart';
import 'ads_details_screen/sliders/floor.dart';
import 'ads_details_screen/interface.dart';
import 'ads_details_screen/sliders/lounges.dart';
import 'ads_details_screen/plan.dart';
import 'ads_details_screen/sliders/rooms.dart';
import 'ads_details_screen/sliders/stores.dart';
import 'ads_details_screen/sliders/street_width.dart';
import 'ads_details_screen/sliders/toilets.dart';
import 'ads_details_screen/sliders/trees.dart';
import 'ads_details_screen/sliders/wells.dart';
import 'ads_details_screen/switchers/appendix.dart';
import 'ads_details_screen/switchers/car_entrance.dart';
import 'ads_details_screen/switchers/cellar.dart';
import 'ads_details_screen/switchers/amusement_park.dart';
import 'ads_details_screen/switchers/conditioner.dart';
import 'ads_details_screen/switchers/driver_room.dart';
import 'ads_details_screen/switchers/duplex.dart';
import 'ads_details_screen/switchers/elevator.dart';
import 'ads_details_screen/switchers/family_partition.dart';
import 'ads_details_screen/switchers/football_court.dart';
import 'ads_details_screen/switchers/furnished.dart';
import 'ads_details_screen/switchers/hall_staircase.dart';
import 'ads_details_screen/switchers/kitchen.dart';
import 'ads_details_screen/switchers/maid_room.dart';
import 'ads_details_screen/switchers/swimming_pool.dart';
import 'ads_details_screen/switchers/verse.dart';
import 'ads_details_screen/switchers/volleyball_court.dart';
import 'ads_details_screen/switchers/yard.dart';


class AdsDetailsScreen extends StatelessWidget {
  const AdsDetailsScreen(this.addAdProvider ,{Key key}) : super(key: key);
  final AddAdProvider addAdProvider;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    Future<bool> _onInterfaceCheck() {
      return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              content: Text(
                AppLocalizations
                    .of(context)
                    .reqInterface,
                style: CustomTextStyle(

                  fontSize: 17,
                  color: const Color(0xff000000),
                ).getTextStyle(),
                textAlign: TextAlign.right,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text(
                      AppLocalizations
                          .of(context)
                          .accept,
                      style: CustomTextStyle(

                        fontSize: 17,
                        color: const Color(0xff00cccc),
                      ).getTextStyle(),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
      ) ??
          false;
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: const Color(0xff00cccc),
        title: Center(
          widthFactor: 1.3,
          child: Text(
            AppLocalizations
                .of(context)
                .addAdsDetails,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
        leadingWidth: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<AddAdProvider>(builder: (context, addAds, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (addAds.id_category_finalAddAds != null)
                Column(
                  children: [
                    ...getPage()[addAds.id_category_finalAddAds]
                  ],
                ),
              TextButton(
                onPressed: () {
                  if (
                  (addAds.id_category_finalAddAds == 1 ||
                      addAds.id_category_finalAddAds == 2 ||
                      addAds.id_category_finalAddAds == 3 ||
                      addAds.id_category_finalAddAds == 4 ||
                      addAds.id_category_finalAddAds == 5 ||
                      addAds.id_category_finalAddAds == 7 ||
                      addAds.id_category_finalAddAds == 8 ||
                      addAds.id_category_finalAddAds == 9 ||
                      addAds.id_category_finalAddAds == 10 ||
                      addAds.id_category_finalAddAds == 11 ||
                      addAds.id_category_finalAddAds == 15 ||
                      addAds.id_category_finalAddAds == 16 ||
                      addAds.id_category_finalAddAds == 18 ||
                      addAds.id_category_finalAddAds == 19 ||
                      addAds.id_category_finalAddAds == 21)
                      &&
                      (addAds.interfaceSelectedAddAds == null ||
                          addAds.interfaceSelectedAddAds == '0')) {
                    _onInterfaceCheck();
                  } else {
                    // addAds.setCurrentStageAddAds(6);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ChangeNotifierProvider<AddAdProvider>.value(
                      value: addAdProvider,
                      child: AdsPriceScreen(addAdProvider),
                    )
                    ));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                  child: Container(
                    width: mediaQuery.size.width * 0.6,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff3f9d28)),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations
                            .of(context)
                            .continuee,
                        style: CustomTextStyle(

                          fontSize: 15,
                          color: const Color(0xff3f9d28),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Map<int, List<dynamic>> getPage(){

    var typeOf = <int, List<dynamic>>{
      1:[
        Interface(),
        Lounges(),
        Toilets(),
        StreetWidth(),
        Rooms(),
        Apartments(),
        AgeOfRealEstate(),

        HallStaircase(),
        DriverRoom(),
        MaidRoom(),
        SwimmingPool(),
        Furnished(),
        Verse(),
        Yard(),
        Kitchen(),
        Appendix(),
        CarEntrance(),
        Cellar(),
        Elevator(),
        Duplex(),
      ],
      2: [
        Interface(),
        CommHousing(),
        StreetWidth(),
      ],
      3: [
        Interface(),
        CommHousing(),
        StreetWidth(),
        Apartments(),

        Stores(),
        Rooms(),

        Furnished(),
      ],
      4: [
        Interface(),
        Lounges(),
        Toilets(),
        StreetWidth(),
        Rooms(),
        Apartments(),
        AgeOfRealEstate(),

        DriverRoom(),
        MaidRoom(),
        Furnished(),
        Verse(),
        Yard(),
        Kitchen(),
        Appendix(),
        CarEntrance(),
      ],
      5: [
        Interface(),
        Lounges(),
        Toilets(),
        StreetWidth(),
        Rooms(),
        AgeOfRealEstate(),

        SwimmingPool(),
        FootballCourt(),
        VolleyballCourt(),
        Verse(),
        AmusementPark(),
        FamilyPartition(),
      ],
      6: [
        Trees(),
        Wells(),

        Verse(),
      ],
      7: [
        Interface(),
        StreetWidth(),
        AgeOfRealEstate(),
      ],
      8: [
        Interface(),
        Lounges(),
        Toilets(),
        StreetWidth(),
        Rooms(),
        Floor(),
        AgeOfRealEstate(),

        Furnished(),
        Kitchen(),
        Appendix(),
        CarEntrance(),
        Elevator(),
      ],
      9: [
        Interface(),
        Lounges(),
        Toilets(),
        StreetWidth(),
        Rooms(),
        Apartments(),
        AgeOfRealEstate(),

        HallStaircase(),
        DriverRoom(),
        MaidRoom(),
        SwimmingPool(),
        Furnished(),
        Verse(),
        Yard(),
        Kitchen(),
        Appendix(),
        CarEntrance(),
        Cellar(),
        Elevator(),
        Duplex(),
        Conditioner(),
      ],
      10: [
        Interface(),
        CommHousing(),
        StreetWidth(),
      ],
      11: [
        Interface(),
        CommHousing(),
        StreetWidth(),
        Apartments(),
        AgeOfRealEstate(),
        Stores(),
        Rooms(),

        Furnished(),
      ],
      12: [
        Plan(),
        Lounges(),
        Toilets(),
        Rooms(),

        SwimmingPool(),
        FootballCourt(),
        VolleyballCourt(),
        Verse(),
        AmusementPark(),
        FamilyPartition(),
      ],
      13: [
        Trees(),
        Wells(),
      ],
      14: [
        FamilyORSingle(),
        Plan(),

        Lounges(),
        Toilets(),
        Rooms(),
        Floor(),
        AgeOfRealEstate(),

        Furnished(),
        Kitchen(),
        Appendix(),
        CarEntrance(),
        Elevator(),
        Conditioner(),
      ],
      15: [
        Interface(),
        Lounges(),
        Toilets(),
        Rooms(),
        Floor(),
        AgeOfRealEstate(),

        Furnished(),
        CarEntrance(),
        Conditioner(),
      ],
      16: [
        Interface(),
        StreetWidth(),
        AgeOfRealEstate(),

        Furnished(),
      ],
      17: [
        Plan(),

        AgeOfRealEstate(),

        Furnished(),
        Kitchen(),
      ],
      18: [
        Interface(),
        StreetWidth(),
        AgeOfRealEstate(),
      ],
      19: [
        Interface(),
        StreetWidth(),
        AgeOfRealEstate(),
      ],
      20: [
        Plan(),
        FamilyPartition(),
      ],
      21: [
        Interface(),
        StreetWidth(),
        AgeOfRealEstate(),
      ]
    };
    return typeOf;
  }
}
