import 'package:flutter/material.dart';

import 'build_age_of_real_estate.dart';
import 'build_appendix.dart';
import 'build_car_entrance.dart';
import 'build_elevator.dart';
import 'build_floor.dart';
import 'build_furnished.dart';
import 'build_interface.dart';
import 'build_kitchen.dart';
import 'build_lounges.dart';
import 'build_price.dart';
import 'build_rooms.dart';
import 'build_space.dart';
import 'build_street_width.dart';
import 'build_toilets.dart';

class SelectedCategory8 extends StatelessWidget {
  const SelectedCategory8({Key key}) : super(key: key);

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
        BuildFloor(),
        BuildAgeOfRealEstate(),
        BuildFurnished(),
        BuildKitchen(),
        BuildAppendix(),
        BuildCarEntrance(),
        BuildElevator(),
      ],
    );
  }
}
