import 'dart:async';

// import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper/constant.dart';
import 'injection/dependency_injection.dart';
import 'screens/my_app.dart';

void main() => setupLocator();

void backgroundFetchHeadlessTask(String taskId) async {
  // print('[BackgroundFetch] Headless event received.');
  // BackgroundFetch.finish(taskId);
  //
  // if (taskId == 'flutter_background_fetch') {
  //   BackgroundFetch.scheduleTask(TaskConfig(
  //       taskId: "com.transistorsoft.customtask",
  //       delay: 5000,
  //       periodic: false,
  //       forceAlarmManager: true,
  //       stopOnTerminate: false,
  //       enableHeadless: true));
  // }
}

Future setupLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injector.getInstance();
  Const.setEnvironment(Environment.PROD);
  runApp(MyApp());
}
