import 'package:flutter/material.dart';

import 'build_age_of_real_estate.dart';
import 'build_interface.dart';
import 'build_price.dart';
import 'build_space.dart';
import 'build_street_width.dart';

class SelectedCategory19 extends StatelessWidget {
  const SelectedCategory19({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuildPrice(),
        BuildSpace(),
        BuildInterface(),
        BuildStreetWidth(),
        BuildAgeOfRealEstate(),
      ],
    );
  }
}
