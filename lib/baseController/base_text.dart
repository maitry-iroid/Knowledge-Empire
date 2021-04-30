import 'package:flutter/material.dart';

class BaseText extends Text{
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  BaseText({@required this.text, @required this.textColor, @required this.fontSize, @required this.fontWeight, @required this.textAlign}) :
        super(text,
        textAlign: textAlign,
        style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight
        ),
      );
}