import 'package:flutter/material.dart';
import 'package:ke_employee/injection/dependency_injection.dart';


class ColorRes {
  static Color white = const Color(0xFFffffff);
  static Color colorPrimary = Injector.isBusinessMode ? colorBgDark : white;
  static Color headerPrimary =
      Injector.isBusinessMode ? headerDashboard : Color(0xFF000040);
  static Color headerBlue = const Color(0xFF000040);
  static Color colorAccent = const Color(0xFFffffff);
  static Color colorBgDark = const Color(0xFFe8e8e8);
  static Color borderColor = const Color(0xFFb2b2b2);
  static Color header = const Color(0xFF005c97);
  static Color headerDashboard = const Color(0xFF3f3f3f);
  static Color bgDrawer = const Color(0xFF005c97);
  static Color colorPrimaryLight = const Color(0xFFcdb7ff);
  static Color fontDarkGrey = const Color(0xFF414141);
  static Color fontGrey = const Color(0xFFA2A2A2);
  static Color red = const Color(0xFFff0000);
  static Color transparent = const Color(0xff000000);
  static Color blackTransparent = const Color(0xD9000000);
  static Color black = const Color(0xFF000000);
  static Color whiteTransparent = const Color(0xD9FFFFFF).withOpacity(0.5);
  static Color greyText = const Color(0xFFb0afaf);
  static Color whiteBg = const Color(0xFFf1f1f1);
  static Color blue = const Color(0xFF4991e1);
  static Color blueMenuUnSelected = const Color(0xFF819bbc);
  static Color blueMenuSelected = const Color(0xFF3f6798);
  static Color lightGrey = const Color(0xFF484848);
  static Color hintColor = const Color(0xFF606060);
  static Color bgTextBox = const Color(0xFF333333);
  static Color greenDot = const Color(0xFF3bd30c);
  static Color lightBg = const Color(0xFF5b5b5b);
  static Color whiteDarkBg = const Color(0xFF737373);
  static Color bgDescription = const Color(0xFF4f4f4f);
  static Color bgHeader = const Color(0xFF737377);
  static Color bgBusSec = const Color(0xFF474747);
  static Color bgMenu = const Color(0xFF272727);
  static Color textBlue = const Color(0xFF2f3d7b);
  static Color textLightBlue = const Color(0xFF7bbdff);
  static Color textRecordBlue = const Color(0xFF0080ff);
  static Color textPrimary =
      Injector.isBusinessMode ? white : Color(0xFF8c8c8c);
  static Color titleBlueProf = Color(0xFF3f6798);
  static Color bgProf = Color(0xFFf6f6f6);
  static Color textProf = Color(0xFF8c8c8c);
}

class DimenRes {
  static double titleBarHeight = 33;
  static double titleBarHeightProf = 35;
  static double drawerWidth = 0.8;
  static double closeIconSize = 0.1;
  static double closeIconPadding = 0.045;
  static double titleTextSize = 17;
  static double inputFieldHeight = 42;
}
