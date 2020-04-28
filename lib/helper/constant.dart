import 'package:ke_employee/injection/dependency_injection.dart';

import 'flavor_config.dart';

enum Environment { DEV, PROD }

class Const {
  static var deviceType = "android";
  static Environment envType;

  static var typeHome = "home";
  static var typeBusinessSector = "businessSector";
  static var typeNewCustomer = "newCustomer";
  static var typeExistingCustomer = "existingCustomer";
  static var typeReward = "reward";
  static var typeTeam = "team";
  static var typeChallenges = "challenge";
  static var typeOrg = "org";
  static var typePl = "pl";
  static var typeRanking = "ranking";
  static var typeProfile = "profile";
  static var typeHelp = "help";
  static var typeEngagement = "engagement";
  static var typeCustomerSituation = "customerSituation";
  static var updateProfileBrod = "updateProfileBrod";


  // push type


  static var pushTypeAll = 1;
  static var pushTypeChallenge = 2;
  static var pushTypeWinChallenge = 3;
  static var pushTypeAddFriend = 4;
  static var pushTypeAchievement = 5;
  static var pushTypeUnansweredQuestion = 6;
  static var pushTypeModule = 7;

  static var openPendingChallengeDialog = 101;

  static var typeName = "26";
  static var typeSideMenu = 27;

  static var typeSalesPersons = "11";
  static var typeEmployee = "12";
  static var typeBrandValue = "13";
  static var typeServicesPerson = "14";
  static var typeMoney = "15";

  static var typeHR = 1;
  static var typeMarketing = 2;
  static var typeSales = 3;
  static var typeOperations = 4;
  static var typeLegal = 5;
  static var typeFinance = 6;
  static var typeCRM = 7;
  static var typeServices = 8;

  static var businessMode = 1;
  static var professionalMode = 2;

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
  static var german  = "German";
  static var chinese = "Chinese";

  //pl screen dd_mm_yy
  static int plDay   = 1;
  static int plMonth = 2;
  static int plYear  = 3;

  static void setEnvironment(Environment env) {
    envType = env;
    Injector.isDev = envType == Environment.DEV;
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
