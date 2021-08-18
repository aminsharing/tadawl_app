import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/general/contact_wp.dart';


class UserConstants {
  static const String followAccount = 'متابعة';
  static const String help = 'المساعدة والدعم';
  static const String banAccount = 'حظر المراسلة';
  static const List<String> choices = <String>[
    followAccount,
    help,
    banAccount,
  ];
}

class EngUserConstants {
  static const String followAccount = 'Follow';
  static const String help = 'help';
  static const String banAccount = 'Ban Messaging';
  static const List<String> choices = <String>[
    followAccount,
    help,
    banAccount,
  ];
}

class AccountActions extends StatelessWidget {
  const AccountActions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = provider.locale.toString();

    Future<void> choiceAction2(String choice) async {
      if (choice == 'متابعة') {
      }else if (choice == 'المساعدة والدعم' || choice == 'help') {
        await Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              ContactWp()
          ),
        );
      } else {}
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.settings,
          color: Color(0xffffffff),
          size: 40,
        ),
        onSelected: choiceAction2,
        itemBuilder: (BuildContext context) {
          return (_lang != 'en_US'
              ?
          UserConstants.choices
              :
          EngUserConstants.choices
          ).map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    choice,
                    style: CustomTextStyle(
                      fontSize: 20,
                      color: const Color(0xff989898),
                    ).getTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        10, 0, 10, 0),
                    child: Icon(
                      choice == (_lang != 'en_US' ? UserConstants.banAccount : EngUserConstants.banAccount)
                          ?
                      Icons.do_disturb_alt_rounded
                          :
                      choice == (_lang != 'en_US' ? UserConstants.help : EngUserConstants.help)
                          ?
                      Icons.support_rounded
                          :
                      Icons.person_add,
                      color:choice == (_lang != 'en_US' ? UserConstants.banAccount : EngUserConstants.banAccount)
                          ?
                      Color(0xffff0000)
                          :
                      Color(0xff989898),
                      size: 30,
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
