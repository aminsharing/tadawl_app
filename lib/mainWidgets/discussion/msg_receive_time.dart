import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/ConvModel.dart';

class MsgReceiveTime extends StatelessWidget {
  const MsgReceiveTime(
      this._phone,
      {
        Key key,
        @required this.msgs,
      }) : super(key: key);
  final ConvModel msgs;
  final String _phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: msgs.phone_user_sender != _phone ?
      MainAxisAlignment.end : MainAxisAlignment.start, /// start
      children: [
        Padding(
          padding: msgs.phone_user_sender != _phone ?
          const EdgeInsets.fromLTRB(20, 0, 0, 0):
          const EdgeInsets.fromLTRB(0, 0, 20, 0), /// 0, 0, 20, 0)
          child: Text(
            DateFormat('yyyy-MM-dd  hh:mm a')
                .format(DateTime.parse(
                msgs.timeAdded)),
            textAlign: msgs.phone_user_sender != _phone ? TextAlign.left : TextAlign.right, /// right
            style: CustomTextStyle(
                fontSize: 8,
                color: const Color(0xffb1b1b1)).getTextStyle(),
          ),
        ),
      ],
    );
  }
}