import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_drawer.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';
import 'discussion_edit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DiscussionList extends StatelessWidget {
  DiscussionList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MsgProvider>(builder: (context, convList, child) {

      print("DiscussionList -> MsgProvider");

      // Future<bool> _onBackPressed() {
      //   return showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text(
      //         AppLocalizations.of(context).closeApp,
      //         style: CustomTextStyle(
      //           fontSize: 20,
      //           color: const Color(0xff00cccc),
      //         ).getTextStyle(),
      //         textAlign: TextAlign.right,
      //       ),
      //       content: Text(
      //         AppLocalizations.of(context).areYouSureCloseApp,
      //         style: CustomTextStyle(
      //
      //           fontSize: 17,
      //           color: const Color(0xff000000),
      //         ).getTextStyle(),
      //         textAlign: TextAlign.right,
      //       ),
      //       actions: <Widget>[
      //         GestureDetector(
      //           onTap: () => SystemNavigator.pop(),
      //           child: Padding(
      //             padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      //             child: Text(
      //               AppLocalizations.of(context).yes,
      //               style: CustomTextStyle(
      //                 fontSize: 17,
      //                 color: const Color(0xff000000),
      //               ).getTextStyle(),
      //               textAlign: TextAlign.left,
      //             ),
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () => Navigator.of(context).pop(false),
      //           child: Padding(
      //             padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      //             child: Text(
      //               AppLocalizations.of(context).no,
      //               style: CustomTextStyle(
      //                 fontSize: 17,
      //                 color: const Color(0xff000000),
      //               ).getTextStyle(),
      //               textAlign: TextAlign.right,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ) ??
      //       false;
      // }

      var mediaQuery = MediaQuery.of(context);
      Provider.of<UserMutualProvider>(context, listen: false).getSession();
      var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;
      //convList.getConvInfo(context);
      convList.getConvInfo(context, _phone);

      Future<Null> refreshPage()async{
        convList.getConvInfo(context, _phone);
        convList.update();
      }

      return Scaffold(
        backgroundColor: const Color(0xffffffff),
        drawer: Drawer(
          child: CustomDrawer(),
        ),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 65.0,
          leadingWidth: 100,
          backgroundColor: const Color(0xff00cccc),
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                //mainChat.closeStreamChat();
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            AppLocalizations.of(context).messages,
            style: CustomTextStyle(
              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: Icon(
                Icons.edit,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DiscussionEdit()),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height * 0.75, // convList.countConvs()
            child: convList.conv.isNotEmpty
                ?
            ListView.builder(
              itemCount: convList.countConvs(),
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, i){
                if (convList.conv[i].state_conv_sender != '0') {
                  convList.getUnreadMsgs(context, _phone, other_phone: convList.conv[i].phone);
                  return TextButton(
                    onPressed: () {
                      // convList.initScrollDown();
                      convList.setReadMsgs(context, _phone, convList.conv[i].phone, convList.conv[i].unreadMsgs);
                      convList.setRecAvatarUserName(convList.conv[i].username);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Discussion(convList.conv[i].phone)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 10,
                          bottom: 5,
                          top: 5,
                          left: 10),
                      padding: EdgeInsets.only(
                          top: 0,
                          left: 13,
                          right: 13,
                          bottom: 13),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      top: 13),
                                  child: Container(
                                    width: mediaQuery.size.width * .22,
                                    height: mediaQuery.size.width * .22,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              'https://tadawl.com.sa/API/assets/images/avatar/${convList.conv[i].image ?? 'avatar.jpg'}'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      convList.conv[i]
                                          .username ??
                                          'UserName',
                                      style: CustomTextStyle(
                                        fontSize: 17,
                                        // color: Colors.white,
                                        color:
                                        convList.conv[i].phone_user_sender == _phone
                                                ? Color(0xff00cccc)
                                                : Color(0xffffffff),
                                      ).getTextStyle(),
                                    ),
                                    Text(
                                      convList.conv[i]
                                          .comment ??
                                          '',
                                      style: CustomTextStyle(
                                        fontSize: 13,
                                        // color: Colors.white54,
                                        color:
                                        convList.conv[i].phone_user_sender == _phone
                                                ? Color(0xff848282)
                                                : Color(0xffffffff),
                                      ).getTextStyle(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  (DateTime.now().difference(DateTime.parse(convList.conv[i].timeAdded)).inHours-3) < 1
                                      ?
                                  ''
                                      :
                                  '',
                                  style: CustomTextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.w300,
                                    color: Colors.green,
                                    // color:
                                    // convList.conv[i].phone_user_sender == _phone
                                    //         ? Color(0xff848282)
                                    //         : Color(0xffffffff),
                                  ).getTextStyle(),
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets
                                              .fromLTRB(
                                              5,
                                              0,
                                              15,
                                              0),
                                          child: Text(
                                            DateTime.now().difference(DateTime.parse(convList.conv[i].timeAdded)).inDays > 0
                                                ?
                                            DateFormat('yyyy-MM-dd')
                                                .format(
                                                DateTime.parse(convList.conv[i].timeAdded),
                                            )
                                                :
                                            DateFormat('hh:mm a')
                                                .format(
                                              DateTime.parse(convList.conv[i].timeAdded),
                                            ),
                                            style: TextStyle(
                                              fontFamily:
                                              'DINNext',

                                              fontSize: 10,
                                              // color: Colors
                                              //     .black45,
                                              color: convList.conv[i]
                                                          .phone_user_sender ==
                                                      _phone
                                                  ? Color(
                                                      0xff848282)
                                                  : Color(
                                                      0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    if(convList.conv[i].unreadMsgs != '0' && convList.conv[i].unreadMsgs != null)
                                      Container(
                                      width: 20.0,
                                      height: 20.0,
                                      decoration:
                                      BoxDecoration(
                                          color: Colors
                                              .green
                                              .withOpacity(
                                              0.7),
                                          shape: BoxShape
                                              .circle),
                                      child: Center(
                                        child: Text(
                                          '${convList.conv[i].unreadMsgs}',
                                          style: TextStyle(
                                            fontFamily:
                                            'DINNext',
                                            fontSize: 13,
                                            color:
                                            Colors.white,
                                            // color:
                                            // convList.conv[i].phone_user_sender == _phone
                                            //         ? Color(0xff848282)
                                            //         : Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          // color: convList.conv[i].phone_user_sender == _phone
                          //     ?
                          // const Color(0xff00cccc)
                          //     :
                          // Colors.blueGrey[100],
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: Colors.grey),
                        color: convList.conv[i].phone_user_sender ==
                                _phone
                            ? Colors.grey[100]
                            : Color(0xff00cccc),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            )
                :
            Center(
              child: Text(
                AppLocalizations.of(context).noMessages,
                style: CustomTextStyle(
                  fontSize: 15,
                  color: Color(0xff848282),
                ).getTextStyle(),
              ),
            ),
          ),
        ),
        // bottomNavigationBar: SizedBox(
        //   height: mediaQuery.size.height * 0.11,
        //     child: BottomNavigationBarApp()),
      );
  }
    );
  }
}
