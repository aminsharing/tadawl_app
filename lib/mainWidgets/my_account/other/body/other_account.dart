import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/app_bar/leading.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/app_bar/account_actions.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/about.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/ads_list.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/avatar_info.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/certified.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

import 'office_location.dart';


class OtherAccount extends StatelessWidget {
  const OtherAccount({
    Key key,
    @required this.myAccountProvider,
    @required this.userPhone,
  }) : super(key: key);
  final MyAccountProvider myAccountProvider;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80.0,
        leadingWidth: 100,
        leading: Leading(),
        // title: MyAccountTitle(),
        actions: [
          AccountActions(userPhone: userPhone)
        ],
        backgroundColor: const Color(0xff1f2835),
      ),
      body:
      // Provider.of<UserMutualProvider>(context, listen: true).wait
      //     ?
      // Center(child: CircularProgressIndicator(),)
      //     :
      SingleChildScrollView(
        child: ChangeNotifierProvider<MyAccountProvider>.value(
          value: myAccountProvider,
          child: Column(
            children: [
              AvatarInfo(myAccountProvider: myAccountProvider),
              About(),
              OfficeLocation(),
              SizedBox(height: 10.0,),
              Certified(),
              AdsList(),
            ],
          ),
        ),
      ),
    );
  }
}
