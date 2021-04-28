import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';

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