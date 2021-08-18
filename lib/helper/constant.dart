import 'package:knowledge_empire/injection/dependency_injection.dart';

import 'flavor_config.dart';

enum Environment { DEV, PROD }

class Const {
  static var deviceType = "android";
  static Environment envType;
  static bool isLandscape = true;

  static var typeHome = "0";
  static var typeBusinessSector = "1";
  static var typeNewCustomer = "2";
  static var typeExistingCustomer = "3";
  static var typeAchievement = "4";
  static var typeTeam = "5";
  static var typeChallenges = "6";
  static var typeOrg = "7";
  static var typePl = "8";
  static var typeRanking = "9";
  static var typeReward = "10";
  static var typeProfile = "15";
  static var typeHelp = "11";
  static var typeEngagement = "12";
  static var typeCustomerSituation = "13";
  static var updateProfileBrod = "14";

  // push type

  static var pushTypeAll = 1;
  static var pushTypeChallenge = 2;
  static var pushTypeWinChallenge = 3;
  static var pushTypeAddFriend = 4;
  static var pushTypeAchievement = 5;
  static var pushTypeUnansweredQuestion = 6;
  static var pushTypeModule = 7;

  static var openPendingChallengeDialog = 201;

  static var typeName = "100";

  static var typeSalesPersons = "101";
  static var typeEmployee = "102";
  static var typeBrandValue = "103";
  static var typeServicesPerson = "104";
  static var typeMoney = "105";

  static var typeHR = 1;
  static var typeMarketing = 2;
  static var typeSales = 3;
  static var typeOperations = 4;
  static var typeLegal = 5;
  static var typeFinance = 6;
  static var typeCRM = 7;
  static var typeServices = 8;

  static var typeMoneyAnim = "typeMoneyAnim";

  static var businessMode = 1;
  static var professionalMode = 2;

// answer type is text or media
  static var typeAnswerText = 1;
  static var typeAnswerMedia = 2;
  static var typeAnswerMediaWithQuestion = 3;

  // privacy policy type
  static var typeGetPrivacyPolicy = 1;
  static var typeUpdateAccessTime = 2;

  static var typeCamera = 101;
  static var typeGallery = 102;

  static int imgQuality = 20;
  static double imgScaleProfile = 1;

  static int subscribe = 1;
  static int unSubscribe = 0;

  static int add = 1;
  static int subtract = 2;

  static int getNewQueType = 1;
  static int getExistingQueType = 2;

  static int typeCost = 1;
  static int typeRevenue = 2;

  static FlavorConfig _config;

  //language
  static var english = "English";
  static var german = "German";
  static var chinese = "Chinese";

  //pl screen dd_mm_yy
  static int plDay = 1;
  static int plMonth = 2;
  static int plYear = 3;

  static void setEnvironment(Environment env) {
    envType = env;
    Injector.isDev = (envType == Environment.DEV);
    switch (env) {
      case Environment.DEV:
        _config = AppConfig.devConfig();
        break;
      case Environment.PROD:
        _config = AppConfig.prodConfig();
        break;
    }
  }

  static get webUrl {
    return _config.webUrl;
  }

  static get appName {
    return _config.appName;
  }
}
