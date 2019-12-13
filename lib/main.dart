import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ke_employee/PDFPage.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/engagement_customer.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/intro_screen.dart';
import 'package:ke_employee/login.dart';
import 'package:notifier/notifier_provider.dart';

import 'helper/constant.dart';
import 'helper/localization.dart';
import 'injection/dependency_injection.dart';
import 'home.dart';

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      home: Injector.prefs.getString(PrefKeys.userId)!=null?(Injector.prefs.getBool(PrefKeys.isLoginFirstTime)==null||Injector.prefs.getBool(PrefKeys.isLoginFirstTime)?IntroPage():HomePage()):LoginPage(),
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
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key}) : super(key: key);
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  @override
//  void initState() {
//    super.initState();
//
//    Future.delayed(Duration(milliseconds: 5000), () {
//      String userId = Injector.prefs.getString(PrefKeys.userId);
//
//      if (userId == null || userId.isEmpty) {
//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(builder: (context) => LoginPage()),
//        );
//      } else {
//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(builder: (context) => HomePage()),
//        );
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
