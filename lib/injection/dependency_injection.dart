import 'package:shared_preferences/shared_preferences.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  static SharedPreferences prefs;
  static int notificationID = 0;

//  factory Injector {
//    return _singleton;
//  }

  Injector._internal();

  static Future<SharedPreferences> getInstance() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }

    return prefs;
  }
}
