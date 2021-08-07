import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_estimates.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_image.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_last_seen.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_name.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_registered_date.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
    // Provider.of<MyAccountProvider>(context, listen: false).getUsersList(locale.phone);
    return SizedBox(
      width: mediaQuery.size.width,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MyAccountProvider>(builder: (context, userMutual, child) {

          // userMutual.getUserAdsList(locale.phone);
          var _lang = locale.locale.toString();
          if (_lang != 'en_US') {
            Jiffy.locale('ar');
          }
          else if (_lang == 'en_US') {
            Jiffy.locale('en');
          }
          return userMutual.users == null
              ?
          Center(child: CircularProgressIndicator(),)
              :
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserImage(imageName: userMutual.users.image?? '',),
                  UserEstimates(estimates: userMutual.estimates, sumEstimates: userMutual.sumEstimates,)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserName(username: userMutual.users.username),
                  UserRegisteredDate(timeRegistered: userMutual.users.timeRegistered,),
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
