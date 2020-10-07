import 'dart:async';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/localization.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/privay_policy.dart';
import 'package:ke_employee/screens/dashboard_game.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/screens/login.dart';
import 'home.dart';

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _status = 0;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  int isSeenPrivacyPolicy;

  @override
  void initState() {
    print("weburl-------" + Const.webUrl);

    Injector.audioCache.loadAll(['all_button_clicks.wav']);

    initPlatformState();

    Injector.getContext(context);

//    if (Injector.userId != null) {
//      PushNotificationHelper(context,"my app").initPush();
//    }

    super.initState();

    apiCallPrivacyPolicy(Injector.userData.userId, Const.typeGetPrivacyPolicy.toString(), Injector.userData.activeCompany, (privacyPolicyResponse){
      setState(() {
        this.isSeenPrivacyPolicy = privacyPolicyResponse.isSeenPrivacyPolicy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
//      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown
    ]);

    return StreamBuilder(
      stream: localeBloc.locale,
      initialData: Locale('en', ''),
      builder: (context, localeSnapshot) {
        return MaterialApp(
          title: Const.appName,
          locale: localeSnapshot.data,
          theme: ThemeData(
            accentColor: ColorRes.transparent,
            fontFamily: 'TrulyMadly',
            backgroundColor: Injector.mode == Const.businessMode
                ? ColorRes.colorBgDark
                : ColorRes.white,
          ),
          home:  Injector.userId != null && isSeenPrivacyPolicy == 1 ? HomePage() : LoginPage(),
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => LoginPage(),
            '/home': (BuildContext context) => HomePage(),
            '/engage': (BuildContext ext) => EngagementCustomer(),
            '/dashboard': (BuildContext context) => DashboardGamePage(),
          },
//          onGenerateRoute: CustomRouter.allRoutes,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('de', ''),
            const Locale.fromSubtags(languageCode: 'zh')
            // ... other locales the app supports
          ],
        );
      },
    );
  }


  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
            BackgroundFetchConfig(
              minimumFetchInterval: 15,
              forceAlarmManager: false,
              stopOnTerminate: false,
              startOnBoot: true,
              enableHeadless: true,
              requiresBatteryNotLow: false,
              requiresCharging: false,
              requiresStorageNotLow: false,
              requiresDeviceIdle: false,
              requiredNetworkType: NetworkType.NONE,
            ),
            _onBackgroundFetch)
        .then((int status) {
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

//    BackgroundFetch.scheduleTask(TaskConfig(
//        taskId: "com.transistorsoft.customtask",
//        delay: 10000,
//        periodic: false,
//        forceAlarmManager: true,
//        stopOnTerminate: false,
//        enableHeadless: true));

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

  void _onBackgroundFetch(String taskId) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    DateTime timestamp = new DateTime.now();
    // This is the fetch-event callback.
    print("[BackgroundFetch] Event received: $taskId");
//    setState(() {
//      _events.insert(0, "$taskId@${timestamp.toString()}");
//    });
//    // Persist fetch events in SharedPreferences
//    prefs.setString(EVENTS_KEY, jsonEncode(_events));

    if (taskId == "flutter_background_fetch") {
      // Schedule a one-shot task when fetch event received (for testing).
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.transistorsoft.customtask",
          delay: 5000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true));
    }
    BackgroundFetch.finish(taskId);
  }
}
