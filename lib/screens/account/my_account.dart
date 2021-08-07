import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/other_account.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/owen_account.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class MyAccount extends StatelessWidget {
  MyAccount({
    Key key,
    @required this.myAccountProvider,
    @required this.phone,
  }) : super(key: key);

  final MyAccountProvider myAccountProvider;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAccountProvider>.value(
      value: myAccountProvider,
      child: Provider.of<MyAccountProvider>(context, listen: false).userPhone == phone
          ?
      OwenAccount(myAccountProvider: myAccountProvider)
          :
      OtherAccount(myAccountProvider: myAccountProvider),
    );
  }
}