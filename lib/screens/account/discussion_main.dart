import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/voice_player.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class MessType{
  static String TEXT = 'text';
  static String VOICE = 'voice';
  static String IMAGE = 'image';
}

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

  final GlobalKey<FormState> _messageKey = GlobalKey<FormState>();

  void choiceAction(String choice) {}

  @override
  Widget build(BuildContext context) {
    Provider.of<MsgProvider>(context, listen: false).initScrollDown();
    return Consumer<MsgProvider>(builder: (context, mainChat, child) {

      print("Discussion -> MsgProvider");


      var mediaQuery = MediaQuery.of(context);
      var phone_user;
      // ignore: omit_local_variable_types
      Map data = {};
      Provider.of<UserMutualProvider>(context, listen: false).getSession();
      var _phone = Provider.of<UserMutualProvider>(context, listen: false)
          .phone;
      data = ModalRoute
          .of(context)
          .settings
          .arguments;
      // phone_user = data['phone_user'];


      mainChat.getConvInfo(context, _phone);
      mainChat.getCommentUser(context, phone_user, _phone);

      //mainChat.initScrollDown();

      return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
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
                //mainChat.closeStreamChat();
                Navigator.pop(context);
              },
            ),
          ),
          title: Row(
            children: [
              Text(
                mainChat.recAvatarUserName,
                style: CustomTextStyle(

                  fontSize: 15,
                  color: const Color(0xffffffff),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
              child:
              StreamBuilder(
                stream: mainChat.streamChatController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<MessageModel> msgsNo = snapshot.data.map<MessageModel>(
                            (document) {
                          return MessageModel.fromJson(document);
                        }).toList();
                    var msgs = msgsNo.reversed.toList();
                    return ListView.builder(
                      controller: mainChat.scrollChatController,
                      reverse: true,
                      itemCount: msgs.length,
                      itemBuilder: (context, i){
                        if (msgs[i].phoneUserSender != _phone) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: 100,
                                          bottom: 5,
                                          top: 5,
                                          left: 20),
                                      padding: EdgeInsets.all(13),
                                      child: msgs[i].msgType == MessType.VOICE
                                          ?
                                      VoicePlayer(voice: msgs[i].voice, player: AudioPlayer(),)
                                          :
                                      Text(
                                        msgs[i].comment,
                                        textAlign: TextAlign.left,
                                        style: CustomTextStyle(
                                            fontSize: 12,
                                            color: Colors.black).getTextStyle(),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[100],
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                            Radius.circular(15),
                                            bottomLeft:
                                            Radius.circular(15),
                                            bottomRight:
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      DateFormat('yyyy-MM-dd  hh:mm a')
                                          .format(DateTime.parse(
                                          msgs[i].timeAdded)),
                                      textAlign: TextAlign.left,
                                      style: CustomTextStyle(
                                          fontSize: 8,
                                          color: Color(0xffb1b1b1)).getTextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                        );
                        } else {
                          return Column(
                            children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: 20,
                                        bottom: 5,
                                        top: 5,
                                        left: 100),
                                    padding: EdgeInsets.all(13),
                                    child:
                                    msgs[i].msgType == MessType.VOICE
                                        ?
                                    VoicePlayer(voice: msgs[i].voice, player: AudioPlayer(),)
                                        :
                                    // msgs[i].msgType == MessType.IMAGE ?
                                    // ImageChat()
                                    //     :
                                    Text(
                                      msgs[i].comment,
                                      textAlign: TextAlign.right,
                                      style: CustomTextStyle(

                                          fontSize: 12,
                                          color: Colors.white).getTextStyle(),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xff00cccc),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft:
                                          Radius.circular(15),
                                          bottomRight:
                                          Radius.circular(15)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 0, 20, 0),
                                  child: Text(
                                    DateFormat('yyyy-MM-dd  hh:mm a')
                                        .format(DateTime.parse(
                                        msgs[i].timeAdded)),
                                    textAlign: TextAlign.right,
                                    style: CustomTextStyle(

                                        fontSize: 8,
                                        color: Color(0xffb1b1b1)).getTextStyle(),
                                  ),
                                ),
                              ],
                            ),
                        ]);
                        }
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
                            child: Row(
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
                                      if (mainChat.messageController.text
                                          .isEmpty) {
                                        return;
                                      }
                                      _messageKey.currentState.save();
                                      mainChat.sendMess(
                                        context,
                                        [],
                                        null,
                                        mainChat.messageController.text,
                                        phone_user,
                                        _phone,
                                        MessType.TEXT,
                                      );
                                    },
                                    controller: mainChat.messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      // suffixIconConstraints: BoxConstraints.expand(width: 50.0, height: 50.0),
                                      // suffixIcon: Container(
                                      //   width: 5.0,
                                      //   height: 5.0,
                                      //   margin: EdgeInsets.only(top: 10.0),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.black45,
                                      //     shape: BoxShape.circle
                                      //   ),
                                      //   child: IconButton(
                                      //     icon: Icon(Icons.image, size: 20, color: const Color(0xff00cccc),),
                                      //     onPressed: (){
                                      //       mainChat.sendImages(phone_user, _phone, context);
                                      //     },
                                      //   ),
                                      // ),
                                    ),
                                    style: CustomTextStyle(
                                      fontSize: 15,
                                      color: const Color(0xff00cccc),
                                    ).getTextStyle(),
                                    keyboardType: TextInputType.text,
                                    onSaved: (String value) {
                                      mainChat.setMessageController(value);
                                    },
                                    onChanged: (value){
                                      if(value.isEmpty){
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
                                    color: Colors.black54,
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
                                            _phone,
                                            MessType.TEXT
                                        );
                                      }
                                      if(mainChat.msgController.text.isNotEmpty){
                                        // mainChat.sendText();
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
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
                                    // onTap: () {
                                    //   if(mainChat.recordIcon != null){
                                    //     mainChat.stopRecorder(false, phone_user, _phone, context);
                                    //     // mainChat.sendVoice();
                                    //   }
                                    // },
                                    // onVerticalDragStart: (value){
                                    //   mainChat.stopRecorder(false, phone_user, _phone, context);
                                    // },
                                    onTapDown: (value){
                                      mainChat.startRecorder();
                                    },
                                    onTapUp: (value){
                                      mainChat.stopRecorder(false, phone_user, _phone, context);
                                    },
                                    onHorizontalDragStart: (value){
                                      mainChat.stopRecorder(true, phone_user, _phone, context);
                                    },
                                    child: Icon(mainChat.recordIcon ?? Icons.mic,
                                      color: Color(0xff00cccc),
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: mainChat.atBottom
            ?
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 100),
          child: FloatingActionButton(
              backgroundColor: Color(0xff00cccc),
              child: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Color(0xffffffff),
                size: 40,
              ),
              onPressed: () {
                mainChat.scrollDownButtun();
              }),
        )
            :
        Container(),
      );
    });
  }
}

class MessageModel{
  String phoneUserSender;
  String comment;
  String msgType;
  String timeAdded;
  String voice;
  String images;

  // ignore: sort_constructors_first
  MessageModel({
    this.phoneUserSender,
    this.comment,
    this.msgType,
    this.voice,
    this.images,
    this.timeAdded,
  });
  // ignore: sort_constructors_first
  MessageModel.fromJson(Map<String, dynamic> json) {
    phoneUserSender = json['phone_user_sender'];
    comment = json['comment'];
    msgType = json['msg_type'];
    voice = json['voice_comment'];
    images = json['image_comment'];
    timeAdded = json['timeAdded'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone_user_sender'] = phoneUserSender;
    data['comment'] = comment;
    data['msg_type'] = msgType;
    data['voice'] = voice;
    data['images'] = images;
    data['timeAdded'] = timeAdded;
    return data;
  }
}