import 'package:flutter/cupertino.dart';
import 'package:ke_employee/routes/route_names.dart';
import 'package:ke_employee/screens_portrait/bottom_navigation.dart';
import 'package:ke_employee/screens_portrait/module.dart';
import 'package:ke_employee/screens_portrait/other.dart';
import 'package:ke_employee/screens_portrait/profile_and_settings.dart';
import 'package:ke_employee/screens_portrait/questions.dart';


enum DrawerItems {
  profile,
  learnings,
  modules,
  ranking,
  achievements,
  awards,
  performance,
  team,
  challenges,
  logout
}

extension DrawerItemsExtension on DrawerItems {

  String get title {
    switch(this){
      case DrawerItems.profile:         return "Profile";
      case DrawerItems.learnings:       return "Learnings";
      case DrawerItems.modules:         return "Modules";
      case DrawerItems.ranking:         return "Ranking";
      case DrawerItems.achievements:    return "Achievements";
      case DrawerItems.awards:          return "Awards";
      case DrawerItems.performance:     return "Performance";
      case DrawerItems.team:            return "Team";
      case DrawerItems.challenges:      return "Challenges";
      case DrawerItems.logout:          return "Logout";
      default:                          return "";
    }
  }

  String get pageRoute {
    switch(this){
      case DrawerItems.profile:         return profileAndSettingsRoute;
      case DrawerItems.learnings:       return questionsRoute;
      case DrawerItems.modules:         return moduleRoute;
      case DrawerItems.ranking:         return otherRoute;
      case DrawerItems.achievements:    return otherRoute;
      case DrawerItems.awards:          return otherRoute;
      case DrawerItems.performance:     return otherRoute;
      case DrawerItems.team:            return otherRoute;
      case DrawerItems.challenges:      return otherRoute;
      case DrawerItems.logout:          return "Logout";
      default:                          return "";
    }
  }

  BottomItems get bottomItem {
    switch(this){
      case DrawerItems.profile:         return BottomItems.profileAndSettings;
      case DrawerItems.learnings:       return BottomItems.questions;
      case DrawerItems.modules:         return BottomItems.modules;
      case DrawerItems.ranking:         return BottomItems.others;
      case DrawerItems.achievements:    return BottomItems.others;
      case DrawerItems.awards:          return BottomItems.others;
      case DrawerItems.performance:     return BottomItems.others;
      case DrawerItems.team:            return BottomItems.others;
      case DrawerItems.challenges:      return BottomItems.others;
      case DrawerItems.logout:          return null;
      default:                          return null;
    }
  }

}


enum BottomItems{
  questions,
  modules,
  others,
  profileAndSettings
}


extension BottomItemsExtension on BottomItems {

  String get title {
    switch(this){
      case BottomItems.questions:           return "Questions";
      case BottomItems.modules:             return "Modules";
      case BottomItems.others:              return "Others";
      case BottomItems.profileAndSettings:  return "Profile";
      default:                              return null;
    }
  }

  Widget get page {
    switch(this){
      case BottomItems.questions:           return QuestionsPagePortrait();
      case BottomItems.modules:             return ModulePagePortrait();
      case BottomItems.others:              return OtherPagePortrait();
      case BottomItems.profileAndSettings:  return ProfileAndSettingsPagePortrait();
      default:                              return null;
    }
  }
}


class ScreensManager {

  static final ScreensManager _singleton = ScreensManager._internal();

  factory ScreensManager() {
    return _singleton;
  }

  ScreensManager._internal();

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> forthTabNavKey = GlobalKey<NavigatorState>();

  bool isTabBarVisible = false;
  bool isTeamVisible = false;

  BottomNavigationPortraitState _bottomNavigationPortraitState;

  BottomNavigationPortraitState get bottomNavigationPortraitState =>
      _bottomNavigationPortraitState;

  set bottomNavigationPortraitState(BottomNavigationPortraitState value) {
    _bottomNavigationPortraitState = value;
  }

}