import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    Key key,
    @required this.text,
    @required this.page
  }) : super(key: key);
  final page;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 10),
              child: page),
        );
      },
      child: Text(
        text,
        style: CustomTextStyle(
          fontSize: 13,
          color: const Color(0xff00cccc),
        ).getTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
