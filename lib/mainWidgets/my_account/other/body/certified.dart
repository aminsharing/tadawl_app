import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/certified_office.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Certified extends StatelessWidget {
  const Certified({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
      if(userMutual.avatars.isEmpty){
        return Center(child: CircularProgressIndicator());
      }
      if (userMutual.offices.isNotEmpty) {
        return CertifiedOffice(state: userMutual.offices.first.state,);
      } else {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Text(
            AppLocalizations.of(context).member,
            style: CustomTextStyle(
              fontSize: 15,
              color: const Color(0xff989696),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
        );
      }
    });
  }
}
