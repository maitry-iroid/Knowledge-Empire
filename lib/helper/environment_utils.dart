import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:knowledge_empire/BLoC/locale_bloc.dart';
import 'package:knowledge_empire/helper/constant.dart';
import 'package:knowledge_empire/helper/prefkeys.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:knowledge_empire/screens/home.dart';
import 'package:knowledge_empire/screens/login.dart';

class EnvUtils {
  static Widget getHomeScreen() {
    if ((Injector.prefs.getBool(PrefKeys.isLoggedIn) ?? false) == true) {
      return HomePage();
    } else {
      return LoginPage();
    }

    // return (Injector.prefs.getBool(PrefKeys.isLoggedIn) ?? false) == true ? BottomNavigationPortrait() : LoginPagePortrait();
  }

  static getOrientation() {
    print("-------mode-----------");
    print(Const.envType == Environment.DEV || Const.envType == Environment.PROD);
    if (Const.envType == Environment.DEV || Const.envType == Environment.PROD) {
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
