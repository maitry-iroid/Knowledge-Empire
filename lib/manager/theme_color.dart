import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_empire/manager/theme_manager.dart';

class AppThemeColorRequest {
  int userId;

  AppThemeColorRequest({this.userId});

  AppThemeColorRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}

class AppThemeColorsResponse {
  String flag;
  String result;
  String msg;
  AppThemeData data;

  AppThemeColorsResponse({this.flag, this.result, this.msg, this.data});

  AppThemeColorsResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = AppThemeData.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class AppThemeData {
  ColorData themeColor;
  ColorData lightColor;
  ColorData darkColor;
  int textColor;
  ColorData badgeColor;
  int headerTheme;
  int contentTheme;
  int footerTheme;
  double bodyText1Opacity;
  double bodyText2Opacity;
  double bodyText3Opacity;
  ColorData backgroundGradientDark;
  ColorData backgroundGradientLight;
  ColorData backgroundGradientWhite;

  AppThemeData(
      {this.themeColor,
      this.lightColor,
      this.darkColor,
      this.textColor,
      this.badgeColor,
      this.headerTheme,
      this.contentTheme,
      this.footerTheme,
      this.bodyText1Opacity,
      this.bodyText2Opacity,
      this.bodyText3Opacity,
      this.backgroundGradientDark,
      this.backgroundGradientLight,
      this.backgroundGradientWhite});

  AppThemeData.fromJson(Map<String, dynamic> json) {
    themeColor = ColorData.fromJson(json['themeColor']);
    lightColor = ColorData.fromJson(json['lightColor']);
    darkColor = ColorData.fromJson(json['darkColor']);
    textColor = json['textColor'];
    badgeColor = ColorData.fromJson(json['badgeColor']);
    headerTheme = json['headerTheme'];
    contentTheme = json['contentTheme'];
    footerTheme = json['footerTheme'];
    bodyText1Opacity = double.parse(json['bodyText1Opacity'].toString());
    bodyText2Opacity = double.parse(json['bodyText2Opacity'].toString());
    bodyText3Opacity = double.parse(json['bodyText3Opacity'].toString());
    backgroundGradientDark = ColorData.fromJson(json['backgroundGradientDark']);
    backgroundGradientLight = ColorData.fromJson(json['backgroundGradientLight']);
    backgroundGradientWhite = ColorData.fromJson(json['backgroundGradientWhite']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['themeColor'] = this.themeColor;
    data['lightColor'] = this.lightColor;
    data['darkColor'] = this.darkColor;
    data['textColor'] = this.textColor;
    data['badgeColor'] = this.badgeColor;
    data['headerTheme'] = this.headerTheme;
    data['contentTheme'] = this.contentTheme;
    data['footerTheme'] = this.footerTheme;
    data['bodyText1Opacity'] = this.bodyText1Opacity;
    data['bodyText2Opacity'] = this.bodyText2Opacity;
    data['bodyText3Opacity'] = this.bodyText3Opacity;
    data['backgroundGradientDark'] = this.backgroundGradientDark;
    data['backgroundGradientLight'] = this.backgroundGradientLight;
    data['backgroundGradientWhite'] = this.backgroundGradientWhite;
    return data;
  }
}

class ColorData {
  double hue;
  double saturation;
  double value;

  ColorData({this.hue, this.saturation, this.value});

  ColorData.fromJson(Map<String, dynamic> json) {
    hue = double.parse(json['h'].toString());
    saturation = double.parse(json['s'].toString());
    value = double.parse(json['b'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h'] = this.hue;
    data['s'] = this.saturation;
    data['b'] = this.value;
    return data;
  }

  Color getColor() {
    return HSVColor.fromAHSV(1, hue, saturation, value).toColor();
  }
}

enum EnumThemeColor { light, dark }

extension EnumThemeColorExtension on EnumThemeColor {
  // ignore: missing_return
  int get value {
    switch (this) {
      case EnumThemeColor.light:
        return 1;
      case EnumThemeColor.dark:
        return 2;
    }
  }

  // ignore: missing_return
  Color get themeColor {
    switch (this) {
      case EnumThemeColor.light:
        return ThemeManager().getLightColor();
      case EnumThemeColor.dark:
        return ThemeManager().getThemeColor();
    }
  }

  static EnumThemeColor getEnum(int value) {
    if (value == EnumThemeColor.light.value) {
      return EnumThemeColor.light;
    } else if (value == EnumThemeColor.dark.value) {
      return EnumThemeColor.dark;
    }
    return null;
  }
}

enum EnumTextColor { light, dark, white, black }

extension EnumTextColorExtension on EnumTextColor {
  // ignore: missing_return
  int get value {
    switch (this) {
      case EnumTextColor.light:
        return 1;
      case EnumTextColor.dark:
        return 2;
      case EnumTextColor.white:
        return 3;
      case EnumTextColor.black:
        return 4;
    }
  }

  // ignore: missing_return
  Color get textColor {
    switch (this) {
      case EnumTextColor.light:
        return ThemeManager().getLightColor();
      case EnumTextColor.dark:
        return ThemeManager().getDarkColor();
      case EnumTextColor.white:
        return Colors.white;
      case EnumTextColor.black:
        return Colors.black;
    }
  }

  static EnumTextColor getEnum(int value) {
    if (value == EnumTextColor.light.value) {
      return EnumTextColor.light;
    } else if (value == EnumTextColor.dark.value) {
      return EnumTextColor.dark;
    } else if (value == EnumTextColor.white.value) {
      return EnumTextColor.white;
    } else if (value == EnumTextColor.black.value) {
      return EnumTextColor.black;
    }
    return null;
  }
}
