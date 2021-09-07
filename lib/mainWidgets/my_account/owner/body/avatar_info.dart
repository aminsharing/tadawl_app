import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_email.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_estimates.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_image.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_last_seen.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_name.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_phone.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_registered_date.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo({
    Key? key,
    required this.myAccountProvider,
  }) : super(key: key);
  final MyAccountProvider myAccountProvider;

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = locale.locale.toString();
    if (_lang != 'en_US') {
      Jiffy.locale('ar');
    }
    else if (_lang == 'en_US') {
      Jiffy.locale('en');
    }
    var mediaQuery = MediaQuery.of(context);
    // Provider.of<MyAccountProvider>(context, listen: false).getUsersList(locale.phone);
    return SizedBox(
      width: mediaQuery.size.width,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MyAccountProvider>(builder: (context, userMutual, child) {
          return userMutual.users == null
              ?
          Center(child: CircularProgressIndicator(),)
              :
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    UserName(username: userMutual.users!.username),
                    UserRegisteredDate(timeRegistered: userMutual.users!.timeRegistered,),
                    UserLastSeen(lastSeen: Jiffy(DateTime.now()).fromNow()),
                    UserPhone(userPhone: userMutual.users!.phone, isMine: locale.phone == userMutual.users!.phone,),
                    UserEmail(userEmail: userMutual.users!.email, isMine: locale.phone == userMutual.users!.phone,),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserImage(imageName: userMutual.users!.image?? '',),
                    UserEstimates(
                      estimates: userMutual.estimates,
                      sumEstimates: userMutual.sumEstimates,
                      myAccountProvider: myAccountProvider,
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
