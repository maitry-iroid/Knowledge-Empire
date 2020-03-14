import 'package:flutter/cupertino.dart';
import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/models/releaseResource.dart';
import 'package:rxdart/rxdart.dart';

final localeBloc = LocaleBloc();

class LocaleBloc {

  final _assignLocaleSubject = PublishSubject<Locale>();

  Observable<Locale> get locale => _assignLocaleSubject.stream;

  setLocale(int index) async {
    if (index == 0)
      _assignLocaleSubject.sink.add(Locale('en', ''));
    else if (index == 1)
      _assignLocaleSubject.sink.add(Locale('de', ''));
    else if (index == 2)
      _assignLocaleSubject.sink.add(Locale('zh', ''));
    else
      _assignLocaleSubject.sink.add(Locale('en', ''));
    return _assignLocaleSubject.stream.distinct();
  }

  dispose() {
    _assignLocaleSubject.close();
  }
}
