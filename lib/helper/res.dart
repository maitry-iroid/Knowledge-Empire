import 'package:flutter/material.dart';
import 'package:ke_employee/injection/dependency_injection.dart';


class ColorRes {
  static Color white = const Color(0xFFffffff);
  static Color colorPrimary = Injector.isBusinessMode ? colorBgDark : white;
  static Color headerPrimary =
      Injector.isBusinessMode ? headerDashboard : Color(0xFF000040);
  static Color headerBlue = const Color(0xFF000040);
  static Color colorAccent = const Color(0xFFffffff);
  static Color colorBgDark = const Color(0xFF3a3a3a);
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
  static Color answerCorrect = const Color(0xFF7ed321);
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
  static Color bgProf = Color(0xFFe8e8e8);
  static Color textProf = Color(0xFF8c8c8c);
  static Color bgSettings= Color(0xFF959595);
  static Color borderRewardsName = Color(0xFFf8bb43);
  static Color rankingBackGround = Color(0xFFa5b7cf);
  static Color loginBg = Color(0xFFcdcdcd);
  static Color rankingProBg = Color(0xFF676767);
  static Color rankingProValueBg  = Color(0xFFcfe5ff);
  static Color rankingProDeSelectDay  = Color(0xFFc6ced8);
  static Color blackTransparentColor  = Color(0x73000000);

  static Color chartTen = Color(0xFF823d28);
  static Color chartNine = Color(0xFF8e4a35);
  static Color chartEight = Color(0xFF9f5842);
  static Color chartSeven = Color(0xFFa86753);
  static Color chartSix = Color(0xFFbc7b67);
  static Color chartFive = Color(0xFFc78977);
  static Color chartFour = Color(0xFFdca595);
  static Color chartThree = Color(0xFFe6b8aa);
  static Color chartTwo = Color(0xFFf3ccc0);
  static Color chartOne = Color(0xFFf9d2c6);

  static Color chartOpen = Color(0xFF6fac46);
  static Color chartClose = Color(0xFFc4d8bc);



  static Color crmColor = Color(0xFFa4551f);
  static Color financeColor = Color(0xFFba6124);
  static Color legalColor = Color(0xFFde752d);
  static Color operationColor = Color(0xFFed7d31);
  static Color salesColor = Color(0xFFf2af95);
  static Color marketingColor = Color(0xFFf5c2b1);
  static Color hrColor = Color(0xFFf7d3c7);

  static Color firstColor = Color(0xFF70ad47);
  static Color secondColor = Color(0xFFa1c491);
  static Color thirdColor = Color(0xFFc4d8bc);








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
