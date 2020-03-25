import 'package:ke_employee/injection/dependency_injection.dart';

import 'flavor_config.dart';

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

  static var typeMoneyAnim = "typeMoneyAnim";

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

  static int introTypeProfile = 101;
  static int introTypeProfileUserDetails = 102;
  static int introSettings = 103;
  static int introTypeOrg = 104;
  static int introHireHR = 105;
  static int introHireHeaderEmployee = 106;
  static int introHireHeaderTest = 107;
  static int introMeetYourTeam = 108;
  static int introHireHREmployeesBoard = 109;
  static int introEmployOMeter = 110;
  static int introCostOfEmployees = 111;
  static int introGetReadyToApproachCustomers = 112;
  static int introSalesOMeter = 113;
  static int introGetReadyToServeCustomers = 114;
  static int introReadyForSeriousBusiness = 115;
  static int introCustomerRelationshipManagement = 116;
  static int introAreaOfCompetency = 117;
  static int introAccesToYourFirstCustomers = 118;
  static int introReadyForYourFirstCustomerContact = 119;
  static int introHeartOfTheBusiness = 120;
  static int introListOfPotentialCustomers = 121;
  static int introYourFirstEngegement = 122;
  static int introImpactOnSalesAndService = 123;
  static int introImpactOnBrandValueAndCash = 124;
  static int introCheckYourExistingCustomers = 125;
  static int introServingYourExistingCustomers = 126;
  static int introListOfExistingCustomers = 127;
  static int introReadyForBusiness = 128;
  static int introRewards = 129;
  static int introYourWillIsAtYourCommand = 130;
  static int introChallanges = 131;
  static int introMarketingAndCommunications = 132;
  static int introRanking = 133;
  static int introYourTeamsPerformance = 134;
  static int introYourTeams = 135;
  static int introYourTeams2 = 136;
  static int introThePersonYouCanCountOn = 137;
  static int introPL= 138;

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
