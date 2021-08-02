import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/offices_vr/stage_0.dart';
import 'package:tadawl_app/provider/user_provider/offices_vr_provider.dart';

class OfficesVR extends StatelessWidget {
  OfficesVR({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OfficesVRProvider>(
      create: (_) => OfficesVRProvider(),
      child: Stage0(),
    );
  }
}


