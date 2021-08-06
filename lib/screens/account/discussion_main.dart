import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/discussion/msg_body.dart';
import 'package:tadawl_app/mainWidgets/discussion/msg_bottom_button.dart';
import 'package:tadawl_app/mainWidgets/discussion/msg_receive_time.dart';
import 'package:tadawl_app/mainWidgets/discussion/msg_send_field.dart';
import 'package:tadawl_app/models/message_model.dart';
import 'package:tadawl_app/provider/locale_provider.dart';
import 'package:tadawl_app/provider/msg_provider.dart';

class Constants {
  static const String banMessaging = 'حظر المراسلة';
  static const List<String> choices = <String>[
    banMessaging,
  ];
}

class Discussion extends StatelessWidget {
  Discussion(
      this.phone_user,
      {
    Key key,
  }) : super(key: key);
  final String phone_user;



  void choiceAction(String choice) {}

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    final msgProv = Provider.of<MsgProvider>(context, listen: false);
    msgProv.initScrollDown();




      var mediaQuery = MediaQuery.of(context);
      // var phone_user;
      // ignore: omit_local_variable_types
      // Map data = {};


      // data = ModalRoute
      //     .of(context)
      //     .settings
      //     .arguments;
      // phone_user = data['phone_user'];




      //mainChat.initScrollDown();

      return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          leadingWidth: 70,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffffffff),
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            msgProv.recAvatarUserName,
            style: CustomTextStyle(
              fontSize: 15,
              color: const Color(0xffffffff),
            ).getTextStyle(),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: PopupMenuButton<String>(
                icon: Icon(
                  Icons.settings,
                  color: Color(0xffffffff),
                  size: 40,
                ),
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: CustomTextStyle(
                          fontSize: 20,
                          color: const Color(0xffff0000),
                        ).getTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ],
          backgroundColor: Color(0xff00cccc),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height * 0.75,
              child: Consumer<MsgProvider>(builder: (context, mainChat, child) {
                print("Discussion -> MsgProvider");
                mainChat.getConvInfo(context, locale.phone);
                mainChat.getCommentUser(context, phone_user, locale.phone);
                return StreamBuilder(
                  stream: mainChat.streamChatController.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> msgsNo = snapshot.data.map<MessageModel>((document) {
                        return MessageModel.fromJson(document);
                      }).toList();
                      var msgs = msgsNo.reversed.toList();
                      return ListView.builder(
                        controller: mainChat.scrollChatController,
                        reverse: true,
                        itemCount: msgs.length,
                        itemBuilder: (context, i){
                          return Column(
                            children: [
                              MsgBody(locale.phone, msgs: msgs[i]),
                              MsgReceiveTime(locale.phone, msgs: msgs[i]),
                            ],
                          );
                        },
                      );
                    }
                    return Center(child: Text('Loading...'));
                  },
                );
              }),
            ),
            // list comments ..............................
            MsgSendField(phone_user: phone_user,),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: MsgBottomButton(),
      );
  }
}

