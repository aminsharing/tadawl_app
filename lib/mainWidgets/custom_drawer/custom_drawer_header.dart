import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/screens/account/my_account.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    // ignore: omit_local_variable_types
    final MyAccountProvider myAccountProvider = MyAccountProvider(locale.phone);
    return ChangeNotifierProvider<MyAccountProvider>(
      create: (_) => myAccountProvider,
      child: Consumer<MyAccountProvider>(builder: (context, customDrawer, child) {
        return locale.phone != null
            ?
        customDrawer.users != null
            ?
        TextButton(
          onPressed: () {
            // customDrawer.setWaitState(true);
            // customDrawer.getUserAdsList(locale.phone);
            // customDrawer.getAvatarList(locale.phone);
            // customDrawer.getEstimatesInfo(locale.phone);
            // customDrawer.getSumEstimatesInfo(locale.phone);
            // customDrawer.checkOfficeInfo(locale.phone);
            // customDrawer.setUserPhone(locale.phone);

            Future.delayed(Duration(seconds: 1), () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>
              //       ChangeNotifierProvider<UserMutualProvider>.value(
              //         value: UserMutualProvider(locale.phone),
              //         child: MyAccount(),
              //       )
              //   ),
              // );


              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<MyAccountProvider>.value(
                              value: myAccountProvider,
                              child: MyAccount(
                                myAccountProvider: myAccountProvider,
                                phone: locale.phone,
                              )
                          )
                  )
              );

              // if (customDrawer.userPhone == locale.phone) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => OwenAccount()),
              //   );
              // }
              // else {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => OtherAccount()),);
              // }
              customDrawer.setWaitState(false);
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: customDrawer.users.image == '' || customDrawer.users.image == null
                        ?
                    const AssetImage('assets/images/avatar.png')
                        :
                        CachedNetworkImageProvider('https://tadawl-store.com//API/assets/images/avatar/${customDrawer.users.image}'),
                    // CachedNetworkImage(
                    //   placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    //   imageUrl: 'https://tadawl-store.com/API/assets/images/avatar/${customDrawer.users.image}',
                    // ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  customDrawer.users.username ?? 'UserName',
                  style: CustomTextStyle(
                    fontSize: 15,
                    color: const Color(0xff1f2835),
                  ).getTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
            :
        Padding(
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
        )
            :
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      duration: Duration(milliseconds: 10),
                      child: Login()
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context).login,
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
                      child: Login()
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
