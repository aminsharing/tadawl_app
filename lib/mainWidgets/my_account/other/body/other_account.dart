import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/app_bar/leading.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/app_bar/title.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/app_bar/account_actions.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/about.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/ads_list.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/avatar_info.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/certified.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';


class OtherAccount extends StatelessWidget {
  const OtherAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80.0,
        leadingWidth: 100,
        leading: Leading(),
        title: MyAccountTitle(),
        actions: [
          AccountActions()
        ],
        backgroundColor: Color(0xff00cccc),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AvatarInfo(),
            About(),
            Certified(),
            ChangeNotifierProvider<MyAccountProvider>(
              create: (_) => MyAccountProvider(),
              child: AdsList(),
            ),
          ],
        ),
      ),
    );
  }
}
