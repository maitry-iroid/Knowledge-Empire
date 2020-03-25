import 'package:ke_employee/injection/dependency_injection.dart';

class StringRes {
  //main options
  static var home = "home";
  static var businessSector = "businessSector";
  static var newCustomers = "newCustomers";
  static var existingCustomers = "existingCustomers";
  static var organizations = "organizations";
  static var challenges = "challenges";
  static var pl = "pl";
  static var rewards = "rewards";
  static var ranking = "ranking";
  static var team = "team";
  static var profile = "profile";
  static var help = "help";

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
  static var newPassword = "newPassword";
  static var currentPassword = "currentPassword";
  static var reEnterPassword = "reEnterPassword";
  static var cancel = "cancel";
  static var send = "send";
  static var forgotPassword = "forgotPassword";
  static var selectLanguages = "selectLanguages"; //onlu define english

  //organization
  static var fireEmp = "fireEmp";
  static var hireEmp = "hireEmp";

  //new customer
  static var sector = "sector";
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

  //learning module
  static var subscribe = "subscribe";
  static var unSubscribe = "unSubscribe";
  static var subscribed = "subscribed";
  static var downLoad = "downLoad";
  static var size = "size";
  static var description = "description";
  static var alertWantToSubscribe1 = "alertWantToSubscribe1";
  static var alertWantToSubscribe2 = "alertWantToSubscribe2";
  static var downloading = "downloading";
  static var thisModuleWillOccupie = "thisModuleWillOccupie";
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
  static var cashAtTheEndOfPeriod = "Cash at end of period";
  static var costSplit = "costSplit";
  static var revenueSplit = "revenueSplit";
  static var employees = "employees";
  static var salaries = "salaries";
  static var customers = "customers";
  static var day = "day";
  static var month = "month";
  static var year = "year";
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
  static var strMarketingCommunicationsDialog =
      "strMarketingCommunicationsDialog";
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

// change password
  static var alertChangePassword = "alertChangePassword";

//  static var empOMasterDetails = "empOMasterDetails";

  static Map<String, Map<String, String>> localizedValues = {
    'en': {
      //region english
      //main options
      'home': "Home",
      'businessSector': "Business Sector",
      'newCustomers': "New Customers",
      'existingCustomers': "Existing Customers",
      'organizations': "Organizations",
      'challenges': "Challenges",
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
      'alertReleaseResources':
          "This customer will be removed, not generate any more revenue and only be accessible again after Loyalty period",

      //challenges
      'searchForKeywords': 'Search for keywords',
      'somethingWrong': 'Something went wrong',
      'friend': 'Friend',
      'alertFriendSuccess': "Friend added successfully",
      'alertUnFriendSuccess': "Unfriend successfully",
      'alertUChallengeSent': "Challenge sent successfully!",

      //learning module
      'subscribe': 'Subscribe',
      'unSubscribe': 'Unsubscribe',
      'subscribed': 'Subscribed',
      'downLoad': 'DownLoad',
      'size': 'Size',
      'description': 'Description',
      'alertWantToSubscribe1': "Are you sure, you want to unsubscribe ",
      'alertWantToSubscribe2': "? You will lose all the questions from the ",
      'downloading': "Downloading...",
      'thisModuleWillOccupie': "This module will occupie ",
      'alertNotAllowed': "You can not unsubscribe assigned Learning Modules.",

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
      'cashAtStartOfPeriod': "Cash at start of Period",
      'cashAtTheEndOfPeriod': "Cash at end of Period",
      'costSplit': "CostSplit",
      'revenueSplit': "revenueSplit",
      'employees': "Employees",
      'salaries': "Salaries",
      'customers': "Customers",
      'customers': "Customers",
      'day': "Day",
      'month': "Month",
      'year': "Year",
      'lastPeriod': "Last Period",
      'thisPeriod': "This Period",
      'sevenDaysDevelopment': "7 days developments",

      //alerts
      'alertWantToBailOut': "Are you sure you want to Bail Out.",
      'alertNoModuleFound': "Oops..No learining module found for this user.",
      'ok': "Ok",
      'yes': "Yes",
      'no': "No",
      'comingSoon': "Coming Soon..",
      'close': "Close",
      'alert': "Alert",
      'alertUnFriend': "Are you sure, you want to unfriend this user?",

      //introDialog
      'gotIt': "Got it",
      'rewardsDialogContent':
          "Check out the reward categories and click on a trophy to\nfind out what you have achieved already and what you will need to\nachieve for the next level.\n\nThe number below the “Next Level” is the bonus\nyou will receive.",
      'challengesDialogTitle1': "Your Will is at your command",
      'challengesDialogContent1':
          "Dear ${Injector.userData?.name ?? ""},\n\nMy name is Will and I am your corporate lawyer.\nI will help you to challenge other competitors and also to defend\nagainst attacks.",
      'strChallanges': "Challenges",
      'strChallangesDialogContent':
          "Search or select a competitor you would like to challenge.\nSelect one of his business sectors you would like to challenge\nhim and select the reward (% of current cash) the the winner\ncan get. Your competitor will need to answer 3 out of 3 questions from the selected sector correctly in order to win the challenge.",
      'strMarketingCommunications': "Marketing & Communications",
      'strMarketingCommunicationsDialog':
          "Hi ${Injector.userData?.name ?? ""},\n\nWhat a great pleasure meeting you. I have heard a lot of good\nthings about you. So I am extremely exited to work for you.\nI am Lydia and in charge of Marketing & Communications.\nLet's have a look at your overall market position. ",
      'strRankingDialogContent':
          "Select on the left side the ranking criteria (e.g. cash) and at the\ntop which group you would like to compare it with and in which\ntime frame.\nYou can also click in “You” to scroll to your position and\nchallenge and add friends.",
      'strYourTeamPerformance': "Your Team's Performance",
      'strYourTeamPerformanceDialog':
          "Hi, it's me again, Niki.\n\nThis section is exclusively for team leaders.\nHere you can see the performance of your reports.",
      'strTeamDialog':
          "As a manager you can see and monitor the performance\nof your team. If you click on a team member you can see his\nindividual performance and also bail him out in case his company is\nout of cash (reset his cash to 30.000).",

      'plPerson': 'The person you can count on',
      'niceMeetYou': 'Nice to meet you${Injector.userData?.name ?? ""}',
      'plMyName':
          '\n\nMy name is Akiko Nakamura. I am in charge of Finance.\nLet\'s make sure to always have\nmore revenue then cost.',
      'hereYourMonitor':
          'Here you can monitor the cost\nand the revenue of your company.',
      'selectPeriod':
          'You can also select the period you want to look\nat and compare the current period with the previous period.',

      'strYourTeamPerformanceDialog2':
          'The graphs show you the “Retention Level” & “Question Status”\n“Retention Level” indicates how many questions are retained\n(1 = low retention and 10 = very well retained knowledge).\n“Question Status” indicates if questions are open and answered\n(open = open for answering, completed = correctly answered)',
      'customersRelationShip': "Customer Relationship Management",

      //existing customer

      'servingYourExisting': 'Serving your existing customers',
      'servingYourExistingDialog':
          'Hi ${Injector.userData?.name ?? ""},\n\nI am Bob and taking care of Customer Service.\nLet me introduce you to the list of existing customer.',

      'listOfExisting': 'List of existing Customers',
      'listOfExistingDetails':
          'Here you see all customers and contracts that you are currently engaged with. How much cash they generate each day and\nhow many days they will be loyal to you.\nYou can click the “X” if you want to end the contract.\nThis customer will no longer generate cash but you will\nwin back 1 Service Rep',

      'readyForBusiness': 'Ready for business',
      'readyForBusinessDeatils':
          "Why don't you check out more business sectors and engage\na few more customers.\n\nOr explore the other area of your company where you can\nearn rewards, challenge other players, see your financial\nperformance and compare your ranking.",
      'finishTutorial': 'Finish Tutorial',

      //customer situation
      'impactOnSales': 'Impact on Sales and Service',
      'impactOnSalesDetails':
          'Congratulations! You just won your first customer.\nYour Sales-o-Meter shows now 8/10 as this customer\nrequired 2 Sales Reps and your Service-o-Meter shows\n9/10 as one Service Rep is busy with this customer.',
      'impactOnBrand': 'Impact on Brand Value and Cash',
      'impactOnBrandDetails':
          'Also your Brand Value is now 100% as you answered 100% of all customer situations correct.\n\nIndependent of your Brand Value, your cash increased\nby the value of the customer.',
      'checkYourCustomer': 'Check your existing customers',
      'checkYourCustomerDetails':
          'You can check on your existing customer in the notepad at\nthe main screen.\n\nYou can reach your notepad by clicking on your\nService-o-Meter, selecting “Existing customers” from\nthe menu or by going to the main screen and\nselecting the notepad.',
      'clickServiceBtn': 'Click on Service-O-Meter',

      //engagement
      'yourFirstEngagement': 'Your first engagement',
      'yourFirstEngagementDetails':
          'In order to win this customer, you will need to answer this\nquestion correctly. You can click on the expand button to\nenlarge the picture, question and answer option.\n\nSelect the right answer and click on “Next”',
      'yourFirstEngagementBtn': 'Select answer & click “Next”',

      //New Customer screen
      'heartBusiness': 'The heart of the business',
      'heartBusinessDetails':
          "Hi Boss,\n\nthis is where the rubber hits the road, where only the best\nsurvive and where we earn the money for our company.\nI am Tina, your Senior Vice President of Global Sales.\nLet's get to work without any further due.",
      'listOfPotential': 'List of potential Customers',
      'listOfPotentialDetails':
          'Each customer has a name and belongs to a sector.\nValue is the cash you will receive every day while the\ncustomer is loyal to you. Loyalty of customers will\nincrease when you master the customer situation.\nResources indicate how many Sales Reps you will\nneed to engage this customer. Click on “Engage Now”.',
      'listOfPotentialBtn': 'Click on “Engage Now”',

      //Business sector screen dialog
      'customerRelation': 'Customer Relationship Management',
      'customerRelationDetails':
          'Hi ${Injector.userData?.name ?? ""},\n\nMy name is Li Wei. Just like the english word leeway.\nI am in charge of Customer Relationship Management (CRM) \nin your company. Shall we have a look at the different business\nsectors to find potential customers?',
      'areaOfComp': 'Area of competency',
      'areaOfCompDetails':
          'Each Business Sector will test specific knowledge to win\ncustomers. “Size” is the number of customers per Sector.\nYou can click on a business sector to read the description,\nsubscribe to it and download the questions for offline use.\nSome Business Sectors might already be assigned to you.',
      'accessToFirst': 'Access to your first customers',
      'accessToFirstDetails':
          'Why don\'t you subscribe to the first business sector to\ngain access to your first customers.\n\nClick on the Business Segment “Getting Started” and then on “Subscribe”.',
      'accessToFirstBtn': 'Click on “Getting Started”',
      'readyForCustomer': 'Ready for your first customer contact?',
      'readyForCustomerDetails':
          'Let\'s head over to the laptop which contains a list of new\ncustomers you can engage.\n\nYou can click on your Sales-o-Meter, use the navigation\nmenu “>”, or click the back button and select the laptop.',
      'readyForCustomerBtn': 'Click on your Sales-o-Meter',
      'customersRelationShip': "Customer Relationship Management",

      'customersRelationShipContent':
          "Hi ${Injector.userData?.name ?? ""},\n\nMy name is Li Wei. Just like the english word leeway.\nI am in charge of Customer Relationship Management (CRM)\nin your company. Shall we have a look at the different business\nsectors to find potential customers?",
      'areaOfCompetency': "",

      'customersRelationShipContent':
          "Hi ${Injector.userData?.name ?? ""},\n\nMy name is Li Wei. Just like the english word leeway.\nI am in charge of Customer Relationship Management (CRM)\nin your company. Shall we have a look at the different business\nsectors to find potential customers?",
      'areaOfCompetency': "Area of competency",
      'areaOfCompetenceContent':
          "Each Business Sector will test specific knowledge to win\ncustomers. “Size” is the number of customers per Sector.\nYou can click on a business sector to read the description,\nsubscribe to it and download the questions for offline use.\nSome Business Sectors might already be assigned to you.",

      //Organization screen Dialog
      'hireHrEmp': 'Hire HR Employees',
      'hireHrEmpDetails':
          'Hi ${Injector.userData?.name ?? ""},\n\nWelcome on board and welcome to the board room.\nMy name is Nikita but please call me Niki.\nAs Head of HR I will introduce you to the team and how you\ncan hire new employees to strengthen the team.',

      'hireHrEmpDetailsSeconds':
          "To hear your Team's' recommendations on why you should\nhire more employees in their team, click on them? \n\nLet's start with hiring 10 HR employees by clicking on HR and then\n“Hire 10 employees”.",

      'empOMaster': 'Employ-o-Meter',
      'empOMasterDetails':
          'Note that your Employ-o-Meter shows 40/50.\n50 is your maximum number employees and 40 your free capacity.\nYou can increase your maximum by hiring more HR employees.\nA click on your Employ-o-Meter will also bring you to this organizational screen.',
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
      'customizeYourCompanyContent':
          "Dear ${Injector.userData?.name ?? ""},\n\nMy name is Mike, your Head of Operations.\nAre you ready to become CEO of your own virtual company?\nClick on your name or on “Profile” in the navigation\nmenu (“>”).",
      'customizeYourCompanyContent':
          "Dear ${Injector.userData?.name ?? ""},\n\nMy name is Mike, your Head of Operations.\nAre you ready to become CEO of your own virtual company?\nClick on your name or on “Profile” in the navigation\nmenu (“>”).",

      //setting screen Dialog
      'settingDetails':
          'You can switch to a professional mode (no virtual company)\nand turn the sound on and off.\n\nIn case your company has negative cash you can request\na bail out which will need to be approved by your manager.',

      //lock feature
      'unLockOrg': 'Unlocks when Sales or Service capacities empty first time.',
      'unLockPl': 'Unlocks 1 week after 1st login.',
      'unLockRanking': 'Unlocks after three days in row login',
      'unLockReward': 'Unlocks if first Achievement is reached',
      'unLockChallenge': 'Unlocks when first lawyer hired',

      //change password
      'alertChangePassword': 'Password changed Successfully.'
    },
    'de': {
      //region german
      //main options
      'home': "Büro",
      'businessSector': "Geschäftsbereich",
      'newCustomers': "Neue Kunden",
      'existingCustomers': "Bestandskunden",
      'organizations': "Organisation",
      'challenges': "Herausforderungen",
      'pl': "Bilanz",
      'rewards': "Preise",
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
      'selectCompany': "Select Company",
      'selectLanguage': "Select Language",
      'english': "English",
      'german': "German",
      'chinese': "Chinese",

      //login
      'login': 'Einloggen',
      'enterRegisteredEmail': 'Email eingeben',
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
      'alertReleaseResources':
          'Dieser Kunde wird entfernt, generiert keinen Umsatz mehr und ist erst nach der Treuefrist wieder erreichbar',

      //challenges
      'searchForKeywords': 'Suche',
      'somethingWrong': 'Da ist was schief gegangen',
      'friends': 'Freunde',
      'alertFriendSuccess': 'Friend added successfully',
      'alertUnFriendSuccess': 'Unfriend successfully',
      'alertUChallengeSent': 'Challenge sent successfully!',

      //learning module
      'subscribe': 'Abonnieren',
      'unSubscribe': 'Abmelden',
      'subscribed': 'abonniert',
      'downLoad': 'Herunterladen',
      'size': 'Größe',
      'description': 'Beschreibung',
      'alertWantToSubscribe1': "Wirklich abmelden ",
      'alertWantToSubscribe2': "? Alle Fragen gehen verlohren",
      'downloading': "Daten werden geladen ...",
      'thisModuleWillOccupie ': "Dieses Modul benötigt ",
      'alertNotAllowed': "You can not unsubscribe assigned Learning Modules.",

      //engage customer
      'engagement': 'Nachbesprechung',
      'situation': 'Debriefing',
      'category': 'Kategorie',
      'achievement': 'Bereits erreicht',
      'nextLevel': 'Nächste Stufe',
      'friend': 'Freund',
      'competitor': 'Wettbewerber',
      'sendChallenge': 'Herausfordern',
      'next': 'Weiter',

      //  engage customer
      'answers': 'Antwortn',
      'question': 'Fragen',
      'explanation': 'Erläuterung',
      'alertSelectOneOption': "Please select at least one option.",

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
      'cashAtTheEndOfPeriod': "Cash at end of Period",
      'costSplit': "CostSplit",
      'revenueSplit': "revenueSplit",
      'employees': "Mitarbeiter",
      'salaries': "Gehälter",
      'customers': "Kunden",
      'customers': "Kunden",
      'engageSegment': 'Segment bearbeiten',
      'day': "Tag",
      'month': "Monat",
      'year': "Jahr",
      'lastPeriod': "Letzte Periode",
      'thisPeriod': "Aktuelle Periode",
      'sevenDaysDevelopment': "7 days developments",

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
          "Schau dir die unterschiedlichen Kategorien von Auszeichnungen an um herauszufinden was du schon erreicht hast und was du noch machen musst um das nächste Level zu erreichen. Die Zahlen ist der Geldbonus den du erhältst, wenn du diese Auszeichnung erreichst.",
      'challengesDialogTitle1': "Dein Will ist mein Befehl",
      'challengesDialogContent1':
          "${Injector.userData?.name ?? ""},\n\nMein Name ist Will und ich bin der Anwalt der Firma.\nIch will dir helfen Wettbewerber herauszufordern und Angriffe abzuwehren.",
      'strChallanges': "Herausforderungen",
      'strChallangesDialogContent':
          "Suche und wähle Wettbewerber aus, die du herausfordern möchtest.\nwähle den Geschäftsbereich aus, in dem er herausgefordert werden soll und den Prozentsatz vom aktuellen Vermögen, den der Gewinner bekommen soll.\n\nDer Herausgeforderte muss dann 3 von 3 fragen aus diesem Geschäftsbereich richtig beantworten um zu gewinnen. Ansonsten gewinnst du.",
      'strMarketingCommunications': "Marketing",
      'strMarketingCommunicationsDialog':
          "Hallo ${Injector.userData?.name ?? ""}, \n\nWas für eine ausserordentliche Freude dich kennenzulernen. Ich habe von den Kollegen schon so viel gutes über dich gehört. Ich freue mich schon sehr mit dir zusammen zu arbeiten.\nIch bin Lydia und verantwortlich für das Marketing.\nLass uns gemeinsam einen Blick auf deine aktuelle Wettbewerbsposition legen",
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
      'niceMeetYou':
          'Nett dich kennenzulernen ${Injector.userData?.name ?? ""}',
      'plMyName':
          'Mein Name ist Akiko Nakamura und verantwortlich für die Finanzen.Lass uns gemeinsam sicherstellen, dass wir immer mehr Einnahmen als Ausgaben haben.',
      'hereYourMonitor':
          'Hier kannst du die Einnahmen und die Ausgeben deines Unternehmens überwachen.',
      'selectPeriod':
          'Dazu kannst du unterschiedliche Zeithorizonte auswählen und immer die aktuelle Periode mit der Perioden davor vergleichen.',

      'strYourTeamPerformanceDialog2':
          'Die Kuchendiagramme zeigen dir das Fragenlevel und den Fragenstatus.Das Fragenlevel ist ein Indikator für wie gut dieses Wissen verinnerlicht ist(1= niedrig, 10=hoch). Der Fragenstatus gibt Auskunft darüber wieviel Fragen aktuell beantwortet und wieviel unbeantwortet sind.',

      //existing customer

      'servingYourExisting': 'Kundenservice',
      'servingYourExistingDialog':
          'Hi ${Injector.userData?.name ?? ""},\n\nIch bin Bob und kümmere mich um den Kundenservice.',

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
          'Hallo Chef,\n\nwillkommen im Vertrieb, dem Herzen unseres Unternehmens. Hier verdienen wir das Geld.\nIch bin Tina, Vice Präsidentin für unseren globalen Vertrieb.\nLass uns ohne weiter Umschweife starten und Geld verdienen.',
      'listOfPotential': 'Liste potentieller Kunden',
      'listOfPotentialDetails':
          'Jeder Kunde hat einen Namen und gehört zu einem Geschäftsbereich.Umsatz ist der tägliche Umsatz den der Kunde uns einbringen wird, so lange er uns loyal ist.Die Kundenloyalität steigt, wenn wir die Fragen dieses Kunden richtig beantworten.\nIn der Spalte Vertriebler ist zu ersehen wieviel Vertriebler wir benötigen um den Kunden anzusprechen.\nUm den Kunden anzusprechen bitte auf "Ansprechen" klicken',
      'listOfPotentialBtn': 'Klick auf "Ansprechen"',

      //Business sector screen dialog
      'customerRelation': 'Kundenbeziehungsmanagement (CRM)',
      'customerRelationDetails':
          'Hallo ${Injector.userData?.name ?? ""},\n\nMein Name ist Li Wei.\nIch leite die CRM Abteilung die sich um das Kundenbeziehungsmanagement kümmert.\nLass uns gemeinsam einen Blick auf die unterschiedlichen Geschäftsbereiche werfen, die uns zur Verfuegung stehen.',
      'areaOfComp': 'Geschäftsbereiche',
      'areaOfCompDetails':
          'Jeder Geschäftsbereich benötigt spezielles Wissen um Kunden zu gewinnen.\n"Groesse" zeigt an, wieviele Kunden (Fragen) es in einem Geschäftsbereich gibt.\n\nIn der Beschreibung erfaehrst du, um was es in diesem Geschäftsbereich geht.\nDu kannst Geschäftsbereich abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Geschäftsbereiche sind dir evtl. schon zugeordnet und können nicht deaktiviert werden.',
      'accessToFirst': "Geschäftsbereich abonnieren",
      'accessToFirstDetails':
          'Lass uns den ersten Geschäftsbereich abonnieren um Zugang zu den ersten Kunden zu erlangen.\n\nDazu klick bitte auf den Geschäftsbereich "Los geht\'s" und dann auf abonnieren.',
      'accessToFirstBtn': 'Klick auf "Los geht\'s"',
      'readyForCustomer': 'Bereit für den ersten Kunden?',
      'readyForCustomerDetails':
          'Auf zur Liste der Neukunden.\n\nDazu bitte entweder auf die Vertriebskapazitätenanzeige klicken, im Menü den Punkt "NeuKunden" klicken oder im Hauptbildschirm den Laptop anklicken.',
      'readyForCustomerBtn': 'Klick auf Vertriebskapazitäten',

      'customersRelationShip': "Kundenbeziehungsmanagement (CRM)",
      //endregion

      'customersRelationShipContent':
          "Hi ${Injector.userData?.name ?? ""}\n\nMein Name ist Li Wei.\nIch leite die CRM Abteilung die sich um das Kundenbeziehungsmanagement kümmert.\nLass uns gemeinsam einen Blick auf die unterschiedlichen Geschäftsbereiche werfen, die uns zur Verfuegung stehen.",
      'areaOfCompetency': "Geschäftsbereiche",
      'areaOfCompetenceContent':
          "Jeder Geschäftsbereich benötigt spezielles Wissen um Kunden zu gewinnen.\n\"Groesse\" zeigt an, wieviele Kunden (Fragen) es in einem Geschäftsbereich gibt.\n\nIn der Beschreibung erfaehrst du, um was es in diesem Geschäftsbereich geht.\nDu kannst Geschäftsbereich abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Geschäftsbereiche sind dir evtl. schon zugeordnet und können nicht deaktiviert werden.",

      // dashboard intro popup

      'dashboardProfile': 'Change Profile\n name, Language',
      'dashboardSales': '"Sales-o-meter"\navailable Sales Reps',
      'dashboardServices': '"Services-o-meter"\navailable Services Reps',
      'dashboardBalance': 'Answering Questions\n increases your Cash',
      'dashboardBusiness': '1. Business Segment\nSelect Learning Module',
      'dashboardNewCustomer': '2. New Customer\nAnswer Questions',
      'dashboardExistingCustomer': '3. Existing Customer\nReview Questions',

      //endregion

      //Organization screen Dialog
      'hireHrEmp': 'Personaler einstellen',
      'hireHrEmpDetails':
          'Hallo ${Injector.userData?.name ?? ""},\n\nwillkommen im Unternehmen und willkommen im Management Team.\nMein Name ist Nikita aber bitte nenne mich Niki.\nAls Personalchef werde ich dir eine kurze Einführung geben, wie du neue Mitarbeiter einstellen kannst.',

      'hireHrEmpDetailsSeconds':
          'Um die Empfehlungen deiner Mitarbeiter zu hören, warum du in eine Abteilung investieren solltest, klicke einfach auf die Mitarbeiter.\n\nLass uns zu Anfang 10 neue Mitarbeiter in der Personalabteilung einstellen. Klicke dazu bitte auf "Personal" und dann auf "10 Mitarbeiter einstellen"',

      'empOMaster': 'Mitarbeiterkapazitäten',
      'empOMasterDetails':
          'Deine Mitarbeiterkapazitäten sind jetzt 40/50.\n50 ist die gesamte Mitarbeiterkapazität und 40 die noch verfügbare, da du ja schon 10 Mitarbeiter in der Personalabteilung hast.\nDu kannst die Mitarbeiterkapazität weiter erhöhen, indem du neue Personalmitarbeiter einstellst.\nEin klick auf deine Mitarbeiter Kapazitäten bringt dich auch zu diesem Bildschirm.',
      'costOfEmp': 'Mitarbeiter Kosten',
      'costOfEmpDetails':
          'Hier kannst du dein Vermögen sehen.\n\nMitarbeiter einzustellen kostet Geld (Kosten steigen mit der Zeit). Diese Kosten werden von deinem Vermögen abgezogen.\nJeder Mitarbeiter bekommt außerdem ein gehalt. Dieses Gehalt betraegt 200 pro Mitarbeiter und Tag (Gehaelter steigen mit der Zeit).',

      //setting screen Dialog
      'settingDetails':
          'Du kannst zur professionellen Ansicht wechseln (kein virtuelles Unternehmen) und den Ton ein und aus schalten.',

      //lock feature
      'unLockOrg': 'Unlocks when Sales or Service capacities empty first time.',
      'unLockPl': 'Unlocks 1 week after 1st login.',
      'unLockRanking': 'Unlocks after three days in row login',
      'unLockReward': 'Unlocks if first Achievement is reached',
      'unLockChallenge': 'Unlocks when first lawyer hired',

      //change password
      'alertChangePassword': 'Password changed Successfully.'
    },
    'zh': {
      //region chinese
      //main options
      'home': "首页",
      'businessSector': "业务部门",
      'newCustomers': "新客户",
      'existingCustomers': "现有客户",
      'organizations': "组织",
      'challenges': "挑战",
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
      'yourEmail': 'Your邮箱',
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
      'password': '密码',
      'newPassword': '新密码',
      'currentPassword': 'Current 密码',
      'reEnterPassword': '请再次输入新密码',
      'cancel': '取消',
      'send': '发送',
      'forgotPassword': '忘记密码?',

      //organization
      'fireEmp': "开除解雇 10 名员工",
      'hireEmp': "开除解雇 10 名员工",

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
      'alertFriendSuccess': "添加朋友成功",
      'alertUnFriendSuccess': "成功取消朋友",
      'alertUChallengeSent': "挑战已成功发送",

      //learning module
      'subscribe': '订阅',
      'unSubscribe': '取消订阅',
      'subscribed': '已订阅',
      'downLoad': '下载',
      'size': '大小',
      'description': '描述',
      'alertWantToSubscribe1': "您确定要取消订阅吗",
      'alertWantToSubscribe2': "您将失去所有的问题",
      'downloading': "正在下载......",
      'thisModuleWillOccupie': "这个模块将占用",
      'alertNotAllowed': "您不能取消加入已分配的业务板块",

      //engage customer
      'engagement': '情况',
      'situation': '任务报告',
      'category': '类别',
      'achievement': '成就',
      'nextLevel': '下一级',
      'friends': '夥伴朋友',
      'competitor': '竞争对手',
      'sendChallenge': '送出挑战寄发战帖',
      'next': '下一步',

      //  engage customer
      'answers': '答案',
      'question': '问题',
      'explanation': '说明',
      'alertSelectOneOption': "Please select at least one option.",

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
      'resets_': "重启:",
      'name_': "Name:",
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
      'cashAtStartOfPeriod': "开始期间的现金",
      'cashAtTheEndOfPeriod': "Cash at end of Period",
      'costSplit': "CostSplit",
      'revenueSplit': "revenueSplit",
      'employees': "员工",
      'salaries': "薪水",
      'customers': "客户顾客",
      'day': "日期",
      'month': "月",
      'year': "年",
      'lastPeriod': "上一时期",
      'thisPeriod': "这一时期",
      'sevenDaysDevelopment': "7 days developments",

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
      'rewardsDialogContent': "查看奖励类别，点击奖杯查看您目前的成就以及您需要取得多少成就才能升到下一级别.\n\n"
          "下一级"
          "下面的数字是您\n将收到的奖金。",
      'challengesDialogTitle1': "您是自己的主宰",
      'challengesDialogContent1':
          "亲爱的${Injector.userData?.name ?? ""},\n\n我叫威尔，我是您公司的律师。\n我会帮助您挑战其他竞争对手，\n同时也帮您防守对方的攻击。",
      'strChallanges': "挑战",
      'strChallangesDialogContent':
          "搜索或选择您想挑战的竞争对手。\n选择您想挑战他的一个业务部门然后选择赢家可以获得的奖励 (%当前知识点数 (KP))。您的竞争对手需要正确回答选定部门的3个问题才能赢得挑战。",
      'strMarketingCommunications': "营销与传播",
      'strMarketingCommunicationsDialog':
          "${Injector.userData?.name ?? ""},您好，\n\n很高兴见到您。我久仰您的大名。所以我非常高兴能为您工作。\n我是莉蒂亚，负责市场营销和传播。\n让我们来看看您的整体市场地位。",
      'strRankingDialogContent': "在左侧选择排名标准（比如现金），并在顶部选择您想对比的分组以及时间范围。\n您也可以点击"
          "您"
          "滚动到您的位置和挑战以及添加朋友。",
      'strYourTeamPerformance': "您的团队的表现",
      'strYourTeamPerformanceDialog':
          "您好，我是尼基，我又来了。\n这部分是团队领导专属。\n在这里您可以看到您的报告的表现。",
      'strTeamDialog':
          "作为经理，您可以查看和监控您的团队的表现。如果您点击一个团队成员，您可以看到他的个人表现。如果他的公司没有了资金，您还可以帮助他缓解资金困难 (将他的现金重置为30.000)。",

      'plPerson': '您可以依靠的人',
      'niceMeetYou': '${Injector.userData?.name ?? ""}很高兴见到您',
      'plMyName': '我叫中村明子。我负责财务。让我们确保收入始终高于支出。',
      'hereYourMonitor': '在这里，您可以监控公司的成本和收入。',
      'selectPeriod': '您还可以选择您想要查看的时间段和比较当前周期与上一个周期',

      'strYourTeamPerformanceDialog2':
          '图表显示"保留级别"和"问题状态”"保留级别"表示保留了多少问题（1 = 低保留级别，10 = 知识保留得很好）。"问题状态"表示问题是否已开启并已回答（开启 = 开启回答，完成 = 已正确回答)',

      //existing customer
      'servingYourExisting': '服务现有客户',
      'servingYourExistingDialog':
          '${Injector.userData?.name ?? ""}您好，\n\n我是负责客户服务的鲍勃。\n让我向您介绍现有客户名单。',

      'listOfExisting': '现有客户名单',
      'listOfExistingDetails':
          '在这里，您可以看到您目前正在联络的所有客户和合同。他们每天产生多少现金\n以及他们在多少天内会对您忠诚。\n如果您想结束合同，您可以点击"X"。\n这个客户将不再产生现金，但您会收回1位服务代表。',

      'readyForBusiness': '准备开展业务',
      'readyForBusinessDeatils':
          '您现在可以查看更多的业务部门，然后联络更多的客户。\n\n或者探索您公司的其他领域，可以赚取奖励，挑战其他玩家，查看您的财务绩效\n和比较您的排名。',
      'finishTutorial': '完成教程',

      //customer situation
      'impactOnSales': '对销售和服务的影响',
      'impactOnSalesDetails':
          '恭喜！您刚刚赢得了您的第一个客户。\n您的销售代表指示图现在显示8/10，因为这个客户需要2个销售代表，而您的服务代表指示图显示9/10，因为您需要1名服务代表为这个客户服务。',
      'impactOnBrand': '对品牌价值和现金的影响',
      'impactOnBrandDetails':
          '您的品牌价值现在是100％，因为您关于所有客户情况的回答100％正确。\n\n独立于您的品牌价值，您的现金增长取决于\n客户价值。',
      'checkYourCustomer': '查看您的现有客户',
      'checkYourCustomerDetails':
          '您可以在主界面的记事本中查看您现有的客户。\n\n您可以通过点击您的服务代表指示图，选择菜单中的“现有客户”或者前往主页面选择“已完成的学习”\n来访问您的记事本。',
      'clickServiceBtn': '点击服务代表指示图',

      //engagement
      'yourFirstEngagement': '您的第一次联络',
      'yourFirstEngagementDetails':
          '为了赢得这个客户，您需要\n准确地回到这个问题。您可以点击展开按钮放大图片、问题和答案选项。\n\n选择正确的答案，然后单击"下一页”',
      'yourFirstEngagementBtn': '选择答案并单击"下一页”',

      //New Customer screen
      'heartBusiness': '业务的核心',
      'heartBusinessDetails':
          '老板您好，\n\n现在到了关键时刻，只有最后的公司才能生存下来，但也是我们为公司赚钱的时机。\n我是蒂娜，您的全球销售高级副总裁。\n我们开始工作吧，不要再拖延了。',
      'listOfPotential': '潜在客户名单',
      'listOfPotentialDetails':
          '每个客户都有一个名称，都属于一个部门。\n“价值”是您每天收到的现金，并且同时顾客对您忠诚。当您掌握了顾客情况时，客户的忠诚度将增加。\n“资源”表示您需要多少销售代表来联络这个客户。点击"立即联络"。',
      'listOfPotentialBtn': '点击"立即联络"',

      //Business sector screen dialog
      'customerRelation': '客户关系管理',
      'customerRelationDetails':
          '${Injector.userData?.name ?? ""}您好，\n\n我叫李伟。就像英文单词leeway一样。\n我负责您的公司的客户关系管理（CRM）。我们看看不同的业务部门来\n寻找潜在的客户吧！',
      'areaOfComp': '能力领域',
      'areaOfCompDetails':
          '每个业务部门将测试特定的知识来赢得客户。"大小"是每个部门的客户数量。\n您可以点击业务板块阅读说明，加入并下载问题以便离线使用。\n某些业务部门可能已经分配给您。',
      'accessToFirst': '访问您的第一个客户',
      'accessToFirstDetails': '您可以加入第一个商业部门从而访问您的第一个客户。\n点击业务板块的"开始"，然后点击"加入"。',
      'accessToFirstBtn': '点击"开始”',
      'readyForCustomer': '准备好接触您的第一个客户了吗？',
      'readyForCustomerDetails':
          '让我们前往笔记本电脑中您可以联络的新客户列表页面。\n\n您可以使用导航菜单“>”，点击您的销售代表指示图，\n或者点击后退然后选择笔记本电脑。',
      'readyForCustomerBtn': '点击您的销售代表指示图',

      // dashboard intro popup

      'dashboardProfile': 'Change Profile\n name, Language',
      'dashboardSales': '"Sales-o-meter"\navailable Sales Reps',
      'dashboardServices': '"services-o-meter"\navailable Services Reps',
      'dashboardBalance': 'Answering Questions\n increases your Cash',
      'dashboardBusiness': '1. Business Segment\nSelect Learning Module',
      'dashboardNewCustomer': '2. New Customer\nAnswer Questions',
      'dashboardExistingCustomer': '3. Existing Customer\nReview Questions',

      'customersRelationShip': "客户关系管理",
      //endregion

      'customersRelationShipContent':
          "${Injector.userData?.name ?? ""}您好\n\n我叫李伟。就像英文单词leeway一样。\n我负责您的公司的客户关系管理（CRM）。我们看看不同的业务部门来\n寻找潜在的客户吧！",
      'areaOfCompetency': "能力领域",
      'areaOfCompetenceContent': "每个业务部门将测试特定的知识来赢得客户。"
          "大小"
          "是每个部门的客户数量。\n您可以点击业务板块阅读说明，加入并下载问题以便离线使用。\n某些业务部门可能已经分配给您。",
      'customizeYourCompany': "自定义您的公司",
      'customizeYourCompanyContent':
          "亲爱的${Injector.userData?.name ?? ""}\n\n我叫迈克，我是您们的运营主管。\n您准备好成为您自己的虚拟公司的CEO了吗？\n点击您的姓名或导航菜单 (“>”) 中的\n"
              "个人资料"
              "。\n",

      //Organization screen Dialog
      'hireHrEmp': '招聘HR员工',
      'hireHrEmpDetails':
          '${Injector.userData?.name ?? ""}您好，\n\n欢迎加入我们，欢迎来到董事会会议室。\n我叫尼基塔，但叫我尼基就可以了。\n作为人力资源部的负责人，我将向您介绍我们的团队以及指导您如何招聘员工，让我们的团队发展壮大。',

      'hireHrEmpDetailsSeconds':
          '听听您的团队的建议，为什么您应该招聘更多的员工，点击他们试试？\n\n让我们先招聘10名HR员工，您只需点击HR然后\n选择“雇用10名员工”。',

      'empOMaster': '雇员指示图',
      'empOMasterDetails':
          '您的雇员指示图显示40/50。\n50是最大可雇用员工的数量，40是当前员工数量。\n您可以通过雇用更多的HR员工来增加最大可雇用员工的数量。\n点击您的雇员指示图也将进入该组织页面。',
      'costOfEmp': '员工成本',
      'costOfEmpDetails':
          '在这里，您可以看到您的总现金。\n\n招聘员工会增加雇用成本（随着时间的推移增加）。\n费用将从您的现金中扣除。\n每个员工每天会收到工资，每日起薪是200。\n工资水平将随着时间的推移而增加。',

      //setting screen Dialog
      'settingDetails':
          '您可以切换到专业模式（没有虚拟公司)，您可以打开或关闭声音。\n\n如果您的公司现金为负，您可以请求一笔纾困资金，您的经理会进行审批。',

      //lock feature
      'unLockOrg': 'Unlocks when Sales or Service capacities empty first time.',
      'unLockPl': 'Unlocks 1 week after 1st login.',
      'unLockRanking': 'Unlocks after three days in row login',
      'unLockReward': 'Unlocks if first Achievement is reached',
      'unLockChallenge': 'Unlocks when first lawyer hired',

      //change password
      'alertChangePassword': 'Password changed Successfully.'
    }
  };

  static Map<String, Map<String, String>> localizedValuesProf = {
    'en': {
      //region english
      'home': "Home",
      'businessSector': "Learning Module",
      'newCustomers': "Open Learnings",
      'existingCustomers': "Completed Learnings",
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
          "Check out the reward categories and click on a trophy to find out what you have achieved already and what you will need to\nachieve for the next level.\n\nThe number below the “Next Level” is the bonus\nyou will receive.",
      'challengesDialogTitle1': "Challenges",
      'challengesDialogContent1':
          "Here you will learn how to challenge other colleagues",
      'strChallanges': "Challenges",
      'strChallangesDialogContent':
          "Search or select a Colleague you would like to challenge.\nSelect one of his Learning Modules you would like to challenge\nhim and select the reward (% of current Knowledge Points (KP)) the winner\ncan get. Your competitor will need to answer 3 out of 3 questions from the selected module correctly in order to win the challenge.",
      'strMarketingCommunications': "Ranking",
      'strMarketingCommunicationsDialog':
          "In this section you will learn everything you need to know about the ranking",
      'strRankingDialogContent':
          "Select on the left side the ranking criteria (e.g. Knowledge Points (KP)) and at the\ntop which group you would like to compare it with and in which\ntime frame.\nYou can also click in “You” to scroll to your position and\nchallenge and add friends.",
      'strYourTeamPerformance': "Your Team's Performance",
      'strYourTeamPerformanceDialog':
          "This section is exclusively for team leaders.\nHere you can see the performance of your reports.",
      'strTeamDialog':
          "As a manager you can see and monitor the performance\nof your team. If you click on a team member you can see his individual performance and reset his Knowledge Points (KP) to 30.000.",

      'plPerson': 'Performance',
//      'niceMeetYou':'${Injector.userData?.name??""}很高兴见到您',
      'plMyName':
          'In this section you will learn everything you need to know about your performance analysis',
      'hereYourMonitor':
          'Here you can monitor the deductions and the additions of Knowledge Points (KP).',
      'selectPeriod':
          'You can also select the period you want to look at and compare the current period with the previous period.',

      'strYourTeamPerformanceDialog2':
          'The graphs show you the “Retention Level” & “Question Status”“Retention Level” indicates how many questions are retained(1 = low retention and 10 = very well retained knowledge).“Question Status” indicates if questions are open and answered (open = open for answering, completed = correctly answered)',

      'customersRelationShip': "Learning Modules introduction",

      'customersRelationShipContent':
          "Here you can search for Learning Modules,\nsubscribe and unsubscribe to them and also\ndecide if you want to download the content for\nfuture offline usage.",
      'areaOfCompetency': "Learning Modules introduction",
      'areaOfCompetenceContent':
          "Each Learning Module will test specific areas of knowledge. \"Size\"\nindicated the number of Questions in each Module. You can click on a Learning Module to read a description and decide if you want to subscribe to them.\nSome Learning Modules are already assigned\nto you by your company and cannot be unsubscribed.",
      'customersRelationShipContent':
          "Here you can search for Learning Modules,\nsubscribe and unsubscribe to them and also\ndecide if you want to download the content for\nfuture offline usage.",
      'areaOfCompetency': "",

      //existing customer
      'servingYourExisting': 'List of Completed Learnings',
      'servingYourExistingDialog':
          'In this part of the tutorial you will learn all relevant information about your completed learnings',
      'listOfExisting': 'List of Completed Learnings',
      'listOfExistingDetails':
          'Here you see all questions that you currently have memorized. How much Knowledge Points (KP) you receive from them each day and\nhow many days they will stay in this list.\nYou can click the “X” if you want to remove a question.\nThis question will then not generate any more Knowledge Points for you but you will regain 1 free Memory Point (MP).',

      'readyForBusiness': 'Ready to get started',
      'readyForBusinessDeatils':
          "Why don't you check out more Learning Modules and answer a few more questions.\n\nOr explore the other area of this app where you can\nearn rewards, challenge other players, see your\nperformance and compare your ranking.",
      'finishTutorial': 'Finish Tutorial',

      //customer situation
      'impactOnSales': 'Impact on Learning Points (LP) and Memory Points (MP)',
      'impactOnSalesDetails':
          'Congratulations! You just answered your first question correctly.\nYour Learning Point (LP) Bar shows now 8/10 as this question\nrequired 2 Learning Points and your Memory Point (MP) Bar shows\n9/10 as one Memory Point (MP) is occupied while you have this question in the list of completed learnings.',
      'impactOnBrand': 'Impact on Knowledge Score (KS)',
      'impactOnBrandDetails':
          'Also your Knowledge Score (KS) is now 100% as you answered 100% of all questions correct.\n\nIndependent of your Knowledge Score (KS), also your Knowledge Points (KP) increased\nby the Knowledge Points (KP) offered for this question.',
      'checkYourCustomer': 'Check the list of complete learnings',
      'checkYourCustomerDetails':
          'You can find a list with all completed questions in the "Completed Learnings" section.\n\nYou can reach your "Completed Learnings" by clicking on your\nMemory Point (MP) Bar, selecting "Completed Learnings" from\nthe menu or by going to the main screen and\nselecting "Completed Learnings"',
      'clickServiceBtn': 'Click on you Memory Points (MP) Bar',

      //engagement
      'yourFirstEngagement': 'Your first Question',
      'yourFirstEngagementDetails':
          'In order to win this question, you will need to answer this\nit correctly. You can click on the expand button to\nenlarge the picture, question and answer option.\n\nSelect the right answer and click on “Next”',
      'yourFirstEngagementBtn': 'Select answer & click “Next”',

      //New Customer screen
      'heartBusiness': 'List of Open Learnings',
      'heartBusinessDetails':
          'In this part of the tutorial you will learn all relevant information needed to select and answer questions',
      'listOfPotential': 'List of Questions',
      'listOfPotentialDetails':
          'Each question has a name and belongs to a Learning Module.\nKnowledge are the Knowledge Points (KP) you can earn every day you have this question in your completed Learning lsit.\n"Repeat in ..." tells you in how many days you need to repeat the question if you now answer it correctly. The more often you answer a question correctly the less often you will need to repeat it.\nStudy Points (SP) indicate how many Study Points (SP) you will need to answer this question. Click on “Answer Now”.',
      'listOfPotentialBtn': 'Click on “Answer Now”',

      //Business sector screen dialog
      'customerRelation': 'Learning Modules introduction',
      'customerRelationDetails':
          'Here you can search for Learning Modules, subscribe and unsubscribe to them and also decide if you want to download the content for future offline usage.',
      'areaOfComp': 'Learning Modules introduction',
      'areaOfCompDetails':
          'Each Learning Module will test specific areas of knowledge. "Size" indicated the number of Questions in each Module. You can click on a Learning Module to read a description and decide if you want to subscribe to them. Some Learning Modules are already assigned to you by your company and cannot be unsubscribed.',
      'accessToFirst': 'Subscribe to the first Module',
      'accessToFirstDetails':
          'Why don\'t you subscribe to the first business sector to\ngain access to your first questions.\n\nClick on the Learning Module “Getting Started” and then on “Subscribe”.',
      'accessToFirstBtn': 'Click on “Getting Started”',
      'readyForCustomer': 'Ready for your first Questions',
      'readyForCustomerDetails':
          'Let\'s head over to the Open Learnings which contains a list of new\nquestions you can answer.\n\nYou can click on your Study Point (SP) Bar, use the navigation\nmenu “>”, or click the back button and select Open Learnings.',
      'readyForCustomerBtn': 'Click on the Study Point (SP) Bar',

      'customizeYourCompany': "Customize your profile",
      'customizeYourCompanyContent':
          "Dear ${Injector.userData?.name ?? ""}\n\nwelcome to this gamified learning Experience.\nAre you ready to earn some points and compete against colleagues?\nClick on your name or on “Profile” in the navigation\nmenu (“>”).",

      'hireHrEmpDetailsSeconds':
          'To get recommendations and understand why you should improve certain Power-Ups (PU), click on them.\nLet\'s start with spending 10 Power-Up (PU) Points and 1000 Knowledge Points (KP) to improve "Max. Power-Ups (PU)" to level 1\nClick on "Max. Power-Ups (PU)" and then on "Increase Level"',

      'empOMaster': 'Power-Up (PU) Bar',
      'empOMasterDetails':
          'Note that your Power-Up (PU) Bar shows 40/50.\n50 is your maximum number of Power-Up Points (PU) and 40 your free capacity.\nYou can increase your maximum by improving the Power-Up (PU) Level.\nA click on your Power-Up (PU) Bar will also bring you to this screen.',
      'costOfEmp': 'Cost for improvements',
      'costOfEmpDetails':
          'Here you see your Knowledge Points (KP).\n\nImproving Power-Ups will cost Knowledge Points (KP). This one time cost will increase with the level.\nEvery Power-Up Point (PU) spend will also incur recurring cost which will start with 200 Knowledge Points (KP) per Power-Up (PU) point and day. This cost will increase over time.',

      //endregion

      //setting screen Dialog
      'settingDetails':
          'You can switch to a game mode (virtual company)\nand turn the sound on and off.\n\nIn case your points become negative, you can request\na new start which will need to be approved by your manager.',
    },
    'de': {
      //region German
      'home': 'Start',
      'businessSector': 'Lernmodule',
      'newCustomers': 'Fragen',
      'existingCustomers': 'Bestandsfragen',
      'organizations': 'Lernbonus',
      'challenges': 'Herausforderungen',
      'pl': 'Entwicklung',
      'rewards': 'Auszeichnungen',
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
      'english': 'English',
      'german': 'German',
      'chinese': 'Chinese',
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
      'resources': 'Lernpunkte (LP)',
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
      'subscribe': 'Abonnieren',
      'unSubscribe': 'Abmelden',
      'subscribed': 'abonniert',
      'downLoad': 'Herunterladen',
      'size': 'Größe',
      'description': 'Beschreibung',
      'alertWantToSubscribe1': 'Wirklich abmelden',
      'alertWantToSubscribe2': '? Alle Fragen gehen verloren',
      'downloading': 'Daten werden geladen ...',
      'thisModuleWillOccupie': 'Dieses Modul benötigt',
      'alertNotAllowed':
          'Zugeordnete Lernbereiche können nicht abgemeldet werden',
      'engagement': 'Situation',
      'debrief': 'Nachbesprechung',
      'category': 'Kategorie',
      'achievement': 'Bereits erreicht',
      'nextLevel': 'Nächste Stufe',
      'friends': 'Freunde',
      'competitor': 'Kollegen',
      'sendChallenge': 'Herausfordern',
      'next': 'Weiter',
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
      'resets_': 'Neustarts:',
      'name_': 'Name:',
      'cost': 'Abzüge',
      'you': 'Du',
      'world': 'Welt',
      'country': 'Land',
      'score': 'Punkte',
      'companyName': 'Spitzname',
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
          "Schau dir die unterschiedlichen Kategorien von Auszeichnungen an um herauszufinden was du schon erreicht hast und was du noch machen musst um das nächste Level zu erreichen. Die Zahlen sind die Wissenspunkte (WP) die du erhältst, wenn du diese Auszeichnung erreichst.",
      'challengesDialogTitle1': "Herausforderungen",
      'challengesDialogContent1':
          "Hier lernst du wie du einen Kollegen zu einem Wissensduell heraus forderst.",
      'strChallanges': "Herausforderungen",
      'strChallangesDialogContent':
          "Suche und wähle Kollegen aus, die du herausfordern möchtest.\nwähle den Lernbereich aus, in dem er herausgefordert werden soll und den Prozentsatz von den aktuellen Wissenspunkte (WP), den der Gewinner bekommen soll.\n\nDer Herausgeforderte muss dann 3 von 3 Fragen aus diesem Lernmodul richtig beantworten um zu gewinnen. Ansonsten gewinnst du.",
      'strMarketingCommunications': "Rangliste",
      'strMarketingCommunicationsDialog':
          "In diesem Bereich lernst du alles über die Rangliste",
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
      'plMyName':
          'In diesem Bereich kannst du deine Entwicklung einsehen und überprüfen.',
      'hereYourMonitor':
          'Hier kannst du deinen Wissenspunkte-Zuwachs und -Abgang überwachen.',
      'selectPeriod':
          'Dazu kannst du unterschiedliche Zeithorizonte auswählen und immer die aktuelle Periode mit der Perioden davor vergleichen.',
      'strYourTeamPerformanceDialog2':
          'Die Kuchendiagramme zeigen dir das Fragenlevel und den Fragenstatus.Das Fragenlevel ist ein Indikator für wie gut dieses Wissen verinnerlicht ist(1= niedrig, 10=hoch). Der Fragenstatus gibt Auskunft darüber wieviel Fragen aktuell bentowertet und wieviel unbeantwortet sind.',
      //existing customer
      'servingYourExisting': 'Liste der Bestandsfragen',
      'servingYourExistingDialog':
          'In diesem Teil der Einführung lernst du alles Wissenswerte über die Bestandsfragen',

      'listOfExisting': 'Liste der Bestandsfragen',
      'listOfExistingDetails':
          'Hier siehst du die Liste der Bestandsfragen, die täglichen Wissenspunkte und wieviel Tage sie noch in der Liste bleiben.\nMit "x" kannst du die Frage aus dieser Liste löschen. Dann generiert sie keine Wissenspunkte mehr, du hast aber eine Bestandsfragenkapazität mehr.',

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
      'heartBusinessDetails':
          'In diesem Teil der Einführung lernst du alles Wissenswerte über die Fragenliste und die Fragen',
      'listOfPotential': 'Liste der offenen Fragen',
      'listOfPotentialDetails':
          'Jeder Frage hat einen Namen und gehört zu einem Lernmodul. Wissenspunkte (WP) sind die täglichen Punkte die dir diese Frage einbringen wird, so lange sie in der Bestandsfragenliste bleibt.\n"Wiederholen in..." zeigt die Anzahl Tage wann die Frage wiederholt werden muss. Je häufiger du sie richtig beantwortest, je grösser wird der Abstand.\nIn der Spalte Lernpunkte (LP) siehst du wieviel Lernpunkte (LP) du benötigst um die Frage zu beantworten.\nUm eine Frage zu beantworten bitte auf "Beantworten" klicken',
      'listOfPotentialBtn': 'Klick auf "Beantworten"',

      //Business sector screen dialog
      'customerRelation': 'Einführung in Lernmodule',
      'customerRelationDetails':
          'Hier kannst du nach Lernmodulen suchen, diese abonnieren und auch herunterladen, wenn du sie ohne Internetverbindung beantworten möchtest.',
      'areaOfComp': 'Einführung in Lernmodule',
      'areaOfCompDetails':
          'Jeder Lernmodul benötigt spezielles Wissen um Fragen zu beantworten.\n"Grösse" zeigt an, wieviele Fragen es in einem Lernmodul gibt.\n\nIn der Beschreibung erfährst du, um was es in diesem Lernmodul geht.\nDu kannst Lernmodule abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Lernmodule sind dir evtl. schon zugeordnet und können nicht deaktiviert werden.',
      'accessToFirst': 'Lernmodul abonnieren',
      'accessToFirstDetails':
          'Lass uns ein erstes Lernmodul abonnieren um Zugang zu den ersten Fragen zu erlangen.\n\nDazu klick bitte auf das Lernmodul "Los geht\'s" und dann auf abonnieren.',
      'accessToFirstBtn': 'Klick auf "Los geht\'s"',
      'readyForCustomer': 'Bereit für die erste Frage?',
      'readyForCustomerDetails':
          'Auf zur Liste der Fragen.\n\nDazu bitte entweder auf die Lernkapazitätenanzeige klicken, im Menü den Punkt "Fragen" anklicken oder im Hauptbildschirm die Kachel "Fragen" anklicken.',
      'readyForCustomerBtn': 'Klick auf die "Lernkapazitätenanzeige"',
      'customersRelationShip': "Einführung in Lernmodule",
      //endregion

      'customersRelationShip': "Einführung in Lernmodule",

      'customersRelationShipContent':
          "Hier kannst du nach Lernmodulen suchen, diese abonnieren und auch herunterladen, wenn du sie ohne Internetverbindung beantworten möchtest.",
      'areaOfCompetency': "Einführung in Lernmodule",
      'areaOfCompetenceContent':
          "Jeder Lernmodul benötigt spezielles Wissen um Fragen zu beantworten.\"Grösse\" zeigt an, wieviele Fragen es in einem Lernmodul gibt\n\nIn der Beschreibung erfährst du, um was es in diesem Lernmodul geht.\nDu kannst Lernmodule abonnieren und die Fragen auch herunterladen um sie im Offline Modus zu nutzen.\nEinige Lernmodule sind dir evtl. schon zugeordnet und können nicht deaktiviert werden.",
      'customizeYourCompany': "Profil bearbeiten",
      'customizeYourCompanyContent':
          "Hallo ${Injector.userData?.name ?? ""}\n\nwillkommen zu dieser spielerischen Wissensmanagement App.\nBist du bereit Wissenspunkte zu verdienen und Kollegen und Freunde herauszufordern?\nBitte klick auf deinen Namen oder "
              "Profil"
              " im Menü (“>”).",

      //Organization screen Dialog
      'hireHrEmp': 'Maximale Bonuspunkte',
      'hireHrEmpDetails':
          'Im Folgenden wirst du lernen wie du mit Bonuspunkten Verbesserungen freischalten kannst ',

      'hireHrEmpDetailsSeconds':
          'Um zu erfahren was die einzelnen Verbesserungen bringen, kannst du auf sie klicke.\n\nLass uns damit anfangen die Anzahl maximaler Bonuspunkte (BP) zu erhöhen. Dafür bitte auf "Max. Bonuspunkte (BP)" klicken und dann auf "Level erhöhen"',

      'empOMaster': 'Bonuskapazität',
      'empOMasterDetails':
          'Deine Bonuskapazität ist jetzt 40/50.\n50 ist die gesamte Bonuskapazität und 40 die noch verfuegbare, da du ja schon 10 Bonuspunkte für die Verbesserung der Max. Bonuspunkte investiert hast.\nDu kannst die Bonuskapazität weiter erhöhen, indem du weitere Bonuspunkte in die "Max. Bonuspunkte" investierst.\nEin klick auf deine Bonuskapazitaeten bringt dich auch zu diesem Bildschirm.',
      'costOfEmp': 'Bonuspunkte Kosten',
      'costOfEmpDetails':
          'Hier kannst du deine Wissenspunkte (WP) sehen.\n\nBonuspunkte zu investieren kostet Wissenspunkte (Kosten steigen mit der Zeit). Diese Kosten werden von deinen Wissenspunkten (WP) abgezogen.\nJeder Bonuspunkt kostet außerdem 200 Wissenspunkte pro investiertem Bonuspunkt und Tag (Kosten steigen mit der Zeit).',

      //setting screen Dialog
      'settingDetails':
          'Du kannst zum wissensspiel wechseln (virtuelles Unternehmen) und den Ton ein und aus schalten.',
    },
    'zh': {
      //region chines
      'home': '首页',
      'businessSector': '学习模块',
      'newCustomers': '开放学习',
      'existingCustomers': '记忆学习',
      'organizations': '威力升级',
      'challenges': '挑战',
      'pl': '表现',
      'rewards': '奖励',
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
      'english': 'English',
      'german': 'German',
      'chinese': 'Chinese',
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
      'value': '知识点数 (KP)',
      'loyalty': '重复...',
      'resources': '学习点数 (SP)',
      'engage': '回答',
      'engageNow': '立刻回答',
      'endRel': '解除',
      'alertReleaseResources': '该问题将被删除，不会再产生任何知识分数，只有在下一个重复时间才能再次访问',
      'searchForKeywords': '搜索关键字',
      'somethingWrong': '出了问题',
      'friend': '朋友',
      'alertFriendSuccess': '添加朋友成功',
      'alertUnFriendSuccess': '成功取消朋友',
      'alertUChallengeSent': '挑战已成功发送',
      'subscribe': '加入',
      'unSubscribe': '取消加入',
      'subscribed': '已加入',
      'downLoad': '下载',
      'size': 'Q&A',
      'description': '描述',
      'alertWantToSubscribe1': '您确定要取消加入吗？',
      'alertWantToSubscribe2': '您将失去所有的问题',
      'downloading': '正在下载......',
      'thisModuleWillOccupie': '这个模块将占用',
      'alertNotAllowed': '您不能取消加入已分配的学习模块',
      'engagement': '情况',
      'debrief': '任务报告',
      'category': '类别',
      'achievement': '成就',
      'nextLevel': '下一级',
      'friends': '朋友',
      'competitor': '同事',
      'sendChallenge': '发送挑战',
      'next': '下一页',
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
      'resets_': '名字:',
      'name_': '扣除',
      'cost': '您',
      'you': '世界',
      'world': '国家',
      'country': '分数',
      'score': '昵称',
      'companyName': '增加',
      'revenue': '#问题',
      'hashCustomers': '%正确',
      'brand': '开始时的知识点数',
      'cashAtStartOfPeriod': '威力升级点数',
      'employees': '费用',
      'salaries': '问题',
      'customers': '日',
      'day': '月',
      'month': '年',
      'year': '上一时期',
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
      'rewardsDialogContent':
          "查看奖励类别，点击奖杯查看您目前的成就以及您需要取得多少成就才能升到下一级别.\n\n下一级下面的数字是您\n将收到的奖金。",
      'challengesDialogTitle1': "挑战",
      'challengesDialogContent1': "在这里，您将学习如何挑战其他同事",
      'strChallanges': "挑战",
      'strChallangesDialogContent':
          "搜索或选择您想挑战的同事。\n选择您想挑战他的学习模块之一，然后选择赢家可以获得的奖励 (%当前知识点数 (KP))。您的竞争对手需要正确回答选定模块的3个问题才能赢得挑战。",
      'strMarketingCommunications': "排名",
      'strMarketingCommunicationsDialog': "在这一部分，您将了解有关排名的所有信息",
      'strRankingDialogContent':
          "在左侧选择排名标准 (比如知识点数 (KP))，并在顶部 \n选择您想对比的分组以及时间范围。\n您也可以点击"
              "您"
              "滚动到您的位置和挑战以及添加朋友。",
      'strYourTeamPerformance': "您的团队的表现",
      'strYourTeamPerformanceDialog': "这部分是团队领导专属。\n在这里您可以看到您的报告的表现。",
      'strTeamDialog':
          "作为经理，您可以查看和监控您的团队的表现。如果您点击一个团队成员，您可以看到他的个人表现，并将他的知识点 (KP) 重置为30.000。",

      'plPerson': '表现',
//      'niceMeetYou':'${Injector.userData?.name??""}很高兴见到您',
      'plMyName': '在这一部分，您将了解有关表现分析的所有信息',
      'hereYourMonitor': '在这里，您可以监控扣除和增加知识点数 (KP)。',
      'selectPeriod': '您还可以选择您想要查看的时间段和比较当前周期与上一个周期。',
      'strYourTeamPerformanceDialog2':
          '图表显示"保留级别"和"问题状态” "保留级别"表示保留了多少问题（1 = 低保留级别，10 = 知识保留得很好）。"问题状态"表示问题是否已开启并已回答（开启 = 开启回答，完成 = 已正确回答)',
      //existing customer
      'servingYourExisting': '已完成的学习列表',
      'servingYourExistingDialog': '在本教程的这一部分，您将学习有关您已完成的学习的所有相关信息',
      'listOfExisting': '已完成的学习列表',
      'listOfExistingDetails':
          '在这里，您可以看到您目前已经记住的所有问题。您每天从这些问题那里获得多少知识点 (KP) 以及这些问题会在列表中存在多少天。\n如果您想删除一个问题，您可以点击"X"。\n然后，这个问题将不会为您生成更多的知识点数，但您将重新获得1个可用记忆点数 (MP)。',
      'readyForBusiness': '准备开始',
      'readyForBusinessDeatils':
          '您可以进一步查看学习模块，回答更多的问题。\n\n或者探索这个应用程序的其他区域，您可以赚取奖励，挑战其他玩家，查看您的表现和比较您的排名。',
      'finishTutorial': '完成教程',

      //customer situation
      'impactOnSales': '对学习点数 (SP) 和记忆点数 (MP) 的影响',
      'impactOnSalesDetails':
          '恭喜！您正确地回答了您的第一个问题。\n您的学习点数 (SP) 条现在显示8/10，因为这个问题\n需要2个学习点数。您的记忆力点数 (MP) 条显示\n9/10，因为这个问题会在您的已完成学习列表中占用1个记忆点数。',
      'impactOnBrand': '对知识分数 (KS) 的影响',
      'impactOnBrandDetails':
          '您的知识分数 (KS) 现在是100％，因您100%正确回答了所有问题。\n\n独立于您的知识分数 (KS)，您的知识点数 (KP) 也因为\n获得这个问题提供的知识点数而增加。',
      'checkYourCustomer': '查看完整的学习列表',
      'checkYourCustomerDetails':
          '您可以在"已完成的学习"部分找到包含所有已完成的问题的列表。\n\n您可以通过点击您的记忆力点数 (MP) 条，\n从菜单选择“已完成的学习”，或者前往主页面选择“已完成的学习”进入您的“已完成的学习”页面。',
      'clickServiceBtn': '点击您的记忆点数 (MP) 条',

      //engagement
      'yourFirstEngagement': '您的第一个问题',
      'yourFirstEngagementDetails':
          '为了赢得这个问题，您需要\n正确回答这个问题。您可以点击展开按钮放大图片、问题和答案选项。\n\n选择正确的答案，然后单击"下一页”',
      'yourFirstEngagementBtn': '选择答案并单击"下一页”',

      //New Customer screen
      'heartBusiness': '开放学习列表',
      'heartBusinessDetails': '在本教程的这一部分，您将学习选择和回答问题所需的所有相关信息',
      'listOfPotential': '问题列表',
      'listOfPotentialDetails':
          '每个问题都有一个名称，属于对应的学习模块。\n知识是您每天可以在已完成学习列表中通过这个问题可以赚取的知识点数 (KP)。\n“重复...”表示您如果现在回答正确，在多少天后您需要重复回答这个问题。您越经常正确地回答一个问题，您就越不经常需要重复。\n学习点数 (SP) 表示您需要多少学习点数 (SP) 来回答这个问题。点击"立即回答"。',
      'listOfPotentialBtn': '点击"立即回答"',

      //Business sector screen dialog
      'customerRelation': '学习模块介绍',
      'customerRelationDetails': '在这里，您可以搜索学习模块，加入和取消加入，并决定是否要下载内容以供将来离线使用。',
      'areaOfComp': '学习模块介绍',
      'areaOfCompDetails':
          '每个学习模块将测试特定的知识领域。"大小"表示每个模块中的问题数量。您可以点击学习模块阅读描述，并决定是否要加入它们。某些学习模块已由贵公司分配给您，无法取消加入。',
      'accessToFirst': '加入第一个模块',
      'accessToFirstDetails':
          '您可以加入第一个商业部门从而\n访问您的第一个问题。\n\n点击学习模块"开始"，然后点击"加入"。',
      'accessToFirstBtn': '点击"开始”',
      'readyForCustomer': '准备好您的第一个问题',
      'readyForCustomerDetails':
          '让我们前往开放学习板块，其中包含一个\n您可以回答的新问题列表。\n\n您可以点击您的学习点数 (SP) 条，使用导航\n菜单“>”，或者单击后退按钮，然后选择“开放学习”。',
      'readyForCustomerBtn': '点击学习点数 (SP) 条',

      'customersRelationShip': "学习模块介绍",
      //endregion

      'customersRelationShipContent':
          "在这里，您可以搜索学习模块，加入和取消加入，并决定是否要下载内容以供将来离线使用。",
      'areaOfCompetency': "学习模块介绍",
      'areaOfCompetenceContent':
          "每个学习模块将测试特定的知识领域。\"大小\"表示每个模块中的问题数量。您可以点击学习模块阅读描述，并决定是否要加入它们。某些学习模块已由贵公司分配给您，无法取消加入。",
      'customizeYourCompany': "自定义您的个人资料",
      'customizeYourCompanyContent':
          "亲爱的${Injector.userData?.name ?? ""}，\n\n欢迎来到游戏化的学习体验。\n您准备好赚取点数以及和同事竞争了吗？\n点击您的姓名或导航菜单 (“>”) 中的\n"
              "个人资料"
              "。 ",

      //Organization screen Dialog
      'hireHrEmp': '提高“最大威力升级 (PU)”',
      'hireHrEmpDetails': '接下来，您将学习如何提高您的威力升级点数 (PU)',

      'hireHrEmpDetailsSeconds':
          '如需获取建议和了解提高威力升级点数 (PU) 的原因，请点击它们。\n让我们先花费10个威力升级点数 (PU) 和1000个知识点数 (KP) 来将“最大威力升级 (PU)”升至1级。\n点击“最大威力升级 (PU)”然后点击“提高等级”',

      'empOMaster': '威力升级点数 (PU) 条',
      'empOMasterDetails':
          '您的威力升级点数 (PU) 条显示40/50。\n50是您最大的威力升级点数 (PU)，40是您当前可用的点数。\n您可以通过提高威力升级点数 (PU) 级别来增加您的最大值。\n点击您的威力升级点数 (PU) 条，您将前往此界面。',
      'costOfEmp': '进步的成本',
      'costOfEmpDetails':
          '在这里，您可以看到您的知识点数 (KP)。\n\n提高威力升级点数 (PU) 会花费知识点数 (KP)。随着等级的提升，这种一次性的花费成本会增加。\n每花费一个威力升级点数 (PU) 会不断产生费用，一开始是每天每个威力升级点数 (PU) 消耗200个知识点数 (KP)。这种成本将随着时间的推移而增加。',

      //setting screen Dialog
      'settingDetails':
          '您可以切换到游戏模式（有虚拟公司),您可以打开或关闭声音。\n\n如果您的点数变为负数，您可以请求重新开始，您的经理会进行审批。',
    }
  };
}
