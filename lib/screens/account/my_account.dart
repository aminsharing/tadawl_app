import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/other_account.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/owen_account.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class MyAccount extends StatelessWidget {
  MyAccount({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if (Provider.of<UserMutualProvider>(context, listen: false).userPhone == Provider.of<LocaleProvider>(context, listen: false).phone){
      return OwenAccount();
    }else{
      return OtherAccount();
    }
  }
}