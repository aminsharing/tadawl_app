import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed as void Function()?,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 120,
          height: 78,
          color: const Color(0xff1f2835),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: Icon(icon,
                    color: const Color(0xff04B404),
                    size: 30,
                  ),
                ),
              ),
              Text(
                text,
                style: CustomTextStyle(
                  fontSize: 15,
                  color: const Color(0xffffffff),
                ).getTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}