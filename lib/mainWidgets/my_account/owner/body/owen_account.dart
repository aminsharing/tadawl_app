import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/app_bar/leading.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/app_bar/title.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/app_bar/account_actions.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/about.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/ads_list.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/avatar_info.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/certified.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class OwenAccount extends StatelessWidget {
  const OwenAccount({Key key}) : super(key: key);

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
