import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/my_account/mutual/body/user_about.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context);


    return SizedBox(
      width: mediaQuery.size.width,
      height: 230,
      child: Consumer<MyAccountProvider>(builder: (context, userMutual, child) {
        void sendEstimate() async {
          await Api().sendEstimateFunc(locale.phone, userMutual.userPhone, userMutual.rating, userMutual.commentRating).then((value) async{
            await userMutual.getEstimatesInfo(userMutual.userPhone).then((value) async{
              await userMutual.getSumEstimatesInfo(userMutual.userPhone);
            });
          });
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
            var number = '${locale.phone!.replaceAll('966', '0')}';
            await FlutterPhoneDirectCaller.callNumber(number).then((value) {
              if(value!){
                Future.delayed(Duration(seconds: 5), (){
                  _showRatingDialog();
                });
              }
            });
          } else {
            var number = '${userMutual.userPhone!.replaceAll('966', '0')}';
            await FlutterPhoneDirectCaller.callNumber(number).then((value) {
              if(value!){
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserAbout(about: userMutual.avatars!.about),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: TextButton(
                    onPressed: _callNumber,
                    child: Container(
                      width:
                      mediaQuery.size.width * 0.3,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.phone_enabled,
                            color: Color(0xff3f9d28),
                            size: 40,
                          ),
                          Text(
                            'إتصال',
                            style: CustomTextStyle(
                                color: Color(0xff3f9d28)
                            ).getTextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextButton(
                    onPressed: () {
                      if(locale.phone == null){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      }else{
                        // Provider.of<MsgProvider>(context, listen: false).setRecAvatarUserName(userMutual.avatars.username);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ChangeNotifierProvider<MsgProvider>(
                                create: (_) => MsgProvider(context, locale.phone),
                                child: Discussion(
                                  userMutual.userPhone,
                                  username:userMutual.avatars!.username,
                                ),
                              )
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: mediaQuery.size.width * 0.5,
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
                            AppLocalizations.of(context)!.sendMess,
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
              ],
            ),
          ],
        );
      }),
    );
  }
}
