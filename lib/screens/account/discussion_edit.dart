import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tadawl_app/screens/account/discussion_main.dart';

class DiscussionEdit extends StatelessWidget {
  DiscussionEdit({
    Key? key,
    required this.msgProvider,
  }) : super(key: key);
  final MsgProvider msgProvider;

  Future _deleteConv(String? phone_user_recipient, String? phone_user_sender) async {
    var res = await http.post(
        Uri.parse('https://tadawl-store.com/API/api_app/conversations/delete_conv.php'),
        body: {
          'auth_key': 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@',
          'phone_user_recipient': phone_user_recipient,
          'phone_user_sender': phone_user_sender,
        });
    var jsonx = json.decode(res.body);
    if (jsonx == 'false') {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء لم يتم الحذف ، راجع الإدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'تم حذف المراسلة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    return Consumer<MsgProvider>(builder: (context, convEdit, child) {


      var mediaQuery = MediaQuery.of(context);
      //convEdit.getConvInfo(context);

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80.0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.messages,
            style: CustomTextStyle(

              fontSize: 20,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          actions: [Text('')],
          backgroundColor: Color(0xff1f2835),
        ),
        backgroundColor: const Color(0xffffffff),
        body: Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          child: ListView.builder(
            itemCount: convEdit.conv.length,
            itemBuilder: (context, i){
            return convEdit.conv.isNotEmpty
                ?
            convEdit.conv[i].state_conv_sender != '0'
                ?
            Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      // width: 50.0,
                      // height: 50.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.remove_circle_rounded,
                          color: Color(0xffFF0000),
                          size: 50,
                        ),
                        onPressed: () {
                          _deleteConv(
                              convEdit.conv[i].phone_user_recipient,
                              convEdit.conv[i].phone_user_sender);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: () {
                      convEdit.setRecAvatarUserName(convEdit.conv[i].username);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                          ChangeNotifierProvider<MsgProvider>.value(
                            value: msgProvider,
                            child: Discussion(
                              convEdit.conv[i].phone,
                              username: convEdit.conv[i].username,
                            ),
                          )
                          )
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 10,
                          bottom: 5,
                          top: 5,
                          left: 10),
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                          color: convEdit.conv[i].phone_user_sender == locale.phone
                              ? Colors.grey[100]
                              : Color(0xff00cccc),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                                0, 0, 0, 0),
                            child: Icon(
                              Icons.navigate_before_rounded,
                              color: convEdit.conv[i].phone_user_sender == locale.phone
                                  ? Color(0xff00cccc)
                                  : Color(0xffffffff),
                              size: 40,
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: ((convEdit.conv[i].image??'').isNotEmpty
                                      ?
                                  CachedNetworkImageProvider('https://tadawl-store.com/API/assets/images/avatar/${convEdit.conv[i].image}')
                                      :
                                  AssetImage('assets/images/avatar.png')) as ImageProvider,
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                convEdit.conv[i].username ??
                                    'UserName',
                                textAlign: TextAlign.right,
                                style: CustomTextStyle(

                                  fontSize: 12,
                                  // color: Color(0xff00cccc),
                                  color: convEdit.conv[i].phone_user_sender == locale.phone
                                      ? Color(0xff00cccc)
                                      : Color(0xffffffff),
                                ).getTextStyle(),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets
                                        .fromLTRB(
                                        5, 0, 10, 0),
                                    child: Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime
                                          .parse(convEdit.conv[i]
                                          .timeAdded!)), //hh:mm a
                                      textAlign:
                                      TextAlign.left,
                                      style:
                                      CustomTextStyle(

                                        fontSize: 8,
                                        // color:
                                        //     Color(0xff848282),
                                        color: convEdit.conv[i].phone_user_sender == locale.phone
                                            ? Color(0xff848282)
                                            : Color(0xffffffff),
                                      ).getTextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                convEdit.conv[i].comment!,
                                textAlign: TextAlign.right,
                                style: CustomTextStyle(

                                  fontSize: 12,
                                  // color: Color(0xff848282),
                                  color:
                                  convEdit.conv[i].phone_user_sender == locale.phone
                                      ? Color(0xff848282)
                                      : Color(0xffffffff),
                                ).getTextStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
                :
            SizedBox()
                :
            Center(
              child: Text(
                AppLocalizations.of(context)!.noMessages,
                style: CustomTextStyle(
                  fontSize: 15,
                  color: Color(0xff848282),
                ).getTextStyle(),
              ),
            );
          },)
        ),
      );
  }
    );
  }
}
