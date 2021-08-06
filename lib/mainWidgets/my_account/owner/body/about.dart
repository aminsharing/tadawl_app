import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_about.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width,
      height: 100,
      child: Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
        return UserAbout(about: userMutual.users.about,);
      }),
    );
  }
}
