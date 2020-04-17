import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';

import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/models/UpdateDialogModel.dart';
import 'package:ke_employee/models/dashboard_lock_status.dart';
import 'package:ke_employee/models/force_update.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/models/intro.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/models/register_for_push.dart';
import 'package:ke_employee/push_notification/PushNotificationHelper.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injector {
//  static final Injector _singleton = new Injector._internal();

  static SharedPreferences prefs;
  static String deviceId = "";
  static int notificationID = 0;
  static UserData userData;
  static int userId;
  static CustomerValueData customerValueData;
  static IntroData introData;
  static DashboardLockStatusData dashboardLockStatusData;
  static UnreadBubbleCountData unreadBubbleCountData;
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
  static AudioCache audioCache = AudioCache(prefix: 'sounds/');
  static AudioCache audioCacheBg = AudioCache(prefix: 'sounds/');

  static AudioPlayer audioPlayerBg = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  static bool isDev = true;

  static int badgeCount = 0;

  static int dialogType = 0;

  static WebApi webApi;

  static PackageInfo packageInfo;
  static BuildContext buildContext;

//  factory Injector {
//    return _singleton;
//  }

  Injector._internal();

  static getInstance() async {
    print("=============== riddhi ");

    prefs = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();

    deviceType = Device.get().isAndroid ? "android" : "ios";

    firebaseMessaging = FirebaseMessaging();

    webApi = WebApi();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    deviceId = "123456";

    if (prefs.getBool(PrefKeys.isSoundEnable) == null) {
      await prefs.setBool(PrefKeys.isSoundEnable, true);
    }

    isSoundEnable = prefs.getBool(PrefKeys.isSoundEnable);

    await Utils.playBackgroundMusic();

    updateInstance();
  }

  static getContext(BuildContext context) {
    buildContext = context;
  }

  static updateInstance() async {
    if (prefs.getString(PrefKeys.user) != null) {
      userData = UserData.fromJson(jsonDecode(prefs.getString(PrefKeys.user)));

      userId = userData.userId;

      isIntroRemaining = prefs.getBool(PrefKeys.isIntroRemaining);
      dialogType = prefs.getInt(PrefKeys.dialogTypes);

      if (prefs.getString(PrefKeys.customerValueData) != null)
        customerValueData = CustomerValueData.fromJson(
            jsonDecode(prefs.getString(PrefKeys.customerValueData)));

      if (prefs.getString(PrefKeys.introData) != null) {
        introData =
            IntroData.fromJson(jsonDecode(prefs.getString(PrefKeys.introData)));

        updateIntroData();
      }
      if (prefs.getString(PrefKeys.lockStatusData) != null) {
        dashboardLockStatusData = DashboardLockStatusData.fromJson(
            jsonDecode(prefs.getString(PrefKeys.lockStatusData)));
      }
      if (prefs.getString(PrefKeys.unreadBubbleCountData) != null) {
        unreadBubbleCountData = UnreadBubbleCountData.fromJson(
            jsonDecode(prefs.getString(PrefKeys.unreadBubbleCountData)));
      }

      headerStreamController = StreamController.broadcast();
      newCustomerStreamController = StreamController.broadcast();
      homeStreamController = StreamController.broadcast();
      cacheManager = DefaultCacheManager();

      mode = prefs.getInt(PrefKeys.mode) ?? Const.businessMode;
      isBusinessMode = mode == Const.businessMode;

      getIntroData();
      PushNotificationHelper pushNotificationHelper =
          PushNotificationHelper(buildContext);

      if (pushNotificationHelper != null) {
        pushNotificationHelper.initPush();
      }
    }
  }

  static logout() async {
    await Injector.prefs.clear();
    userData = null;
    userId = null;
    customerValueData = null;
    customerValueData = null;
    introData = null;
    StringRes.username = "";
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
        PrefKeys.customerValueData, jsonEncode(_customerValueData.toJson()));

    customerValueData = _customerValueData;
  }

  static setIntroData(IntroData _introData) async {
    if (_introData != null) {
      await Injector.prefs
          .setString(PrefKeys.introData, jsonEncode(_introData.toJson()));

//      updateIntroData();
      introData = _introData;
    }
  }

  static isManager() {
    return userData?.isManager == 1;
  }

  static getIntroData() {
    if (Injector.introData != null) return;

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        IntroRequest rq = IntroRequest();
        rq.userId = Injector.userId;
        rq.type = 1;

        WebApi().callAPI(WebApi.rqGameIntro, rq.toJson()).then((data) async {
          if (data != null) {
            IntroData introData = IntroData.fromJson(data);
            await Injector.setIntroData(introData);
          }
        }).catchError((e) {
          print("getIntro" + e.toString());
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  static updateIntroData() {
    if (Injector.introData == null) return;

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        IntroRequest rq = IntroRequest();
        rq.userId = Injector.userId;
        rq.type = 2;
        rq.data = Injector.introData;

        WebApi().callAPI(WebApi.rqGameIntro, rq.toJson()).then((data) {
          if (data != null) {}
        }).catchError((e) {
          print("updateIntroData");
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  static Future<UpdateDialogModel> getCurrentVersion(
      BuildContext context) async {
    bool isConnected = await Utils.isInternetConnected();
    if (isConnected) {
      bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
      Map<String, dynamic> map = {
        "appVersion": packageInfo.version,
        "deviceType": isIOS ? "ios" : "android",
        "language":
            Injector.userData != null ? Injector.userData.language : "English"
      };
      Map data = await WebApi().callAPI(WebApi.forceUpdate, map);
      if (data != null) {
        UpdateDialogModel dialogModel = UpdateDialogModel.fromJson(data);
        return dialogModel;
      } else {
        return null;
      }
    }
  }

  static forceUpdateApplicationDialog(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to remember?'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
