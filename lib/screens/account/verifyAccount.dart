import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/verify_account/stage_1.dart';
import 'package:tadawl_app/provider/user_provider/change_pass_provider.dart';

class VerifyAccount extends StatelessWidget {
  VerifyAccount({
    Key key,
    @required this.currentPhone,
  }) : super(key: key);
  final String currentPhone;
  final ChangePassProvider changePassProvider = ChangePassProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePassProvider>(
      create: (_) => changePassProvider,
      child: Stage1(currentPhone,changePassProvider: changePassProvider),
    );
  }
}
