import 'package:flutter/material.dart';
import 'package:knowledge_empire/helper/res.dart';
import 'package:knowledge_empire/manager/theme_manager.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class BaseTextField extends TextFormField {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isSecure;
  final String Function(String) validator;
  final bool isEnabled;
  final bool enableInteractiveSelection;
  final FocusNode focusNode;
  final Color fillColor;

  BaseTextField(
      {@required this.hintText,
      @required this.controller,
      this.fillColor,
      this.textInputType,
      this.isSecure,
      this.isEnabled,
      this.enableInteractiveSelection,
      this.focusNode,
      @required this.validator})
      : super(
            controller: controller,
            enabled: isEnabled,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isSecure ?? false,
            enableInteractiveSelection: enableInteractiveSelection ?? true,
            focusNode: focusNode,
            cursorColor: ThemeManager().getDarkColor(),
            style: TextStyle(
              fontSize: 14,
              color: ThemeManager().getDarkColor(),
            ),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5),
                ),
                fillColor: fillColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                labelText: hintText,
                hintMaxLines: 1,
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
                ),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
                )),
            validator: validator);
}

class TextFieldWithBorder extends TextFormField {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isSecure;
  final String Function(String) validator;
  final bool isEnabled;
  final Color fillColor;

  TextFieldWithBorder(
      {@required this.hintText,
      @required this.controller,
      this.fillColor,
      this.textInputType,
      this.isSecure,
      this.isEnabled,
      @required this.validator})
      : super(
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
                )),
            validator: validator);
}

class SearchTextField extends TextFormField {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isSecure;
  final String Function(String) validator;
  final bool isEnabled;
  final Color fillColor;

  SearchTextField(
      {@required this.hintText,
      @required this.controller,
      this.fillColor,
      this.textInputType,
      this.isSecure,
      this.isEnabled,
      @required this.validator})
      : super(
            controller: controller,
            enabled: isEnabled,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isSecure ?? false,
            cursorColor: ThemeManager().getDarkColor(),
            style: TextStyle(
              fontSize: 13,
              color: ThemeManager().getDarkColor(),
            ),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager().getDarkColor(), width: 0.5), borderRadius: BorderRadius.circular(15)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeManager().getDarkColor(), width: 0.5), borderRadius: BorderRadius.circular(15)),
                fillColor: fillColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                hintText: hintText,
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
                )),
            validator: validator);
}
