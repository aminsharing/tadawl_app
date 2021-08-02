import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/bottom_navigation_bar.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:tadawl_app/mainWidgets/maps/regions_map.dart';
import 'package:tadawl_app/provider/region_provider.dart';

class Regions extends StatelessWidget {
  Regions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      body: Center(
        child: ChangeNotifierProvider<RegionProvider>(
          create: (_) => RegionProvider(),
          child: RegionsMap(),
        ),
      ),
      bottomNavigationBar: SizedBox(
            height: mediaQuery.size.height * 0.11,
          child: BottomNavigationBarApp()),
    );
  }
}
