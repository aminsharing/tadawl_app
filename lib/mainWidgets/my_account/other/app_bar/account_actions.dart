import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/screens/general/contact_wp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserConstants {
  static const String followAccount = 'متابعة';
  static const String help = 'المساعدة والدعم';
  static const String rateUs = 'قيمنا';
  static const String banAccount = 'حظر';
  static const List<String> choices = <String>[
    followAccount,
    help,
    rateUs,
    banAccount,
  ];
}

class EngUserConstants {
  static const String followAccount = 'Follow';
  static const String help = 'help';
  static const String rateUs = 'Rate us';
  static const String banAccount = 'Ban';
  static const List<String> choices = <String>[
    followAccount,
    help,
    rateUs,
    banAccount,
  ];
}

class AccountActions extends StatelessWidget {
  const AccountActions({Key? key, required this.userPhone}) : super(key: key);
  final String? userPhone;

  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<LocaleProvider>(context, listen: false);
    var _lang = locale.locale.toString();

    void sendEstimate(String rating, String commentRating) async {
      await Api().sendEstimateFunc(locale.phone, userPhone, rating, commentRating);
    }

    void _showRatingDialog() {
      final _dialog = RatingDialog(
        title: AppLocalizations.of(context)!.ratingDialog,
        commentHint: AppLocalizations.of(context)!.ratingCommentHint,
        message: AppLocalizations.of(context)!.ratingHint,
        image: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: const AssetImage('assets/images/avatar.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        submitButton: AppLocalizations.of(context)!.send,
        onSubmitted: (response) {
          sendEstimate(response.rating.toString(), response.comment.toString());
        },
      );
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => _dialog,
      );
    }

    Future<void> choiceAction2(String choice) async {
      if (choice == 'متابعة') {
      }else if (choice == 'المساعدة والدعم' || choice == 'help') {
        await Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              ContactWp()
          ),
        );
      }else if (choice == 'قيمنا' || choice == 'Rate us') {
        _showRatingDialog();
      } else {}
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.settings,
          color: Color(0xff04B404),
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
                      choice == (_lang != 'en_US' ? UserConstants.rateUs : EngUserConstants.rateUs)
                          ?
                      Icons.thumb_up_rounded
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
