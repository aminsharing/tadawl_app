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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';
import 'package:tadawl_app/screens/account/my_account.dart';

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
    Key? key,
        required this.username,

  }) : super(key: key);
  final String? phone_user;
  final String? username;


  final GlobalKey<FormState> _messageKey = GlobalKey<FormState>();

  void choiceAction(String choice) {

  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context, listen: false);
    final msgProv = Provider.of<MsgProvider>(context, listen: false);
    msgProv.initScrollDown();
    msgProv.getCommentUser(phone_user, locale.phone);

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
          title: TextButton(
            onPressed: () {
              final myAccountProvider = MyAccountProvider(phone_user);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<MyAccountProvider>(
                          create: (_) => myAccountProvider,
                          child: MyAccount(myAccountProvider: myAccountProvider, phone: locale.phone),
                        ),
                  ),
              );
            },
            child: Text(
              username ?? 'Username',
              style: CustomTextStyle(
                fontSize: 15,
                color: const Color(0xffffffff),
              ).getTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: PopupMenuButton<String>(
                icon: Icon(
                  Icons.settings,
                  color: Color(0xff04B404),
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
          backgroundColor: Color(0xff1f2835),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Consumer<MsgProvider>(builder: (context, mainChat, child) {
                return Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * 0.745,
                  child: StreamBuilder<List<ConvModel>>(
                    stream: mainChat.streamChatController.stream,
                    builder: (BuildContext context, AsyncSnapshot<List<ConvModel>> snapshot) {
                      if (snapshot.hasData) {
                        // ignore: omit_local_variable_types
                        List<ConvModel> msgs = snapshot.data!.reversed.toList();
                        return ListView.builder(
                          controller: mainChat.scrollChatController,
                          reverse: true,
                          itemCount: msgs.length,
                          itemBuilder: (context, i){
                            if(msgs[i].state_conv_sender != '0') {
                              // ignore: omit_local_variable_types
                              bool text = false;
                              if(i < msgs.length -1){
                                // ignore: omit_local_variable_types
                                String firstNum = msgs[i].timeAdded!.split(' ').first.split('-').last;
                                // ignore: omit_local_variable_types
                                String secondNum = msgs[i+1].timeAdded!.split(' ').first.split('-').last;
                                if(firstNum != secondNum) {
                                  text = true;
                                }
                              }
                              return Column(
                                crossAxisAlignment: msgs[i].phone_user_sender != locale.phone ?
                                CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                                            DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(DateTime.parse(msgs[i].timeAdded!))
                                                ?
                                            AppLocalizations.of(context)!.today
                                                :
                                            DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1))) == DateFormat('yyyy-MM-dd').format(DateTime.parse(msgs[i].timeAdded!))
                                                ?
                                            AppLocalizations.of(context)!.yesterday
                                                :
                                            "${DateFormat('yyyy-MM-dd').format(DateTime.parse(msgs[i].timeAdded!),)}",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyle(
                                              fontSize: 13,
                                              color: const Color(0xffb1b1b1),
                                            ).getTextStyle(),
                                          ),
                                        )
                                    ),
                                  MsgBody(locale.phone, msgs: msgs[i],),
                                  if(msgs[i].phone_user_sender == locale.phone)
                                    Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Container(
                                      width: 10.0,
                                      child: Stack(
                                        children: [
                                          Icon(
                                            msgs[i].isLocal!
                                                ?
                                            Icons.check_box_outline_blank_rounded
                                                :
                                            Icons.check_rounded,
                                            size: 15.0,
                                          ),
                                          if(msgs[i].seen_reciever == '1')
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Icon(
                                                Icons.check_rounded,
                                                size: 15.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MsgReceiveTime(locale.phone, msgs: msgs[i]),
                                ],
                              );
                            }else{
                              return SizedBox();
                            }
                          },
                        );
                      }
                      return Center(child: Text('Loading...'));
                    },
                  ),
                );
              }),
              // list comments ..............................
              SizedBox(
                height: mediaQuery.size.height * 0.13,
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
                                        Text(RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch('${Duration(seconds: mainChat.recordDuration)}')?.group(1) ?? ''),
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        IconButton(
                                          onPressed: (){
                                            mainChat.stopRecorder(true, phone_user, locale.phone, context);
                                          },
                                          icon: Icon(Icons.stop_rounded),
                                          color: const Color(0xff00cccc),
                                        ),
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
                                      focusNode: mainChat.myFocusNode,
                                      autofocus: false,
                                      onFieldSubmitted: (_) {
                                        if (mainChat.messageController.text.isEmpty) {
                                          return;
                                        }
                                        // _messageKey.currentState!.save();
                                        mainChat.sendMess(
                                            context,
                                            [],
                                            null,
                                            mainChat.messageController.text,
                                            phone_user!,
                                            locale.phone!,
                                            MessType.TEXT,
                                            null
                                        );
                                        // myFocusNode.requestFocus();
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
                                      onSaved: (String? value) {
                                        // mainChat.setMessageController(value!);
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
                                          // _messageKey.currentState.save();
                                          mainChat.sendMess(
                                              context,
                                              [],
                                              null,
                                              mainChat.messageController.text,
                                              phone_user!,
                                              locale.phone!,
                                              MessType.TEXT,
                                              null
                                          );
                                        }
                                      },
                                      child: Icon(Icons.send_rounded,
                                        color: Color(0xff04B404),
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
                                      onTap: (){
                                        if(mainChat.isRecording){
                                          mainChat.stopRecorder(false, phone_user, locale.phone, context);
                                        }else{
                                          mainChat.startRecorder();
                                        }
                                      },
                                      child: Icon(mainChat.recordIcon ?? Icons.mic,
                                        color: Color(0xff04B404),
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
              // MsgSendField(phone_user: phone_user,),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: MsgBottomButton(),
      );
  }
}

