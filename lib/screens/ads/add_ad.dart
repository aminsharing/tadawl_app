import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/add_ads/init_screen.dart';
import 'package:tadawl_app/provider/ads_provider/add_ad_provider.dart';

class AddAds extends StatelessWidget {
  AddAds({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InitScreen(),
      );
  }
}
