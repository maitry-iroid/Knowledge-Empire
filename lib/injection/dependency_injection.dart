import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:ke_employee/BLoC/learning_module_bloc.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injector {
//  static final Injector _singleton = new Injector._internal();

  static SharedPreferences prefs;
  static String deviceId = "";
  static int notificationID = 0;
  static LoginResponseData userData;
  static int userId;
  static CustomerValueData customerValueData;
  static int mode;
  static bool isBusinessMode = true;
  static DefaultCacheManager cacheManager;
  static StreamController<String> streamController;
  static FirebaseMessaging firebaseMessaging;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static bool isSoundEnable;
  static AudioCache player = AudioCache(prefix: 'sounds/');


//  factory Injector {
//    return _singleton;
//  }

  Injector._internal();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();

    firebaseMessaging = FirebaseMessaging();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    deviceId = await FlutterUdid.udid;

    if (prefs.getBool(PrefKeys.isSoundEnable) == null) {
      await prefs.setBool(PrefKeys.isSoundEnable, true);
    }

    isSoundEnable = prefs.getBool(PrefKeys.isSoundEnable);

    if (prefs.getString(PrefKeys.user) != null &&
        prefs.getString(PrefKeys.user).isNotEmpty) {
      userData = LoginResponseData.fromJson(
          jsonDecode(prefs.getString(PrefKeys.user)));

      userId = userData.userId;


      if (prefs.getString(PrefKeys.customerValueData) != null)
        customerValueData = CustomerValueData.fromJson(
            jsonDecode(prefs.getString(PrefKeys.customerValueData)));

      streamController = StreamController.broadcast();
      cacheManager = DefaultCacheManager();

      mode = prefs.getInt(PrefKeys.mode) ?? Const.businessMode;
      isBusinessMode = mode == Const.businessMode;
    }
  }
}
