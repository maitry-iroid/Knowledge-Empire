import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/routes/route_names.dart';
import 'package:ke_employee/screens_portrait/achievement.dart';
import 'package:ke_employee/screens_portrait/achievement_detail.dart';
import 'package:ke_employee/screens_portrait/bottom_navigation.dart';
import 'package:ke_employee/screens_portrait/challenge.dart';
import 'package:ke_employee/screens_portrait/change_password.dart';
import 'package:ke_employee/screens_portrait/drawer.dart';
import 'package:ke_employee/screens_portrait/history.dart';
import 'package:ke_employee/screens_portrait/login.dart';
import 'package:ke_employee/screens_portrait/module.dart';
import 'package:ke_employee/screens_portrait/module_detail.dart';
import 'package:ke_employee/screens_portrait/other.dart';
import 'package:ke_employee/screens_portrait/performance.dart';
import 'package:ke_employee/screens_portrait/performance_detail.dart';
import 'package:ke_employee/screens_portrait/performance_module_detail.dart';
import 'package:ke_employee/screens_portrait/profile_and_settings.dart';
import 'package:ke_employee/screens_portrait/questions.dart';
import 'package:ke_employee/screens_portrait/ranking.dart';
import 'package:ke_employee/screens_portrait/rewards.dart';
import 'package:ke_employee/screens_portrait/rewards_detail.dart';
import 'package:ke_employee/screens_portrait/team.dart';
import 'package:ke_employee/screens_portrait/team_detail.dart';

class CustomRouter{

  static Route<dynamic> allRoutes(RouteSettings settings){
    switch(settings.name){
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPagePortrait());
      case bottomNavigationRoute:
        return MaterialPageRoute(builder: (_) => BottomNavigationPortrait());
      case drawerRoute:
        return MaterialPageRoute(builder: (_) => DrawerPortrait());
      case moduleRoute:
        return MaterialPageRoute(builder: (_) => ModulePagePortrait());
      case otherRoute:
        return MaterialPageRoute(builder: (_) => OtherPagePortrait());
      case questionsRoute:
        return MaterialPageRoute(builder: (_) => QuestionsPagePortrait());
      case profileAndSettingsRoute:
        return MaterialPageRoute(builder: (_) => ProfileAndSettingsPagePortrait());
    }
    return MaterialPageRoute(builder: (_) => LoginPagePortrait());
  }

  // ignore: missing_return
  static Route getRoute({@required String name, dynamic parameter}) {
    switch(name){
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => ChangePasswordPortrait(parameter));
      case teamRoute:
        return MaterialPageRoute(builder: (_) => TeamPortrait(parameter));
      case teamDetailRoute:
        return MaterialPageRoute(builder: (_) => TeamDetailPortrait());
      case rewardsRoute:
        return MaterialPageRoute(builder: (_) => RewardsPortrait());
      case rewardDetailRoute:
        return MaterialPageRoute(builder: (_) => RewardsDetailPortrait());
      case performanceRoute:
        return MaterialPageRoute(builder: (_) => PerformancePortrait());
      case performanceDetailRoute:
        return MaterialPageRoute(builder: (_) => PerformanceDetailPortrait());
      case performanceModuleDetailRoute:
        return MaterialPageRoute(builder: (_) => PerformanceModuleDetailPortrait());
      case rankingRoute:
        return MaterialPageRoute(builder: (_) => RankingPortrait());
      case achievementRoute:
        return MaterialPageRoute(builder: (_) => AchievementPortrait());
      case achievementDetailRoute:
        return MaterialPageRoute(builder: (_) => AchievementDetailPortrait());
      case challengeRoute:
        return MaterialPageRoute(builder: (_) => ChallengePortrait());
      case historyRoute:
        return MaterialPageRoute(builder: (_) => HistoryPortrait());
      case moduleDetailRoute:
        return MaterialPageRoute(builder: (_) => ModuleDetailPortrait(parameter));
    }
  }

}
