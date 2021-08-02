import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/update_details/stage_0.dart';
import 'package:tadawl_app/provider/ads_provider/ad_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_details_provider.dart';


class UpdateDetails extends StatelessWidget {
  UpdateDetails(
  this._id_description,
      {
    Key key,

  }) : super(key: key);
  final String _id_description;

  @override
  Widget build(BuildContext context) {
      // var mediaQuery = MediaQuery.of(context);
      // ignore: omit_local_variable_types
      // Map data = {};
      // data = ModalRoute.of(context).settings.arguments;
      // var _id_description = data['id_description'];
      // var provider = Provider.of<LocaleProvider>(context, listen: false);
      // var _lang = provider.locale.toString();
      Provider.of<UpdateDetailsProvider>(context, listen: false).getCategoryeInfoUpdate(context);
      Provider.of<AdPageProvider>(context, listen: false).getAdsPageInfoUpdateDetails(context, _id_description);
      return Stage0(_id_description);
  }
}
