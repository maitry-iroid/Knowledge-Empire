import 'package:flutter/material.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class StringRes {
  static var dashboard = "Dashboard";
  static var businessSector = "Business Sector";
  static var newCustomers = "New Customers";
  static var existingCustomers = "Existing Customers";
  static var organizations = "Organizations";
  static var challenges = "Challenges";
  static var pl = "P+L";
  static var rewards = "Rewards";
  static var ranking = "Ranking";
  static var team = "Team";

  static var editProfile = "Edit Profile";
  static var yourName = "Your Name";
  static var yourEmail = "Your Email";
  static var changePassword = "Change Password";
  static var save = "Save";
  static var settings = "Settings";
  static var privacyPolicy = "Privacy & Policy";
  static var termsConditions = "Terms & Conditions";
  static var contactUs = "Contact Us";
  static var switchProfMode = "Switch to Professional Mode";
  static var switchBusinessMode = "Switch to Business Mode";
  static var logout = "Log out";
}

class ColorRes {
  static Color white = const Color(0xFFffffff);
  static Color colorPrimary = Injector.isBusinessMode ? colorBgDark : white;
  static Color headerPrimary =
      Injector.isBusinessMode ? headerDashboard : Color(0xFF000040);
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
}

class DimenRes {
  static double titleBarHeight = 35;
  static double drawerWidth = 0.8;
  static double closeIconSize = 0.1;
  static double closeIconPadding = 0.045;
  static double titleTextSize = 17;
  static double inputFieldHeight = 42;
}
