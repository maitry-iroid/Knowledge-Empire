import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/login.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injector {
//  static final Injector _singleton = new Injector._internal();

  static SharedPreferences prefs;
  static String deviceId = "";
  static int notificationID = 0;
  static LoginResponseData userData;
  static CustomerValueData customerValueData;
  static int mode;
  static bool isBusinessMode = true;
  static AudioPlayer audioPlayer;
  static AudioCache audioCache;
  static DefaultCacheManager cacheManager;
  static StreamController<String> streamController;
  static FlutterSound flutterSound = new FlutterSound();



//  factory Injector {
//    return _singleton;
//  }

  Injector._internal();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();

    audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

    audioCache = AudioCache();

    deviceId = await FlutterUdid.udid;

    if (prefs.getString(PrefKeys.user) != null &&
        prefs.getString(PrefKeys.user).isNotEmpty) {
      userData = LoginResponseData.fromJson(
          json.decode(prefs.getString(PrefKeys.user)));

      if (prefs.getString(PrefKeys.customerValueData) != null)
        customerValueData = CustomerValueData.fromJson(
            json.decode(prefs.getString(PrefKeys.customerValueData)));


      streamController = StreamController.broadcast();
      cacheManager = DefaultCacheManager();


      mode = prefs.getInt(PrefKeys.mode) != null
          ? prefs.getInt(PrefKeys.mode)
          : Const.businessMode;
      isBusinessMode = mode == Const.businessMode;
    }
  }
}
