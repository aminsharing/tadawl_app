import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/message_model.dart';
import 'package:tadawl_app/provider/msg_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class MsgSendField extends StatelessWidget {
  MsgSendField({Key key, @required this.phone_user}) : super(key: key);
  final String phone_user;

  final GlobalKey<FormState> _messageKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    Provider.of<UserMutualProvider>(context, listen: false).getSession();
    var _phone = Provider.of<UserMutualProvider>(context, listen: false).phone;

    return Align(
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
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
