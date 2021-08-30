import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/update_details/stage_2.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'stage_1/sliders/age_of_real_estate.dart';
import 'stage_1/switchers/amusement_park.dart';
import 'stage_1/sliders/apartments.dart';
import 'stage_1/switchers/appendix.dart';
import 'stage_1/switchers/car_entrance.dart';
import 'stage_1/switchers/cellar.dart';
import 'stage_1/comm_housing.dart';
import 'stage_1/switchers/conditioner.dart';
import 'stage_1/switchers/driver_room.dart';
import 'stage_1/switchers/duplex.dart';
import 'stage_1/switchers/elevator.dart';
import 'stage_1/family_or_single.dart';
import 'stage_1/switchers/family_partition.dart';
import 'stage_1/sliders/floor.dart';
import 'stage_1/switchers/football_court.dart';
import 'stage_1/switchers/furnished.dart';
import 'stage_1/switchers/hall_staircase.dart';
import 'stage_1/interface.dart';
import 'stage_1/switchers/kitchen.dart';
import 'stage_1/sliders/lounges.dart';
import 'stage_1/switchers/maid_room.dart';
import 'stage_1/plan.dart';
import 'stage_1/sliders/rooms.dart';
import 'stage_1/sliders/stores.dart';
import 'stage_1/sliders/street_width.dart';
import 'stage_1/switchers/swimming_pool.dart';
import 'stage_1/sliders/toilets.dart';
import 'stage_1/sliders/trees.dart';
import 'stage_1/switchers/verse.dart';
import 'stage_1/switchers/volleyball_court.dart';
import 'stage_1/sliders/wells.dart';
import 'stage_1/switchers/yard.dart';

class Stage1 extends StatelessWidget {
  const Stage1(this._id_description, {Key key, @required this.updateDetailsProvider}) : super(key: key);
  final String _id_description;
  final UpdateDetailsProvider updateDetailsProvider;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: const Color(0xff1f2835),
        leadingWidth: 70,
        title: Text(
          AppLocalizations.of(context)
              .updateDetails,
          style: CustomTextStyle(

            fontSize: 20,
            color: const Color(0xffffffff),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 40,
          ),
          onPressed: () {
            // updateDetails
            //     .setCurrentStageUpdateDetails(
            //     null);
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
//...............................
            Consumer<UpdateDetailsProvider>(builder: (context, updateDetails, _){
              if (updateDetails.id_category_finalUpdate != null){
                return Column(
                  children: [
                    ...getPage()[updateDetails.id_category_finalUpdate]
                  ],
                );
              }else{
                return Container();
              }
            }),
//........end switches...........
//...............................
            TextButton(
              onPressed: () {
                // if (!_updateAdsKey.currentState.validate()) {
                //   return;
                // }
                // _updateAdsKey.currentState.save();
                // updateDetails.setCurrentStageUpdateDetails(2);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ChangeNotifierProvider<UpdateDetailsProvider>.value(
                  value: updateDetailsProvider,
                  child: Stage2(_id_description, updateDetailsProvider: updateDetailsProvider),
                )
                ));
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
                      AppLocalizations.of(context).continuee,
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
        ),
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


