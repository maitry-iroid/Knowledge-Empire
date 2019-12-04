import 'dart:convert';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injector {
//  static final Injector _singleton = new Injector._internal();

  static SharedPreferences prefs;
  static String deviceId = "";
  static int notificationID = 0;
  static LoginResponseData userData;
  static int mode;
  static bool isBusinessMode = true;
  static AudioPlayer audioPlayer;
  static AudioCache audioCache;


//  factory Injector {
//    return _singleton;
//  }

  Injector._internal();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString(PrefKeys.user) != null &&
        prefs.getString(PrefKeys.user).isNotEmpty)
      userData = LoginResponseData.fromJson(
          json.decode(prefs.getString(PrefKeys.user)));

    mode = prefs.getInt(PrefKeys.mode);
    isBusinessMode = mode == Const.businessMode;

    deviceId = await FlutterUdid.udid;

    audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    audioCache = AudioCache();
  }
}
