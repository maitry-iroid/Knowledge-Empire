import 'package:ke_employee/injection/dependency_injection.dart';

enum Environment { DEV, PROD }

class Const {
  static var deviceType = "android";
//  static var typeHome = 0;
//  static var typeBusinessSector = 1;
//  static var typeNewCustomer = 2;
//  static var typeExistingCustomer = 3;
//  static var typeReward = 4;
//  static var typeTeam = 5;
//  static var typeChallenges = Injector.isManager() == 1 ? 6 : 5;
//  static var typeOrg = Injector.isManager() == 1 ? 7 : 6;
//  static var typePL = Injector.isManager() == 1 ? 8 : 7;
//  static var typeRanking = Injector.isManager() == 1 ? 9 : 8;
//  static var typeProfile = 10;
//  static var typeHelp = 11;
//  static var typeEngagement = 12;
//  static var typeCustomerSituation = 13;

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
  static int getExistingQueTYpe = 2;

  static int typeCost = 1;
  static int typeRevenue = 2;

  static int introTypeProfile = 101;
  static int introTypeProfileUserDetails = 102;
  static int introTypeSettings= 103;
  static int introTypeOrg= 104;
  static int introTypeHireHR= 105;
  static int introTypeHireHeaderEmployee= 105;
  static int introTypeHireHeaderTest= 106;

  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get SERVER_ONE {
    return _config[_Config.SERVER_ONE];
  }

  static get APP_NAME {
    return _config[_Config.APP_NAME];
  }

  static get WHERE_AM_I {
    return _config[_Config.WHERE_AM_I];
  }
}

class _Config {
  static const SERVER_ONE = "SERVER_ONE";
  static const APP_NAME = "APP_NAME";
  static const WHERE_AM_I = "WHERE_AM_I";

  static Map<String, dynamic> debugConstants = {
    SERVER_ONE: "http://13.127.186.25:7000/api",
//    SERVER_ONE: "http://13.127.186.25:7001/api",  // for achievement feature
    APP_NAME: "KE Dev",
  };

  static Map<String, dynamic> prodConstants = {
    SERVER_ONE: "http://18.141.132.109:7000/api",
    APP_NAME: "KE Prod",
  };



}
