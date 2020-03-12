import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  static UserData userData;
  static int userId;
  static CustomerValueData customerValueData;
  static int mode;
  static bool isBusinessMode = true;
  static DefaultCacheManager cacheManager;
  static StreamController<String> headerStreamController;
  static StreamController<String> homeStreamController;
  static StreamController<String> newCustomerStreamController;
  static FirebaseMessaging firebaseMessaging;
  static bool isIntroRemaining = true;
  static int currentIntroType = 0;
  static String deviceType = "";

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static bool isSoundEnable;
  static AudioCache player = AudioCache(prefix: 'sounds/');
  static bool isDev = true;

//  factory Injector {
//    return _singleton;
//  }

  Injector._internal();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();

    deviceType = Device.get().isAndroid ? "android" : "ios";

    firebaseMessaging = FirebaseMessaging();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    deviceId = "123456";

    if (prefs.getBool(PrefKeys.isSoundEnable) == null) {
      await prefs.setBool(PrefKeys.isSoundEnable, true);
    }

    isSoundEnable = prefs.getBool(PrefKeys.isSoundEnable);

    if (prefs.getString(PrefKeys.user) != null) {
      userData = UserData.fromJson(jsonDecode(prefs.getString(PrefKeys.user)));

      userId = userData.userId;

      isIntroRemaining = prefs.getBool(PrefKeys.isIntroRemaining);

      if (prefs.getString(PrefKeys.customerValueData) != null)
        customerValueData = CustomerValueData.fromJson(
            jsonDecode(prefs.getString(PrefKeys.customerValueData)));

      headerStreamController = StreamController.broadcast();
      newCustomerStreamController = StreamController.broadcast();
      homeStreamController = StreamController.broadcast();
      cacheManager = DefaultCacheManager();

      mode = prefs.getInt(PrefKeys.mode) ?? Const.businessMode;
      isBusinessMode = mode == Const.businessMode;
    }
  }

  static updateMode(int _mode) async {
    mode = _mode;
    prefs.setInt(PrefKeys.mode, _mode);
    isBusinessMode = _mode == Const.businessMode;
  }

  static setUserData(UserData _user) async {
    await Injector.prefs.setString(PrefKeys.user, json.encode(_user.toJson()));

    userData = _user;

    userId = _user.userId;
  }

  static setCustomerValueData(CustomerValueData _customerValueData) async {
    await Injector.prefs.setString(
        PrefKeys.customerValueData, json.encode(_customerValueData.toJson()));

    customerValueData = _customerValueData;
  }

  static isManager() {
    return userData.isManager == 1;
  }

  static updateIntroType(int introType) async {
    await prefs.setInt(PrefKeys.currentIntroType, introType);
    return currentIntroType == introType;
  }
}
