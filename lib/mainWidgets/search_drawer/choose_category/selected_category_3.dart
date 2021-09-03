import 'package:flutter/material.dart';

import 'build_age_of_real_estate.dart';
import 'build_apartements.dart';
import 'build_commercial_housing.dart';
import 'build_furnished.dart';
import 'build_interface.dart';
import 'build_price.dart';
import 'build_space.dart';
import 'build_stores.dart';
import 'build_street_width.dart';

class SelectedCategory3 extends StatelessWidget {
  const SelectedCategory3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuildCommercialHousing(),
        BuildPrice(),
        BuildSpace(),
        BuildInterface(),
        BuildStreetWidth(),
        BuildApartments(),
        BuildAgeOfRealEstate(),
        BuildStores(),
        BuildFurnished(),
      ],
    );
  }
}
