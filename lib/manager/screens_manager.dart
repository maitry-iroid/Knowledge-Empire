import 'package:flutter/cupertino.dart';

enum DrawerItems { profile, learnings, modules, ranking, achievements, awards, performance, team, challenges, logout }

extension DrawerItemsExtension on DrawerItems {
  String get title {
    switch (this) {
      case DrawerItems.profile:
        return "Profile";
      case DrawerItems.learnings:
        return "Learnings";
      case DrawerItems.modules:
        return "Modules";
      case DrawerItems.ranking:
        return "Ranking";
      case DrawerItems.achievements:
        return "Achievements";
      case DrawerItems.awards:
        return "Awards";
      case DrawerItems.performance:
        return "Performance";
      case DrawerItems.team:
        return "Team";
      case DrawerItems.challenges:
        return "Challenges";
      case DrawerItems.logout:
        return "Logout";
      default:
        return "";
    }
  }

  BottomItems get bottomItem {
    switch (this) {
      case DrawerItems.profile:
        return BottomItems.profileAndSettings;
      case DrawerItems.learnings:
        return BottomItems.questions;
      case DrawerItems.modules:
        return BottomItems.modules;
      case DrawerItems.ranking:
        return BottomItems.others;
      case DrawerItems.achievements:
        return BottomItems.others;
      case DrawerItems.awards:
        return BottomItems.others;
      case DrawerItems.performance:
        return BottomItems.others;
      case DrawerItems.team:
        return BottomItems.others;
      case DrawerItems.challenges:
        return BottomItems.others;
      case DrawerItems.logout:
        return null;
      default:
        return null;
    }
  }
}

enum BottomItems { questions, modules, others, profileAndSettings }

extension BottomItemsExtension on BottomItems {
  String get title {
    switch (this) {
      case BottomItems.questions:
        return "Questions";
      case BottomItems.modules:
        return "Modules";
      case BottomItems.others:
        return "Others";
      case BottomItems.profileAndSettings:
        return "Profile";
      default:
        return null;
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
}
