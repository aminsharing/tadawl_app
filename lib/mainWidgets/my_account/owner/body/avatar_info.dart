import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_estimates.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_image.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_last_seen.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_name.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_registered_date.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return SizedBox(
      width: mediaQuery.size.width,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
          userMutual.getUsersList(userMutual.phone);
          userMutual.getUserAdsList(userMutual.phone);
          var provider = Provider.of<LocaleProvider>(context, listen: false);
          var _lang = provider.locale.toString();
          if (_lang != 'en_US') {
            Jiffy.locale('ar');
          }
          else if (_lang == 'en_US') {
            Jiffy.locale('en');
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserImage(imageName: userMutual.users.first.image,),
                  UserEstimates(estimates: userMutual.estimates, sumEstimates: userMutual.sumEstimates,)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserName(username: userMutual.users.first.username),
                  UserRegisteredDate(timeRegistered: userMutual.users.first.timeRegistered,),
                  UserLastSeen(lastSeen: Jiffy(DateTime.now()).fromNow()),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
