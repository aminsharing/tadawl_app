import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/voice_player.dart';
import 'package:tadawl_app/models/ConvModel.dart';
import 'package:tadawl_app/models/message_model.dart';

class MsgBody extends StatelessWidget {
  const MsgBody(
      this._phone,
      {
        Key? key,
        required this.msgs,
      }) : super(key: key);
  final ConvModel msgs;
  final String? _phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: msgs.phone_user_sender != _phone
          ?
      MainAxisAlignment.end
          :
      MainAxisAlignment.start, /// start
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
                right: msgs.phone_user_sender != _phone ? 100 : 20, /// 20
                bottom: 5,
                top: 5,
                left: msgs.phone_user_sender != _phone ? 20 : 100),/// 100
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: msgs.phone_user_sender != _phone ? Colors.blueGrey[100] : Color(0xff00cccc), ///
              borderRadius: BorderRadius.only(
                  topRight: /// topLeft
                  msgs.phone_user_sender != _phone?
                  Radius.circular(15):
                  Radius.circular(0),
                  topLeft: msgs.phone_user_sender != _phone ?
                  Radius.circular(0) :
                  Radius.circular(15),
                  bottomLeft:
                  Radius.circular(15),
                  bottomRight:
                  Radius.circular(15)),
            ),
            child: msgs.msgType == MessType.VOICE
                ?
            VoicePlayer(voice: msgs.voice, isLocal: msgs.isLocal, duration: msgs.duration,)
                :
            Text(
              msgs.comment??'',
              textAlign: msgs.phone_user_sender != _phone ? TextAlign.left : TextAlign.right, /// right
              style: CustomTextStyle(
                  fontSize: 12,
                  color: Colors.black).getTextStyle(),
            ),
          ),
        ),
      ],
    );
  }
}