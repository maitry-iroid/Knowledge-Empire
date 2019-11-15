import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/login.dart';

import 'injection/dependency_injection.dart';
import 'menu_drawer.dart';
import 'new_customer.dart';

void main() => setupLocator();

Future setupLocator() async {
  await Injector.getInstance();

  runApp(MyApp());
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
          accentColor: ColorRes.transparent, fontFamily: 'TrulyMadly'),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
//        '/splash': (BuildContext context) => SplashScreen(),
        '/home': (BuildContext context) => HomePage(),
        '/dashboard': (BuildContext context) => DashboardPage(),
//        '/contacts': (BuildContext context) => ContactsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () async {
      String userId = Injector.prefs.getString(PrefKeys.userId);

      if ( userId == null||userId.isEmpty ) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            ModalRoute.withName("/home"));
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
            ModalRoute.withName("/login"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
