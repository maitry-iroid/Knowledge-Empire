import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/routes/route_names.dart';
import 'package:ke_employee/screens_portrait/bottom_navigation.dart';
import 'package:ke_employee/screens_portrait/drawer.dart';
import 'package:ke_employee/screens_portrait/login.dart';
import 'package:ke_employee/screens_portrait/module.dart';
import 'package:ke_employee/screens_portrait/other.dart';
import 'package:ke_employee/screens_portrait/profile_and_settings.dart';
import 'package:ke_employee/screens_portrait/questions.dart';

class CustomRouter{

  static Route<dynamic> allRoutes(RouteSettings settings){
    switch(settings.name){
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPagePortrait());
      case bottomNavigationRoute:
        return MaterialPageRoute(builder: (_) => BottomNavigationPortrait());
      case drawerRoute:
        return MaterialPageRoute(builder: (_) => DrawerPortrait());
      case moduleRoute:
        return MaterialPageRoute(builder: (_) => ModulePagePortrait());
      case otherRoute:
        return MaterialPageRoute(builder: (_) => OtherPagePortrait());
      case questionsRoute:
        return MaterialPageRoute(builder: (_) => QuestionsPagePortrait());
      case profileAndSettingsRoute:
        return MaterialPageRoute(builder: (_) => ProfileAndSettingsPagePortrait());
    }
    return MaterialPageRoute(builder: (_) => LoginPagePortrait());
  }
}
