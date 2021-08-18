import 'package:flutter/material.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class BaseRaisedButton extends RaisedButton {
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;

  BaseRaisedButton(
      {@required this.buttonText, @required this.onPressed, @required this.buttonColor, @required this.textColor, @required this.borderColor})
      : super(
            child: Text(buttonText, style: TextStyle(color: textColor, fontSize: 18)),
            onPressed: onPressed,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: borderColor ?? ThemeManager().getTextColor())),
            color: buttonColor ?? Colors.white,
            textColor: textColor ?? Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12.0));
}
