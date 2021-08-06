import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_about.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width,
      height: 200,
      child: Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
        if(userMutual.avatars == null){
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: TextButton(
                onPressed: () {
                  if(locale.phone == null){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  }else{
                    Provider.of<MsgProvider>(context, listen: false).setRecAvatarUserName(userMutual.avatars.username);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Discussion(userMutual.userPhone)));
                  }
                },
                child: Container(
                  width: mediaQuery.size.width * 0.6,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10.0),
                    border: Border.all(
                        color: const Color(0xff00cccc),
                        width: 1),
                    color: const Color(0xffffffff),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(
                            15, 0, 0, 0),
                        child: Icon(
                          Icons.comment_rounded,
                          color: Color(0xff00cccc),
                          size: 40,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).sendMess,
                        style: CustomTextStyle(
                          fontSize: 15,
                          color: const Color(0xff00cccc),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            UserAbout(about: userMutual.avatars.about),
          ],
        );
      }),
    );
  }
}
