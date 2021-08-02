import 'package:flutter/material.dart';

class Leading extends StatelessWidget {
  const Leading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xffffffff),
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
