import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

final localeBloc = LocaleBloc();

class LocaleBloc {
  final _assignLocaleSubject = PublishSubject<Locale>();

  Stream<Locale> get locale => _assignLocaleSubject.stream;

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
