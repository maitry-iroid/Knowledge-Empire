import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper/constant.dart';
import 'injection/dependency_injection.dart';
import 'screens/my_app.dart';

void main() => setupLocator();

Future setupLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.getInstance();
  Const.setEnvironment(Environment.PROD);
  runApp(MyApp());
}
