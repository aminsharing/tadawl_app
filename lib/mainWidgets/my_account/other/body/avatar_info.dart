import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_estimates.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_image.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_last_seen.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_name.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_registered_date.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo({
    Key key,
    @required this.myAccountProvider,
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
          // userMutual.getAvatarList(userMutual.userPhone);
          // userMutual.getUserAdsList(userMutual.userPhone);


          void sendEstimate() async {
            Future.delayed(Duration(milliseconds: 0), () {
              Api().sendEstimateFunc(
                  locale.phone, userMutual.userPhone, userMutual.rating, userMutual.commentRating);
            });

            // userMutual.getAvatarList(userMutual.userPhone ?? locale.phone);
            // userMutual.getUserAdsList(userMutual.userPhone ?? locale.phone);
            // userMutual.getEstimatesInfo(userMutual.userPhone ?? locale.phone);
            // userMutual.getSumEstimatesInfo(userMutual.userPhone ?? locale.phone);
            // userMutual.checkOfficeInfo(userMutual.userPhone ?? locale.phone);
            // userMutual.setUserPhone(userMutual.userPhone ?? locale.phone);

            // Future.delayed(Duration(seconds: 0), () {
            //   Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => MyAccount()),
            //   );
            // });
          }

          void _showRatingDialog() {
            final _dialog = RatingDialog(
              title: AppLocalizations.of(context).ratingDialog,
              commentHint: AppLocalizations.of(context).ratingCommentHint,
              message: AppLocalizations.of(context).ratingHint,
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
              submitButton: AppLocalizations.of(context).send,
              onSubmitted: (response) {
                userMutual.setRating(response.rating.toString());
                userMutual.setCommentRating(response.comment.toString());
                sendEstimate();
              },
            );
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => _dialog,
            );
          }

          void _callNumber() async {
            if (userMutual.estimates.isNotEmpty) {
              for (var i = 0; i < userMutual.countEstimates(); i++) {
                if (userMutual.estimates[i].phone_user == locale.phone &&
                    userMutual.estimates[i].phone_user_estimated == userMutual.userPhone) {
                  userMutual.setCalled();
                }
              }
              if (userMutual.called == 1) {
              } else {
                // _showRatingDialog();
              }
            } else {
              // _showRatingDialog();
            }
            if (userMutual.userPhone == locale.phone) {
              var number = '+${locale.phone}';
              await FlutterPhoneDirectCaller.callNumber(number).then((value) {
                if(value){
                  Future.delayed(Duration(seconds: 5), (){
                    _showRatingDialog();
                  });
                }
              });
            } else {
              var number = '+${userMutual.userPhone}';
              await FlutterPhoneDirectCaller.callNumber(number).then((value) {
                if(value){
                  Future.delayed(Duration(seconds: 5), (){
                    _showRatingDialog();
                  });
                }
              });
            }
          }

          if(userMutual.avatars == null){
            return Center(child: CircularProgressIndicator());
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  userMutual.avatars != null
                      ?
                  UserImage(imageName: userMutual.avatars.image??'',)
                      :
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: const AssetImage(
                            'assets/images/avatar.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  UserEstimates(
                    estimates: userMutual.estimates,
                    sumEstimates: userMutual.sumEstimates,
                    myAccountProvider: myAccountProvider,
                  )
                ],
              ),
              Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  UserName(username: userMutual.avatars.username),
                  UserRegisteredDate(timeRegistered: userMutual.avatars.timeRegistered),
                  UserLastSeen(lastSeen: Jiffy(DateTime.parse(userMutual.avatars.lastActive ?? '').add(Duration(hours: 3))).fromNow()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        0, 30, 0, 30),
                    child: TextButton(
                      onPressed: _callNumber,
                      child: Container(
                        width:
                        mediaQuery.size.width * 0.4,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10.0),
                          border: Border.all(
                              color:
                              const Color(0xff3f9d28),
                              width: 1),
                          color: const Color(0xffffffff),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.phone_enabled,
                            color: Color(0xff3f9d28),
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
