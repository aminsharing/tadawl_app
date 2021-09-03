import 'package:flutter/material.dart';
import 'build_amusement_park.dart';
import 'build_family_partition.dart';
import 'build_football_court.dart';
import 'build_kitchen.dart';
import 'build_lounges.dart';
import 'build_plan.dart';
import 'build_price.dart';
import 'build_rooms.dart';
import 'build_space.dart';
import 'build_swimming_pool.dart';
import 'build_toilets.dart';
import 'build_verse.dart';
import 'build_volleyball_court.dart';

class SelectedCategory12 extends StatelessWidget {
  const SelectedCategory12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuildPrice(),
        BuildSpace(),
        BuildPlan(),
        BuildLounges(),
        BuildToilets(),
        BuildRooms(),
        BuildSwimmingPool(),
        BuildFootballCourt(),
        BuildVolleyballCourt(),
        BuildVerse(),
        BuildKitchen(),
        BuildAmusementPark(),
        BuildFamilyPartition(),
      ],
    );
  }
}
