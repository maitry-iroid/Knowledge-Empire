import 'package:ke_employee/injection/dependency_injection.dart';

class StringRes {
  static String username = Injector.userData?.name ?? "";

  //<editor-fold desc="old strings">
  static var accept = "accept";
  static var decline = "decline";

  //main options
  static var home = "home";
  static var businessSector = "businessSector";
  static var newCustomers = "newCustomers";
  static var existingCustomers = "existingCustomers";
  static var organizations = "organizations";
  static var challenges = "challenges";
  static var challenge = "challenge";
  static var pl = "pl";
  static var rewards = "rewards";
  static var ranking = "ranking";
  static var team = "team";
  static var profile = "profile";
  static var help = "help";
  static var strDefault = "Default";
  static var asc = "Asc";
  static var desc = "Desc";

  //profile
  static var emailId = "emailId";
  static var editProfile = "editProfile";
  static var yourName = "yourName";
  static var yourEmail = "yourEmail";
  static var changePassword = "changePassword";
  static var save = "save";
  static var settings = "settings";
  static var privacyPolicy = "privacyPolicy";
  static var termsConditions = "termsConditions";
  static var contactUs = "contactUs";
  static var switchProfMode = "switchProfMode";
  static var switchBusinessMode = "switchBusinessMode";
  static var logout = "logout";
  static var choosePhoto = "choosePhoto";
  static var takePhoto = "takePhoto";
  static var sound = "sound";
  static var bailout = "bailout";
  static var requestBailOut = "requestbailout";
  static var alertBailOut = "alertBailOut";
  static var successProfileUpdate = "successProfileUpdate";
  static var selectCompany = "selectCompany";
  static var selectLanguage = "selectLanguage";
  static var english = "english";
  static var german = "german";
  static var chinese = "chinese";

  //login
  static var login = "login";
  static var enterRegisteredEmail = "enterRegisteredEmail";
  static var password = "password";
  static var usernameText = "username";
  static var newPassword = "newPassword";
  static var currentPassword = "currentPassword";
  static var reEnterPassword = "reEnterPassword";
  static var cancel = "cancel";
  static var send = "send";
  static var forgotPassword = "forgotPassword";

  //TODO add for other language
  static var newNickName = "newNickName";
  static var nickname = "nickName";
  static var enterPassPhrase = "EnterparsePhrase";

  //TODO add for other language
  static var companyCode = "companyCode";
  static var addKey = "Addkey";
//  static var selectLanguages = "selectLanguages"; //onlu define english

  //organization
  static var fireEmp = "fireEmp";
  static var hireEmp = "hireEmp";

  //new customer
  static var sector = "sector";
  static var Level = "Level";
  static var Retention = "Retention";
  static var DaysInLimit = "DaysInLimit";
  static var name = "name";
  static var value = "value";
  static var loyalty = "loyalty";
  static var resources = "resources";
  static var engage = "engage";
  static var engageNow = "engageNow";

  //existing customer
  static var endRel = "endRel";
  static var alertReleaseResources = "alertReleaseResources";

  //challenges
  static var searchForKeywords = "searchForKeywords";
  static var somethingWrong = "Something went wrong";
  static var friend = "friend";
  static var alertFriendSuccess = "alertFriendSuccess";
  static var alertUnFriendSuccess = "alertUnFriendSuccess";
  static var alertUChallengeSent = "alertUChallengeSent";
  static var by = "by";
  static var inText = "inText";
  static var toWin = "toWin";
  static var questions = "questions";

  //Rewards module
  static var redeem = "redeem";
  static var costReward = "costReward";
  static var costUnit = "costUnit";
  static var unitsLeft = "unitsLeft";
  static var categories = "categories";

  //learning module
  static var subscribe = "subscribe";
  static var unSubscribe = "unSubscribe";
  static var contactExpert = "contactExpert";
  static var moreInformation = "moreInformation";
  static var subscribed = "subscribed";
  static var downLoad = "downLoad";
  static var size = "size";
  static var description = "description";
  static var alertWantToSubscribe1 = "alertWantToSubscribe1";
  static var alertWantToSubscribe2 = "alertWantToSubscribe2";
  static var downloading = "downloading";
  static var downloadText = "downloadText";
  static var alertNotAllowed = "alertNotAllowed";

  //engage customer
  static var engagement = "engagement";
  static var debrief = "debrief";
  static var category = "category";
  static var achievement = "achievement";
  static var nextLevel = "nextLevel";

  static var friends = "friends";
  static var competitor = "competitor";
  static var sendChallenge = "sendChallenge";
  static var next = "next";
  static var backToList = "BackToList";

//  engage customer

  static var answers = "answers";
  static var question = "question";
  static var explanation = "explanation";
  static var alertSelectOneOption = "alertSelectOneOption";

  //customer situation
  static var situation = "situation";
  static var profit = "profit";

  //team
  static var learningModule = "learningModule";
  static var levels = "levels";
  static var complete = "complete";
  static var qLevel = "qLevel";
  static var qStatus = "qStatus";
  static var lastLog = "lastLog";
  static var points = "points";
  static var correct = "correct";
  static var department_ = "department_";
  static var department = "department";
  static var resets_ = "resets_";
  static var name_ = "name_";
  static var cost = "cost";

  //ranking
  static var you = "you";
  static var world = "world";
  static var country = "country";
  static var score = "score";
  static var companyName = "companyName";
  static var revenue = "revenue";
  static var hashCustomers = "hashCustomers";
  static var brand = "brand";

  //pl
  static var cashAtStartOfPeriod = "cashAtStartOfPeriod";
  static var cashAtTheEndOfPeriod = "cashAtTheEndOfPeriod";
  static var costSplit = "costSplit";
  static var revenueSplit = "revenueSplit";
  static var employees = "employees";
  static var salaries = "salaries";
  static var customers = "customers";
  static var day = "day";
  static var month = "month";
  static var year = "year";
  static var total = "total";
  static var lastPeriod = "lastPeriod";
  static var thisPeriod = "thisPeriod";
  static var sevenDaysDevelopment = "sevenDaysDevelopment";
  static var cash = "cash";

  //alerts
  static var alertWantToBailOut = "alertWantToBailOut";
  static var alertNoModuleFound = "alertNoModuleFound";

  static var ok = "ok";
  static var yes = "yes";
  static var no = "no";
  static var comingSoon = "comingSoon";
  static var close = "close";
  static var alert = "alert";
  static var alertUnFriend = "alertUnFriend";

  //introDialog
  static var gotIt = "gotIt";
  static var rewardsDialogContent = "rewardsDialogContent";

  static var challengesDialogTitle1 = "challengesDialogTitle1";
  static var challengesDialogContent1 = "challengesDialogContent1";
  static var strChallanges = "strChallanges";
  static var strChallangesDialogContent = "strChallangesDialogContent";
  static var strMarketingCommunications = "strMarketingCommunications";
  static var strMarketingCommunicationsDialog = "strMarketingCommunicationsDialog";
  static var strRankingDialogContent = "strRankingDialogContent";
  static var strYourTeamPerformance = "strYourTeamPerformance";
  static var strYourTeamPerformanceDialog = "strYourTeamPerformanceDialog";
  static var strTeamDialog = "strTeamDialog";
  static var strYourTeamPerformanceDialog2 = "strYourTeamPerformanceDialog2";

  //pl screen
  static var plPerson = "plPerson";
  static var niceMeetYou = "niceMeetYou";
  static var plMyName = "plMyName";
  static var hereYourMonitor = "hereYourMonitor";
  static var selectPeriod = "selectPeriod";
  static var graphShow = "graphShow";

  //existing customer dialog
  static var servingYourExisting = "servingYourExisting";
  static var servingYourExistingDialog = "servingYourExistingDialog";
  static var listOfExisting = "listOfExisting";
  static var listOfExistingDetails = "listOfExistingDetails";

  static var readyForBusiness = "readyForBusiness";
  static var readyForBusinessDeatils = "readyForBusinessDeatils";
  static var finishTutorial = "finishTutorial";

  //customer situation dialog
  static var impactOnSales = "impactOnSales";
  static var impactOnSalesDetails = "impactOnSalesDetails";
  static var impactOnBrand = "impactOnBrand";
  static var impactOnBrandDetails = "impactOnBrandDetails";
  static var checkYourCustomer = "checkYourCustomer";
  static var checkYourCustomerDetails = "checkYourCustomerDetails";
  static var clickServiceBtn = "clickServiceBtn";

  //engagement dialog
  static var yourFirstEngagement = "yourFirstEngagement";
  static var yourFirstEngagementDetails = "yourFirstEngagementDetails";
  static var yourFirstEngagementBtn = "yourFirstEngagementBtn";

  //New Customer screen dialog
  static var heartBusiness = "heartBusiness";
  static var heartBusinessDetails = "heartBusinessDetails";
  static var listOfPotential = "listOfPotential";
  static var listOfPotentialDetails = "listOfPotentialDetails";
  static var listOfPotentialBtn = "listOfPotentialBtn";

  //Business sector screen dialog
  static var customerRelation = "customerRelation";
  static var customerRelationDetails = "customerRelationDetails";
  static var areaOfComp = "areaOfComp";
  static var areaOfCompDetails = "areaOfCompDetails";
  static var accessToFirst = "accessToFirst";
  static var accessToFirstDetails = "accessToFirstDetails";
  static var accessToFirstBtn = "accessToFirstBtn";
  static var readyForCustomer = "readyForCustomer";
  static var readyForCustomerDetails = "readyForCustomerDetails";
  static var readyForCustomerBtn = "readyForCustomerBtn";

//  static var selectPeriod = "selectPeriod";
  // dashboard intro popup
  static var dashboardProfile = "dashboardProfile";
  static var dashboardSales = "dashboardSales";
  static var dashboardServices = "dashboardServices";
  static var dashboardBalance = "dashboardBalance";
  static var dashboardBusiness = "dashboardBusiness";
  static var dashboardNewCustomer = "dashboardNewCustomer";
  static var dashboardExistingCustomer = "dashboardExistingCustomer";

  //business sectoer
  static var customersRelationShip = "customersRelationShip";
  static var customersRelationShipContent = "customersRelationShipContent";
  static var areaOfCompetency = "areaOfCompetency";
  static var areaOfCompetenceContent = "areaOfCompetenceContent";

  //newCustomer
  static var theHeartOfTheBusiness = "customersRelationShip";

  //profile
  static var customizeYourCompany = "customizeYourCompany";
  static var customizeYourCompanyContent = "customizeYourCompanyContent";

  //Organization screen Dialog
  static var hireHrEmp = "hireHrEmp";
  static var hireHrEmpDetails = "hireHrEmpDetails";
  static var hireHrEmpDetailsSeconds = "hireHrEmpDetailsSeconds";
  static var empOMaster = "empOMaster";
  static var empOMasterDetails = "empOMasterDetails";
  static var costOfEmp = "costOfEmp";
  static var costOfEmpDetails = "costOfEmpDetails";

  //setting screen Dialog
  static var settingDetails = "settingDetails";

  //lock feature

  static var unLockOrg = "unLockOrg";
  static var unLockPl = "unLockPl";
  static var unLockRanking = "unLockRanking";
  static var unLockReward = "unLockReward";
  static var unLockChallenge = "unLockChallenge";

//Dashboard Game screen
  static var welcomeToKnow = "welcomeToKnow";
  static var welcomeToKnowDetails = "welcomeToKnowDetails";
  static var clickYourProfile = "clickYourProfile";

  static var meetYourTeam = "meetYourTeam";
  static var meetYourTeamDetails = "meetYourTeamDetails";
  static var clickOrgChart = "clickOrgChart";

  static var getReadyApproach = "getReadyApproach";
  static var getReadyApproachDetails = "getReadyApproachDetails";
  static var clickSale = "clickSale";

  static var salesOMeter = "salesOMeter";
  static var salesOMeterDetails = "salesOMeterDetails";

  static var getReadyServer = "getReadyServer";
  static var getReadyServerDetails = "getReadyServerDetails";
  static var clickOnService = "clickOnService";
  static var serviceOMeter = "serviceOMeter";
  static var serviceOMeterDetails = "serviceOMeterDetails";

  static var readyForSerious = "readyForSerious";
  static var readyForSeriousDetails = "readyForSeriousDetails";
  static var goToBusiness = "goToBusiness";

  //me
  //subscribed
  static var subscribedSuccess = "subscribedSuccess";
  static var unSubscribedSuccess = "unSubscribedSuccess";

  //index

  //validation
  static var emailEmpty = "emailEmpty";
  static var passWordEmpty = "passWordEmpty";
  static var mailSent = "mailSent";
  static var enterOldPassword = "enterOldPassword";
  static var enterNewPassword = "enterNewPassword ";
  static var enterRePassword = "enterRePassword";
  static var enterSameNewPassword = "enterSameNewPassword";
  //TODO add for other language
  static var enterNickName = "enterNickName";
  //TODO add for other language
  static var enterCompanyCode = "enterCompanyCode";
  static var changeLanguage = 'changeLanguage';
  static var passwordChange = "passwordChange";
  static var nicknameChange = "nicknameChange";
  static var passPhraseCharacters = "parsephrasemustbe16characters";
  //intro page
  static var skipTutorial = "skipTutorial";

  //ranking
  static var addFriend = "addFriend";
  static var unFriend = "unFriend";

  //pushNotification alert
  static var congratulations = "congratulations";
  static var collector = "collector";
  static var businessSegments = "businessSegments";
  static var businessSegmentsNew = "businessSegmentsNew";
  static var dear = "dear";
  static var hi = "hi";
  static var noInternet = "noInternet";
  static var updateNow = "update";

  static var updateLatter = "updateLatter";

  static var serviceReps = "serviceReps";
  static var salesReps = "salesReps";

  static var noOffline = "noOffline";

  static var my = "my";
  static var mHis = "mHis";
  static var needAtList = "needAtList";
  static var sizeInKb = "sizeInKb";
  static var strKp = "strKp";
  static var requestDemoAccount = "requestDemoAccount";
  static var GeneratePassPhrase = "generatePhraseCode";
  static var strVersion = "strVersion";
  static var strUrlExeption = "strUrlExeption";
  static var strOpen = "strOpen";

  //help screen
  static var helpProProfile = "helpProProfile";
  static var helpProEmployMeter = "helpProEmployMeter";
  static var helpProSalesMeter = "helpProSalesMeter";
  static var helpProServiceMeter = "helpProServiceMeter";
  static var helpProBrandValue = "helpProBrandValue";
  static var helpProCash = "helpProCash";
  static var helpProBusinessSector = "helpProBusinessSector";
  static var helpProNewCustomers = "helpProNewCustomers";
  static var helpProExistingCustomer = "helpProExistingCustomer";
  static var helpProRewards = "helpProRewards";
  static var helpProTeam = "helpProTeam";
  static var helpProChallenges = "helpProChallenges";
  static var helpProOrganization = "helpProOrganization";
  static var helpProP = "helpProP";
  static var helpProRanking = "helpProRanking";

  //</editor-fold>

  static String strProProfile = "strProProfile";
  static String strEmpOMeter = "strEmpOMeter";
  static String strSalesOMeter = "strSalesOMeter";
  static String strServiceOMeter = "strServiceOMeter";
  static String strBrandValue = "strBrandValue";
  static String strCash = "strCash";
  static String strBusinessSector = "strBusinessSector";
  static String strNewCustomer = "strNewCustomer";
  static String strExistingCustomer = "strExistingCustomer";
  static String strAchievement = "strAchievement";
  static String strReward = "strReward";
  static String strTeam = "strTeam";
  static String strChallenges = "strChallenges";
  static String strOrganization = "strOrganization";
  static String strPL = "strPL";
  static String strBrandValueTitle = "strBrandValueTitle";
  static String strRanking = "strRanking";
  static String strBalance = "strBalance";
  static String targetLevel = "targetLevel";
  static String targetRetention = "targetRetention";
  static String certificationCriteria = "certificationCriteria";

  static Map<String, Map<String, String>> localizedValues = {
    'en': {
      //Nickname
      'enterNickName': 'Please enter nickname',
      'nicknameChange': 'Nickname changed Successfully',
      'newNickName': 'New Nickname',
      'nickName': 'Nickname',
      'downloadText': 'This module will occupie ',

      //Company code
      'enterCompanyCode': 'Please enter company code that you received in your email',
      'changeLanguage': 'Change Language',
      'companyCode': 'Company code',

      //password
      'enterSameNewPassword': 'Please enter same new password.',
      'enterRePassword': 'Please re-eneter new Password.',
      'enterNewPassword ': 'Please enter new Password.',
      'enterOldPassword': 'Please enter old Password.',

      //<editor-fold desc="english">
      //main options
      'accept': "Accept",
      "decline": "Decline",
      'home': "Home",
      'businessSector': "Business Sector",
      'newCustomers': "New Customers",
      'existingCustomers': "Existing Customers",
      'organizations': "Organizations",
      'challenges': "Challenges",
      'challenge': "Challenge",
      'pl': "P+L",
      'rewards': "Rewards",
      'ranking': "Ranking",
      'team': "Team",
      'profile': "Profile",
      'help': "Help",

      //profile
      'emailId': 'Email Id',
      'editProfile': 'Edit Profile',
      'yourName': 'Your Name',
      'yourEmail': 'Your Email',
      'changePassword': 'Change Password',
      'save': 'Save',
      'settings': 'Settings',
      'privacyPolicy': 'Privacy & Policy',
      'termsConditions': 'Terms & Conditions',
      'contactUs': 'Contact Us',
      'switchProfMode': 'Switch to Professional Mode',
      'switchBusinessMode': 'Switch to Business Mode',
      'logout': 'Log out',
      'choosePhoto': "Choose photo",
      'takePhoto': "Take photo",
      'sound': 'Sound',
      'bailout': 'Bail Out',
      'requestbailout': 'Request Bail Out',
      'alertBailOut': "Are you sure you want to Bail Out?",
      'successProfileUpdate': 'Profile updated successfully!',
      'selectCompany': "Select Company",
      'selectLanguage': "Select Language",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",

      //login
      'login': 'Login',
      'enterRegisteredEmail': 'Enter Registered Email Id',
      'password': 'Password',
      'newPassword': 'New Password',
      'currentPassword': 'Current Password',
      'reEnterPassword': 'Re-enter new Password',
      'cancel': 'Cancel',
      'send': 'Send',
      'forgotPassword': 'Forgot Password?',
      'selectLanguages': 'Select Language',

      //organization
      'fireEmp': "Fire 10 employees",
      'hireEmp': "Hire 10 employees",

      //new customer
      'sector': 'Sector',
      'name': 'Name',
      'value': 'Value',
      'loyalty': 'Loyalty',
      'resources': 'Resources',
      'engage': 'Engage',
      'engageNow': 'Engage Now',

      //existing customer
      'endRel': 'End Rel.',
      'alertReleaseResources': "This customer will be removed, not generate any more revenue and only be accessible again after Loyalty period",

      //challenges
      'searchForKeywords': 'Search for keywords',
      'somethingWrong': 'Something went wrong',
      'friend': 'Friend',
      'alertFriendSuccess': "Friend added successfully",
      'alertUnFriendSuccess': "Unfriend successfully",
      'alertUChallengeSent': "Challenge sent successfully!",

      // Rewards module
      'redeem': 'Redeem',
      'costReward': 'Cost',
      'costUnit': 'virtual cash',
      'unitsLeft': "Units left",
      'categories': 'Categories',

      //learning module
      'subscribe': 'Subscribe',
      'unSubscribe': 'Unsubscribe',
      'contactExpert': 'Contact Expert',
      'moreInformation': 'More Information',
      'subscribed': 'Subscribed',
      'downLoad': 'DownLoad',
      'size': 'Size',
      'description': 'Description',
      'alertWantToSubscribe1': "Are you sure, you want to unsubscribe from this module? All progress will be lost. ",
      'alertWantToSubscribe2': "? You will lose all the questions from the ",
      'downloading': "Downloading...",
      'alertNotAllowed': "You can not unsubscribe assigned Business Segments.",

      //engage customer
      'engagement': 'Situation',
      'situation': 'Debriefing',
      'category': 'Category',
      'achievement': 'Achievement',
      'nextLevel': 'Next Level',
      'friends': 'Friends',
      'competitor': 'Competitor',
      'sendChallenge': 'Send Challenge',
      'next': 'Next',
      'BackToList': 'Back to List',

      //  engage customer
      'answers': 'Answers',
      'question': 'Question',
      'explanation': 'Explanation',
      'alertSelectOneOption': "Please select at least one option.",

      //customer situation
      'profit': "Profit",

      //team
      'learningModule': "Learning Module",
      'levels': "Levels",
      'complete': "%Complete",
      'qLevel': "Q Level",
      'qStatus': "Q Status",
      'lastLog': "Last Log",
      'points': "Points",
      'correct': "%Correct",
      'department_': "Department:",
      'department': "Department",
      'resets_': "Resets:",
      'name_': "Name:",
      'cost': "Cost",

      //ranking
      'you': "You",
      'world': "World",
      'country': "Country",
      'score': 'Score',
      'companyName': 'Company Name',
      'revenue': "Revenue",
      'hashCustomers': "#Customers",
      'brand': "Brand",

      //pl
      'revenueSplit': "revenueSplit",
      'employees': "Employees",
      'salaries': "Salaries",
      'customers': "Customers",
      'day': "Day",
      'month': "Month",
      'year': "Year",
      "total": "total",
      'lastPeriod': "Last Period",
      'thisPeriod': "This Period",

      //alerts
      'alertWantToBailOut': "Are you sure you want to Bail Out.",
      'alertNoModuleFound': "Oops..No learining module found for this user.",
      'ok': "Ok",
      'yes': "Yes",
      'no': "No",
      'comingSoon': "Coming Soon..",
      'close': "Close",

      //introDialog
      'gotIt': "Got it",
      'rewardsDialogContent':
          "Check out the reward categories and click on a trophy to find out what you have achieved already and what you will need to achieve for the next level.\n\nThe number below the “Next Level” is the bonus you will receive.",
      'challengesDialogTitle1': "Your Will is at your command",
      'challengesDialogContent1':
          ", \n\nMy name is Will and I am your corporate lawyer.\nI will help you to challenge other competitors and also to defend against attacks.",
      'strChallanges': "Challenges",
      'strChallangesDialogContent':
          "Search or select a competitor you would like to challenge.\nSelect one of his business sectors you would like to challenge him and select the reward (% of current cash) the the winner can get. Your competitor will need to answer 3 out of 3 questions from the selected sector correctly in order to win the challenge.",
      'strMarketingCommunications': "Marketing & Communications",
      'strMarketingCommunicationsDialog':
          ", \n\nWhat a great pleasure meeting you. I have heard a lot of good things about you. So I am extremely exited to work for you.\nI am Lydia and in charge of Marketing & Communications.\nLet's have a look at your overall market position. ",
      'strRankingDialogContent':
          "Select on the left side the ranking criteria (e.g. cash) and at the top which group you would like to compare it with and in which time frame.\nYou can also click in “You” to scroll to your position and challenge and add friends.",
      'strYourTeamPerformance': "Your Team's Performance",
      'strYourTeamPerformanceDialog':
          "Hi, it's me again, Niki.\n\nThis section is exclusively for team leaders.\nHere you can see the performance of your reports.",
      'strTeamDialog':
          "As a manager you can see and monitor the performance of your team. If you click on a team member you can see his individual performance and also bail him out in case his company is out of cash (reset his cash to 30.000).",

      'plPerson': 'The person you can count on',
      'niceMeetYou': 'Nice to meet you ',
      'plMyName': '\n\nMy name is Akiko Nakamura. I am in charge of Finance.\nLet\'s make sure to always have more revenue then cost.',
      'hereYourMonitor': 'Here you can monitor the cost and the revenue of your company.',
      'selectPeriod': 'You can also select the period you want to look at and compare the current period with the previous period.',

      'strYourTeamPerformanceDialog2':
          'The graphs show you the “Retention Level” & “Question Status”, “Retention Level” indicates how many questions are retained(1 = low retention and 10 = very well retained knowledge).\n“Question Status” indicates if questions are open and answered (open = open for answering, completed = correctly answered)',
      'customersRelationShip': "Customer Relationship Management",

      //existing customer

      'servingYourExisting': 'Serving your existing customers',
      'servingYourExistingDialog': ', \n\nI am Bob and taking care of Customer Service.\nLet me introduce you to the list of existing customer.',

      'listOfExisting': 'List of existing Customers',
      'listOfExistingDetails':
          'Here you see all customers and contracts that you are currently engaged with. How much cash they generate each day and how many days they will be loyal to you.\nYou can click the “X” if you want to end the contract.This customer will no longer generate cash but you will win back 1 Service Rep',

      'readyForBusiness': 'Ready for business',
      'readyForBusinessDeatils':
          "Why don't you check out more business sectors and engage a few more customers.\n\nOr explore the other area of your company where you can earn rewards, challenge other players, see your financial performance and compare your ranking.",
      'finishTutorial': 'Finish Tutorial',

      //customer situation
      'impactOnSales': 'Impact on Sales and Service',
      'impactOnSalesDetails':
          'Congratulations! You just won your first customer.\nYour Sales-o-Meter shows now 8/10 as this customer required 2 Sales Reps and your Service-o-Meter shows 9/10 as one Service Rep is busy with this customer.',
      'impactOnBrand': 'Impact on Brand Value and Cash',
      'impactOnBrandDetails':
          'Also your Brand Value is now 100% as you answered 100% of all customer situations correct.\n\nIndependent of your Brand Value, your cash increased by the value of the customer.',
      'checkYourCustomer': 'Check your existing customers',
      'checkYourCustomerDetails':
          'You can check on your existing customer in the notepad at the main screen.\n\nYou can reach your notepad by clicking on your Service-o-Meter, selecting “Existing customers” from the menu or by going to the main screen and selecting the notepad.',
      'clickServiceBtn': 'Click on Service-O-Meter',

      //engagement
      'yourFirstEngagement': 'Your first engagement',
      'yourFirstEngagementDetails':
          'In order to win this customer, you will need to answer this question correctly. You can click on the expand button to enlarge the picture, question and answer option.\n\nSelect the right answer and click on “Next”',
      'yourFirstEngagementBtn': 'Select answer & click “Next”',

      //New Customer screen
      'heartBusiness': 'The heart of the business',
      'heartBusinessDetails':
          "Hi Boss,\n\nthis is where the rubber hits the road, where only the best survive and where we earn the money for our company.\nI am Tina, your Senior Vice President of Global Sales. Let's get to work without any further due.",
      'listOfPotential': 'List of potential Customers',
      'listOfPotentialDetails':
          'Each customer has a name and belongs to a sector.Value is the cash you will receive every day while the customer is loyal to you. Loyalty of customers will increase when you master the customer situation.Resources indicate how many Sales Reps you will need to engage this customer. Click on “Engage Now”.',
      'listOfPotentialBtn': 'Click on “Engage Now”',

      //Business sector screen dialog
      'customerRelation': 'Customer Relationship Management',
      'customerRelationDetails':
          ', \n\nMy name is Li Wei. Just like the english word leeway.\nI am in charge of Customer Relationship Management (CRM) in your company. Shall we have a look at the different business sectors to find potential customers?',
      'areaOfComp': 'Area of competency',
      'areaOfCompDetails':
          'Each Business Sector will test specific knowledge to win customers. “Size” is the number of customers per Sector.You can click on a business sector to read the description, subscribe to it and download the questions for offline use.Some Business Sectors might already be assigned to you.',
      'accessToFirst': 'Access to your first customers',
      'accessToFirstDetails':
          'Why don\'t you subscribe to the first business sector to gain access to your first customers.Click on the Business Segment “Getting Started” and then on “Subscribe”.',
      'accessToFirstBtn': 'Click on “Getting Started”',
      'readyForCustomer': 'Ready for your first customer contact?',
      'readyForCustomerDetails':
          'Let\'s head over to the laptop which contains a list of new customers you can engage.\n\nYou can click on your Sales-o-Meter, use the navigation menu “>”, or click the back button and select the laptop.',
      'readyForCustomerBtn': 'Click on your Sales-o-Meter',
      'customersRelationShip': "Customer Relationship Management",

      'customersRelationShipContent':
          "\n\nMy name is Li Wei. Just like the english word leeway.\nI am in charge of Customer Relationship Management (CRM) in your company. Shall we have a look at the different business sectors to find potential customers?",
      'areaOfCompetency': "Area of competency",
      'areaOfCompetenceContent':
          "Each Business Sector will test specific knowledge to win customers. “Size” is the number of customers per Sector.\nYou can click on a business sector to read the description, subscribe to it and download the questions for offline use. Some Business Sectors might already be assigned to you.",

      //Organization screen Dialog
      'hireHrEmp': 'Hire HR Employees',
      'hireHrEmpDetails':
          ', \n\nWelcome on board and welcome to the board room.\nMy name is Nikita but please call me Niki.\nAs Head of HR I will introduce you to the team and how you can hire new employees to strengthen the team.',

      'hireHrEmpDetailsSeconds':
          "To hear your Team's' recommendations on why you should hire more employees in their team, click on them? \n\nLet's start with hiring 10 HR employees by clicking on HR and then “Hire 10 employees”.",

      'empOMaster': 'Employ-o-Meter',
      'empOMasterDetails':
          'Note that your Employ-o-Meter shows 40/50.\n50 is your maximum number employees and 40 your free capacity.You can increase your maximum by hiring more HR employees.\nA click on your Employ-o-Meter will also bring you to this organizational screen.',
      'costOfEmp': 'Cost of employees',
      'costOfEmpDetails':
          'Here you see your total cash.\n\nHiring employees will incur hiring cost (increasing over time).\nThe cost will be deducted from your cash.\nEvery employee also recieves a daily salary which starts at 200.\nSalary levels will increase over time.',

      // dashboard intro popup

      'dashboardProfile': 'Change Profile\n name, Language',
      'dashboardSales': '"Sales-o-meter"\navailable Sales Reps',
      'dashboardServices': '"Services-o-meter"\navailable Services Reps',
      'dashboardBalance': 'Answering Questions\n increases your Cash',
      'dashboardBusiness': '1. Business Segment\nSelect Learning Module',
      'dashboardNewCustomer': '2. New Customer\nAnswer Questions',
      'dashboardExistingCustomer': '3. Existing Customer\nReview Questions',

      'customizeYourCompany': "Customize your company",
      'customizeYourCompan'
              'yContent':
          "\n\nMy name is Mike, your Head of Operations.\nAre you ready to become CEO of your own virtual company?\nClick on your name or on “Profile” in the navigation\nmenu (“>”).",
      'customizeYourCompanyContent':
          ", \n\nMy name is Mike, your Head of Operations.\nAre you ready to become CEO of your own virtual company?\nClick on your name or on “Profile” in the navigation\nmenu (“>”).",

      //setting screen Dialog
      'settingDetails':
          'You can switch to a professional mode (no virtual company) and turn the sound on and off.\n\nIn case your company has negative cash you can request a bail out which will need to be approved by your manager.',

      //lock feature
      'unLockOrg': 'Unlocks when Sales or Service capacities empty first time.',
      'unLockPl': 'Unlocks 1 week after 1st login.',
      'unLockRanking': 'Unlocks after three days in row login',
      'unLockReward': 'Unlocks if first Achievement is reached',
      //TODO add unLockReward dialog text
      'unLockChallenge': 'Unlocks when first lawyer hired',

      //Dashboard Game screen
      'welcomeToKnow': 'Welcome to Knowledge Empire',
      'welcomeToKnowDetails':
          ", \n\nMy name is Mike, your Head of Operations.\nAre you ready to become CEO of your own virtual company?\nClick on your name or on “Profile” in the navigation\nmenu (“>”).",
      'clickYourProfile': 'Click on your Profile',

      'meetYourTeam': 'Meet your team',
      'meetYourTeamDetails':
          "Click the orgchart to have an overview of your organisation.\nYou get to hire and fire people as you want!\nTo get started you will need to hire some HR, Sales and Service employees.",

      'getReadyApproach': 'Get ready to approach customers',
      'getReadyApproachDetails':
          "In order to win new customers you need to have Sales Reps.\n\nLet's hire 10 Sales Reps by clicking on Sales and then “Hire 10 employees”.",
      'clickSale': 'Click on Sales',

      'salesOMeter': 'Sales-O-Meter',
      'salesOMeterDetails':
          '"Note that your Sales-o-Meter shows 10/10.\nThe last number shows your current number of Sales Rep. \nThe first number shows how many of them are currently available.\n\nEngaging customers will keep Sales Reps busy for 8 hours. "',

      'getReadyServer': 'Get ready to serve customers',
      'getReadyServerDetails':
          '"In order to serve/provide services to existing customers you need to have one Service Representatives per customer.\n\nLet\'s hire 10 Service Reps by clicking on Service and then “Hire 10 employees”."',
      'clickOnService': 'Click on Service',
      'serviceOMeter': 'Service-O-Meter',
      'serviceOMeterDetails':
          "Note that your Service-o-Meter shows 10/10.\nThe last number shows your current number of Service Rep.\nThe first number shows how many of them are currently available.\n\nEach existing customer will keep 1 Service Rep. occupied.",

      'readyForSerious': 'Ready for serious business',
      'readyForSeriousDetails':
          '"Great, you are all set for business.\nLet\'s head over to the newspaper to select the first business sector that you want to engage in.\n\nYou can click on the menu “>” and then “Business Sectors”"',
      'goToBusiness': 'Go to ”Business Sectors”',

      //question index
      'aIndex': 'A',
      'bIndex': 'B',
      'cIndex': 'C',
      'dIndex': 'D',

      //validation
      'emailEmpty': 'Email can\'t be empty.',
      'passWordEmpty': 'Password can\'t be empty.',
      'mailSent': 'Mail sent Successfully.',
      'passwordChange': 'Password changed Successfully.',

      //intro page
      'skipTutorial': 'Skip Tutorial',

      //ranking
      'addFriend': 'Friend added successfully',
      'unFriend': 'Unfriend successfully',

      //pushNotification alert
      'congratulations': 'Congratulations!, You earned',
      'collector': 'Collector',
      'businessSegments': '5 Business Segments subscribed to” then we say “Bonus:',
      'businessSegmentsNew': '5 Business Segments subscribed to \n Bonus:',

      'bonusPoint': "Bonus Point",
      'dear': "Dear",
      'hi': "Hi",
      'noInternet': "Check Your Internet Connection",
      'update': "Update now",
      'updateLatter': "Update later",
      'serviceReps': "Service Reps",
      'salesReps': "Sales Reps",
      'noOffline': "Sorry, this feature is only available while online.",
      'my': "My",
      'mHis': "His",
      'by': 'By',
      'inText': 'In',
      'toWin': 'To Win',
      'sizeInKb': "kb",

      'cashAtTheEndOfPeriod': "Cash at end of Period",
      'sizeInKb': "kb",
      'questions': 'Questions',
      'english': 'English',
      'german': 'German',
      'chinese': 'Chinese',
      'costSplit': "Cost Split",
      'sevenDaysDevelopment': "7 days developments",

      'cashAtStartOfPeriod': 'Cash at start of Period',
      'subscribedSuccess': 'Subscribed successfully!',
      'unSubscribedSuccess': 'Unsubscribed successfully!',
      'requestDemoAccount': "Request demo Account",
      'strVersion': "Version",
      'strUrlExeption': "Could not launch",
      'strOpen': "Open",
      'clickOrgChart': 'Click the Org Chart',
      'requestBailOut': 'Request Bail Out',
      'debrief': 'Debriefing',
      'alertChangePassword': 'Password changed Successfully.',
      'servicePerson': 'Service Reps',
      //</editor-fold>
      'strKp': "\$",
      'strBalance': "Cash",

      'alert': "Alert",
      'alertUnFriend': "Are you sure, you want to unfriend this user?",
      'Asc': "Asc",
      'Desc': "Desc",
      'Level': "Level",
      'Retention': "Retention",
      'DaysInLimit': "DaysInLimit",
      'targetLevel': "Target Level",
      'targetRetention': "Target Retention",
      'certificationCriteria': "Certification Criteria",
      "generatePhraseCode": "generate pass phrase?",
      "Addkey": "Add key",
      "EnterparsePhrase": "Enter parse Phrase",
      "parsephrasemustbe16characters": "parse phrase must be 16 characters",
    },
    'de': {
      //Nickname
      'enterNickName': 'Bitte Spitznamen eingeben',
      'nicknameChange': 'Spitzname erfolgreich geändert',
      'newNickName': 'Neuer Spitzname',
      'nickName': 'Spitzname',
      'downloadText': 'Dieses Modul benötigt',

      //Company code
      'enterCompanyCode': 'Bitte geben Sie die Unternehmenscode ein, den Sie in Ihrer E-Mail erhalten haben',
      'changeLanguage': 'Sprache ändern',
      'companyCode': 'Unternehmenscode',

      //password
      'enterOldPassword': 'Bitte geben Sie das alte Passwort ein.',
      'enterSameNewPassword': 'Bitte geben Sie das gleiche neue Passwort ein.',
      'enterRePassword': 'Bitte geben Sie das neue Passwort erneut ein.',
      'enterNewPassword ': 'Bitte geben Sie ein neues Passwort ein.',

      //<editor-fold desc="german">
      //main options
      'accept': "akzeptieren",
      "decline": "Ablehnen",
      'home': "Büro",
      'businessSector': "Geschäftsbereich",
      'newCustomers': "Neue Kunden",
      'existingCustomers': "Bestandskunden",
      'organizations': "Organisation",
      'challenges': "Herausforderungen",
      'challenge': "Herausforderungen",
      'pl': "Bilanz",
      'achievement': "Auszeichnungen",
      'rewards': 'Belohnungen',
      'ranking': "Rangliste",
      'team': "Team",
      'profile': "Profil",
      'help': "Hilfe",

      //profile
      'emailId': 'Email',
      'editProfile': 'Profil bearbeiten',
      'yourName': 'Name',
      'yourEmail': 'Email',
      'changePassword': 'Passwort ändern',
      'save': 'Speichern',
      'settings': 'Einstellungen',
      'privacyPolicy': 'Datenschutz',
      'termsConditions': 'Allgemeine Geschäftsbedingungen',
      'contactUs': 'Kontakt',
      'switchProfMode': 'Professionelle Version',
      'switchBusinessMode': 'Gamifizierte Version',
      'logout': 'Ausloggen',
      'choosePhoto': "Foto wählen",
      'takePhoto': "Foto machen",
      'sound': 'Ton',
      'bailout': 'Neustart gewähren',
      'requestbailout': 'Konkurs anmelden',
      'alertBailOut': "Wirklich Konkurs anmelden?",
      'successProfileUpdate': 'Profil erfolgreich gespeichert!',
      'selectCompany': "Unternehmen auswählen",
      'selectLanguage': "Select Language",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",

      //login
      'login': 'Einloggen',
      'enterRegisteredEmail': 'Email eingeben',
      'username': 'Nutzername',
      'password': 'Passwort',
      'newPassword': 'Neues Passwort',
      'currentPassword': 'Aktuelles Passwort',
      'reEnterPassword': 'Passwort erneut eingeben',
      'cancel': 'Abbrechen',
      'send': 'Senden',
      'forgotPassword': 'Passwort Vergessen?',

      //organization
      'fireEmp': "10 Mitarbeiter entlassen",
      'hireEmp': "10 Mitarbeiter einstellen",

      //new customer
      'sector': 'Geschäftsbereich',
      'name': 'Name',
      'value': 'Umsatz',
      'loyalty': 'Loyalität',
      'resources': 'Vertriebler',
      'engage': 'Ansprechen',
      'engageNow': 'Ansprechen',

      //existing customer
      'endRel': 'Beziehung beenden',
      'alertReleaseResources': 'Dieser Kunde wird entfernt, generiert keinen Umsatz mehr und ist erst nach der Treuefrist wieder erreichbar',

      //challenges
      'searchForKeywords': 'Suche',
      'somethingWrong': 'Da ist was schief gegangen',
      'friends': 'Freunde',
      'alertFriendSuccess': 'Freund hinzugefügt',
      'alertUnFriendSuccess': 'Freund entfernt',
      'alertUChallengeSent': 'Herausforderung erfolgreich gesendet!',

      //Rewards module
      'redeem': 'Einlösen',
      'costReward': 'kosten',
      'costUnit': 'virtuelles Vermögen',
      'unitsLeft': "Noch vorhanden",
      'categories': 'Kategorien',

      //learning module
      'subscribe': 'Abonnieren',
      'unSubscribe': 'Abmelden',
      'contactExpert': 'Experte Kontaktieren',
      'moreInformation': 'Mehr Informationen',
      'subscribed': 'abonniert',
      'downLoad': 'Herunterladen',
      'size': 'Größe',
      'description': 'Beschreibung',
      'alertWantToSubscribe1': "Wirklich von diesem Modul abmelden? Aller Fortschritt geht verlohren. ",
      'alertWantToSubscribe2': "? Alle Fragen gehen verloren",
      'downloading': "Daten werden geladen ...",
      'alertNotAllowed': "Zugeordnete Geschäftsbereiche können nicht abgemeldet werden",

      //engage customer
      'engagement': 'Nachbesprechung',
      'situation': 'Nachbesprechung',
      'category': 'Kategorie',
      'nextLevel': 'Nächste Stufe',
      'friend': 'Freund',
      'competitor': 'Wettbewerber',
      'sendChallenge': 'Herausfordern',
      'next': 'Weiter',
      'BackToList': 'Zur Übersicht',

      //  engage customer
      'answers': 'Antworten',
      'question': 'Fragen',
      'explanation': 'Erläuterung',
      'alertSelectOneOption': "Bitte mindestens eine Option auswählen",

      //customer situation
      'profit': "Gewinn",

      //team
      'learningModule': "Lernmodule",
      'levels': "Level",
      'complete': "% Abgeschlossen",
      'qLevel': "Frage Level",
      'qStatus': "Frage Status",
      'lastLog': "Letzter Login",
      'points': "Punkte",
      'correct': "% Korrekt",
      'department_': "Abteilung:",
      'department': "Abteilung",
      'resets_': "Neustarts:",
      'name_': "Name:",
      'cost': "Kosten",

      //ranking
      'you': "Du",
      'world': "Welt",
      'country': "Country",
      'score': 'Punkte',
      'companyName': 'Firmenname',
      'revenue': "Umsatz",
      'hashCustomers': "Anzahl Kunden",
      'brand': "Marke",

      //pl
      'cashAtStartOfPeriod': "Startvermögen",

      'revenueSplit': "revenueSplit",
      'employees': "Mitarbeiter",
      'salaries': "Gehälter",
      'customers': "Kunden",
      'engageSegment': 'Segment bearbeiten',
      'day': "Tag",
      'month': "Monat",
      'year': "Jahr",
      "total": "total",
      'lastPeriod': "Letzte Periode",
      'thisPeriod': "Aktuelle Periode",

      //alerts
      'alertWantToBailOut': "Wirklich Konkurs anmelden?",
      'alertNoModuleFound': "Oops..Keine Lernmodule für diesen Nutzer gefunden",
      'ok': 'Ok',
      'yes': "Ja",
      'no': "Nein",
      'comingSoon': "Demnächst verfügbar..",
      'close': "Schließen",

      //introDialog
      'gotIt': "Verstanden",
      'rewardsDialogContent':
          "Schau dir die unterschiedlichen Kategorien von Auszeichnungen an um herauszufinden was du schon erreicht hast und was du noch machen musst um das nächste Level zu erreichen.Die Zahlen ist der Geldbonus den du erhältst, wenn du diese Auszeichnung erreichst.",
      'challengesDialogTitle1': "Dein Will ist mein Befehl",
      'challengesDialogContent1':
          ", \n\nMein Name ist Will und ich bin der Anwalt der Firma.\nIch will dir helfen Wettbewerber herauszufordern und Angriffe abzuwehren.",
      'strChallanges': "Herausforderungen",
      'strChallangesDialogContent':
          "Suche und wähle Wettbewerber aus, die du herausfordern möchtest.wähle den Geschäftsbereich aus, in dem er herausgefordert werden soll und den Prozentsatz vom aktuellen Vermögen, den der Gewinner bekommen soll.\n\nDer Herausgeforderte muss dann 3 von 3 fragen aus diesem Geschäftsbereich richtig beantworten um zu gewinnen.\nAnsonsten gewinnst du.",
      'strMarketingCommunications': "Marketing",
      'strMarketingCommunicationsDialog':
          ", \n\nWas für eine ausserordentliche Freude dich kennenzulernen.\nIch habe von den Kollegen schon so viel gutes über dichgehört. Ich freue mich schon sehr mit dir zusammen zu arbeiten. Ich bin Lydia und verantwortlich für das Marketing.\nLass uns gemeinsam einen Blick auf deine aktuelle Wettbewerbsposition legen",
      'strRankingDialogContent':
          "Auf der linken Seite kannst du die Kategorie für die Rangliste auswählen und am oberen Rand, mit welcher Gruppe du dich vergleichen möchtest und in welchem Zeitraum.\n\nWenn du auf "
              "Du"
              " klickst siehst du deine Position und auf der rechten Seite kannst du Freunde hinzufügen und Wettbewerber herausfordern.",
      'strYourTeamPerformance': "Teamperformance",
      'strYourTeamPerformanceDialog':
          "Hallo, Ich bin es nochmal, Niki.\n\nDieser Bereich ist nur für Mitarbeiter mit Führungsverantwortung.\nHier kannst du die Leistungen deiner echten Mitarbeiter einsehen.",
      'strTeamDialog':
          "Als Manager kannst du hier die Leistungen deines Teams und wenn du auf einen Mitarbeiter klickst auch dieses einzelnen Mitarbeiters einsehen.\naußerdem kannst du ihm aus dem Konkurs helfen und sein Vermögen auf 30.000 zurücksetzen.",

      'plPerson': 'Mit mir kannst du rechnen',
      'niceMeetYou': 'Nett dich kennenzulernen ',
      'plMyName':
          'Mein Name ist Akiko Nakamura und verantwortlich für die Finanzen.Lass uns gemeinsam sicherstellen, dass wir immermehr Einnahmen als Ausgaben haben.',
      'hereYourMonitor': 'Hier kannst du die Einnahmen und die Ausgeben deines Unternehmens überwachen.',
      'selectPeriod': 'Dazu kannst du unterschiedliche Zeithorizonte auswählen und immer die aktuelle Periode mit der Perioden davor vergleichen.',

      'strYourTeamPerformanceDialog2':
          'Die Kuchendiagramme zeigen dir das Fragenlevel und den Fragenstatus.Das Fragenlevel ist ein Indikator für wie gut dieses Wissen verinnerlicht ist(1= niedrig, 10=hoch). Der Fragenstatus gibt Auskunft darüber wieviel Fragen aktuell beantwortet und wieviel unbeantwortet sind.',

      //existing customer

      'servingYourExisting': 'Kundenservice',
      'servingYourExistingDialog': ', \n\nIch bin Bob und kümmere mich um den Kundenservice.',

      'listOfExisting': 'Bestandskundenliste',
      'listOfExistingDetails':
          'Hier siehst du die Liste der Bestandskunden, ihren täglichen Umsatz und wieviel Tage sie noch loyal zu uns sind.\nMit "x" kannst du die Kundenbeziehung beenden. Dann generiert der Kunde keinen Umsatz mehr, wir gewinnen aber einen freien Servicemitarbeiter zurück.',

      'readyForBusiness': 'Ab ins Abenteuer ...',
      'readyForBusinessDeatils':
          'Hier endet die Einführung.\nDu kannst weitere Kundensegmente abonnieren und Fragen beantworten.\nOder du entdeckst die anderen Bereiche in denen du z.B. deine Auszeichnungen sehen, andere Wettbewerber herausfordern , deine Finanzen analysieren und dein Platz in der Rangliste einsehen kannst.',
      'finishTutorial': 'Einführung beenden',

      //customer situation
      'impactOnSales': 'Einfluss auf Vertrieb und Service',
      'impactOnSalesDetails':
          'Herzlichen Glückwunsch! Du hast gerade deinen ersten Kunden gewonnen.\nDeine Vertriebskapazitäten zeigt nun 8/10 da dieser Kunde 2 Vertriebsmitarbeiter benötigte um ihn zu gewinnen. Die Servicekapazitäten zeigen nun 9/10 da ein Servicemitarbeiter mit diesem Kunden beschäftigt ist.',
      'impactOnBrand': 'Einfluss auf Markenwert und Vermögen',
      'impactOnBrandDetails':
          'Der Markenwert liegt jetzt bei 100% da du 100% aller Fragen richtig beantwortet hast.\n\nDein Vermögen ist auch schon um den täglichen Umsatz dieses Kunden gestiegen.',
      'checkYourCustomer': 'Schau in die Liste der Bestandskunden',
      'checkYourCustomerDetails':
          'Deine Bestandskunden findest du im Notizblock im Hauptbildschirm.\n\nDu kannst aber auch auf die Servicekapazitätenanzeige klicken oder den Punkt "Bestandskunden" im Menü auswählen.',
      'clickServiceBtn': 'Klick auf Servicekapazitäten',

      //engagement
      'yourFirstEngagement': 'Erste Kundensituation',
      'yourFirstEngagementDetails':
          'Um den Kunden zu gewinnen muss die Frage richtig beantwortet werden.\nUm das Bild, die Frage oder die Antwortmöglichkeiten vergrößert dargestellt zu bekommen bitte auf das Vergrößerungssymbol klicken.\n\nBitte richtige Antwort auswählen und dann auf "Weiter" klicken.',
      'yourFirstEngagementBtn': 'Antwort auswählen und auf "Weiter" klicken',

      //New Customer screen
      'heartBusiness': 'willkommen im Vertrieb',
      'heartBusinessDetails':
          'Hallo Chef,\n\nwillkommen im Vertrieb, dem Herzen unseres Unternehmens.\nHier verdienen wir das Geld.Ich bin Tina, Vice Präsidentin für unseren globalen Vertrieb.Lass uns ohne weiter Umschweife starten und Geld verdienen.',
      'listOfPotential': 'Liste potentieller Kunden',
      'listOfPotentialDetails':
          'Jeder Kunde hat einen Namen und gehört zu einem Geschäftsbereich.Umsatz ist der tägliche Umsatz den der Kunde uns einbringen wird, so lange er uns loyal ist.Die Kundenloyalität steigt, wenn wir die Fragen dieses Kunden richtig beantworten.\nIn der Spalte Vertriebler ist zu ersehen wieviel Vertriebler wir benötigen um den Kunden anzusprechen.Um den Kunden anzusprechen bitte .auf "Ansprechen" klicken',
      'listOfPotentialBtn': 'Klick auf "Ansprechen"',

      //Business sector screen dialog
      'customerRelation': 'Kundenbeziehungsmanagement (CRM)',
      'customerRelationDetails':
          ', \n\nMein Name ist Li Wei.Ich leite die CRM Abteilung die sich um das Kundenbeziehungsmanagement kümmert.Lass uns gemeinsam einen Blick auf die unterschiedlichen Geschäftsbereiche werfen, die uns zur Verfuegung stehen.',
      'areaOfComp': 'Geschäftsbereiche',
      'areaOfCompDetails':
          'Jeder Geschäftsbereich benötigt spezielles Wissen um Kunden zu gewinnen.\n"Groesse" zeigt an, wieviele Kunden (Fragen) es in einem Geschäftsbereich gibt.\n\nIn der Beschreibung erfaehrst du, um was es in diesem Geschäftsbereich geht.\nDu kannst Geschäftsbereich abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Geschäftsbereiche sind dir evtl. schon zugeordnet undkönnen nicht deaktiviert werden.',
      'accessToFirst': "Geschäftsbereich abonnieren",
      'accessToFirstDetails':
          'Lass uns den ersten Geschäftsbereich abonnieren um Zugang zu den ersten Kunden zu erlangen.\n\nDazu klick bitte auf den Geschäftsbereich "Los geht\'s" und dann auf abonnieren.',
      'accessToFirstBtn': 'Klick auf "Los geht\'s"',
      'readyForCustomer': 'Bereit für den ersten Kunden?',
      'readyForCustomerDetails':
          'Auf zur Liste der Neukunden.\n\nDazu bitte entweder auf die Vertriebskapazitätenanzeige klicken, im Menü den Punkt "NeuKunden" klicken oder im Hauptbildschirm den Laptop anklicken.',
      'readyForCustomerBtn': 'Klick auf Vertriebskapazitäten',

      'customersRelationShip': "Kundenbeziehungsmanagement (CRM)",

      'customersRelationShipContent':
          "\n\nMein Name ist Li Wei.\nIch leite die CRM Abteilung die sich um das Kundenbeziehungsmanagement kümmert.\nLass uns gemeinsam einen Blick auf die unterschiedlichen Geschäftsbereiche werfen, die uns zur Verfuegung stehen.",
      'areaOfCompetency': "Geschäftsbereiche",
      'areaOfCompetenceContent':
          "Jeder Geschäftsbereich benötigt spezielles Wissen um Kunden zu gewinnen.\n\"Groesse\" zeigt an, wieviele Kunden (Fragen) es in einem Geschäftsbereich gibt.\n\nIn der Beschreibung erfaehrst du, um was es in diesem Geschäftsbereich geht.\nDu kannst Geschäftsbereich abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Geschäftsbereiche sind dir evtl. schon zugeordnet und können nicht deaktiviert werden.",

      // dashboard intro popup

      'dashboardProfile': 'Benutzer Profil und\nSprache anpassen',
      'dashboardSales': 'Vertriebskapazitäten\nAnzahl Verteibsmitarbeiter',
      'dashboardServices': 'Servicekapazitaeten\nAnzahl Service Mitarbeiter',
      'dashboardBalance': 'Fragen beantworten\nErhöht Vermögen',
      'dashboardBusiness': '1. Geschäftsbereiche\nLernmodule auswählen',
      'dashboardNewCustomer': '2. Neukundenliste\nFragen beantworten',
      'dashboardExistingCustomer': '3. Bestandskundenliste\nRichtig beantwortete Fragen',

      'alertChangePassword': 'Passwort erfolgreich geändert.',
      'unLockOrg': 'Wird freigeschaltet, wenn zum ersten mal Vertriebs- oder Service-Kapazitäten erschoepft sind',
      'unLockPl': 'Wird eine Woche nach erstem Login freigeschaltet',
      'unLockRanking': 'Wird freigeschaltet, wenn sich Nutzer drei Tage in Folge anmeldet',
      'unLockReward': 'Wird freigeschaltet, wenn erstes Achievement erreicht wird',
      'unLockChallenge': 'Wird freigeschaltet, wenn erster Anwalt eingestellt wird.',
      //'detailChallengeMessage': 'Du Wurdest von $username im Modul ${questionData.moduleName} herausgefordert.\nDu musst alle Fragen richtig beantworten um ${questionData.winningAmount} zu gewinnen.',

      //Organization screen Dialog
      'hireHrEmp': 'Personaler einstellen',
      'hireHrEmpDetails':
          ', \n\nwillkommen im Unternehmen und willkommen im Management Team.Mein Name ist Nikita aber bitte nenne mich Niki.Als Personalchef werde ich dir eine kurze Einführung geben, wie du neue Mitarbeiter einstellen kannst.',

      'hireHrEmpDetailsSeconds':
          'Um die Empfehlungen deiner Mitarbeiter zu hören, warum du in eine Abteilung investieren solltest, klicke einfach auf die Mitarbeiter.\n\nLass uns zu Anfang 10 neue Mitarbeiter in der Personalabteilung einstellen. Klicke dazu bitte auf "Personal" und dann auf "10 Mitarbeiter einstellen"',

      'empOMaster': 'Mitarbeiterkapazitäten',
      'empOMasterDetails':
          'Deine Mitarbeiterkapazitäten sind jetzt 40/50.50 ist die gesamte Mitarbeiterkapazität und 40 die noch verfügbare, da du ja schon 10 Mitarbeiter in der Personalabteilung hast.\nDu kannst die Mitarbeiterkapazität weiter erhöhen, indem du neue Personalmitarbeiter einstellst.Ein klick auf deine Mitarbeiter Kapazitäten bringt dich auch zu diesem Bildschirm.',
      'costOfEmp': 'Mitarbeiter Kosten',
      'costOfEmpDetails':
          'Hier kannst du dein Vermögen sehen.\n\nMitarbeiter einzustellen kostet Geld (Kosten steigen mit der Zeit). Diese Kosten werden von deinem Vermögen abgezogen.\nJeder Mitarbeiter bekommt außerdem ein gehalt. Dieses Gehalt betraegt 200 pro Mitarbeiter und Tag (Gehaelter steigen mit der Zeit).',

      //setting screen Dialog
      'settingDetails': 'Du kannst zur professionellen Ansicht wechseln (kein virtuelles Unternehmen) und den Ton ein und aus schalten.',

      //Dashboard Game screen
      'welcomeToKnow': 'Willkommen bei Knowledge Empire',
      'welcomeToKnowDetails':
          ", \n\nMein Name ist Mike und ich arbeite in der Verwaltung.\nBist du bereit die Geschäftsführung deines eigenen kleinen Unternehmens zu übernehmen?\nBitte klick auf deinen Namen oder "
              "Profil"
              " im Menü (“>”).",
      'clickYourProfile': 'Klick auf dein Profil',
      'meetYourTeam': 'Das Führungsteam',
      'meetYourTeamDetails':
          "Auf das Organigramm klicken um das Führungsteam zu treffen. Hier kannst du neue Mitarbeiter einstellen und entlassen.\nZu Beginn musst du ein paar Mitarbeiter in der Personalabteilung, im Vertrieb und im Service einstellen.",
      'clickOrgChart': 'Klick auf "Organigramm"',
      'getReadyApproach': 'Stärke dein Vertriebsteam',
      'getReadyApproachDetails':
          '"Um neue Kunden gewinnen zu können benötigst du Vertriebsmitarbeiter.\n\nLass uns 10 Vertriebsmitarbeiter einstellen. Dazu klick bitte auf ""Vertrieb"" und Anschließend auf ""10 Mitarbeiter einstellen""."',
      'clickSale': 'Klick auf "Vertrieb" ',
      'salesOMeter': 'Vertriebskapazitäten',
      'salesOMeterDetails':
          "Deine Vertriebskapazitäten zeigen nun 10/10.\nDie letzte Zahl zeigt dir deine gesamten Vertriebskapazitäten und die erste Zahl, wieviele davon aktuell verfuegbar sind.\n\nKunden anzusprechen beschaeftigt Vertriebsmitarbeiter für 8 Stunden bevor sie wieder zur Verfuegung stehen.",

      'getReadyServer': 'Kunden benötigen Kundenservice',
      'getReadyServerDetails':
          '"Um einen Kunden betreuen zu können benötigst du einen freien Service Mitarbeiter.\n\nLass uns 10 Servicemitarbeiter einstellen. Dazu bitte auf ""Service"" und dann auf ""10 Mitarbeiter einstellen"" klicken."',
      'clickOnService': 'Klick auf "Service"',
      'serviceOMeter': 'Servicekapazitat',
      'serviceOMeterDetails':
          "Deine Servicekapazitäten zeigen jetzt 10/10.\n\nDie hintere Zahl zeigt dir deine gesammten Servicekapazitäten an. Die erste Zahl zeigt dir, wieviele diese Servicemitarbeiter aktuell frei zur Verfuegung stehen.\n\nJeder Kunde benötigt einen freien Servicemitarbeiter.",

      'readyForSerious': 'Neue Geschäftsbereiche',
      'readyForSeriousDetails':
          "Super, jetzt sind wir startklar. Lass uns in der Zeitung nach neuen Geschäftsbereichen suchen, in denen wir aktiv werden wollen.\n\nBitte im Menü "
              ">"
              " "
              "Geschäftsbereiche"
              " auswählen.",
      'goToBusiness': 'Zu "Geschäftsbereiche" wechseln',

      'alertChangePassword': 'Passwort erfolgreich geändert.',
      'unLockOrg': 'Wird freigeschaltet, wenn zum ersten mal Lern- oder Bestandsfragen-Kapazitäten erschoepft sind',
      'unLockPl': 'Wird eine Woche nach erstem Login freigeschaltet',
      'unLockRanking': 'Wird freigeschaltet, wenn sich Nutzer drei Tage in Folge anmeldet',
      'unLockReward': 'Wird freigeschaltet, wenn erstes Achievement erreicht wird',
      'unLockChallenge': 'Wird freigeschaltet, wenn Max. Herausforderungen erstmals erhöht werden',

      'dear': "Hallo",
      'hi': "Hallo",
      'noInternet': 'Bitte Internetverbindung prüfen',
      'update': "Jetzt aktualisieren",
      'updateLatter': "Später aktualisieren",
      'noOffline': "Diese Funktion ist leider nur online verfügbar.",
      'my': 'Mein',
      'mHis': 'Sein',
      'by': 'Von',
      'inText': 'In',
      'toWin': 'Preis',

      'servicePerson': 'Servicemitarbeiter',
      'salesReps': 'Vertriebler',

      'cashAtTheEndOfPeriod': "Vermögen am Ende der Periode",
      'sizeInKb': "kb",
      'questions': "Fragen",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",
      'costSplit': "Kosten",
      'sevenDaysDevelopment': "7 Tage Überblick",

      'subscribedSuccess': 'Erfolgreich abonniert!',
      'unSubscribedSuccess': 'Erfolgreich abbestellt!',
      'selectLanguage': "Sprache auswählen",
      'requestDemoAccount': "Demozugang beantragen",
      'strVersion': "Version",
      'strUrlExeption': "Konnte nicht gestartet werden",
      'strOpen': "Offen",
      'requestBailOut': 'Konkurs anmelden',
      'debrief': 'Nachbesprechung',
      //</editor-fold>

      'passwordChange': 'Passwort erfolgreich geändert.',
      'nicknameChange': 'Spitzname erfolgreich geändert',
      'serviceReps': "Servicemitarbeiter",
      'strKp': "\$",
      'strBalance': "Vermögen",
      'addFriend': 'Freund hinzugefügt',
      'unFriend': 'Freund entfernt',
      'alertUnFriend': "Sind Sie sicher, dass Sie diesen Benutzer entfreunden möchten?",
      'alert': "Achtung",
      'Asc': "Asc",
      'Desc': "Desc",
      'Level': "Level",
      'Retention': "Retention",
      'DaysInLimit': "DaysInLimit",
      'targetLevel': "Target Level",
      'targetRetention': "Target Retention",
      'certificationCriteria': "Certification Criteria",
      "generatePhraseCode": "Passphrase generieren?",
      "Addkey": "Schlüssel hinzufügen",
      "EnterparsePhrase": "Geben Sie die Parsing-Phrase ein",
      "parsephrasemustbe16characters": "Parse-Phrase muss 16 Zeichen lang sein",
    },
    'zh': {
      //Nickname
      'enterNickName': '请输入昵称',
      'nicknameChange': '昵称已成功更改',
      'newNickName': '新昵称',
      'nickName': '昵称',
      'downloadText': '这个模块将占用',

      //Company code
      'enterCompanyCode': '请输入您在电子邮件中收到的公司代码',
      'changeLanguage': '改变语言',
      'companyCode': '公司代码',

      //password
      'enterOldPassword': '请输入旧密码。',
      'enterNewPassword ': '请输入新密码。',
      'enterRePassword': '请重新输入新密码。',
      'enterSameNewPassword': '请输入相同的新密码。',

      //<editor-fold desc="chinese">
      //main options
      'accept': "接受",
      "decline": "下降",
      'home': "首页",
      'businessSector': "业务部门",
      'newCustomers': "新客户",
      'existingCustomers': "现有客户",
      'organizations': "组织",
      'challenges': "挑战",
      'challenge': "挑战",
      'pl': "损益表",
      'rewards': "奖励",
      'ranking': "排名",
      'team': "团队",
      'profile': "个人主页",
      'help': "帮助中心",

      //profile
      'emailId': '邮箱账户名会员名',
      'editProfile': '编辑个人主页',
      'yourName': '您的名字',
      'yourEmail': '您的电子邮箱',
      'changePassword': '更改密码',
      'save': '保存',
      'settings': '设置',
      'privacyPolicy': '隐私权政策',
      'termsConditions': '法律声明',
      'contactUs': '联系我们',
      'switchProfMode': '专业模式',
      'switchBusinessMode': '商业模式',
      'logout': '登出',
      'choosePhoto': "选择相片",
      'takePhoto': "拍照",
      'sound': '音效音量',
      'bailout': '紓困',
      'requestbailout': '申请纾困',
      'alertBailOut': "你确定要纾困吗.",
      'successProfileUpdate': '个人主页已更新!',
      'selectCompany': "选择公司",
      'selectLanguage': "选择语言",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",

      //login
      'login': '登录',
      'enterRegisteredEmail': '登录账户',
      'username': '用户名',
      'password': '密码',
      'newPassword': '新密码',
      'currentPassword': 'Current 密码',
      'reEnterPassword': '请再次输入新密码',
      'cancel': '取消',
      'send': '发送',
      'forgotPassword': '忘记密码?',

      //organization
      'fireEmp': "解雇10名员工",
      'hireEmp': "雇用10名员工",

      //new customer
      'sector': '部门',
      'name': '名字',
      'value': '价值',
      'loyalty': '忠诚度',
      'resources': '资源',
      'engage': '经营',
      'engageNow': '立刻联络',

      //existing customer
      'endRel': '结束',
      'alertReleaseResources': "该客户将被移除，不会再产生任何收入，并且只能在忠诚度期后再次访问",

      //challenges
      'searchForKeywords': '关键词搜索',
      'somethingWrong': '出了问题',
      'friend': '夥伴朋友',
      'alertFriendSuccess': "成功添加朋友",
      'alertUnFriendSuccess': "成功取消朋友",
      'alertUChallengeSent': "挑战已成功发送",

      //Rewards module
      'redeem': '赎回',
      'costReward': '费用',
      'costUnit': '虚拟现金',
      'unitsLeft': "剩余单位",
      'categories': '类别',

      //learning module
      'subscribe': '订阅',
      'unSubscribe': '取消订阅',
      'contactExpert': '咨询专家',
      'moreInformation': '了解更多资讯',
      'subscribed': '已订阅',
      'downLoad': '下载',
      'size': '大小',
      'description': '描述',
      'alertWantToSubscribe1': "您确定要取消订阅吗",
      'alertWantToSubscribe2': "您将失去所有的问题",
      'downloading': "正在下载......",
      'alertNotAllowed': "您不能取消加入已分配的业务板块",

      //engage customer
      'engagement': '情况',
      'situation': '任务报告',
      'category': '类别',
      'achievement': '奖励',
      'nextLevel': '下一级',
      'friends': '夥伴朋友',
      'competitor': '竞争对手',
      'sendChallenge': '送出挑战寄发战帖',
      'next': '下一页',
      'BackToList': '回到问题主选单',

      //  engage customer
      'answers': '答案',
      'question': '问题',
      'explanation': '说明',
      'alertSelectOneOption': "请至少选择一个选项",

      //customer situation
      'profit': "营业收益",

      //team
      'learningModule': "学习模块",
      'levels': "级别",
      'complete': "%完成",
      'qLevel': "Q级",
      'qStatus': "Q状态",
      'lastLog': "上次登录时间",
      'points': "点数",
      'correct': "%正确",
      'department_': "部门:",
      'department': "部门",
      'resets_': "重启:",
      'name_': "名字::",
      'cost': "成本",

      //ranking
      'you': "您",
      'world': "世界",
      'country': "国家",
      'score': '比分分数',
      'companyName': '公司名称',
      'revenue': "收入",
      'hashCustomers': "#客户",
      'brand': "品牌",

      //pl
      'cashAtStartOfPeriod': "期初现金",
      'cashAtTheEndOfPeriod': "Cash at end of Period",
      'revenueSplit': "revenueSplit",
      'employees': "员工",
      'salaries': "薪水",
      'customers': "客户顾客",
      'day': "日期",
      'month': "月",
      'year': "年",
      "total": "total",
      'lastPeriod': "上一时期",
      'thisPeriod': "这一时期",

      //alerts
      'alertWantToBailOut': "您确定要申请纾困.",
      'alertNoModuleFound': "哎呀..找不到该用户的学习模块.",
      'ok': "好",
      'yes': "是",
      'no': "不是",
      'comingSoon': "即将推出..",
      'close': "关闭",

      //introDialog
      'gotIt': "了解",
      'rewardsDialogContent': "查看奖励类别,\n点击奖杯查看您目前的成就以及您需要取得多 少成就才能升到下一级别.\n\n"
          "下一级"
          "下面的数字是您将收到的奖金。",
      'challengesDialogTitle1': "您是自己的主宰",
      'challengesDialogContent1': ", \n\n我叫威尔，我是您公司的律师。\n我会帮助您挑战其他竞争对手，\n同时也帮您防守对方的攻击。",
      'strChallanges': "挑战",
      'strChallangesDialogContent': "搜索或选择您想挑战的竞争对手。\n选择您想挑战他的一个业务部门然后选择赢家可以获得的奖励 (%当前知识点数 (KP))。\n您的竞争对手需要正确回答选定部门的3个问题才能赢得挑战。",
      'strMarketingCommunications': "营销与传播",
      'strMarketingCommunicationsDialog': ", \n\n很高兴见到您。我久仰您的大名。\n所以我非常高兴能为您工作。\n我是莉蒂亚，负责市场营销和传播。\n让我们来看看您的整体市场地位。",
      'strRankingDialogContent': "在左侧选择排名标准（比如现金，\n并在顶部选择您想对比的分组以及时间范围。\n您也可以点击"
          "您"
          "滚动到您的位置和挑战以及添加朋友。",
      'strYourTeamPerformance': "您的团队的表现",
      'strYourTeamPerformanceDialog': "您好，我是尼基，我又来了。\n这部分是团队领导专属。\n在这里您可以看到您的报告的表现。",
      'strTeamDialog': "作为经理，您可以查看和监控您的团队的表现。\n如果您点击一个团队成员，您可以看到他的个人表现。\n如果他的公司没有了资金，您还可以帮助他缓解资金困难 (将他的现金重置为30.000)。",

      'plPerson': '您可以依靠的人',
      'niceMeetYou': '很高兴见到您',
      'plMyName': '我叫中村明子。\n我负责财务。让我们确保收入始终高于支出。',
      'hereYourMonitor': '在这里，您可以监控公司的成本和收入。',
      'selectPeriod': '您还可以选择您想要查看的时间段和比较当前周期与上一个周期',

      'strYourTeamPerformanceDialog2': '图表显示"保留级别"和"问题状态”\n"保留级别"表示保留了多少问题（1 = 低保留级别，10 = 知识保留得很好）。\n"问题状态"表示问题是否已开启并已回答（开启 = 开启回答，完成 = 已正确回答)',

      //existing customer
      'servingYourExisting': '服务现有客户',
      'servingYourExistingDialog': ', \n\n我是负责客户服务的鲍勃。\n让我向您介绍现有客户名单。',

      'listOfExisting': '现有客户名单',
      'listOfExistingDetails': '在这里，您可以看到您目前正在联络的所有客户和合同.\n他们每天产生多少现金以及他们在多少天内会对您忠诚。\n如果您想结束合同，您可以点击"X"。\n这个客户将不再产生现金，但您会收回1位服务代表。',

      'readyForBusiness': '准备开展业务',
      'readyForBusinessDeatils': '您现在可以查看更多的业务部门，然后联络更多的客户。\n\n或者探索您公司的其他领域，可以赚取奖励，挑战其他玩家，查看您的财务绩效和比较您的排名。',
      'finishTutorial': '完成教程',

      //customer situation
      'impactOnSales': '对销售和服务的影响',
      'impactOnSalesDetails': '恭喜！您刚刚赢得了您的第一个客户。\n您的销售代表指示图现在显示8/10，因为这个客户需要2个销售代表，而您的服务代表指示图显示9/10，因为您需要1名服务代表为这个客户服务。',
      'impactOnBrand': '对品牌价值和现金的影响',
      'impactOnBrandDetails': '您的品牌价值现在是100％，因为您关于所有客户情况的回答100％正确。\n\n独立于您的品牌价值，您的现金增长取决于客户价值。',
      'checkYourCustomer': '查看您的现有客户',
      'checkYourCustomerDetails': '您可以在主界面的记事本中查看您现有的客户。\n\n您可以通过点击您的服务代表指示图，选择菜单中的“现有客户”或者前往主页面选择“已完成的学习”来访问您的记事本。',
      'clickServiceBtn': '点击服务代表指示图',

      //engagement
      'yourFirstEngagement': '您的第一次联络',
      'yourFirstEngagementDetails': '为了赢得这个客户，您需要准确地回到这个问题。您可以点击展开按钮放大图片、问题和答案选项。\n\n选择正确的答案，然后单击"下一页”',
      'yourFirstEngagementBtn': '选择答案并单击"下一页”',

      //New Customer screen
      'heartBusiness': '业务的核心',
      'heartBusinessDetails': '老板您好，\n\n现在到了关键时刻，只有最后的公司才能生存下来, 但也是我们为公司赚钱的时机。我是蒂娜, 您的全球销售高级副总裁。\n我们开始工作吧，不要再拖延了。',
      'listOfPotential': '潜在客户名单',
      'listOfPotentialDetails': '每个客户都有一个名称，都属于一个部门。\n“价值”是您每天收到的现金，并且同时顾客对您忠诚.\n当您掌握了顾客情况时，客户的忠诚度将增加。\n“资源”表示您需要多少销售代表来联络这个客户。\n点击"立即联络"。',
      'listOfPotentialBtn': '点击"立即联络"',

      //Business sector screen dialog
      'customerRelation': '客户关系管理',
      'customerRelationDetails': ', \n\n我叫李伟。就像英文单词leeway一样。\n我负责您的公司的客户关系管理（CRM).\n我们看看不同的业务部门来寻找潜在的客户吧！',
      'areaOfComp': '能力领域',
      'areaOfCompDetails': '每个业务部门将测试特定的知识来赢得客户.\n"大小"是每个部门的客户数量.\n您可以点击业务板块阅读说明,\n加入并下载问题以便离线使用.\n某些业务部门可能已经分配给您。',
      'accessToFirst': '访问您的第一个客户',
      'accessToFirstDetails': '您可以加入第一个商业部门从而访问您的第一个客户。\n点击业务板块的"开始"，然后点击"加入"。',
      'accessToFirstBtn': '点击"开始”',
      'readyForCustomer': '准备好接触您的第一个客户了吗？',
      'readyForCustomerDetails': '让我们前往笔记本电脑中您可以联络的新客户列表页面。\n\n您可以使用导航菜单“>”，点击您的销售代表指示图，\n或者点击后退然后选择笔记本电脑。',
      'readyForCustomerBtn': '点击您的销售代表指示图',

      'customersRelationShip': "客户关系管理",

      'customersRelationShipContent': "您好\n\n我叫李伟。就像英文单词leeway一样。\n我负责您的公司的客户关系管理（CRM）。我们看看不同的业务部门来\n寻找潜在的客户吧！",
      'areaOfCompetency': "能力领域",
      'areaOfCompetenceContent': "每个业务部门将测试特定的知识来赢得客户。"
          "大小"
          "是每个部门的客户数量。\n您可以点击业务板块阅读说明，加入并下载问题以便离线使用。\n某些业务部门可能已经分配给您。",
      'customizeYourCompany': "自定义您的公司",
      'customizeYourCompanyContent': ", \n\n我叫迈克，我是您们的运营主管。\n您准备好成为您自己的虚拟公司的CEO了吗？\n点击您的姓名或导航菜单 (“>”) 中的\n"
          "个人资料"
          "。\n",

      //Organization screen Dialog
      'hireHrEmp': '招聘人力资源员工',
      'hireHrEmpDetails': ', \n\n欢迎加入我们，欢迎来到董事会会议室。\n我叫尼基塔，但叫我尼基就可以了。\n作为人力资源部的负责人，\n我将向您介绍我们的团队以及指导您如何招聘员工,\n让我们的团队发展壮大。',

      'hireHrEmpDetailsSeconds': '听听您的团队的建议，为什么您应该招聘更多的员工，\n点击他们试试？\n\n让我们先招聘10名HR员工，您只需点击HR然后选择“雇用10名员工”。',

      'empOMaster': '雇员指示图',
      'empOMasterDetails': '您的雇员指示图显示40/50。\n50是最大可雇用员工的数量，40是当前员工数量。\n您可以通过雇用更多的HR员工来增加最大可雇用员工的数量。\n点击您的雇员指示图也将进入该组织页面。',
      'costOfEmp': '员工成本',
      'costOfEmpDetails': '在这里，您可以看到您的总现金。\n\n招聘员工会增加雇用成本（随着时间的推移增加）。\n费用将从您的现金中扣除。\n每个员工每天会收到工资，每日起薪是200。\n工资水平将随着时间的推移而增加。',

      //setting screen Dialog
      'settingDetails': '您可以切换到专业模式（没有虚拟公司),\n您可以打开或关闭声音。\n\n如果您的公司现金为负，您可以请求一笔纾困资金,\n您的经理会进行审批。',

      //Dashboard Game screen
      'welcomeToKnow': '欢迎来到知识帝国',
      'welcomeToKnowDetails': ", \n\n我叫迈克，我是您们的运营主管。\n您准备好成为您自己的虚拟公司的CEO了吗？\n点击您的姓名或导航菜单 (“>”) 中的\n"
          "个人资料"
          "。",
      'clickYourProfile': '点击您的个人资料',

      'meetYourTeam': '认识您的团队',
      'meetYourTeamDetails': "单击组织结构图以了解您的组织概况。\n只要您想，您可以雇用和解雇员工！\n开始之前，您将需要聘请一些HR、销售和服务的员工。",
      'clickOrgChart': '点击组织结构图',
      'getReadyApproach': '准备接触客户',
      'getReadyApproachDetails': '"为了赢得新的客户，您需要有销售代表。\n\n我们点击“销售”，然后点击""雇用10名员工""来雇用10名销售代表。"',
      'clickSale': '点击“销售”',

      'salesOMeter': '销售代表指示图',
      'salesOMeterDetails': "您的销售代表指示图显示10/10。\n最后一个数字显示您当前的销售代表数量。\n第一个数字显示当前可用的服务代表数量。\n\n吸引客户将会让销售代表工作8个小时。",

      'getReadyServer': '准备好为客户服务',
      'getReadyServerDetails': '"为了服务现有客户或提供服务，您需要为每个客户配备一个服务代表。\n\n我们点击“服务”，然后点击""雇用10名员工""来雇用10名服务代表。"',
      'clickOnService': '点击“服务”',
      'serviceOMeter': '服务代表指示图',
      'serviceOMeterDetails': "您的服务代表指示图显示10/10。\n最后一个数字显示您当前的服务代表数量。\n第一个数字显示当前可用的服务代表数量。\n\n每个现有客户将占用1个服务代表。",

      'readyForSerious': '准备开展真正的业务',
      'readyForSeriousDetails': "很好，您们都准备好开展业务了。\n让我们来看看报纸，选择您想要从事的第一个商业部门。\n\n您可以点击菜单"
          ">"
          "，然后点击"
          "业务部门”",
      'goToBusiness': '转到"业务部门”',

      //lock feature
      'unLockOrg': 'Unlocks when Sales or Service capacities empty first time.',
      'unLockRanking': 'Unlocks after three days in row login',
      'unLockChallenge': 'Unlocks when first lawyer hired',

      'dashboardProfile': '更改个人资料\n名字，语言',
      'dashboardSales': '销售代表指示图\n可用销售代表',
      'dashboardServices': '服务代表指示图\n可用服务代表',
      'dashboardBalance': '回答问题可以增加您的现金',
      'dashboardBusiness': '1. 业务部门\n选择学习模块',
      'dashboardNewCustomer': '2. 新客户\n回答问题',
      'dashboardExistingCustomer': '3. 现有客户\n复习问题',
      'alertChangePassword': '密码已更改。',
      'unLockOrg': '销售或服务点数第一次清零时解锁。',
      'unLockPl': '在第一次登录一周后解锁',
      'unLockRanking': '连续三天登录后解锁',
      'unLockReward': '在达成第一个成就后解锁',
      'unLockChallenge': '雇用第一个律师后解锁',

      'dear': "亲爱的",
      'hi': "您好",
      'noInternet': '请确认是否连接到互联网',
      'update': "立即升级",
      'updateLatter': "以后再说",
      'noOffline': "很抱歉 此项功能需要连接互联网",
      'my': '我的',
      'mHis': '他的',
      'by': '挑战者',
      'inText': '业务部门',
      'toWin': '可赢得',

      'servicePerson': '服务代表',
      'salesReps': '销售代表',

      'cashAtTheEndOfPeriod': "期末现金",
      'sizeInKb': "kb",
      'questions': "问题",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",
      'costSplit': "花费",
      'sevenDaysDevelopment': "过去7天的概览",

      'selectLanguages': '选择语言',
      'subscribedSuccess': '订阅成功！',
      'unSubscribedSuccess': '取消订阅！',
      'requestDemoAccount': "申请模拟账户",
      'strVersion': "版本",
      'strUrlExeption': "无法启动",
      'strOpen': "打开",
      'requestBailOut': '申请纾困',
      'debrief': '任务报告',
      //</editor-fold>

      'passwordChange': '密码已更改。',
      'nicknameChange': '昵称已成功更改',
      'serviceReps': "服务代表",
      'strKp': "\$",
      'strBalance': "现金",
      'addFriend': '成功添加朋友',
      'unFriend': '成功添加朋友',
      'alertUnFriend': "您确定要与该用户成为好友吗？",
      'alert': "警告",
      'Asc': "Asc",
      'Desc': "Desc",
      'Level': "Level",
      'Retention': "Retention",
      'DaysInLimit': "DaysInLimit",
      'targetLevel': "Target Level",
      'targetRetention': "Target Retention",
      'certificationCriteria': "Certification Criteria",
      'generatePhraseCode': "生成密码短语？",
      "Addkey": "添加键",
      "EnterparsePhrase": "输入解析短语",
      "parsephrasemustbe16characters": "解析短语必须是 16 个字符",
    }
  };

  static Map<String, Map<String, String>> localizedValuesProf = {
    'en': {
      //Nickname
      'enterNickName': 'Please enter nickname',
      'nicknameChange': 'Nickname changed Successfully',
      'newNickName': 'New Nickname',
      'nickName': 'Nickname',
      'downloadText': 'This module will occupie',

      //Company code
      'enterCompanyCode': 'Please enter company code that you received in your email',
      'changeLanguage': 'Change Language',
      'companyCode': 'Company code',

      //<editor-fold desc="english">
      'accept': "Accept",
      "decline": "Decline",
      'home': "Home",
      'businessSector': "Learning Module",
      'newCustomers': "Open Learnings",
      'existingCustomers': "Memorized Learnings",
      'organizations': "Power-Up",
      'challenges': "Challenges",
      'pl': "Performance",
      'rewards': "Rewards",
      'ranking': "Ranking",
      'team': "Team",
      'sector': 'Module',
      'size': 'Q&A',
      'engagement': 'Situation',
      'situation': 'Debriefing',
      'value': 'Knowledge Points (KP)',
      'loyalty': 'Repeat in ...',
      'endRel': 'Release',
      'resources': 'Study Points (SP)',

      //challenges
      'competitor': 'Colleagues',

      //introDialog
      'gotIt': "Got it",
      'rewardsDialogContent':
          "Check out the reward categories and click on a trophy to find out what you have achieved already and what you will need to achieve for the next level.\n\nThe number below the “Next Level” is the bonus you will receive.",
      'challengesDialogTitle1': "Challenges",
      'challengesDialogContent1': "Here you will learn how to challenge other colleagues",
      'strChallanges': "Challenges",
      'strChallangesDialogContent':
          "Search or select a Colleague you would like to challenge.\nSelect one of his Learning Modules you would like to challenge him and select the reward (% of current Knowledge Points (KP)) the winner can get. Your competitor will need to answer 3 out of 3 questions from the selected module correctly in order to win the challenge.",
      'strMarketingCommunications': "Ranking",
      'strMarketingCommunicationsDialog': "In this section you will learn everything you need to know about the ranking",
      'strRankingDialogContent':
          "Select on the left side the ranking criteria (e.g. Knowledge Points (KP)) and at the top which group you would like to compare it with and in which time frame.\nYou can also click in “You” to scroll to your position and challenge and add friends.",
      'strYourTeamPerformance': "Your Team's Performance",
      'strYourTeamPerformanceDialog': "This section is exclusively for team leaders.\nHere you can see the performance of your reports.",
      'strTeamDialog':
          "As a manager you can see and monitor the performance of your team. If you click on a team member you can see his individual performance and reset his Knowledge Points (KP) to 30.000.",

      'plPerson': 'Performance',
//      'niceMeetYou':'${Injector.userData?.name??""}很高兴见到您',
      'plMyName': 'In this section you will learn everything you need to know about your performance analysis',
      'hereYourMonitor': 'Here you can monitor the deductions and the additions of Knowledge Points (KP).',
      'selectPeriod': 'You can also select the period you want to look at and compare the current period with the previous period.',

      'strYourTeamPerformanceDialog2':
          'The graphs show you the “Retention Level” & “Question Status”“Retention Level” indicates how many questions are retained(1 = low retention and 10 = very well retained knowledge).“Question Status” indicates if questions are open and answered (open = open for answering, completed = correctly answered)',

      'customersRelationShip': "Learning Modules introduction",

      'customersRelationShipContent':
          "Here you can search for Learning Modules, subscribe and unsubscribe to them and also decide if you want to download the content for future offline usage.",
      'areaOfCompetency': "Learning Modules introduction",
      'areaOfCompetenceContent':
          "Each Learning Module will test specific areas of knowledge. \"Size\" indicated the number of Questions in each Module. You can click on a Learning Module to read a description and decide if you want to subscribe to them.\nSome Learning Modules are already assigned to you by your company and cannot be unsubscribed.",
      'customersRelationShipContent':
          "Here you can search for Learning Modules, subscribe and unsubscribe to them and also decide if you want to download the content for future offline usage.",
      'areaOfCompetency': "",

      //existing customer
      'servingYourExisting': 'List of Completed Learnings',
      'servingYourExistingDialog': 'In this part of the tutorial you will learn all relevant information about your completed learnings',
      'listOfExisting': 'List of Completed Learnings',
      'listOfExistingDetails':
          'Here you see all questions that you currently have memorized. How much Knowledge Points (KP) you receive from them each day and how many days they will stay in this list.\nYou can click the “X” if you want to remove a question.\nThis question will then not generate any more Knowledge Points for you but you will regain 1 free Memory Point (MP).',

      'readyForBusiness': 'Ready to get started',
      'readyForBusinessDeatils':
          "Why don't you check out more Learning Modules and answer a few more questions.\n\nOr explore the other area of this app where you can earn rewards, challenge other players, see your performance and compare your ranking.",
      'finishTutorial': 'Finish Tutorial',

      //customer situation
      'impactOnSales': 'Impact on Learning Points (LP) and Memory Points (MP)',
      'impactOnSalesDetails':
          'Congratulations! You just answered your first question correctly.\nYour Learning Point (LP) Bar shows now 8/10 as this question required 2 Learning Points and your Memory Point (MP) Bar shows 9/10 as one Memory Point (MP) is occupied while you have this question in the list of completed learnings.',
      'impactOnBrand': 'Impact on Knowledge Score (KS)',
      'impactOnBrandDetails':
          'Also your Knowledge Score (KS) is now 100% as you answered 100% of all questions correct.\n\nIndependent of your Knowledge Score (KS), also your Knowledge Points (KP) increased by the Knowledge Points (KP) offered for this question.',
      'checkYourCustomer': 'Check the list of complete learnings',
      'checkYourCustomerDetails':
          'You can find a list with all completed questions in the "Completed Learnings" section.\n\nYou can reach your "Completed Learnings" by clicking on your Memory Point (MP) Bar, selecting "Completed Learnings" from the menu or by going to the main screen and selecting "Completed Learnings"',
      'clickServiceBtn': 'Click on you Memory Points (MP) Bar',

      //engagement
      'yourFirstEngagement': 'Your first Question',
      'yourFirstEngagementDetails':
          'In order to win this question, you will need to answer this it correctly. You can click on the expand button to enlarge the picture, question and answer option.\n\nSelect the right answer and click on “Next”',
      'yourFirstEngagementBtn': 'Select answer & click “Next”',

      //New Customer screen
      'heartBusiness': 'List of Open Learnings',
      'heartBusinessDetails': 'In this part of the tutorial you will learn all relevant information needed to select and answer questions',
      'listOfPotential': 'List of Questions',
      'listOfPotentialDetails':
          'Each question has a name and belongs to a Learning Module.\nKnowledge are the Knowledge Points (KP) you can earn everyday you have this question in your completed Learning list.\n"Repeat in ..." tells you in how many days you need to repeat the question if you now answer it correctly.\nThe more often you answer a question correctly the less often you will need to repeat it.\nStudy Points (SP) indicate how many Study Points (SP) you will need to answer this question. Click on “Answer Now”.',
      'listOfPotentialBtn': 'Click on “Answer Now”',

      //Business sector screen dialog
      'customerRelation': 'Learning Modules introduction',
      'customerRelationDetails':
          'Here you can search for Learning Modules, subscribe and unsubscribe to them and also decide if you want to download the content for future offline usage.',
      'areaOfComp': 'Learning Modules introduction',
      'areaOfCompDetails':
          'Each Learning Module will test specific areas of knowledge. "Size" indicated the number of Questions in each Module. You can click on a Learning Module to read a description and decide if you want to subscribe to them. Some Learning Modules are already assignedto you by your company and cannot be unsubscribed.',
      'accessToFirst': 'Subscribe to the first Module',
      'accessToFirstDetails':
          'Why don\'t you subscribe to the first business sector to gain access to your first questions.\n\nClick on the Learning Module “Getting Started” and then on “Subscribe”.',
      'accessToFirstBtn': 'Click on “Getting Started”',
      'readyForCustomer': 'Ready for your first Questions',
      'readyForCustomerDetails':
          'Let\'s head over to the Open Learnings which contains a list of new questions you can answer.\n\nYou can click on your Study Point (SP) Bar, use the navigation menu “>”, or click the back button and select Open Learnings.',
      'readyForCustomerBtn': 'Click on the Study Point (SP) Bar',

      'customizeYourCompany': "Customize your profile",
      'customizeYourCompanyContent':
          ", \n\nWelcome to this gamified learning Experience.\nAre you ready to earn some points and compete against colleagues?\nClick on your name or on “Profile” in the navigation menu (“>”).",

      'hireHrEmpDetailsSeconds':
          'To get recommendations and understand why you should improve certain Power-Ups (PU), click on them.\nLet\'s start with spending 10 Power-Up (PU) Points and 1000 Knowledge Points (KP) to improve "Max. Power-Ups (PU)" to level 1 Click on "Max. Power-Ups (PU)" and then on "Increase Level"',

      'empOMaster': 'Power-Up (PU) Bar',
      'empOMasterDetails':
          'Note that your Power-Up (PU) Bar shows 40/50.\n50 is your maximum number of Power-Up Points (PU) and 40 your free capacity.\nYou can increase your maximum by improving the Power-Up (PU) Level.\nA click on your Power-Up (PU) Bar will also bring you to this screen.',
      'costOfEmp': 'Cost for improvements',
      'costOfEmpDetails':
          'Here you see your Knowledge Points (KP).\n\nImproving Power-Ups will cost Knowledge Points (KP). This one time cost will increase with the level.\nEvery Power-Up Point (PU) spend will also incur recurring cost which will start with 200 Knowledge Points (KP) per Power-Up (PU) point and day. This cost will increase over time.',

      //setting screen Dialog
      'settingDetails':
          'You can switch to a game mode (virtual company) and turn the sound on and off.\n\nIn case your points become negative, you can request a new start which will need to be approved by your manager.',

      //Dashboard Game screen
      'welcomeToKnow': 'Welcome to Knowledge Empire',
      'welcomeToKnowDetails':
          ", \n\nwelcome to this gamified learning Experience.\nAre you ready to earn some points and compete against colleagues?\nClick on your name or on “Profile” in the navigation\nmenu (“>”).",
      'clickYourProfile': 'Click on your Profile',
      'meetYourTeam': 'Your Power-Ups (PU)',
      'meetYourTeamDetails':
          "Click on Power-Ups to have an overview of your improvements.\nYou get to increase and reduce power-up levels as you want!\nTo get started you will need to improve "
              "Max. Power-Ups (PU)"
              ", "
              "Max. Study Points (SP)"
              " and "
              "Max. Memory (MP)"
              ".",
      'clickOrgChart': 'Click on Power-Ups (PU)',
      'getReadyApproach': 'Study Points (SP) to answer questions',
      'getReadyApproachDetails':
          '"In order to answer questions you need Study Points.\n\nLet\'s improve ""Max. Study Points (SP)"" to Level 1 by clicking on ""Max. Study Points (SP)"" and then ""Increase Level"""',
      'clickSale': 'Click on "Max. Study Points (SP)"',
      'salesOMeter': 'Study Points (SP) Bar',
      'salesOMeterDetails':
          "Note that your Study Points (SP) Bar shows 10/10.\nThe last number shows your max Study Points (SP).\nThe first number shows how many Study Points (SP) are currently available.\n\nAnswering questions will require Study Points (SP) which will refill automatically after 8 hours. ",

      'getReadyServer': 'Max Memory Points (MP)',
      'getReadyServerDetails':
          "In order to keep one correctly answered in your memory, you need to have one free memory point.\n\nLet's get 10 Memory Points by clicking on "
              "Max. Memory Points (MP)"
              " and then “Increase Level”.",
      'clickOnService': 'Click on "Max. Memory Points (MP)"',
      'serviceOMeter': 'Memory Point (MP) Bar',
      'serviceOMeterDetails':
          "Note that your Memory Point (MP) Bar shows 10/10.\nThe last number shows your maximum Memory capacity.\nThe first number shows your free Memory for new questions.\n\nEach correctly answered question will require 1 memory point.",

      'readyForSerious': 'Ready for your first question?',
      'readyForSeriousDetails': "Great, you are now ready for your first questions.\nLet's head over to the "
          "Learning Modules"
          " section to select the first Learning Module that you want to engage in.\n\nYou can click on the menu “>” and then “Learning Modules”",
      'goToBusiness': 'Go to "Learning Modules"',

      'dashboardProfile': 'Change Profile',

      'dashboardSales': 'Study Points Bar\navailable Study Points',
      'dashboardServices': 'Memory Points Bar\navailable Memory Points',
      'dashboardBalance': 'Answering your question\nincreases your points',
      'dashboardBusiness': '1. Learning Modules\nSelect Learning Module',
      'dashboardNewCustomer': '2. New Questions\nAnswer Questions',
      'dashboardExistingCustomer': '3. Existing Questions\nReview Questions',
      'alertChangePassword': 'Password changed Successfully.',

      'unLockOrg': 'Unlocks when Study or Memory Points are empty for the first time.',
      'unLockPl': 'Unlocks 1 week after 1st login',
      'unLockRanking': 'Unlocks after three days in row login',
      'unLockReward': 'Unlocks if first Achievement is reached',
      'unLockChallenge': 'Unlocks when max. Challenge Power-Up is increased',

      'dear': "Dear",
      'hi': "Dear",
      'noInternet': 'Please check your Internet connection',
      'update': "Update Application",
      'updateLatter': "Update later",
      'noOffline': "Sorry, this feature is only available while online.",
      'my': "My",
      'mHis': "His",
      'by': 'By',
      'inText': 'In',
      'toWin': 'To win',
      'challenge': 'Challenge',

      'servicePerson': 'Memory Points',
      'salesReps': 'Study Points',

      'yourName': 'Your Name',
      'yourEmail': 'Your Email',

      'cost': 'KP Cost',
      'employees': 'Power-Ups',
      'salaries': 'KP Cost',
      'revenue': 'KP Gain',
      'hashCustomers': '#Questions',
      'brand': '%Correct',
      'customers': 'Questions',
      'Profit': 'Knowledge Points (KP)',
      'alertWantToSubscribe1': "Are you sure, you want to unsubscribe from this module? All progress will be lost. ",
      'alertWantToSubscribe2': '? You will lose all the questions from the ',
      'answers': 'Answers',
      'bonusPoint': "Bonus Point",

      'cashAtStartOfPeriod': 'Knowledge Points at start of Period',
      'subscribedSuccess': 'Subscribed successfully!',
      'alertFriendSuccess': 'Friend added successfully',
      'alertUnFriendSuccess': "Unfriend successfully",
      'unSubscribedSuccess': 'Unsubscribed successfully!',

      'selectCompany': 'Select Company',
      'selectLanguages': 'Select Language',
      'requestDemoAccount': "Request demo Account",

      'cashAtTheEndOfPeriod': "Knowledge Points at end of Period",
      'sizeInKb': "kb",
      'questions': "Questions",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",
      'costSplit': "KP Cost",
      'sevenDaysDevelopment': "7 days developments",
      'strVersion': "Version",
      'strUrlExeption': "Could not launch",
      'strOpen': "Open",
      'hireHrEmp': "Improve Max. Power-Ups (PU)",

      'helpProProfile': '"Profile: \n- Change your company name \n- switch to game mode \n- switch company \n- request a restart"',
      'helpProEmployMeter':
          '"Power-Up Bar (xx/yy):  \n- xx = currently free Power-Up Points  \n- yy = total Power-Up capacity  \n- Every Power-Up Point cost you 200 (increasing) per day  \n- Click on Power-Up Bar brings you to Power Up Screen"',
      'helpProSalesMeter':
          '"Study Points Bar(xx/yy):  \n- xx = currently free Study Points  \n- yy = total Study Points  \n- Used Study Points will refill after 8 hours \n- Click onStudy Point Bar brings you to List of open questions"',
      'helpProServiceMeter':
          '"Memory Points Bar (xx/yy):  \n- xx = currently free Memory Points  \n- yy = totalMemory Points  \n- 1 free Memory Point needed per Question  \n- Click on Memory Point Bar brings you to list of answered questions"',
      'helpProBrandValue':
          '"%Correct Answers:  \n- Percentage of correctly answered questions  \n- Click on %Correct Answers brings you to Ranking Screen"',
      'helpProCash':
          '"Knowledge Points:  \n- Increases by answering Questions correct and earning achievements  \n- Decreases through Power-Up costs"',

      'helpProBusinessSector': '"Learning Modules: \n- Find new Learning Module \n- Subscribe / Unsubscribe \n- Download for offline availability"',
      'helpProNewCustomers':
          '"Open Learnings: \n- Find new Questions to answer \n- Each Question requires free Study and Memory Points \n- Repetition of Questions increases if you answer them correctly"',
      'helpProExistingCustomer':
          '"Compleeted Learnings: \n- review all your correctly answered questions \n- Repetition of Questions increases if you answer them correctly"',
      'helpProRewards':
          '"Rewards: \n- Rewards are earned by completing certain task \n- Rewards pay extra Knowledge Points if you reach a new level"',
      'helpProTeam':
          '"Team (only visible to managers):  \n- list of your direct reports  \n- high level reporting and KPI  \n- Allow bailout / reset"',
      'helpProChallenges':
          '"Challenges: \n- Challenge friends \n- Selected % value determined # of questions and payout \n- increasing % = Increasing ammount of questions to be answered \n- higher % = higher payout for competitor if he wins and lower payout for you if he looses"',
      'helpProOrganization':
          '"Power-Ups:  \n- select additional Power-Ups  \n- you need Power-Up capacities (HR) to Spend Power-Up points  \n- Every Power-Up Point spend costs you 100 Knowledge Points per day"',
      'helpProP&L': '"Performance:  \n- Monitor your performance and progress  \n- Ensure you earn enough Knowledge Points"',
      'helpProRanking': '"Ranking:  \n- See and compare your rank  \n- you can check multiple timelines and comparison groups"',
      'emailId': 'Email Id',
      'editProfile': 'Edit Profile',
      'changePassword': 'Change Password',
      'save': 'Save',

      'settings': 'Settings',
      'privacyPolicy': 'Privacy & Policy',
      'termsConditions': 'Terms & Conditions',
      'contactUs': 'Contact Us',
      'switchProfMode': 'Switch to Professional Mode',
      'switchBusinessMode': 'Switch to Business Mode',
      'logout': 'Log out',
      'choosePhoto': 'Choose photo',
      'takePhoto': 'Take photo',
      'sound': 'Sound',
      'bailout': 'Start new',
      'requestBailOut': 'Request new start',
      'alertBailOut': 'Are you sure you want to restart?',
      'successProfileUpdate': 'Profile updated successfully!',
      'login': 'Login',
      'enterRegisteredEmail': 'Enter Registered Email Id',
      'password': 'Password',
      'newPassword': 'New Password',
      'currentPassword': 'Current Password',
      'reEnterPassword': 'Re-enter new Password',
      'cancel': 'Cancel',
      'send': 'Send',
      'forgotPassword': 'Forgot Password?',
      'fireEmp': 'Reduce Level',
      'hireEmp': 'Increase Level',
      'name': 'Name',
      'engage': 'Answer',
      'engageNow': 'Answer Now',
      'alertReleaseResources':
          'This question will be removed, not generate any more Knowledge Points and only be accessible again after next repetition time ended',
      'searchForKeywords': 'Search for keywords',
      'somethingWrong': 'Something went wrong',
      'friend': 'Friend',
      'alertUChallengeSent': 'Challenge sent successfully!',
      //Rewards module
      'redeem': 'Redeem',
      'costReward': 'Cost',
      'costUnit': 'Knowledge Points',
      'unitsLeft': "Units left",
      'categories': 'Categories',

      'subscribe': 'Subscribe',
      'unSubscribe': 'Unsubscribe',
      'contactExpert': 'Contact Expert',
      'moreInformation': 'More Information',
      'subscribed': 'Subscribed',
      'downLoad': 'DownLoad',
      'description': 'Description',
      'downloading': 'Downloading...',
      'alertNotAllowed': 'You can not unsubscribe assigned Learning Modules.',
      'debrief': 'Debriefing',
      'category': 'Category',
      'achievement': 'Achievement',
      'nextLevel': 'Next Level',
      'friends': 'Friends',
      'sendChallenge': 'Send Challenge',
      'explanation': 'Explanation',
      'alertSelectOneOption': "Please select at least one option.",
      'profit': 'Gain/Loss',
      'learningModule': 'Learning Module',
      'levels': 'Levels',
      'complete': '%Complete',
      'qLevel': 'Q Level',
      'qStatus': 'Q Status',
      'lastLog': 'Last Log',
      'points': 'Points',
      'correct': '%Correct',
      'department_': 'Category:',
      'department': 'Category',
      'resets_': 'Resets:',
      'name_': 'Name:',
      'cost': 'Deductions',
      'you': 'You',
      'world': 'World',
      'country': 'Country',
      'score': 'Score',
      'companyName': 'Company Name',
      'day': 'Day',
      'month': 'Month',
      'year': 'Year',
      "total": "total",
      'lastPeriod': 'Last Period',
      'thisPeriod': 'This Period',
      'alertWantToBailOut': 'Are you sure you want to restart',
      'alertNoModuleFound': 'Oops..No learning module found for this user.',
      'ok': 'Ok',
      'yes': 'Yes',
      'no': 'No',
      'comingSoon': 'Coming Soon..',
      'close': 'Close',
      //</editor-fold>
      'passwordChange': 'Password changed Successfully.',
      'nicknameChange': 'Nickname changed Successfully',
      'serviceReps': "Memory Points",

      'strProProfile': "- Change your company name\n- switch to game mode\n- switch company\n- request a restart",
      'strEmpOMeter':
          "- xx = currently free Power-Up Points\n- yy = total Power-Up capacity\n- Every Power-Up Point cost you 200 (increasing) per day\n- Click on Power-Up Bar brings you to Power Up Screen",
      'strSalesOMeter':
          "- xx = currently free Study Points\n- yy = total Study Points\n- Used Study Points will refill after 8 hours\n- Click onStudy Point Bar brings you to List of open questions",
      'strServiceOMeter':
          "- xx = currently free Memory Points\n- yy = totalMemory Points\n- 1 free Memory Point needed per Question\n- Click on Memory Point Bar brings you to list of answered questions",
      'strBrandValue': "- Percentage of correctly answered questions\n- Click on %Correct Answers brings you to Ranking Screen",
      'strBrandValueTitle': "%Correct Answers",
      'strCash': "- Increases by answering Questions correct and earning achievements\n- Decreases through Power-Up costs",
      'strBusinessSector': "- Find new Learning Module\n- Subscribe / Unsubscribe\n- Download for offline availability",
      'strNewCustomer':
          "- Find new Questions to answer\n- Each Question requires free Study and Memory Points\n- Repetition of Questions increases if you answer them correctly",
      'strExistingCustomer': "- review all your correctly answered questions\n- Repetition of Questions increases if you answer them correctly",
      'strAchievement': "- Achievements are earned by completing certain task\n- Achievements pay extra Knowledge Points if you reach a new level",
      'strReward': "- Redeem Knowledge Points to receive real world rewards",
      'strTeam': "- list of your direct reports\n- high level reporting and KPI\n- Allow bailout / reset",
      'strChallenges':
          "- Challenge friends\n- Selected % value determined # of questions and payout\n- increasing % = Increasing ammount of questions to be answered\n- higher % = higher payout for competitor if he wins and lower payout for you if he looses",
      'strOrganization':
          "- select additional Power-Ups\n- you need Power-Up capacities (HR) to Spend Power-Up points\n- Every Power-Up Point spend costs you 100 Knowledge Points per day",
      'strPL': "- Monitor your performance and progress\n- Ensure you earn enough Knowledge Points",
      'strRanking': "- See and compare your rank\n- you can check multiple timelines and comparison groups",
      'strRanking': "- See and compare your rank\n- you can check multiple timelines and comparison groups",
      'strKp': "Kp",
      'strBalance': "Knowledge Points",
      'next': 'Next',
      'BackToList': 'Back to List',
      'alertUnFriend': "Are you sure, you want to unfriend this user?",
      'addFriend': 'Friend added successfully',
      'unFriend': 'Unfriend successfully',
      'alert': "Alert",
      'Asc': "Asc",
      'Desc': "Desc",
      'Level': "Level",
      'Retention': "Retention",
      'DaysInLimit': "DaysInLimit",
      'targetLevel': "Target Level",
      'targetRetention': "Target Retention",
      'certificationCriteria': "Certification Criteria",
      'generatePhraseCode': "generate pass phrase?",
      "Addkey": "Add key",
      "EnterparsePhrase": "Enter parse Phrase",
      "parsephrasemustbe16characters": "parse phrase must be 16 characters"
    },
    'de': {
      //Nickname
      'enterNickName': 'Bitte Spitznamen eingeben',
      'nicknameChange': 'Spitzname erfolgreich geändert',
      'newNickName': 'Neuer Spitzname',
      'nickName': 'Spitzname',
      'downloadText ': 'Dieses Modul benötigt',

      //Company code
      'enterCompanyCode': 'Bitte geben Sie die Unternehmenscode ein, den Sie in Ihrer E-Mail erhalten haben',
      'changeLanguage': 'Sprache ändern',
      'companyCode': 'Unternehmenscode',

      //password
      'enterOldPassword': 'Bitte geben Sie das alte Passwort ein.',
      'enterSameNewPassword': 'Bitte geben Sie das gleiche neue Passwort ein.',
      'enterRePassword': 'Bitte geben Sie das neue Passwort erneut ein.',
      'enterNewPassword ': 'Bitte geben Sie ein neues Passwort ein.',

      //<editor-fold desc="German">
      'accept': "akzeptieren",
      "decline": "Ablehnen",
      'home': 'Start',
      'businessSector': 'Lernmodule',
      'newCustomers': 'Fragen',
      'existingCustomers': 'Bestandsfragen',
      'organizations': 'Lernbonus',
      'challenges': 'Herausforderungen',
      'pl': 'Entwicklung',
      'rewards': "Belohnungen",
      'achievement': 'Auszeichnungen',
      'rewards': 'Belohnungen',
      'ranking': 'Rangliste',
      'team': 'Team',
      'profile': 'Profil',
      'help': 'Hilfe',
      'emailId': 'Email',
      'editProfile': 'Profil bearbeiten',
      'yourName': 'Name',
      'yourEmail': 'Email',
      'changePassword': 'Passwort ändern',
      'save': 'Speichern',
      'settings': 'Einstellungen',
      'privacyPolicy': 'Datenschutz',
      'termsConditions': 'Allgemeine Geschäftsbedingungen',
      'contactUs': 'Kontakt',
      'switchProfMode': 'Professionelle Version',
      'switchBusinessMode': 'Gamifizierte Version',
      'logout': 'Ausloggen',
      'choosePhoto': 'Foto wählen',
      'takePhoto': 'Foto machen',
      'sound': 'Ton',
      'bailout': 'Neustart gewähren',
      'requestBailOut': 'Neustart beantragen',
      'alertBailOut': 'Wirklich neu starten?',
      'successProfileUpdate': 'Profil erfolgreich gespeichert!',
      'selectCompany': 'Unternehmen auswählen',
      'selectLanguage': 'Sprache auswählen',
      'login': 'Einloggen',
      'enterRegisteredEmail': 'Email eingeben',
      'password': 'Passwort',
      'newPassword': 'Neues Passwort',
      'currentPassword': 'Aktuelles Passwort',
      'reEnterPassword': 'Passwort erneut eingeben',
      'cancel': 'Abbrechen',
      'send': 'Senden',
      'forgotPassword': 'Passwort Vergessen?',
      'fireEmp': 'Level reduzieren',
      'hireEmp': 'Level erhöhen',
      'sector': 'Lernmodule',
      'name': 'Name',
      'value': 'Wissenspunkte (WP)',
      'loyalty': 'Wiederholung in ...',
      'resources': 'Lernpunkte (SP)',
      'engage': 'Beantworten',
      'engageNow': 'Beantworten',
      'endRel': 'Entfernen',
      'alertReleaseResources':
          'Dieser Frage wird entfert. Sie wird keinen Punkte mehr generieren und erst nach der Wiederholungsperiode wieder verfügbar sein.',
      'searchForKeywords': 'Suche',
      'somethingWrong': 'Da ist was schief gegangen',
      'friend': 'Freund',
      'alertFriendSuccess': 'Freund hinzugefügt',
      'alertUnFriendSuccess': 'Freund entfernt',
      'alertUChallengeSent': 'Herausforderung erfolgreich gesendet!',
      //Rewards module
      'redeem': 'Einlösen',
      'costReward': 'kosten',
      'costUnit': 'Wissenspunkte',
      'unitsLeft': "Noch vorhanden",
      'categories': 'Kategorien',

      'subscribe': 'Abonnieren',
      'unSubscribe': 'Abmelden',
      'contactExpert': 'Experte Kontaktieren',
      'moreInformation': 'Mehr Informationen',
      'subscribed': 'abonniert',
      'downLoad': 'Herunterladen',
      'size': 'Größe',
      'description': 'Beschreibung',
      'alertWantToSubscribe1': 'Wirklich von diesem Modul abmelden? Aller Fortschritt geht verlohren. ',
      'alertWantToSubscribe2': '? Alle Fragen gehen verloren',
      'downloading': 'Daten werden geladen ...',
      'alertNotAllowed': 'Zugeordnete Lernbereiche können nicht abgemeldet werden',
      'engagement': 'Situation',
      'debrief': 'Nachbesprechung',
      'category': 'Kategorie',
      'nextLevel': 'Nächste Stufe',
      'friends': 'Freunde',
      'competitor': 'Kollegen',
      'sendChallenge': 'Herausfordern',
      'next': 'Weiter',
      'BackToList': 'Zur Übersicht',
      'answers': 'Antworten',
      'question': 'Fragen',
      'explanation': 'Erläuterung',
      'alertSelectOneOption': 'Bitte mindestens eine Option auswählen',
      'situation': 'Nachbesprechung',
      'profit': 'Wissenspunkte',
      'learningModule': 'Lernmodul',
      'levels': 'Level',
      'complete': '% abgeschlossen',
      'qLevel': 'Frage Level',
      'qStatus': 'Frage Status',
      'lastLog': 'Letzter Login',
      'points': 'Punkte',
      'correct': '% korrekt',
      'department_': 'Kategorie:',
      'department': 'Kategorie',
      'resets_': 'Neustarts:',
      'name_': 'Name:',
      'cost': 'Abzüge',
      'you': 'Du',
      'world': 'Welt',
      'country': 'Land',
      'score': 'Punkte',
      'companyName': 'Firmenname',
      'revenue': 'Additionen',
      'hashCustomers': 'Anzahl Fragen',
      'brand': '%Richtig',
      'cashAtStartOfPeriod': 'Wissenspunkte am Anfang',
      'employees': 'Bonuspunkte',
      'salaries': 'Kosten',
      'customers': 'Fragen',
      'day': 'Tag',
      'month': 'Monat',
      'year': 'Jahr',
      "total": "total",
      'lastPeriod': 'Letzte Periode',
      'thisPeriod': 'Aktuelle Periode',
      'alertWantToBailOut': 'Wirklich neu beginnen?',
      'alertNoModuleFound': 'Oops..Keine Lernmodule für diesen Nutzer gefunden',
      'ok': 'Ok',
      'yes': 'Ja',
      'no': 'Nein',
      'comingSoon': 'Demnächst verfügbar..',
      'close': 'Schließen',

      //introDialog
      'gotIt': "Verstanden",
      'rewardsDialogContent':
          "Schau dir die unterschiedlichen Kategorien von Auszeichnungen an um herauszufinden was du schon erreicht hast und was du noch machen musst um das nächste Level zu erreichen.\nDie Zahlen sind die Wissenspunkte (WP) die du erhältst, wenn du diese Auszeichnung erreichst.",
      'challengesDialogTitle1': "Herausforderungen",
      'challengesDialogContent1': "\nHier lernst du wie du einen Kollegen zu einem Wissensduell heraus forderst.",
      'strChallanges': "Herausforderungen",
      'strChallangesDialogContent':
          "Suche und wähle Kollegen aus, die du herausfordern möchtest.\nwähle den Lernbereich aus, in dem er herausgefordert werden soll und den Prozentsatz von den aktuellen Wissenspunkte (WP), den der Gewinner bekommen soll.\n\nDer Herausgeforderte muss dann 3 von 3 Fragen aus diesem Lernmodul richtig beantworten um zu gewinnen.\nAnsonsten gewinnst du.",
      'strMarketingCommunications': "Rangliste",
      'strMarketingCommunicationsDialog': "In diesem Bereich lernst du alles über die Rangliste",
      'strRankingDialogContent':
          "Auf der linken Seite kannst du die Kategorie für die Rangliste auswählen und am oberen Rand, mit welcher Gruppe du dich vergleichen möchtest und in welchem Zeitraum.\n\nWenn du auf "
              "Du"
              " klickst siehst du deine Position und auf der rechten Seite kannst du Freunde hinzufügen und Kollegen herausfordern.",
      'strYourTeamPerformance': "Teamperformance",
      'strYourTeamPerformanceDialog':
          "Dieser Bereich ist nur für Mitarbeiter mit Führungsverantwortung.\nHier kannst du die Leistungen deiner echten Mitarbeiter einsehen.",
      'strTeamDialog':
          "Als Manager kannst du hier die Leistungen deines Teams und wenn du auf einen Mitarbeiter klickst auch dieses einzelnen Mitarbeiters einsehen.\naußerdem kannst du ihm aus dem Konkurs helfen und seine Wissenspunkte auf 30.000 zurücksetzen.",

      'plPerson': 'Entwicklung',
//      'niceMeetYou':'${Injector.userData?.name??""}很高兴见到您',
      'plMyName': 'In diesem Bereich kannst du deine Entwicklung einsehen und überprüfen.',
      'hereYourMonitor': 'Hier kannst du deinen Wissenspunkte-Zuwachs und -Abgang überwachen.',
      'selectPeriod': 'Dazu kannst du unterschiedliche Zeithorizonte auswählen und immer die aktuelle Periode mit der Perioden davor vergleichen.',
      'strYourTeamPerformanceDialog2':
          'Die Kuchendiagramme zeigen dir das Fragenlevel und den Fragenstatus.Das Fragenlevel ist ein Indikator für wie gut dieses Wissen verinnerlicht ist(1= niedrig, 10=hoch). Der Fragenstatus gibt Auskunft darüber wieviel Fragen aktuell bentowertet und wieviel unbeantwortet sind.',
      //existing customer
      'servingYourExisting': 'Liste der Bestandsfragen',
      'servingYourExistingDialog': 'In diesem Teil der Einführung lernst du alles Wissenswerte über die Bestandsfragen',

      'listOfExisting': 'Liste der Bestandsfragen',
      'listOfExistingDetails':
          'Hier siehst du die Liste der Bestandsfragen, die täglichen Wissenspunkte und wieviel Tage sie noch in der Liste bleiben.\nMit "x" kannst du die Frage aus dieser Liste löschen.\nDann generiert sie keine Wissenspunkte mehr, du hast aber eine Bestandsfragenkapazität mehr.',

      'readyForBusiness': 'Und los geht\'s ...',
      'readyForBusinessDeatils':
          'Hier endet die Einführung.\nDu kannst weitere Lernmodule abonnieren und Fragen beantworten.\nOder du entdeckst die anderen Bereiche in denen du z.B. deine Auszeichnungen sehen, andere Kollegen herausfordern , deine Finanzen analysieren und dein Platz in der Rangliste einsehen kannst.',
      'finishTutorial': 'Einführung beenden',

      //customer situation
      'impactOnSales': 'Einfluss auf Lernpunkte und Bestandsfragen',
      'impactOnSalesDetails':
          'Herzlichen Glückwunsch! Du hast gerade deinen erste Frage richtig beantwortet.\nDeine Lernpunkteanzeige zeigt nun 8/10 da diese Frage 2 Lernpunkte benötigte um sie zu beantworten. Die Bestandsfragenanzeige zeigen nun 9/10 da du eine von 10 möglichen Fragen in deinem Bestand hast .',
      'impactOnBrand': 'Einfluss auf Wissensscore (WP) und Wissenspunkte (WP)',
      'impactOnBrandDetails':
          'Dein Wissensscore (WS) liegt jetzt bei 100% da du 100% aller Fragen richtig beantwortet hast.\n\nDeine Wissenspunkte (WP) sind auch schon um die täglichen Punkte dieser Frage gestiegen',
      'checkYourCustomer': 'Schau in die Liste der Bestandsfragen',
      'checkYourCustomerDetails':
          'Deine Bestandsfragen findest du in der Kachel "Bestandsfragen" im Hauptbildschirm.\n\nDu kannst aber auch auf die Bestandsfragenanzeige klicken oder den Punkt "Bestandsfragen" im Menü auswählen.',
      'clickServiceBtn': 'Klick auf die Bestandsfragenanzeige',

      //engagement
      'yourFirstEngagement': 'Erste Frage',
      'yourFirstEngagementDetails':
          'Um diese Frage zu gewinnen musst du diese Frage richtig beantworten.\nUm das Bild, die Frage oder die Antwortmöglichkeiten vergrößert dargestellt zu bekommen bitte auf das Vergrößerungssymbol klicken.\n\nBitte richtige Antwort auswählen und dann auf "Weiter" klicken.',
      'yourFirstEngagementBtn': 'Antwort auswählen und auf "Weiter" klicken',

      //New Customer screen
      'heartBusiness': 'Liste der offenen Fragen',
      'heartBusinessDetails': 'In diesem Teil der Einführung lernst du alles Wissenswerte über die Fragenliste und die Fragen',
      'listOfPotential': 'Liste der offenen Fragen',
      'listOfPotentialDetails':
          'Jeder Frage hat einen Namen und gehört zu einem Lernmodul. Wissenspunkte (WP) sind die täglichen Punkte die dir diese Frage einbringen wird, so lange sie in der Bestandsfragenliste bleibt.\n"Wiederholen in..." zeigt die Anzahl Tage wann die Frage wiederholt werden muss. Je häufiger du sie richtig beantwortest, je grösser wird der Abstand.\nIn der Spalte Lernpunkte (LP) siehst du wieviel Lernpunkte (LP) du benötigst um die Frage zu beantworten.\nUm eine Frage zu beantworten bitte auf "Beantworten" klicken',
      'listOfPotentialBtn': 'Klick auf "Beantworten"',

      //Business sector screen dialog
      'customerRelation': 'Einführung in Lernmodule',
      'customerRelationDetails':
          '\nHier kannst du nach Lernmodulen suchen, diese abonnieren und auch herunterladen, wenn du sie ohne Internetverbindung beantworten möchtest.',
      'areaOfComp': 'Einführung in Lernmodule',
      'areaOfCompDetails':
          'Jeder Lernmodul benötigt spezielles Wissen um Fragen zu beantworten."Grösse" zeigt an, wieviele Fragen es in einem Lernmodul gibt.\n\nIn der Beschreibung erfährst du, um was es in diesem Lernmodul geht. Du kannst Lernmodule abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Lernmodule sind dir evtl.\nschon zugeordnet und können nicht deaktiviert werden.',
      'accessToFirst': 'Lernmodul abonnieren',
      'accessToFirstDetails':
          'Lass uns ein erstes Lernmodul abonnieren um Zugang zu den ersten Fragen zu erlangen.\n\nDazu klick bitte auf das Lernmodul "Los geht\'s" und dann auf abonnieren.',
      'accessToFirstBtn': 'Klick auf "Los geht\'s"',
      'readyForCustomer': 'Bereit für die erste Frage?',
      'readyForCustomerDetails':
          'Auf zur Liste der Fragen.\n\nDazu bitte entweder auf die Lernkapazitätenanzeige klicken, im Menü den Punkt "Fragen" anklicken oder im Hauptbildschirm die Kachel "Fragen" anklicken.',
      'readyForCustomerBtn': 'Klick auf die "Lernkapazitätenanzeige"',
      'customersRelationShip': "Einführung in Lernmodule",

      'customersRelationShip': "Einführung in Lernmodule",

      'customersRelationShipContent':
          "Hier kannst du nach Lernmodulen suchen, diese abonnieren und auch herunterladen, wenn du sie ohne Internetverbindung beantworten möchtest.",
      'areaOfCompetency': "Einführung in Lernmodule",
      'areaOfCompetenceContent':
          "Jeder Lernmodul benötigt spezielles Wissen um Fragen zu beantworten.\"Grösse\" zeigt an, wieviele Fragen es in einem Lernmodul gibt\n\nIn der Beschreibung erfährst du, um was es in diesem Lernmodul geht.\nDu kannst Lernmodule abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Lernmodule sind dir evtl. schon zugeordnet und können nicht deaktiviert werden.",
      'customizeYourCompany': "Profil bearbeiten",
      'customizeYourCompanyContent':
          ", \n\nwillkommen zu dieser spielerischen Wissensmanagement App.\nBist du bereit Wissenspunkte zu verdienen und Kollegen und Freunde herauszufordern?\nBitte klick auf deinen Namen oder "
              "Profil"
              " im Menü (“>”).",

      //Organization screen Dialog
      'hireHrEmp': 'Maximale Bonuspunkte',
      'hireHrEmpDetails': 'Im Folgenden wirst du lernen wie du mit Bonuspunkten Verbesserungen freischalten kannst ',

      'hireHrEmpDetailsSeconds':
          'Um zu erfahren was die einzelnen Verbesserungen bringen, kannst du auf sie klicke.\n\nLass uns damit anfangen die Anzahl maximaler Bonuspunkte (BP) zu erhöhen. Dafür bitte auf "Max. Bonuspunkte (BP)" klicken und dann auf "Level erhöhen"',

      'empOMaster': 'Bonuskapazität',
      'empOMasterDetails':
          'Deine Bonuskapazität ist jetzt 40/50.\n50 ist die gesamte Bonuskapazität und 40 die noch verfuegbare, da du ja schon 10 Bonuspunkte für die Verbesserung der Max. Bonuspunkte investiert hast.\nDu kannst die Bonuskapazität weiter erhöhen, indem du weitere Bonuspunkte in die "Max. Bonuspunkte" investierst.\nEin klick auf deine Bonuskapazitaeten bringt dich auch zu diesem Bildschirm.',
      'costOfEmp': 'Bonuspunkte Kosten',
      'costOfEmpDetails':
          'Hier kannst du deine Wissenspunkte (WP) sehen.\n\nBonuspunkte zu investieren kostet Wissenspunkte (Kosten steigen mit der Zeit). Diese Kosten werden von deinen Wissenspunkten (WP) abgezogen.\nJeder Bonuspunkt kostet außerdem 200 Wissenspunkte pro investiertem Bonuspunkt und Tag (Kosten steigen mit der Zeit).',

      //setting screen Dialog
      'settingDetails': 'Du kannst zum wissensspiel wechseln (virtuelles Unternehmen) und den Ton ein und aus schalten.',

      //Dashboard Game screen
      'welcomeToKnow': 'Willkommen bei Knowledge Empire',
      'welcomeToKnowDetails':
          ", \n\nwillkommen zu dieser spielerischen Wissensmanagement App.\nBist du bereit Wissenspunkte zu verdienen und Kollegen und Freunde herauszufordern?\nBitte klick auf deinen Namen oder "
              "Profil"
              " im Menü (“>”).",
      'clickYourProfile': 'Klick auf dein Profil',
      'meetYourTeam': 'Bonuspunkte',
      'meetYourTeamDetails':
          "Auf Bonuspunkte  klicken um mögliche Verbesserungen einzusehen. Hier kannst Bonuspunkte investieren um Vereinfachungen zu erhalten Zu Beginn musst du ein paar Bonuspunkte investieren um die maximalen Bonuspunkte, maximale Lernpunkte und maximale Bestandsfragen zu erhöhen.",
      'clickOrgChart': 'Klick auf "Bonuspunkte"',
      'getReadyApproach': 'Lernpunkte (LP) um Fragen zu beantworten',
      'getReadyApproachDetails':
          '"Um neue Fragen beantworten zu können benötigst du Lernpunkte (LP).\n\nLass uns unsere Lernpunkte auf 10 erhöhen. Dazu klick bitte auf ""Lernpunkte (LP)"" und Anschließend auf ""Level erhöhen""."',
      'clickSale': 'Klick auf "Lernpunkte (LP)"',
      'salesOMeter': 'Lernkapazität',
      'salesOMeterDetails':
          "Deine Lernkapazitäten zeigen nun 10/10.\nDie letzte Zahl zeigt dir deine gesammten Lernkapazitäten und die erste Zahl, wieviele davon aktuell verfuegbar sind.\n\nFragen zu beantworten beansprucht Lernkapazitäten für 8 Stunden bevor sie wieder zur Verfuegung stehen.",
      'getReadyServer': 'Bestandsfragen (BF)',
      'getReadyServerDetails':
          "Wenn du eine Frage richtig beantwortest wechselt sie in die Liste der Bestandsfragen. Dazu benötigst du ausreichend Kapazitaeten in den Bestandsfragen.\n\nLass uns die Bestnadskundenkapazitaeten auf 10 erhöhen. Dazu bitte auf "
              "Bestandsfragen (BF)"
              " und dann auf "
              "Level erhöhen"
              " klicken.",
      'clickOnService': 'Klick auf "Bestandsfragen"',
      'serviceOMeter': 'Bestandsfragenkapazitat (BF)',
      'serviceOMeterDetails':
          "Deine Bestandsfragenkapazitaeten zeigen jetzt 10/10.\n\nDie hintere Zahl zeigt dir deine gesamten Bestandsfragenkapazitaeten an. Die erste Zahl zeigt dir, wieviele diese Bestandsfragenkapazitaeten aktuell frei zur Verfuegung stehen.\n\nJeder Fragen benötigt eine freie Bestandsfragenkapazitat.",

      'readyForSerious': 'Bereit für die erste Frage?',
      'readyForSeriousDetails': "Super, jetzt sind wir startklar. Lass uns in einen Blick in die Lernmodule werfen.\n\nBitte im Menü "
          ">"
          " "
          "Lernmodule"
          " auswählen.",
      'goToBusiness': 'Zu "Lernmodule" wechseln',

      'dashboardProfile': 'Benutzer Profil und\nSprache anpassen',
      'dashboardSales': 'Lernkapazitäten"\num Fragen zu beantworten',
      'dashboardServices': '""Bestandsfragenkapazitaeten"\num Fragen zu behalten',
      'dashboardBalance': '""Wissenspunkte"\nerhöhen durch Fragen beantworten',
      'dashboardBusiness': '1. Lernmodule\nsuchen & auswählen',
      'dashboardNewCustomer': '2. Fragenkatalog\nFragen beantworten',
      'dashboardExistingCustomer': '3. Bestandsfragenliste\nRichtig beantwortete Fragen',
      'alertChangePassword': 'Passwort erfolgreich geändert.',
      'unLockOrg': 'Wird freigeschaltet, wenn zum ersten mal Lern- oder Bestandsfragen-Kapazitäten erschoepft sind',
      'unLockPl': 'Wird eine Woche nach erstem Login freigeschaltet',
      'unLockRanking': 'Wird freigeschaltet, wenn sich Nutzer drei Tage in Folge anmeldet',
      'unLockReward': 'Wird freigeschaltet, wenn erstes Achievement erreicht wird',
      'unLockChallenge': 'Wird freigeschaltet, wenn Max. Herausforderungen erstmals erhöht werden',

      'dear': "Hallo",
      'hi': "Hallo",
      'noInternet': 'Bitte Internetverbindung prüfen',
      'update': "Jetzt aktualisieren",
      'updateLatter': "Später aktualisieren",
      'noOffline': "Diese Funktion ist leider nur online verfügbar.",
      'my': 'Mein',
      'mHis': 'Sein',
      'by': 'Von',
      'inText': 'In',
      'toWin': 'Preis',
      'challenge': 'Herausforderung',
      'servicePerson': 'Bestandsfragen',
      'salesReps': 'Lernpunkte ',

      'cashAtTheEndOfPeriod': "Wissenspunkte am Ende der Periode",
      'sizeInKb': "kb",
      'questions': "Fragen",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",
      'costSplit': "Kosten",
      'sevenDaysDevelopment': "7 Tage Überblick",

      'subscribedSuccess': 'Erfolgreich abonniert!',
      'unSubscribedSuccess': 'Erfolgreich abbestellt!',
      'selectLanguages': 'Sprache auswählen',
      'requestDemoAccount': "Request demo Account",
      'requestDemoAccount': "Demozugang beantragen",
      'strVersion': "Version",
      'strUrlExeption': "Konnte nicht gestartet werden",
      'strOpen': "Offen",

      //help screen
      'helpProProfile': '"Profil:  \n- Firmenname ändern  \n- Zu gamifizierter Version wechseln  \n- Neustart beantragen"',
      'helpProEmployMeter':
          '"Bonuskapazitäten (xx/yy):  \n- xx = noch verfuegbare Bonuspunkte  \n- yy = totale Bonuskapazitaet  \n- Jeder Bonuspunkt kostet 200 (zunehmend) pro Tag  \n- Auf Bonuspunktekapazitaeten klicken um zum Lernbonusbildschirm zu wechseln"',
      'helpProSalesMeter':
          '"Lernkapazitäten (xx/yy):  \n- xx = noch verfuegbare Lernkapazität  \n- yy = totale Lernkapazität  \n- Lernpunkte fuellen sich 8 Stunden nach benutzung automatisch wieder auf  \n- Auf Lernkapazitäten klicken um zum Fragenkatalog zu wechseln"',
      'helpProServiceMeter':
          '"Bestandsfragenkapazitäten (xx/yy):  \n- xx = noch verfügbare Bestandsfragenkapazität  \n- yy = totale Bestandsfragenkapazität  \n- Jeder Frage bindet eine Bestandsfragenkapazität  \n- Auf Bestandsfragenkapazitaeten klicken um zur Bestandskundenliste zu wechseln"',
      'helpProBrandValue':
          '"% richtige Antworten:  \n- Anteil richtig beantworteter Fragen  \n- Auf % richtige Antworten klicken um zur Rangliste zu wechseln"',
      'helpProCash':
          '"Wissenspunkte:  \n- Erhöht sich durch korrekt beantwortete Fragen und Auszeichnungen  \n- Verringert sich duch Kosten fuer Bonuspunkte"',

      'helpProBusinessSector':
          '"Lernmodule:  \n- Neue Lernmodule finden  \n- Abonnieren / abmelden  \n- Herunterladen zur Nutzung ohne Internet Zugang"',
      'helpProNewCustomers':
          '"Fragenkatalog:  \n- Neue unbeantwortete Fragen finden und beantworten  \n- Fragen benötigen freie Lern- und Bestandsfragen-Kapazitäten  \n- Tage bis zur nächsten Wiederholung nimmt bei richtigen Antworten zu"',
      'helpProExistingCustomer':
          '"Bestandsfragen:  \n- Bestandsfragen liste enthält richtig beantwortete Fragen  \n- Tage bis zur nächsten Wiederholung nimmt bei richtigen Antworten zu"',
      'helpProRewards': '"Auszeichnungen:  \n- Gibt es für gewisse Aktionen  \n- Steigen im Wert in höheren Leveln"',
      'helpProTeam':
          '"Teamperformance (nur Sichtbar wenn Mitarbeiterführung besteht):  \n- Liste der Mitarbeiter im Team  \n- Basis Reporting und KPIs  \n- Neustarts gewähren"',
      'helpProChallenges':
          '"Herausforderungen:  \n- Kollegen herausfordern  \n- hoher % Wert bedeutet der Herausgeforderte hat viele Fragen richtig zu beantworten  \n- niedriger % Wert bedeutet der Herausgeforderte hat wenig Fragen zu beantworten, bekommt aber auch nur wenig Wissenspunkte"',
      'helpProOrganization':
          '"Lernbonus:  \n- Bonuspunkte auf Bonusbereiche verteilen  \n- ""Max. Bonuspunkte"" erhöhen um mehr Bonuspunkte verteilen zu koennen  \n- Jeder Bonuspunkt kostet 100 Wissenspunkte pro Tag und nimmt mit der Zeit zunehmend"',
      'helpProP': '"Entwicklung: \n- Überwache die Entwicklung deines Fortschritts  \n- Sorge dafür, dass deine Wissenpunkte zunehmen"',
      'helpProRanking': '"Rangliste:  \n- Rang einsehen und vergleichen  \n- Unterschiedliche Zeitlinien können angezeigt werden"',
      //</editor-fold>
      'passwordChange': 'Passwort erfolgreich geändert.',
      'nicknameChange': 'Spitzname erfolgreich geändert',
      'serviceReps': "Bestandsfragen",

      'strProProfile': "- Firmenname ändern\n- Zu gamifizierter Version wechseln\n- Neustart beantragen",
      'strEmpOMeter':
          "- xx = noch verfuegbare Bonuspunkte\n- yy = totale Bonuskapazitaet\n- Jeder Bonuspunkt kostet 200 (zunehmend) pro Tag\n- Auf Bonuspunktekapazitaeten klicken um zum Lernbonusbildschirm zu wechseln",
      'strSalesOMeter':
          "- xx = noch verfuegbare Lernkapazität\n- yy = totale Lernkapazität\n- Lernpunkte fuellen sich 8 Stunden nach benutzung automatisch wieder auf\n- Auf Lernkapazitäten klicken um zum Fragenkatalog zu wechseln",
      'strServiceOMeter':
          "- xx = noch verfügbare Bestandsfragenkapazität\n- yy = totale Bestandsfragenkapazität\n- Jeder Frage bindet eine Bestandsfragenkapazität\n- Auf Bestandsfragenkapazitaeten klicken um zur Bestandskundenliste zu wechseln",
      'strBrandValue': "- Anteil richtig beantworteter Fragen\n- Auf % richtige Antworten klicken um zur Rangliste zu wechseln",
      'strBrandValueTitle': "% richtige Antworten",
      'strCash': "- Erhöht sich durch korrekt beantwortete Fragen und Auszeichnungen\n- Verringert sich duch Kosten fuer Bonuspunkte",
      'strBusinessSector': "- Neue Lernmodule finden\n- Abonnieren / abmelde\n- Herunterladen zur Nutzung ohne Internet Zugang",
      'strNewCustomer':
          "- Neue unbeantwortete Fragen finden und beantworten\n- Fragen benötigen freie Lern- und Bestandsfragen-Kapazitäten\n- Tage bis zur nächsten Wiederholung nimmt bei richtigen Antworten zu",
      'strExistingCustomer':
          "- Bestandsfragen liste enthält richtig beantwortete Fragen\n- Tage bis zur nächsten Wiederholung nimmt bei richtigen Antworten zu",
      'strAchievement': "- Gibt es für gewisse Aktionen\n- Steigen im Wert in höheren Leveln",
      'strReward': "- Tausche Wissenspunkte ein, um echte Belohnungen zu erhalten",
      'strTeam': "- Liste der Mitarbeiter im Team\n- Basis Reporting und KPIs\n- Neustarts gewähren",
      'strChallenges':
          "- Kollegen herausfordern\n- hoher % Wert bedeutet der Herausgeforderte hat viele Fragen richtig zu beantworten\n- niedriger % Wert bedeutet der Herausgeforderte hat wenig Fragen zu beantworten, bekommt aber auch nur wenig Wissenspunkte",
      'strOrganization':
          "- Bonuspunkte auf Bonusbereiche verteilen\n- \"Max. Bonuspunkte\" erhöhen um mehr Bonuspunkte verteilen zu koennen\n- Jeder Bonuspunkt kostet 100 Wissenspunkte pro Tag und nimmt mit der Zeit zunehmend",
      'strPL': "- Überwache die Entwicklung deines Fortschritts\n- Sorge dafür, dass deine Wissenpunkte zunehmen",
      'strRanking': "- Rang einsehen und vergleichen\n- Unterschiedliche Zeitlinien können angezeigt werden",
      'strRanking': "- Rang einsehen und vergleichen\n- Unterschiedliche Zeitlinien können angezeigt werden",
      'strKp': "WP",
      'strBalance': "Wissenspunkte",
      'addFriend': 'Freund hinzugefügt',
      'unFriend': 'Freund entfernt',
      'alert': "Achtung",
      'alertUnFriend': "Sind Sie sicher, dass Sie diesen Benutzer entfreunden möchten?",
      'Asc': "Asc",
      'Desc': "Desc",
      'Level': "Level",
      'Retention': "Retention",
      'DaysInLimit': "DaysInLimit",
      'targetLevel': "Target Level",
      'targetRetention': "Target Retention",
      'certificationCriteria': "Certification Criteria",
    },
    'zh': {
      //Nickname
      'enterNickName': '请输入昵称',
      'nicknameChange': '昵称已成功更改',
      'newNickName': '新昵称',
      'nickName': '昵称',
      'downloadText': '这个模块将占用',

      //Company code
      'enterCompanyCode': '请输入您在电子邮件中收到的公司代码',
      'changeLanguage': '改变语言',
      'companyCode': '公司代码',

      //password
      'enterOldPassword': '请输入旧密码。',
      'enterNewPassword ': '请输入新密码。',
      'enterRePassword': '请重新输入新密码。',
      'enterSameNewPassword': '请输入相同的新密码。',

      //<editor-fold desc="chines">
      'accept': "接受",
      "decline": "下降",
      'home': '首页',
      'businessSector': '学习模块',
      'newCustomers': '开放学习',
      'existingCustomers': '记忆学习',
      'organizations': '威力升级',
      'challenges': '挑战',
      'pl': '表现',
      'rewards': '奖赏',
      'ranking': '排名',
      'team': '团队',
      'profile': '个人资料',
      'help': '帮助',
      'emailId': '电子邮件ID',
      'editProfile': '编辑个人资料',
      'yourName': '您的名字',
      'yourEmail': '您的电子邮箱',
      'changePassword': '更改密码',
      'save': '保存',
      'settings': '设置',
      'privacyPolicy': '隐私政策',
      'termsConditions': '条款及细则',
      'contactUs': '联系我们',
      'switchProfMode': '切换到专业模式',
      'switchBusinessMode': '切换到业务模式',
      'logout': '登出',
      'choosePhoto': '选择照片',
      'takePhoto': '拍照',
      'sound': '声音',
      'bailout': '重新开始',
      'requestBailOut': '请求重新开始',
      'alertBailOut': '您确定要重新开始吗？',
      'successProfileUpdate': '个人资料已更新！',
      'selectCompany': '选择公司',
      'selectLanguage': '选择语言',
      'login': '登录',
      'enterRegisteredEmail': '输入注册电子邮件ID',
      'password': '密码',
      'newPassword': '新密码',
      'currentPassword': '当前密码',
      'reEnterPassword': '重新输入新密码',
      'cancel': '取消',
      'send': '发送',
      'forgotPassword': '忘记密码？',
      'fireEmp': '降低等级',
      'hireEmp': '提高等级',
      'sector': '模块',
      'name': '名字',
      'value': '知识点数',
      'loyalty': '重复...',
      'resources': '学习点数',
      'engage': '回答',
      'engageNow': '立刻回答',
      'endRel': '解除',
      'alertReleaseResources': '该问题将被删除，不会再产生任何知识分数，只有在下一个重复时间才能再次访问',
      'searchForKeywords': '搜索关键字',
      'somethingWrong': '出了问题',
      //Rewards module
      'redeem': '赎回',
      'costReward': '费用',
      'costUnit': '知识点数',
      'unitsLeft': "剩余单位",
      'categories': '类别',

      'subscribe': '加入',
      'unSubscribe': '取消加入',
      'contactExpert': '咨询专家',
      'moreInformation': '了解更多资讯',
      'subscribed': '已加入',
      'downLoad': '下载',
      'size': 'Q&A',
      'description': '描述',
      'alertWantToSubscribe1': '您确定要取消加入吗？',
      'alertWantToSubscribe2': '您将失去所有的问题',
      'downloading': '正在下载......',
      'alertNotAllowed': '您不能取消加入已分配的学习模块',
      'engagement': '情况',
      'debrief': '任务报告',
      'category': '类别',
      'achievement': '奖励',
      'nextLevel': '下一级',
      'friends': '朋友',
      'competitor': '同事',
      'sendChallenge': '发送挑战',
      'next': '下一页',
      'BackToList': '回到问题主选单',
      'answers': '答案',
      'question': '问题',
      'explanation': '说明',
      'alertSelectOneOption': '请至少选择一个选项',
      'situation': '任务报告',
      'profit': '知识点数 (KP)',
      'learningModule': '学习模块',
      'levels': '级别',
      'complete': '%完成',
      'qLevel': 'Q级',
      'qStatus': 'Q状态',
      'lastLog': '上次登录时间',
      'points': '%正确',
      'correct': '类别:',
      'department_': '重置:',
      'department': '重置',
      'resets_': '名字:',
      'name_': '扣除',
      'cost': '您',
      'you': '世界',
      'world': '国家',
      'country': '分数',
      'score': '昵称',
      'companyName': '公司名称',
      'revenue': '#问题',
      'hashCustomers': '%正确',
      'brand': '%正确',
      'cashAtStartOfPeriod': '期初知识点数',
      'employees': '费用',
      'salaries': '问题',
      'customers': '日',
      'day': '月',
      'month': '年',
      'year': '上一时期',
      "total": "total",
      'lastPeriod': '这一时期',
      'thisPeriod': '您确定要重新开始吗',
      'alertWantToBailOut': '噢，没有找到此用户的学习模块。',
      'alertNoModuleFound': '好',
      'ok': '是',
      'yes': '否',
      'no': '即将推出',
      'comingSoon': '关闭',
      'close': '关闭',

      //introDialog
      'gotIt': "了解",
      'rewardsDialogContent': "查看奖励类别，点击奖杯查看您目前的成就以及您需要取得多少成就才能升到下一级别.\n\n下一级下面的数字是您将收到的奖金。",
      'challengesDialogTitle1': "挑战",
      'challengesDialogContent1': "在这里，您将学习如何挑战其他同事",
      'strChallanges': "挑战",
      'strChallangesDialogContent': "搜索或选择您想挑战的同事。\n选择您想挑战他的学习模块之一，\n然后选择赢家可以获得的奖励 (%当前知识点数 (KP))。\n您的竞争对手需要正确回答选定模块的3个问题才能赢得挑战。",
      'strMarketingCommunications': "排名",
      'strMarketingCommunicationsDialog': "在这一部分，您将了解有关排名的所有信息",
      'strRankingDialogContent': "在左侧选择排名标准 (比如知识点数 (KP))，并在顶部 选择您想对比的分组以及时间范围。\n您也可以点击"
          "您"
          "滚动到您的位置和挑战以及添加朋友。",
      'strYourTeamPerformance': "您的团队的表现",
      'strYourTeamPerformanceDialog': "这部分是团队领导专属。\n在这里您可以看到您的报告的表现。",
      'strTeamDialog': "作为经理，您可以查看和监控您的团队的表现。如果您点击一个团队成员，您可以看到他的个人表现，并将他的知识点 (KP) 重置为30.000。",

      'plPerson': '表现',
//      'niceMeetYou':'${Injector.userData?.name??""}很高兴见到您',
      'plMyName': '在这一部分，\n您将了解有关表现分析的所有信息',
      'hereYourMonitor': '在这里，您可以监控扣除和增加知识点数 (KP)。',
      'selectPeriod': '您还可以选择您想要查看的时间段和比较当前周期与上一个周期。',
      'strYourTeamPerformanceDialog2': '图表显示"保留级别"和"问题状态” "保留级别"表示保留了多少问题（1 = 低保留级别，10 = 知识保留得很好）。"问题状态"表示问题是否已开启并已回答（开启 = 开启回答，完成 = 已正确回答)',
      //existing customer
      'servingYourExisting': '已完成的学习列表',
      'servingYourExistingDialog': '\n在本教程的这一部分，\n您将学习有关您已完成的学习的所有相关信息',
      'listOfExisting': '已完成的学习列表',
      'listOfExistingDetails':
          '在这里，您可以看到您目前已经记住的所有问题。\n您每天从这些问题那里获得多少知识点 (KP) 以及这些问题会在列表中存在多少天。\n如果您想删除一个问题，您可以点击"X"。\n然后，这个问题将不会为您生成更多的知识点数，\n但您将重新获得1个可用记忆点数 (MP)。',
      'readyForBusiness': '准备开始',
      'readyForBusinessDeatils': '您可以进一步查看学习模块，回答更多的问题。\n\n或者探索这个应用程序的其他区域，您可以赚取奖励，挑战其他玩家，查看您的表现和比较您的排名。',
      'finishTutorial': '完成教程',

      //customer situation
      'impactOnSales': '对学习点数 (SP) 和记忆点数 (MP) 的影响',
      'impactOnSalesDetails': '恭喜！您正确地回答了您的第一个问题。\n您的学习点数 (SP) 条现在显示8/10，因为这个问题需要2个学习点数。您的记忆力点数 (MP) 条显示 9/10，因为这个问题会在您的已完成学习列表中占用1个记忆点数。',
      'impactOnBrand': '对知识分数 (KS) 的影响',
      'impactOnBrandDetails': '您的知识分数 (KS) 现在是100％，因您100%正确回答了所有问题。\n\n独立于您的知识分数 (KS)，您的知识点数 (KP) 也因为获得这个问题提供的知识点数而增加。',
      'checkYourCustomer': '查看完整的学习列表',
      'checkYourCustomerDetails': '您可以在"已完成的学习"部分找到包含所有已完成的问题的列表。\n\n您可以通过点击您的记忆力点数 (MP) 条，\n从菜单选择“已完成的学习”，或者前往主页面选择“已完成的学习”进入您的“已完成的学习”页面。',
      'clickServiceBtn': '点击您的记忆点数 (MP) 条',

      //engagement
      'yourFirstEngagement': '您的第一个问题',
      'yourFirstEngagementDetails': '为了赢得这个问题，您需要正确回答这个问题。您可以点击展开按钮放大图片、问题和答案选项。\n\n选择正确的答案，然后单击"下一页”',
      'yourFirstEngagementBtn': '选择答案并单击"下一页”',

      //New Customer screen
      'heartBusiness': '开放学习列表',
      'heartBusinessDetails': '在本教程的这一部分,\n您将学习选择和回答问题所需的所有相关信息',
      'listOfPotential': '问题列表',
      'listOfPotentialDetails':
          '每个问题都有一个名称，属于对应的学习模块。\n知识是您每天可以在已完成学习列表中通过这 个问题可以赚取的知识点数 (KP)。\n“重复...”表示您如果现在回答正确，在多少天后您需要重复回答这个问题。\n您越经常正确地回答一个问题，您就越不经常需要重复。\n学习点数 (SP) 表示您需要多少学习点数 (SP) 来回答这个问题。点击"立即回答"。',
      'listOfPotentialBtn': '点击"立即回答"',

      //Business sector screen dialog
      'customerRelation': '学习模块介绍',
      'customerRelationDetails': '\n在这里，您可以搜索学习模块，加入和取消加入，\n并决定是否要下载内容以供将来离线使用。',
      'areaOfComp': '学习模块介绍',
      'areaOfCompDetails': '每个学习模块将测试特定的知识领域。\n"大小"表示每个模块中的问题数量。\n您可以点击学习模块阅读描述，并决定是否要加入它们。\n某些学习模块已由贵公司分配给您，无法取消加入。',
      'accessToFirst': '加入第一个模块',
      'accessToFirstDetails': '您可以加入第一个商业部门从而访问您的第一个问题。\n\n点击学习模块"开始"，然后点击"加入"。',
      'accessToFirstBtn': '点击"开始”',
      'readyForCustomer': '准备好您的第一个问题',
      'readyForCustomerDetails': '让我们前往开放学习板块，其中包含一个您可以回答的新问题列表。\n\n您可以点击您的学习点数 (SP) 条，使用导航菜单“>”，或者单击后退按钮，然后选择“开放学习”。',
      'readyForCustomerBtn': '点击学习点数 (SP) 条',

      'customersRelationShip': "学习模块介绍",

      'customersRelationShipContent': "在这里，您可以搜索学习模块，加入和取消加入，并决定是否要下载内容以供将来离线使用。",
      'areaOfCompetency': "学习模块介绍",
      'areaOfCompetenceContent': "每个学习模块将测试特定的知识领域。\"大小\"表示每个模块中的问题数量。您可以点击学习模块阅读描述，并决定是否要加入它们。某些学习模块已由贵公司分配给您，无法取消加入。",
      'customizeYourCompany': "自定义您的个人资料",
      'customizeYourCompanyContent': "，\n\n欢迎来到游戏化的学习体验。\n您准备好赚取点数以及和同事竞争了吗？\n点击您的姓名或导航菜单 (“>”) 中的\n"
          "个人资料"
          "。 ",

      //Organization screen Dialog
      'hireHrEmp': '提高“最大威力升级 (PU)”',
      'hireHrEmpDetails': '接下来，您将学习如何提高您的威力升级点数 (PU)',

      'hireHrEmpDetailsSeconds':
          '如需获取建议和了解提高威力升级点数 (PU) 的原因，请点击它们。\n让我们先花费10个威力升级点数 (PU) 和1000个知识点数 (KP) 来将“最大威力升级 (PU)”升至1级。\n点击“最大威力升级 (PU)”然后点击“提高等级”',

      'empOMaster': '威力升级点数 (PU) 条',
      'empOMasterDetails': '您的威力升级点数 (PU) 条显示40/50。\n50是您最大的威力升级点数 (PU)，40是您当前可用的点数。\n您可以通过提高威力升级点数 (PU) 级别来增加您的最大值。\n点击您的威力升级点数 (PU) 条，您将前往此界面。',
      'costOfEmp': '进步的成本',
      'costOfEmpDetails':
          '在这里，您可以看到您的知识点数 (KP)。\n\n提高威力升级点数 (PU) 会花费知识点数 (KP)。随着等级的提升，这种一次性的花费成本会增加。\n每花费一个威力升级点数 (PU) 会不断产生费用，一开始是每天每个威力升级点数 (PU) 消耗200个知识点数 (KP)。这种成本将随着时间的推移而增加。',

      //setting screen Dialog
      'settingDetails': '您可以切换到游戏模式（有虚拟公司),您可以打开或关闭声音。\n\n如果您的点数变为负数，您可以请求重新开始，您的经理会进行审批。',

      //Dashboard Game screen
      'welcomeToKnow': '',
      'welcomeToKnowDetails': ", \n\n欢迎来到游戏化的学习体验。\n您准备好赚取点数以及和同事竞争了吗？\n点击您的姓名或导航菜单 (“>”) 中的\n"
          "个人资料"
          "。 ",
      'clickYourProfile': '点击您的个人资料',
      'meetYourTeam': '您的威力升级点数 (PU)',
      'meetYourTeamDetails': "点击威力升级点数查看您的进步概览。\n您可以根据需要增加和减少威力升级点数的级别！\n开始前您需要提高”最大威力升级点数 (PU)”，“最大学习点数 (SP)”和“最大记忆力 (MP)”。",
      'clickOrgChart': '点击威力升级 (PU)',
      'getReadyApproach': '回答问题的学习点数 (SP)',
      'getReadyApproachDetails': '"要回答问题，您需要学习点数。\n\n让我们点击“最大学习点数 (SP)”，然后“提升等级”来将“最大学习点数 (SP)”升至1级。"',
      'clickSale': '点击“最大学习点数 (SP)”',
      'salesOMeter': '学习点数 (SP) 条',
      'salesOMeterDetails': '"您的学习点数 (SP) 条显示10/10。\n最后一个数字显示您的最大学习点数 (SP)。\n第一个数字显示当前可用的学习点数 (SP)。\n\n回答问题将需要学习点数 (SP)，8小时后会自动补充。"',

      'getReadyServer': '最大记忆点数 (MP)',
      'getReadyServerDetails': "为了在您的记忆中保持一个正确的回答，您需要有一个可用的记忆点数。\n\n让我们点击“最大记忆点数 (MP)"
          "，然后点击“提升等级”来获取10个记忆点数。",
      'clickOnService': '点击“最大记忆点数 (MP)"',
      'serviceOMeter': '记忆点数 (MP) 条',
      'serviceOMeterDetails': "您的记忆点数 (MP) 条显示10/10。\n最后一个数字显示您的最大记忆容量。\n第一个数字显示新问题的可用记忆点数。\n\n每个正确回答的问题将需要1个记忆点数。",

      'readyForSerious': '准备好回答您的第一个问题了吗',
      'readyForSeriousDetails': "很好，您现在已经准备好您的第一个问题。\n让我们前往"
          "学习模块"
          "部分选择要进入的第一个学习模块。\n\n您可以点击菜单"
          ">"
          "，然后点击"
          "学习模块”",
      'goToBusiness': '转到"学习模块"',

      'dashboardProfile': '更改个人资料\n名字，语言',
      'dashboardSales': '学习点数条      \n可用学习点数',
      'dashboardServices': '记忆点数条      \n可用记忆点数',
      'dashboardBalance': '回答问题可以增加您的点数',
      'dashboardBusiness': '1. 学习模块\n选择学习模块',
      'dashboardNewCustomer': '2. 新问题\n回答问题',
      'dashboardExistingCustomer': '3. 现有问题\n复习问题',
      'alertChangePassword': '密码已更改。',
      'unLockOrg': '学习或记忆点数第一次清零时解锁。',
      'unLockPl': '在第一次登录一周后解锁',
      'unLockRanking': '连续三天登录后解锁',
      'unLockReward': '在达成第一个成就后解锁',
      'unLockChallenge': '最大挑战威力升级点数增加后解锁',

      'dear': "亲爱的",
      'hi': "亲爱的",
      'noInternet': '请确认是否连接到互联网',
      'update': "立即升级",
      'updateLatter': "以后再说",
      'noOffline': "很抱歉 此项功能需要连接互联网",
      'my': '我的',
      'mHis': '他的',
      'by': '挑战者',
      'inText': '学习模块',
      'toWin': '可赢得',
      'challenge': '挑战',
      'servicePerson': '记忆点数',
      'salesReps': '学习点数',

      'cashAtTheEndOfPeriod': "期末知识点数",
      'sizeInKb': "kb",
      'questions': "问题",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",
      'costSplit': "花费",
      'sevenDaysDevelopment': "过去7天的概览",

      'subscribedSuccess': '订阅成功！',
      'unSubscribedSuccess': '取消订阅！',
      'selectLanguages': '选择语言',
      'requestDemoAccount': "申请模拟账户",
      'strVersion': "版本",
      'strUrlExeption': "无法启动",
      'strOpen': "打开",

      //help pro screen :
      'helpProProfile': '"个人资料: \n- 更改您的公司名称 \n- 切换到游戏模式 \n- 切换公司 \n- 申请重新开始"',
      'helpProEmployMeter': '"威力升级点数条 (xx/yy): \n- xx = 当前可用威力升级点数 \n- yy = 威力升级总量 \n- 每一个威力升级点数每天花费您200 (逐渐增加) \n- 点击威力升级点数条将前往威力升级界面"',
      'helpProSalesMeter': '"学习点数条 (xx/yy): \n- xx = 当前可用学习点数 \n- yy = 总学习点数 \n- 8小时候已使用的学习点数会重新填充 \n- 点击学习点数条将前往开放问题列表"',
      'helpProServiceMeter': '"记忆点数条 (xx/yy): \n- xx = 当前可用记忆点数 \n- yy =  总记忆点数 \n- 每个问题需要一个可用的记忆点数 \n-  点击记忆点数条将前往已回答问题列表"',
      'helpProBrandValue': '"%正确答案: \n- 正确回答问题的百分比 \n- 点击%正确答案将前往排名界面 "',
      'helpProCash': '"知识点数: \n- 正确回答问题和达成成就都可以增加知识点数 \n- 进行威力升级会减少知识点数"',

      'helpProBusinessSector': '"学习模块: \n- 寻找新的学习模块 \n- 加入 / 取消加入 \n- 下载以供离线使用"',
      'helpProNewCustomers': '"开放学习: \n- 寻找新的问题来回答 \n- 每个问题都需要可用的学习和记忆点数 \n- 如果您答对了问题，问题重复的次数就会增加"',
      'helpProExistingCustomer': '"完成的学习: \n- 复习您所有正确回答的问题 \n- 如果您答对了问题，问题重复的次数就会增加"',
      'helpProRewards': '"奖励: \n- 通过完成某些任务获得奖励 \n- 如果您达到新的级别，您将获得额外的知识点数奖励"',
      'helpProTeam': '"团队 (仅对经理可见): \n- 您的直接下属名单 \n- 高级别报告和KPI \n- 允许纾困/重置"',
      'helpProChallenges': '"挑战: \n- 挑战好友 \n- 选择%价值，确定问题的数量#和奖励 \n- 增加% = 增加要回答的问题的数量 \n- 更高％ = 如果对手赢了，他可以赢得更多，如果他输了，您赢得更少"',
      'helpProOrganization': '"威力升级: \n- 选择额外的威力升级 \n- 您需要威力升级容量 (PU) 才能使用威力升级点数 \n- 每天每使用一个威力升级点数花费您100个知识点数"',
      'helpProP': '"表现: \n- 监控您的表现和进步 \n- 确保您赚取足够的知识点数"',
      'helpProRanking': '"排名: \n- 查看和比较您的排名 \n- 您可以检查多个时间段和比较多个群组"',
      //</editor-fold>
      'passwordChange': '密码已更改。',
      'nicknameChange': '昵称已成功更改',
      'serviceReps': "记忆点数",

      'strProProfile': " - 更改您的公司名称\n- 切换到游戏模式\n- 切换公司\n- 申请重新开始",
      'strEmpOMeter': "- xx = 当前可用威力升级点数\n- yy = 威力升级总量\n- 每一个威力升级点数每天花费您200 (逐渐增加)\n- 点击威力升级点数条将前往威力升级界面",
      'strSalesOMeter': "- xx = 当前可用学习点数\n- yy = 总学习点数\n- 8小时候已使用的学习点数会重新填充\n- 点击学习点数条将前往开放问题列表",
      'strServiceOMeter': "- xx = 当前可用记忆点数\n- yy =  总记忆点数\n- 每个问题需要一个可用的记忆点数\n-  点击记忆点数条将前往已回答问题列表",
      'strBrandValue': "- 正确回答问题的百分比\n- 点击%正确答案将前往排名界面",
      'strBrandValueTitle': "%正确答案",
      'strCash': "- 正确回答问题和达成成就都可以增加知识点数\n- 进行威力升级会减少知识点数",
      'strBusinessSector': "- 寻找新的学习模块\n- 加入 / 取消加入\n- 下载以供离线使用",
      'strNewCustomer': "- 寻找新的问题来回答\n- 每个问题都需要可用的学习和记忆点数\n- 如果您答对了问题，问题重复的次数就会增加",
      'strExistingCustomer': "- 复习您所有正确回答的问题\n- 如果您答对了问题，问题重复的次数就会增加",
      'strAchievement': "- 通过完成某些任务获得奖励\n- 如果您达到新的级别，您将获得额外的知识点数奖励",
      'strReward': "- 兑换知识点数以获得真实世界的奖赏",
      'strTeam': "- 您的直接下属名单\n- 高级别报告和KPI\n- 允许纾困/重置",
      'strChallenges': "- 挑战好友\n- 选择%价值，确定问题的数量#和奖励\n- 增加% = 增加要回答的问题的数量\n- 更高％ = 如果对手赢了，他可以赢得更多，如果他输了，您赢得更少",
      'strOrganization': "- 选择额外的威力升级\n- 您需要威力升级容量 (PU) 才能使用威力升级点数\n- 每天每使用一个威力升级点数花费您100个知识点数",
      'strPL': "- 监控您的表现和进步\n- 确保您赚取足够的知识点数",
      'strRanking': "- 查看和比较您的排名\n- 您可以检查多个时间段和比较多个群组",
      'strRanking': "- 查看和比较您的排名\n- 您可以检查多个时间段和比较多个群组",
      'strKp': "知识点数",
      'strBalance': "知识点数",
      'alert': "警告",
      'alertUnFriend': "您确定要与该用户成为好友吗？",
      'addFriend': '成功添加朋友',
      'unFriend': '成功取消朋友',
      'Asc': "Asc",
      'Desc': "Desc",
      'Level': "Level",
      'Retention': "Retention",
      'DaysInLimit': "DaysInLimit",
      'targetLevel': "Target Level",
      'targetRetention': "Target Retention",
      'certificationCriteria': "Certification Criteria",
      'generatePhraseCode': "生成密码短语？",
      "Addkey": "添加键",
      "EnterparsePhrase": "输入解析短语",
      "parsephrasemustbe16characters": "解析短语必须是 16 个字符",
    }
  };
}
