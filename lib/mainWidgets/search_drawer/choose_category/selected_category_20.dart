import 'package:flutter/material.dart';

import 'build_family_partition.dart';
import 'build_plan.dart';
import 'build_price.dart';
import 'build_space.dart';

class SelectedCategory20 extends StatelessWidget {
  const SelectedCategory20({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuildPrice(),
        BuildSpace(),
        BuildPlan(),
        BuildFamilyPartition(),
      ],
    );
  }
}
