import 'package:flutter/material.dart';

import 'build_commercial_housing.dart';
import 'build_interface.dart';
import 'build_price.dart';
import 'build_space.dart';
import 'build_street_width.dart';

class SelectedCategory2 extends StatelessWidget {
  const SelectedCategory2({Key? key}) : super(key: key);

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
      ],
    );
  }
}
