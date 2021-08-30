import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/app_bar/leading.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/app_bar/title.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/office_location.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/app_bar/account_actions.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/about.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/ads_list.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/avatar_info.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/certified.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class OwenAccount extends StatelessWidget {
  const OwenAccount({
    Key key,
    @required this.myAccountProvider,
  }) : super(key: key);
  final MyAccountProvider myAccountProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAccountProvider>.value(
      value: myAccountProvider,
      builder: (context, _){
        return Scaffold(
          backgroundColor: const Color(0xffffffff),
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 80.0,
            leadingWidth: 100,
            leading: Leading(),
            title: MyAccountTitle(),
            actions: [
              AccountActions(
                myAccountProvider: myAccountProvider,
                office: Provider.of<MyAccountProvider>(context, listen: false).offices,
              )
            ],
            backgroundColor: Color(0xff1f2835),
          ),
          body:
          // Provider.of<UserMutualProvider>(context, listen: true).wait
          //     ?
          // Center(child: CircularProgressIndicator(),)
          //     :
          SingleChildScrollView(
            child: Column(
              children: [
                AvatarInfo(myAccountProvider: myAccountProvider,),
                About(),
                OfficeLocation(),
                SizedBox(height: 10.0,),
                Certified(),
                AdsList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
