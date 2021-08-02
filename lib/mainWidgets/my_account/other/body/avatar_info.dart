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
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvatarInfo extends StatelessWidget {
  const AvatarInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return SizedBox(
      width: mediaQuery.size.width,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
          userMutual.getAvatarList(userMutual.userPhone);
          userMutual.getUserAdsList(userMutual.userPhone);
          userMutual.getUsersList(userMutual.phone);

          void sendEstimate() async {
            Future.delayed(Duration(milliseconds: 0), () {
              Api().sendEstimateFunc(
                  userMutual.phone, userMutual.userPhone, userMutual.rating, userMutual.commentRating);
            });

            userMutual.getAvatarList(userMutual.userPhone ?? userMutual.phone);
            userMutual.getUserAdsList(userMutual.userPhone ?? userMutual.phone);
            userMutual.getEstimatesInfo(userMutual.userPhone ?? userMutual.phone);
            userMutual.getSumEstimatesInfo(userMutual.userPhone ?? userMutual.phone);
            userMutual.checkOfficeInfo(userMutual.userPhone ?? userMutual.phone);
            userMutual.setUserPhone(userMutual.userPhone ?? userMutual.phone);

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
                if (userMutual.estimates[i].phone_user == userMutual.phone &&
                    userMutual.estimates[i].phone_user_estimated == userMutual.userPhone) {
                  userMutual.setCalled();
                }
              }
              if (userMutual.called == 1) {
              } else {
                _showRatingDialog();
              }
            } else {
              _showRatingDialog();
            }
            if (userMutual.userPhone == userMutual.phone) {
              var number = '+${userMutual.phone}';
              await FlutterPhoneDirectCaller.callNumber(number);
            } else {
              var number = '+${userMutual.userPhone}';
              await FlutterPhoneDirectCaller.callNumber(number);
            }
          }

          if(userMutual.avatars.isEmpty){
            return Center(child: CircularProgressIndicator());
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  userMutual.avatars.isNotEmpty
                      ?
                  UserImage(imageName: userMutual.avatars.first.image,)
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
                  UserEstimates(estimates: userMutual.estimates, sumEstimates: userMutual.sumEstimates,)
                ],
              ),
              Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  UserName(username: userMutual.avatars.first.username),
                  UserRegisteredDate(timeRegistered: userMutual.avatars.first.timeRegistered),
                  UserLastSeen(lastSeen: Jiffy(DateTime.parse(userMutual.avatars.first.lastActive ?? '').add(Duration(hours: 3))).fromNow()),
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
