import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_helper_provider.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/screens/ads/ad_page.dart';

class AdPageHelper extends StatelessWidget {
  const AdPageHelper({
    Key? key,
    required this.ads,
    required this.index,
  }) : super(key: key);
  final List<AdsModel?> ads;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdPageHelperProvider>(
      create: (_) => AdPageHelperProvider(),
      builder: (context, _){
        return PageView.builder(
          controller: Provider.of<AdPageHelperProvider>(context, listen: false).setControllerIndex(index!),
          itemCount: ads.length,
          itemBuilder: (context, i){
            return ChangeNotifierProvider<AdPageProvider>(
              create: (_) => AdPageProvider(context, ads[i]!.idDescription, ads[i]!.idCategory),
              child: AdPage(ads: ads, selectedScreen: SelectedScreen.menu, index: i),
            );
          },
        );
      },
    );
  }
}
