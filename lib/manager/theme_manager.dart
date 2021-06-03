import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:knowledge_empire/helper/Utils.dart';
import 'package:knowledge_empire/helper/prefkeys.dart';
import 'package:knowledge_empire/helper/web_api.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:knowledge_empire/manager/theme_color.dart';

class ThemeManager {
  static final ThemeManager _singleton = ThemeManager._internal();

  factory ThemeManager() {
    return _singleton;
  }

  ThemeManager._internal();

  AppThemeData _appThemeData;

  // ignore: unnecessary_getters_setters
  AppThemeData get appThemeData => _appThemeData;

  // ignore: unnecessary_getters_setters
  set appThemeData(AppThemeData value) {
    _appThemeData = value;
  }

  getAppThemeColorsFromPrefs() {
    if (Injector.prefs.getString(PrefKeys.appThemeColor) != null) {
      this.appThemeData = AppThemeData.fromJson(jsonDecode(Injector.prefs.getString(PrefKeys.appThemeColor)));
    }
  }

  getAppThemeColors(void Function() completion) {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        AppThemeColorRequest rq = AppThemeColorRequest();
        rq.userId = Injector.userData.userId;

        WebApi().callAPI(WebApi.rqGetAppThemeColors, rq.toJson()).then((data) {
          if (data != null) {
            AppThemeData response = AppThemeData.fromJson(data);

            if (response != null) {
              Injector.prefs.setString(PrefKeys.appThemeColor, jsonEncode(response.toJson()));
              this.appThemeData = response;
              print(this.appThemeData.toString());
            }
          }
          completion();
        }).catchError((e) {
          print("getAppThemeColors_" + e.toString());
          completion();
        });
      } else {
        completion();
      }
    });
  }

  //Get theme data
  Color getThemeColor() => this.appThemeData?.themeColor?.getColor() ?? HSVColor.fromAHSV(1, 235, 0.5, 0.8).toColor();

  Color getDarkColor() => this.appThemeData?.darkColor?.getColor() ?? HSVColor.fromAHSV(1, 235, 0.5, 0.6).toColor();

  Color getLightColor() => this.appThemeData?.lightColor?.getColor() ?? HSVColor.fromAHSV(1, 235, 0.02, 1).toColor();

  Color getBadgeColor() => this.appThemeData?.badgeColor?.getColor() ?? HSVColor.fromAHSV(1, 350, 0.7, 1).toColor();

  Color getHeaderColor() =>
      EnumThemeColorExtension.getEnum(this.appThemeData?.headerTheme)?.themeColor ?? HSVColor.fromAHSV(1, 235, 0.5, 0.8).toColor();

  Color getContentColor() =>
      EnumThemeColorExtension.getEnum(this.appThemeData?.contentTheme)?.themeColor ?? HSVColor.fromAHSV(1, 235, 0.5, 0.8).toColor();

  Color getFooterColor() =>
      EnumThemeColorExtension.getEnum(this.appThemeData?.footerTheme)?.themeColor ?? HSVColor.fromAHSV(1, 235, 0.5, 0.8).toColor();

  Color getTextColor() => EnumTextColorExtension.getEnum(this.appThemeData?.textColor)?.textColor ?? HSVColor.fromAHSV(1, 235, 0.02, 1).toColor();

  double getOpacity1() => (this.appThemeData?.bodyText1Opacity ?? 1);

  double getOpacity2() => (this.appThemeData?.bodyText2Opacity ?? 1);

  double getOpacity3() => (this.appThemeData?.bodyText3Opacity ?? 1);

  Color getBgGradientDark() => this.appThemeData?.backgroundGradientDark?.getColor() ?? HSVColor.fromAHSV(1, 235, 0.1, 1).toColor();

  Color getBgGradientLight() => this.appThemeData?.backgroundGradientLight?.getColor() ?? HSVColor.fromAHSV(1, 235, 0.1, 1).toColor();

  Color getBgGradientWhite() => this.appThemeData?.backgroundGradientWhite?.getColor() ?? HSVColor.fromAHSV(1, 235, 0.1, 1).toColor();

  Color getStaticGradientColor() => Color(0xFFFFFAF7);
}
