// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tadawl_app/models/AdsModel.dart';
// import 'package:tadawl_app/provider/ads_provider.dart';
// import 'package:tadawl_app/screens/ads/ad_page.dart';
//
// class AdPageHelper extends StatelessWidget {
//   const AdPageHelper({Key key, this.menuAds}) : super(key: key);
//   final List<AdsModel> menuAds;
//
//   @override
//   Widget build(BuildContext context) {
//     final adsPage = Provider.of<AdsProvider>(context, listen: false);
//     return PageView.builder(
//       itemCount: menuAds.length,
//       controller: adsPage.adPageHelperController,
//       onPageChanged: (int i) => adsPage.resetIndex(context),
//       itemBuilder: (context, i){
//         adsPage.stopVideoAdsPage();
//
//         return AdPage();
//       },
//     );
//   }
// }
