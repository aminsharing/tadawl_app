import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/certified_office.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/offices_Vr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Certified extends StatelessWidget {
  const Certified({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
      if (userMutual.offices != null) {
        return CertifiedOffice(state: userMutual.offices.state,);
      } else {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(
                AppLocalizations.of(context).member,
                style: CustomTextStyle(
                  fontSize: 15,
                  color: const Color(0xff989696),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OfficesVR()),
                );
              },
              child: Container(
                width: mediaQuery.size.width * 0.6,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: const Color(0xff00cccc), width: 1),
                  color: const Color(0xffffffff),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)
                        .officesAccreditation,
                    style: CustomTextStyle(
                      fontSize: 15,
                      color: const Color(0xff00cccc),
                    ).getTextStyle(),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
