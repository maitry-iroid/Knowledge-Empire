import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:knowledge_empire/helper/string_res.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String text(String text) {
    return Injector.isBusinessMode
        ? StringRes.localizedValues[locale.languageCode][text]
        : (StringRes.localizedValuesProf[locale.languageCode][text] != null
            ? StringRes.localizedValuesProf[locale.languageCode][text]
            : StringRes.localizedValues[locale.languageCode][text]);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
