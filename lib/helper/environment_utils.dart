import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/screens/login.dart';
import 'package:ke_employee/screens_portrait/bottom_navigation.dart';
import 'package:ke_employee/screens_portrait/login.dart';

class EnvUtils{

  static Widget getHomeScreen() {
    if((Injector.prefs.getBool(PrefKeys.isLoggedIn) ?? false) == true) {
      if(Const.envType == Environment.DEV || Const.envType == Environment.PROD)
        return HomePage();
      else {
        return BottomNavigationPortrait();
      }
    } else {
      return LoginPage();
    }
    // return (Injector.prefs.getBool(PrefKeys.isLoggedIn) ?? false) == true ? BottomNavigationPortrait() : LoginPagePortrait();
  }

  static getOrientation() {
    print("-------mode-----------");
    print(Const.envType == Environment.DEV || Const.envType == Environment.PROD);
    if(Const.envType == Environment.DEV || Const.envType == Environment.PROD) {
      Const.isLandscape = true;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      Const.isLandscape = false;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);
    }
  }

}