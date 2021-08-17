import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/update_details/stage_0.dart';


class UpdateDetails extends StatelessWidget {
  UpdateDetails(
  this._id_description, {Key key,}) : super(key: key);
  final String _id_description;

  @override
  Widget build(BuildContext context) {
      return Stage0(_id_description);
  }
}
