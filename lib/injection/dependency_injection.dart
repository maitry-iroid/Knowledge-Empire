import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:wasm';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

//import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/commonview/challenge_header.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';

import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/models/UpdateDialogModel.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/intro.dart';
import 'package:ke_employee/models/intro_model.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/models/on_off_feature.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class Injector {
//  static final Injector _singleton = new Injector._internal();

  static SharedPreferences prefs;
  static String deviceId = "";
  static int notificationID = 0;
  static UserData userData;
  static int userId;
  static CustomerValueData customerValueData;
  static IntroData introData;
  static DashboardStatusResponse dashboardStatusResponse;
  static int mode;
  static bool isBusinessMode = true;
  static DefaultCacheManager cacheManager;
  static StreamController<String> headerStreamController;
  static StreamController<String> homeStreamController =
      new StreamController<String>();
  static StreamController<String> newCustomerStreamController;
  static FirebaseMessaging firebaseMessaging;
  static bool isIntroRemaining = true;
  static int currentIntroType = 0;
  static String deviceType = "";
  static ui.Image image;

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
  static IntroModel introModel;

//  factory Injector {
//    return _singleton;
//  }

  Injector._internal();

  static List<QuestionCountWithData> countList = new List();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();

    deviceType = Platform.operatingSystem;
    print(deviceType);

    firebaseMessaging = FirebaseMessaging();

    webApi = WebApi();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    deviceId = await DeviceId.getID;
    print(deviceId);

    updateInstance();
    init();
  }

  static getContext(BuildContext context) {
    buildContext = context;
  }

  static Future<Null> init() async {
    final ByteData data =
        await rootBundle.load(Utils.getAssetsImg("small_coin"));
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  static Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  static updateInstance() async {
    if (prefs.getString(PrefKeys.user) != null) {
      userData = UserData.fromJson(jsonDecode(prefs.getString(PrefKeys.user)));

      userId = userData.userId;

      isIntroRemaining = prefs.getBool(PrefKeys.isIntroRemaining);
      dialogType = prefs.getInt(PrefKeys.dialogTypes);

      if (prefs.getString(PrefKeys.customerValueData) != null) {
        customerValueData = CustomerValueData.fromJson(
            jsonDecode(prefs.getString(PrefKeys.customerValueData)));
        
        isSoundEnable  = customerValueData.isEnableSound==1;
      }

      if (prefs.getString(PrefKeys.introData) != null) {
        introData =
            IntroData.fromJson(jsonDecode(prefs.getString(PrefKeys.introData)));

        updateIntroData();
      }



      if (prefs.getString(PrefKeys.dashboardStatusData) != null) {
        dashboardStatusResponse = DashboardStatusResponse.fromJson(
            jsonDecode(prefs.getString(PrefKeys.dashboardStatusData)));
      }

      headerStreamController = StreamController.broadcast();
      newCustomerStreamController = StreamController.broadcast();
      homeStreamController = StreamController.broadcast();
      cacheManager = DefaultCacheManager();

      mode = prefs.getInt(PrefKeys.mode) ?? Const.businessMode;
      isBusinessMode = mode == Const.businessMode;

      getIntroData();
      getIntroText();

      if (prefs.getString(PrefKeys.introModel) != null) {
        introModel = IntroModel.fromJson(
            jsonDecode(prefs.getString(PrefKeys.introModel)));
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

    updateMode(_user.mode);
  }

  static setCustomerValueData(CustomerValueData _customerValueData) async {
    await Injector.prefs.setString(
        PrefKeys.customerValueData, jsonEncode(_customerValueData.toJson()));

    customerValueData = _customerValueData;

    isSoundEnable = customerValueData.isEnableSound == 1;

    if (mode != _customerValueData.mode) {
      updateMode(customerValueData.mode);
      localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));
    }

    if (isSoundEnable) {
      await Utils.playBackgroundMusic();
    }
  }

  static setIntroData(IntroData _introData) async {
    if (_introData != null) {
      await Injector.prefs
          .setString(PrefKeys.introData, jsonEncode(_introData.toJson()));
      introData = _introData;
    }
  }

  static setIntroModel(IntroModel _introModel) async {
    if (_introModel != null) {
      await Injector.prefs
          .setString(PrefKeys.introModel, jsonEncode(_introModel.toJson()));
      introModel = _introModel;
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

  static getIntroText() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        IntroRequest rq = IntroRequest();
        rq.userId = Injector.userId;
        rq.type = 1;

        WebApi().callAPI(WebApi.getIntroText, rq.toJson()).then((data) async {
          if (data != null) {
            introModel = IntroModel.fromJson(data);
            await Injector.setIntroModel(introModel);
          }
        }).catchError((e) {
          print("getIntro" + e.toString());
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
