import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';

class BaseRaisedButton extends RaisedButton{
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonColor;

  BaseRaisedButton({@required this.buttonText, @required this.onPressed, @required this.buttonColor}) :
        super(
          child: Text(buttonText, style: TextStyle(color: Colors.white)),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          color: buttonColor,
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.0)
      );
}