import 'package:ke_employee/helper/string_res.dart';

enum OtherTabOptions { ranking, achievement, awards, performance, team, challenges, history }

extension OtherTabOptionExtension on OtherTabOptions {
  String get title {
    switch (this) {
      case OtherTabOptions.ranking:
        return StringRes.ranking;
      case OtherTabOptions.achievement:
        return StringRes.achievement;
      case OtherTabOptions.awards:
        return StringRes.rewards;
      case OtherTabOptions.performance:
        return "Performance"; //TODO change title of performance
      case OtherTabOptions.team:
        return StringRes.team;
      case OtherTabOptions.challenges:
        return StringRes.challenge;
      case OtherTabOptions.history:
        return "History";
    }
  }
}
