import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/other_account.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/owen_account.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader(this._phone, {Key key}) : super(key: key);
  final String _phone;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserMutualProvider>(builder: (context, customDrawer, child) {

      if (customDrawer.users.isEmpty) {
        customDrawer.getUsersList(_phone);
      }

      if (_phone != null) {
        if (customDrawer.users.isNotEmpty) {
          return TextButton(
            onPressed: () {
              var userMutual = Provider.of<UserMutualProvider>(context, listen: false);
              customDrawer.setWaitState(true);
              userMutual.getAvatarList(_phone);
              userMutual.getUserAdsList(_phone);
              userMutual.getEstimatesInfo(_phone);
              userMutual.getSumEstimatesInfo(_phone);
              userMutual.checkOfficeInfo(_phone);
              userMutual.setUserPhone(_phone);

              Future.delayed(Duration(seconds: 1), () {
                if (userMutual.userPhone ==
                    userMutual.phone) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OwenAccount()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtherAccount()),);
                }
                customDrawer.setWaitState(false);
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customDrawer.users.first.image == '' ||
                    customDrawer.users.first.image == null
                    ? Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage(
                          'assets/images/avatar.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
                    :
                Container(
                  width: 150.0,
                  height: 150.0,
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        Center(
                            child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                    imageUrl: 'https://tadawl.com.sa/API/assets/images/avatar/${customDrawer
                        .users.first.image}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    customDrawer.users.first.username ?? 'UserName',
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff00cccc),
                    ).getTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
                child: Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff00cccc),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xffffffff)),
                  ),
                )),
          );
        }
      }
      else{
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      duration: Duration(milliseconds: 10),
                      child: Login()),
                );
              },
              child: Text(
                AppLocalizations
                    .of(context)
                    .login,
                style: CustomTextStyle(
                  fontSize: 20,
                  color: const Color(0xff00cccc),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.meeting_room,
                color: Color(0xff00cccc),
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => Login()),
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      duration: Duration(milliseconds: 10),
                      child: Login()),
                );
              },
            ),
          ],
        );
      }
    });
  }
}
