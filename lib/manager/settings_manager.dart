import 'dart:ui';

import 'package:ke_employee/manager/theme_manager.dart';

enum SettingsOptions{
  language,
  switchMode,
  sound,
  selectCompany,
  changePassword,
  privacyAndPolicy,
  termsAnsConditions,
  contactUs,
  logout
}

extension SettingsOptionsExtension on SettingsOptions {

  String get title {
    switch(this){
      case SettingsOptions.language:            return "Language";
      case SettingsOptions.switchMode:          return "Switch mode";
      case SettingsOptions.sound:               return "Sound";
      case SettingsOptions.selectCompany:       return "Select company";
      case SettingsOptions.changePassword:      return "Change passowrd";
      case SettingsOptions.privacyAndPolicy:    return "Privacy and policy";
      case SettingsOptions.termsAnsConditions:  return "Terms and conditions";
      case SettingsOptions.contactUs:           return "Contact us";
      case SettingsOptions.logout:              return "Logout";
      default:                                  return "";
    }
  }

  bool get selectionOption {
    switch(this){
      case SettingsOptions.language:            return true;
      case SettingsOptions.switchMode:          return true;
//      case SettingsOptions.selectCompany:       return true;
      case SettingsOptions.sound:               return true;
      default:                                  return false;
    }
  }

  Color get color {
    switch(this){
      case SettingsOptions.logout:         return ThemeManager().getBadgeColor();
      default:                             return ThemeManager().getDarkColor();
    }
  }

}

enum LanguageBottomSheetOptions {
  english,
  german,
  chinese,
}

extension LanguageBottomSheetOptionsExtension on LanguageBottomSheetOptions {

  String get title {
    switch(this){
      case LanguageBottomSheetOptions.english:                return "English";
      case LanguageBottomSheetOptions.german:                 return "German";
      case LanguageBottomSheetOptions.chinese:                return "Chinese";
    }
  }

}

enum SwitchModeBottomSheetOptions {
  modernVersion,
  professionalVersion,
  gamifiedVersion
}

extension SwitchModeBottomSheetOptionsExtension on SwitchModeBottomSheetOptions {

  String get title {
    switch(this){
      case SwitchModeBottomSheetOptions.modernVersion:          return "Modern";
      case SwitchModeBottomSheetOptions.professionalVersion:    return "Prof";
      case SwitchModeBottomSheetOptions.gamifiedVersion:        return "Game";
    }
  }

}