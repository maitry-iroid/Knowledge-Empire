import 'dart:async';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ke_employee/screens/dashboard_new.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/screens/intro_screen.dart';
import 'package:ke_employee/screens/login.dart';
import 'package:notifier/notifier_provider.dart';

import 'helper/constant.dart';
import 'helper/localization.dart';
import 'injection/dependency_injection.dart';
import 'screens/home.dart';

void main() => setupLocator();

Future setupLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.getInstance();

  runApp(
    NotifierProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<DateTime> _events = [];
  int _status = 0;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
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
        '/dashboard': (BuildContext context) => DashboardNewPage(),
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
