import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/message_model.dart';

class MsgReceiveTime extends StatelessWidget {
  const MsgReceiveTime(
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
      mainAxisAlignment: msgs.phoneUserSender != _phone ?
      MainAxisAlignment.end : MainAxisAlignment.start, /// start
      children: [
        Padding(
          padding: msgs.phoneUserSender != _phone ?
          const EdgeInsets.fromLTRB(20, 0, 0, 0):
          const EdgeInsets.fromLTRB(0, 0, 20, 0), /// 0, 0, 20, 0)
          child: Text(
            DateFormat('yyyy-MM-dd  hh:mm a')
                .format(DateTime.parse(
                msgs.timeAdded)),
            textAlign: msgs.phoneUserSender != _phone ? TextAlign.left : TextAlign.right, /// right
            style: CustomTextStyle(
                fontSize: 8,
                color: Color(0xffb1b1b1)).getTextStyle(),
          ),
        ),
      ],
    );
  }
}