import 'package:flutter/material.dart';

import 'package:tadawl_app/mainWidgets/custom_text_style.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    Key? key,
    required this.text,
    required this.page
  }) : super(key: key);
  final page;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => page),
        );
      },
      child: Text(
        text,
        style: CustomTextStyle(
          fontSize: 13,
          color: const Color(0xff1f2835),
        ).getTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
