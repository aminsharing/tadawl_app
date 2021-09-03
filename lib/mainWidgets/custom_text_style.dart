import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextStyle {
  CustomTextStyle({this.fontSize, this.color, this.fontWeight});
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;


  TextStyle getTextStyle() {
    if(Platform.isIOS){
      return GoogleFonts.tajawal(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
    }
    else if(Platform.isAndroid){
      return TextStyle(
        fontFamily: 'DINNext',
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
    }else{
      return TextStyle(
        fontFamily: 'DINNext',
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      );
    }
  }
}
