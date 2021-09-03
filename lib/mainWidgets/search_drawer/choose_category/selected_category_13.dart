import 'package:flutter/material.dart';

import 'build_price.dart';
import 'build_space.dart';
import 'build_trees.dart';
import 'build_wells.dart';

class SelectedCategory13 extends StatelessWidget {
  const SelectedCategory13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuildPrice(),
        BuildSpace(),
        BuildTrees(),
        BuildWells(),
      ],
    );
  }
}
