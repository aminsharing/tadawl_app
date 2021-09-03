import 'package:flutter/material.dart';

import 'build_age_of_real_estate.dart';
import 'build_appendix.dart';
import 'build_car_entrance.dart';
import 'build_driver_room.dart';
import 'build_furnished.dart';
import 'build_interface.dart';
import 'build_kitchen.dart';
import 'build_lounges.dart';
import 'build_maid_room.dart';
import 'build_price.dart';
import 'build_rooms.dart';
import 'build_space.dart';
import 'build_street_width.dart';
import 'build_toilets.dart';
import 'build_verse.dart';
import 'build_yard.dart';

class SelectedCategory4 extends StatelessWidget {
  const SelectedCategory4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuildPrice(),
        BuildSpace(),
        BuildInterface(),
        BuildLounges(),
        BuildToilets(),
        BuildStreetWidth(),
        BuildRooms(),
        BuildAgeOfRealEstate(),
        BuildDriverRoom(),
        BuildMaidRoom(),
        BuildFurnished(),
        BuildVerse(),
        BuildYard(),
        BuildKitchen(),
        BuildAppendix(),
        BuildCarEntrance(),
      ],
    );
  }
}
