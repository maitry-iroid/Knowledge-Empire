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
  static var strYourTeamPerformanceDialog2 = "strYourTeamPerformanceDialog2";
  static var strTeamDialog = "strTeamDialog";

//pl screen
  static var plPerson = "plPerson";
  static var niceMeetYou = "niceMeetYou";
  static var plMyName = "plMyName";
  static var hereYourMonitor = "hereYourMonitor";
  static var selectPeriod = "selectPeriod";
  static var graphShow = "graphShow";

//  static var selectPeriod = "selectPeriod";

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
      'selectLanguages':'Select Language',

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
      'alertUnFriend': "Are sure want to unfriend this user?",


      //endregion

      //introDialog
      'gotIt': "Got it",
      'rewardsDialogContent':
          "Check out the reward categories and click on a trophy to\nfind out what you have achieved already and what you will need to\nachieve for the next level.\n\nThe number below the “Next Level” is the bonus\nyou will receive.",
      'challengesDialogTitle1': "Your Will is at your command",
      'challengesDialogContent1':
          "Dear ${Injector.userData?.name},\n\nMy name is Will and I am your corporate lawyer.\nI will help you to challenge other competitors and also to defend\nagainst attacks.",
      'strChallanges': "Challenges",
      'strChallangesDialogContent':
          "Search or select a competitor you would like to challenge.\nSelect one of his business sectors you would like to challenge\nhim and select the reward (% of current cash) the the winner\ncan get. Your competitor will need to answer 3 out of 3 questions from the selected sector correctly in order to win the challenge.",
      'strMarketingCommunications': "Marketing & Communications",
      'strMarketingCommunicationsDialog':
          "Hi ${Injector.userData?.name},\n\nWhat a great pleasure meeting you. I have heard a lot of good\nthings about you. So I am extremely exited to work for you.\nI am Lydia and in charge of Marketing & Communications.\nLet's have a look at your overall market position. ",
      'strRankingDialogContent':
          "Select on the left side the ranking criteria (e.g. cash) and at the\ntop which group you would like to compare it with and in which\ntime frame.\nYou can also click in “You” to scroll to your position and\nchallenge and add friends.",
      'strYourTeamPerformance': "Your Team's Performance",
      'strYourTeamPerformanceDialog':
          "Hi, it's me again, Niki.\n\nThis section is exclusively for team leaders.\nHere you can see the performance of your reports.",
      'strTeamDialog':
          "As a manager you can see and monitor the performance\nof your team. If you click on a team member you can see his\nindividual performance and also bail him out in case his company is\nout of cash (reset his cash to 30.000).",


      'plPerson': 'The person you can count on',
      'niceMeetYou': 'Nice to meet you${Injector.userData?.name}',
      'plMyName':
          '\n\nMy name is Akiko Nakamura. I am in charge of Finance.\nLet\'s make sure to always have more revenue then cost.',
      'hereYourMonitor':
          'Here you can monitor the cost and the revenue of your company.',
      'selectPeriod':
          'You can also select the period you want to look at and compare the current period with the previous period.',

      'strYourTeamPerformanceDialog2':
          'The graphs show you the “Retention Level” & “Question Status”\n“Retention Level” indicates how many questions are retained\n(1 = low retention and 10 = very well retained knowledge).\n“Question Status” indicates if questions are open and answered\n(open = open for answering, completed = correctly answered)',
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
      //endregion

      //introDialog
      'gotIt': "Verstanden",
      'rewardsDialogContent':
          "Schau dir die unterschiedlichen Kategorien von Auszeichnungen an um herauszufinden was du schon erreicht hast und was du noch machen musst um das nächste Level zu erreichen. Die Zahlen ist der Geldbonus den du erhältst, wenn du diese Auszeichnung erreichst.",
      'challengesDialogTitle1': "Dein Will ist mein Befehl",
      'challengesDialogContent1':
          "${Injector.userData?.name},\n\nMein Name ist Will und ich bin der Anwalt der Firma.\nIch will dir helfen Wettbewerber herauszufordern und Angriffe abzuwehren.",
      'strChallanges': "Herausforderungen",
      'strChallangesDialogContent':
          "Suche und wähle Wettbewerber aus, die du herausfordern möchtest.\nwähle den Geschäftsbereich aus, in dem er herausgefordert werden soll und den Prozentsatz vom aktuellen Vermögen, den der Gewinner bekommen soll.\n\nDer Herausgeforderte muss dann 3 von 3 fragen aus diesem Geschäftsbereich richtig beantworten um zu gewinnen. Ansonsten gewinnst du.",
      'strMarketingCommunications': "Marketing",
      'strMarketingCommunicationsDialog':
          "Hallo ${Injector.userData?.name}, \n\nWas für eine ausserordentliche Freude dich kennenzulernen. Ich habe von den Kollegen schon so viel gutes über dich gehört. Ich freue mich schon sehr mit dir zusammen zu arbeiten.\nIch bin Lydia und verantwortlich für das Marketing.\nLass uns gemeinsam einen Blick auf deine aktuelle Wettbewerbsposition legen",
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
      'niceMeetYou': 'Nett dich kennenzulernen ${Injector.userData?.name}',
      'plMyName':
          'Mein Name ist Akiko Nakamura und verantwortlich für die Finanzen.Lass uns gemeinsam sicherstellen, dass wir immer mehr Einnahmen als Ausgaben haben.',
      'hereYourMonitor':
          'Hier kannst du die Einnahmen und die Ausgeben deines Unternehmens überwachen.',
      'selectPeriod':
          'Dazu kannst du unterschiedliche Zeithorizonte auswählen und immer die aktuelle Periode mit der Perioden davor vergleichen.',

      'strYourTeamPerformanceDialog2':
          'Die Kuchendiagramme zeigen dir das Fragenlevel und den Fragenstatus.Das Fragenlevel ist ein Indikator für wie gut dieses Wissen verinnerlicht ist(1= niedrig, 10=hoch). Der Fragenstatus gibt Auskunft darüber wieviel Fragen aktuell beantwortet und wieviel unbeantwortet sind.',
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
      //endregion

      //introDialog
      'gotIt': "了解",
      'rewardsDialogContent': "查看奖励类别，点击奖杯查看您目前的成就以及您需要取得多少成就才能升到下一级别.\n\n"
          "下一级"
          "下面的数字是您\n将收到的奖金。",
      'challengesDialogTitle1': "您是自己的主宰",
      'challengesDialogContent1':
          "亲爱的${Injector.userData?.name},\n\n我叫威尔，我是您公司的律师。\n我会帮助您挑战其他竞争对手，\n同时也帮您防守对方的攻击。",
      'strChallanges': "挑战",
      'strChallangesDialogContent':
          "搜索或选择您想挑战的竞争对手。\n选择您想挑战他的一个业务部门然后选择赢家可以获得的奖励 (%当前知识点数 (KP))。您的竞争对手需要正确回答选定部门的3个问题才能赢得挑战。",
      'strMarketingCommunications': "营销与传播",
      'strMarketingCommunicationsDialog':
          "${Injector.userData?.name},您好，\n\n很高兴见到您。我久仰您的大名。所以我非常高兴能为您工作。\n我是莉蒂亚，负责市场营销和传播。\n让我们来看看您的整体市场地位。",
      'strRankingDialogContent': "在左侧选择排名标准（比如现金），并在顶部选择您想对比的分组以及时间范围。\n您也可以点击"
          "您"
          "滚动到您的位置和挑战以及添加朋友。",
      'strYourTeamPerformance': "您的团队的表现",
      'strYourTeamPerformanceDialog':
          "您好，我是尼基，我又来了。\n这部分是团队领导专属。\n在这里您可以看到您的报告的表现。",
      'strTeamDialog':
          "作为经理，您可以查看和监控您的团队的表现。如果您点击一个团队成员，您可以看到他的个人表现。如果他的公司没有了资金，您还可以帮助他缓解资金困难 (将他的现金重置为30.000)。",


      'plPerson': '您可以依靠的人',
      'niceMeetYou': '${Injector.userData?.name}很高兴见到您',
      'plMyName': '我叫中村明子。我负责财务。让我们确保收入始终高于支出。',
      'hereYourMonitor': '在这里，您可以监控公司的成本和收入。',
      'selectPeriod': '您还可以选择您想要查看的时间段和比较当前周期与上一个周期',

      'strYourTeamPerformanceDialog2':
          '图表显示"保留级别"和"问题状态”"保留级别"表示保留了多少问题（1 = 低保留级别，10 = 知识保留得很好）。"问题状态"表示问题是否已开启并已回答（开启 = 开启回答，完成 = 已正确回答)',
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
      //endregion

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
//      'niceMeetYou':'${Injector.userData?.name}很高兴见到您',
      'plMyName':
          'In this section you will learn everything you need to know about your performance analysis',
      'hereYourMonitor':
          'Here you can monitor the deductions and the additions of Knowledge Points (KP).',
      'selectPeriod':
          'You can also select the period you want to look at and compare the current period with the previous period.',

      'strYourTeamPerformanceDialog2':
          'The graphs show you the “Retention Level” & “Question Status”“Retention Level” indicates how many questions are retained(1 = low retention and 10 = very well retained knowledge).“Question Status” indicates if questions are open and answered (open = open for answering, completed = correctly answered)',
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
      //endregion

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
//      'niceMeetYou':'${Injector.userData?.name}很高兴见到您',
      'plMyName':
          'In diesem Bereich kannst du deine Entwicklung einsehen und überprüfen.',
      'hereYourMonitor':
          'Hier kannst du deinen Wissenspunkte-Zuwachs und -Abgang überwachen.',
      'selectPeriod':
          'Dazu kannst du unterschiedliche Zeithorizonte auswählen und immer die aktuelle Periode mit der Perioden davor vergleichen.',
      'strYourTeamPerformanceDialog2':
          'Die Kuchendiagramme zeigen dir das Fragenlevel und den Fragenstatus.Das Fragenlevel ist ein Indikator für wie gut dieses Wissen verinnerlicht ist(1= niedrig, 10=hoch). Der Fragenstatus gibt Auskunft darüber wieviel Fragen aktuell bentowertet und wieviel unbeantwortet sind.',
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
      //endregion

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
//      'niceMeetYou':'${Injector.userData?.name}很高兴见到您',
      'plMyName': '在这一部分，您将了解有关表现分析的所有信息',
      'hereYourMonitor': '在这里，您可以监控扣除和增加知识点数 (KP)。',
      'selectPeriod': '您还可以选择您想要查看的时间段和比较当前周期与上一个周期。',
      'strYourTeamPerformanceDialog2':
          '图表显示"保留级别"和"问题状态” "保留级别"表示保留了多少问题（1 = 低保留级别，10 = 知识保留得很好）。"问题状态"表示问题是否已开启并已回答（开启 = 开启回答，完成 = 已正确回答)',
    }
  };
}
