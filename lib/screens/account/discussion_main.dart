import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/discussion/msg_body.dart';
import 'package:tadawl_app/mainWidgets/discussion/msg_bottom_button.dart';
import 'package:tadawl_app/mainWidgets/discussion/msg_receive_time.dart';
import 'package:tadawl_app/models/ConvModel.dart';
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
        @required this.username,

  }) : super(key: key);
  final String phone_user;
  final String username;


  final GlobalKey<FormState> _messageKey = GlobalKey<FormState>();

  void choiceAction(String choice) {}

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    final msgProv = Provider.of<MsgProvider>(context, listen: false);
    msgProv.initScrollDown();
    msgProv.getConvInfo(locale.phone);
    msgProv.getCommentUser(phone_user, locale.phone);

    print("Date.Now(): ${DateTime.now().day}");
    var mediaQuery = MediaQuery.of(context);

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
            username ?? 'Username',
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
        body: Consumer<MsgProvider>(builder: (context, mainChat, child) {
          return Stack(
            children: <Widget>[
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * 0.75,
                child: StreamBuilder<List<ConvModel>>(
                  stream: mainChat.streamChatController.stream,
                  builder: (BuildContext context, AsyncSnapshot<List<ConvModel>> snapshot) {
                    if (snapshot.hasData) {

                      // ignore: omit_local_variable_types
                      List<ConvModel> msgs = snapshot.data.reversed.toList();
                      return ListView.builder(
                        controller: mainChat.scrollChatController,
                        reverse: true,
                        itemCount: msgs.length,
                        itemBuilder: (context, i){
                          bool text = false;
                          if(i < msgs.length -1){
                            String firstNum = msgs[i].timeAdded.split(' ').first.split('-').last;
                            String secondNum = msgs[i+1].timeAdded.split(' ').first.split('-').last;
                            if(firstNum != secondNum) {
                              print("msgs[i].timeAdded");
                              text = true;
                            }
                          }
                          return Column(
                            children: [
                              if(text)
                                Container(
                                  width: mediaQuery.size.width,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff2f2f2)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(

                                        "${DateFormat('yyyy-MM-dd').format(DateTime.parse(msgs[i].timeAdded),)}",
                                        textAlign: TextAlign.center,
                                        style: CustomTextStyle(
                                          fontSize: 13,
                                          color: const Color(0xffb1b1b1),
                                        ).getTextStyle(),
                                      ),
                                    )
                                ),
                              MsgBody(locale.phone, msgs: msgs[i]),
                              MsgReceiveTime(locale.phone, msgs: msgs[i]),
                            ],
                          );
                        },
                      );
                    }
                    return Center(child: Text('Loading...'));
                  },
                ),
              ),
              // list comments ..............................
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 90,
                  child: Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _messageKey,
                          child: Container(
                            width: mediaQuery.size.width,
                            height: mediaQuery.size.height,
                            decoration: BoxDecoration(
                              color: const Color(0xfff2f2f2),
                              border: Border.all(width: 1.0, color: const Color(0xfff2f2f2)),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Consumer<MsgProvider>(builder: (context, mainChat, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    mainChat.isRecording
                                        ?
                                    Container(
                                      width: mediaQuery.size.width * 0.7,
                                      height: mediaQuery.size.height * 0.9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white70
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(),
                                          mainChat.recordLengthSec < 10 ?
                                          mainChat.recordLengthMin < 10 ?
                                          Text('0${mainChat.recordLengthMin}:0${mainChat.recordLengthSec}') :
                                          Text('${mainChat.recordLengthMin}:0${mainChat.recordLengthSec}') :
                                          Text('0${mainChat.recordLengthMin}:${mainChat.recordLengthSec}'),
                                          SizedBox(),
                                          SizedBox(),
                                          Row(
                                            children: [
                                              Container(
                                                width: 50.0,
                                                child: Icon(Icons.arrow_back_ios,
                                                  color: Color(0xff00cccc),
                                                  size: 30,
                                                ),
                                              ),
                                              Text('اسحب للإلغاء')
                                            ],
                                          ),
                                          SizedBox(),
                                        ],
                                      ),
                                    )
                                        :
                                    Container(
                                      width: mediaQuery.size.width * 0.7,
                                      height: mediaQuery.size.height * 0.9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white70
                                      ),
                                      child: TextFormField(
                                        onFieldSubmitted: (_) {
                                          if (mainChat.messageController.text.isEmpty) {
                                            return;
                                          }
                                          _messageKey.currentState.save();
                                          mainChat.sendMess(
                                            context,
                                            [],
                                            null,
                                            mainChat.messageController.text,
                                            phone_user,
                                            locale.phone,
                                            MessType.TEXT,
                                          );
                                        },
                                        controller: mainChat.messageController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: CustomTextStyle(
                                          fontSize: 15,
                                          // color: const Color(0xff00cccc),
                                        ).getTextStyle(),
                                        keyboardType: TextInputType.multiline,
                                        minLines: 1,
                                        maxLines: 30,
                                        onSaved: (String value) {
                                          mainChat.setMessageController(value);
                                        },
                                        onChanged: (value){
                                          if(mainChat.messageController.text.isEmpty){
                                            mainChat.setIsTyping(false);
                                          }
                                          else{
                                            mainChat.setIsTyping(true);
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10.0,),
                                    mainChat.isTyping
                                        ?
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          if(mainChat.messageController.text.isNotEmpty){
                                            _messageKey.currentState.save();
                                            mainChat.sendMess(
                                                context,
                                                [],
                                                null,
                                                mainChat.messageController.text,
                                                phone_user,
                                                locale.phone,
                                                MessType.TEXT
                                            );
                                          }
                                        },
                                        child: Icon(Icons.send_rounded,
                                          color: Color(0xff00cccc),
                                          size: 30,
                                        ),
                                      ),
                                    )
                                        :
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: GestureDetector(
                                        onTapDown: (value){
                                          mainChat.startRecorder();
                                        },
                                        onTapUp: (value){
                                          mainChat.stopRecorder(false, phone_user, locale.phone, context);
                                        },
                                        onHorizontalDragStart: (value){
                                          mainChat.stopRecorder(true, phone_user, locale.phone, context);
                                        },
                                        child: Icon(mainChat.recordIcon ?? Icons.mic,
                                          color: Color(0xff00cccc),
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // MsgSendField(phone_user: phone_user,),
            ],
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: MsgBottomButton(),
      );
  }
}

