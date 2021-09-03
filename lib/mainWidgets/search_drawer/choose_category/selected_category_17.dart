import 'package:flutter/material.dart';

import 'build_age_of_real_estate.dart';
import 'build_furnished.dart';
import 'build_kitchen.dart';
import 'build_plan.dart';
import 'build_price.dart';
import 'build_space.dart';

class SelectedCategory17 extends StatelessWidget {
  const SelectedCategory17({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuildPrice(),
        BuildSpace(),
        BuildPlan(),
        BuildAgeOfRealEstate(),
        BuildFurnished(),
        BuildKitchen(),
      ],
    );
  }
}
