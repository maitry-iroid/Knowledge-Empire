import 'dart:async';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/localization.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/register_for_push.dart';
import 'package:ke_employee/screens/dashboard_game.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/screens/intro_screen.dart';
import 'package:ke_employee/screens/login.dart';

import 'home.dart';


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<DateTime> _events = [];
  int _status = 0;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {

    print(Const.SERVER_ONE);

    initPlatformState();

    if (Injector.prefs.getInt(PrefKeys.userId) != null) {
      initPush();
    }

    super.initState();
  }

  void callRegisterForPush(String token) {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        RegisterForPushRequest rq = RegisterForPushRequest();
        rq.userId = Injector.userData.userId;
        rq.deviceId = Injector.deviceId;
        rq.deviceType = "android";
        rq.deviceToken = token;

        WebApi().registerForPush(rq).then((response) {
          if (response != null) {
            if (response.flag == "true") {
//              Utils.showToast(response.msg);
            }
          }
        });
      }
    }).catchError((e) {
      print("registerForPush_"+e.toString());
      Utils.showToast(e);
    });
  }

  void initPush() async {
    firebaseCloudMessagingListeners();

    var initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await Injector.flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: onSelectNotification);

    Injector.firebaseMessaging.requestNotificationPermissions();

    Injector.firebaseMessaging.getToken().then((token) {
      print("token : " + token);

      callRegisterForPush(token);
    });
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print("onDidReceiveLocalNotification");
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }

  void firebaseCloudMessagingListeners() async {
    Injector.firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');

        Utils.showNotification(message);
      },
//      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');

        Utils.showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');

        Utils.showNotification(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'Ke Employee',
      theme: ThemeData(
          accentColor: ColorRes.transparent,
          fontFamily: 'TrulyMadly',
          backgroundColor: Injector.mode == Const.businessMode
              ? ColorRes.colorBgDark
              : ColorRes.white,
          textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 17.0,
                color: Injector.isBusinessMode
                    ? ColorRes.white
                    : ColorRes.colorBgDark),
            title: TextStyle(
                fontSize: 17,
                color: Injector.isBusinessMode
                    ? ColorRes.white
                    : ColorRes.colorBgDark),
            body1: TextStyle(fontSize: 15, color: ColorRes.white),
            body2: TextStyle(
                fontSize: 14,
                color: Injector.isBusinessMode
                    ? ColorRes.white
                    : ColorRes.colorBgDark),
          )),
      home: Injector.prefs.getInt(PrefKeys.userId) != null
          ? (Injector.prefs.getBool(PrefKeys.isLoginFirstTime) == null ||
          Injector.prefs.getBool(PrefKeys.isLoginFirstTime)
          ? IntroPage()
          : HomePage())
          : LoginPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
//        '/splash': (BuildContext context) => SplashScreen(),
        '/home': (BuildContext context) => HomePage(),
        '/engage': (BuildContext ext) => EngagementCustomer(),
        '/dashboard': (BuildContext context) => DashboardGamePage(),
        '/intro': (BuildContext context) => IntroPage(),
//        '/contacts': (BuildContext context) => ContactsScreen(),
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        // ... other locales the app supports
      ],
    );
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: false,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_NONE),
            () async {
          // This is the fetch-event callback.
          print('[BackgroundFetch] Event received');
          setState(() {
            _events.insert(0, new DateTime.now());
          });
          // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
          // for taking too long in the background.
          BackgroundFetch.finish();
        }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }
}
