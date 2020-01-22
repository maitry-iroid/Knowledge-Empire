import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/screens/my_app.dart';
import 'helper/constant.dart';
import 'injection/dependency_injection.dart';

void main() => setupLocator();

Future setupLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.getInstance();
  Const.setEnvironment(Environment.DEV);
  runApp(MyApp());
}
