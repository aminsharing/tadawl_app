import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';

class UserName extends StatelessWidget {
  const UserName({Key key, @required this.username}) : super(key: key);
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          15, 0, 15, 0),
      child: Text(
        username ??
            'UserName',
        style: CustomTextStyle(

          fontSize: 15,
          color: const Color(0xff00cccc),
        ).getTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
