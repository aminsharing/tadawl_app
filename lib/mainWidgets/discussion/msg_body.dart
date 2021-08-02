import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/mainWidgets/voice_player.dart';
import 'package:tadawl_app/models/message_model.dart';

class MsgBody extends StatelessWidget {
  const MsgBody(
      this._phone,
      {
        Key key,
        @required this.msgs,
      }) : super(key: key);
  final MessageModel msgs;
  final String _phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: msgs.phoneUserSender != _phone
          ?
      MainAxisAlignment.end
          :
      MainAxisAlignment.start, /// start
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
                right: msgs.phoneUserSender != _phone ? 100 : 20, /// 20
                bottom: 5,
                top: 5,
                left: msgs.phoneUserSender != _phone ? 20 : 100),/// 100
            padding: EdgeInsets.all(13),
            child: msgs.msgType == MessType.VOICE
                ?
            VoicePlayer(voice: msgs.voice, player: AudioPlayer(),)
                :
            Text(
              msgs.comment,
              textAlign: msgs.phoneUserSender != _phone ? TextAlign.left : TextAlign.right, /// right
              style: CustomTextStyle(
                  fontSize: 12,
                  color: Colors.black).getTextStyle(),
            ),
            decoration: BoxDecoration(
              color: msgs.phoneUserSender != _phone ? Colors.blueGrey[100] : Color(0xff00cccc), ///
              borderRadius: BorderRadius.only(
                  topRight: /// topLeft
                  msgs.phoneUserSender != _phone?
                  Radius.circular(15):
                  Radius.circular(0),
                  topLeft: msgs.phoneUserSender != _phone ?
                  Radius.circular(0) :
                  Radius.circular(15),
                  bottomLeft:
                  Radius.circular(15),
                  bottomRight:
                  Radius.circular(15)),
            ),
          ),
        ),
      ],
    );
  }
}