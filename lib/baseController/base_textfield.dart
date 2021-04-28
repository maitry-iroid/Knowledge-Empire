import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class BaseTextField extends TextFormField{
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isSecure;
  final String Function(String) validator;


  BaseTextField({@required this.hintText, @required this.controller, this.textInputType, this.isSecure, @required this.validator}) :
        super(
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: isSecure ?? false,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black
          ),
          decoration: InputDecoration(
              fillColor: ColorRes.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//              hintText: hintText,
              labelText: hintText,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black
              )
          ),
          validator: validator
      );
}

class TextFieldWithBorder extends TextFormField {

  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isSecure;
  final String Function(String) validator;
  final bool isEnabled;
  final Color fillColor;

  TextFieldWithBorder({@required this.hintText, @required this.controller, this.fillColor, this.textInputType, this.isSecure, this.isEnabled, @required this.validator}) :
        super(
          controller: controller,
          enabled: isEnabled,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: isSecure ?? false,
          cursorColor: ThemeManager().getDarkColor(),
          style: TextStyle(
            fontSize: 14,
            color: ThemeManager().getDarkColor(),
          ),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5),
              ),
              fillColor: fillColor,
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                fontSize: 16,
                color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
              )
          ),
          validator: validator
      );

}