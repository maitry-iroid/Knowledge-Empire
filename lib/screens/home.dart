import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/BLoC/locale_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/models/UpdateDialogModel.dart';
import 'package:ke_employee/models/dashboard_lock_status.dart';
import 'package:ke_employee/models/get_challenges.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/push_notification/PushNotificationHelper.dart';
import 'package:ke_employee/screens/customer_situation.dart';
import 'package:ke_employee/screens/challenges.dart';
import 'package:ke_employee/screens/dashboard_prof.dart';
import 'package:ke_employee/screens/dashboard_game.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/screens/existing_customers.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/help_screen.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/screens/new_customer.dart';
import 'package:ke_employee/screens/organization2.dart';
import 'package:ke_employee/screens/powerups.dart';
import 'package:ke_employee/screens/profile.dart';
import 'package:ke_employee/screens/ranking.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';
import 'package:ke_employee/screens/rewards.dart';
import 'package:ke_employee/screens/team.dart';
import 'P+L.dart';
import 'business_sector.dart';
import '../commonview/header.dart';
import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/res.dart';
import '../helper/string_res.dart';
import '../models/get_friends.dart';
import 'package:flutter/services.dart';

class FadeRouteHome extends PageRouteBuilder {
//  final HomeData homeData;
  List<GetFriendsData> arrFriends = List();

  FadeRouteHome(/*{this.homeData}*/)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              /*homeData.page,*/
              HomePage(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: HomePage(
//              homeData: homeData,
                ),
          ),
        );
}

class HomePage extends StatefulWidget {
//  final HomeData homeData;
//
//  HomePage({Key key, this.homeData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class DrawerItem {
  String title;
  String icon;
  String key;

  DrawerItem(this.title, this.icon, this.key);
}

List<DrawerItem> drawerItems = List();

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _currentPage = Const.typeHome;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool startAnim = false;
  int duration = 1;
  bool isCoinViseble = false;
  DashboardLockStatusData dashboardLockStatusData;

  HomeData homeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    dashboardLockStatusData = Injector.dashboardLockStatusData;
    Future.delayed(Duration(seconds: 1)).then((d) {
      initStateMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    initDrawerItems();
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      drawerOptions.add(new ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          title: showMainItem(drawerItems[i]),
          selected: drawerItems[i].key == _currentPage,
          onTap: () => _onSelectItem(drawerItems[i])));
    }

    navigationBloc.updateNavigation(HomeData(initialPageType: _currentPage));

    return StreamBuilder(
        stream: navigationBloc?.navigationKey,
        builder: (context, AsyncSnapshot<HomeData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: ColorRes.white,
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              homeData = snapshot.data;
              _currentPage = snapshot.data.initialPageType;

              print("current_page :  " + _currentPage);

              if (_currentPage == Const.typeCustomerSituation &&
                  ((homeData.isCameFromNewCustomer != null &&
                          homeData.isCameFromNewCustomer &&
                          homeData.questionHomeData.isAnsweredCorrect) ||
                      (homeData.isChallenge != null &&
                          homeData.isChallenge &&
                          homeData.questionHomeData.isAnsweredCorrect))) {
                isCoinViseble = true;
              } else
                isCoinViseble = false;

              return Scaffold(
                key: _scaffoldKey,
                drawer: new SizedBox(
                  width: Utils.getDeviceWidth(context) / 2.5,
                  child: Drawer(
                      child: Container(
                    color: Injector.isBusinessMode
                        ? ColorRes.bgMenu
                        : ColorRes.headerBlue,
                    child: new ListView(children: drawerOptions),
                  )),
                ),
                backgroundColor: ColorRes.colorBgDark,
                body: SafeArea(
                    child: Stack(
                  children: <Widget>[
                    getDrawerItemWidget(),
                    HeaderView(
                      scaffoldKey: _scaffoldKey,
                      isShowMenu: true,
//                      openProfile: openProfile,
                    ),
                    Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        coinWidget(250, 150),
                        coinWidget(310, 50),
                        coinWidget(70, 50),
                        coinWidget(150, 20),
                        coinWidget(350, 320),
                        coinWidget(350, 450),
                        coinWidget(180, 300),
                        coinWidget(200, 550),
                        coinWidget(350, 650),
                      ],
                    ),
                  ],
                )),
              );
            } else
              return Container();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Container();
          }
        });
  }

  Future<void> initStateMethods() async {
    updateVersionDialog();
    initContent();
    getLockStatus();
    Utils.removeBadge();
  }

//push notification

  String _appBadgeSupported = 'Unknown';

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }
//    if (!mounted) return;
//    _appBadgeSupported = appBadgeSupported;
//    if (_appBadgeSupported != null) {
//      _addBadge();
//    }
//    if (mounted)setState(() {});
  }

  //--- push

  @override
  void dispose() {
    Injector.homeStreamController.close();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("=============");
    print(state.toString());

    if (state == AppLifecycleState.resumed) {
//      print("====== resume ======");
      Utils.removeBadge();
      Injector.audioPlayerBg.resume();
    } else if (state == AppLifecycleState.inactive) {
      Injector.audioPlayerBg.pause();
//      print("====== inactive ======");
    } else if (state == AppLifecycleState.paused) {
//      print("====== paused ======");
      Injector.updateIntroData();
    }
  }

  getDrawerItemWidget() {
    if (_currentPage == Const.typeHome) {
      return Injector.isBusinessMode
          ? DashboardGamePage()
          : DashboardProfPage();
    } else if (_currentPage == Const.typeBusinessSector) {
      return BusinessSectorPage();
    } else if (_currentPage == Const.typeNewCustomer) {
      return NewCustomerPage();
    } else if (_currentPage == Const.typeExistingCustomer) {
      return ExistingCustomerPage();
    } else if (_currentPage == Const.typeTeam) {
      return TeamPage();
    } else if (_currentPage == Const.typeChallenges) {
      return ChallengesPage(homeData: homeData);
    } else if (_currentPage == Const.typeReward) {
      return RewardsPage();
    } else if (_currentPage == Const.typeOrg) {
      return Injector.isBusinessMode ? OrganizationsPage2() : PowerUpsPage();
    } else if (_currentPage == Const.typeRanking) {
      return RankingPage();
    } else if (_currentPage == Const.typePl) {
      return PLPage();
    } else if (_currentPage == Const.typeProfile) {
      return ProfilePage();
    } else if (_currentPage == Const.typeEngagement) {
      return EngagementCustomer(homeData: homeData);
    } else if (_currentPage == Const.typeCustomerSituation) {
      return CustomerSituationPage(homeData: homeData);
    } else if (_currentPage == Const.typeCustomerSituation) {
      return ProfilePage();
    } else {
      return Injector.isBusinessMode
          ? DashboardGamePage()
          : DashboardProfPage();
    }
  }

  _onSelectItem(DrawerItem item) {
//    _currentPage = item.key;

    Utils.playClickSound();
    if (_currentPage != item.key) {
      if (item.key == Const.typeOrg &&
          dashboardLockStatusData != null &&
          dashboardLockStatusData.organization != null &&
          dashboardLockStatusData.organization != 1) {
        Utils.isInternetConnected().then((isConnected) {
          if (isConnected) {
            Utils.showLockReasonDialog(Const.typeOrg, context, false);
          } else {
            Utils.showLockReasonDialog(StringRes.noOffline, context, true);
          }
        });
      } else if (item.key == Const.typePl &&
          dashboardLockStatusData != null &&
          dashboardLockStatusData.pl != null &&
          dashboardLockStatusData.pl != 1) {
        Utils.isInternetConnected().then((isConnected) {
          if (isConnected) {
            Utils.showLockReasonDialog(Const.typePl, context, false);
          } else {
            Utils.showLockReasonDialog(StringRes.noOffline, context, true);
          }
        });
      } else if (item.key == Const.typeRanking &&
          dashboardLockStatusData != null &&
          dashboardLockStatusData.ranking != null &&
          dashboardLockStatusData.ranking != 1) {
        Utils.isInternetConnected().then((isConnected) {
          if (isConnected) {
            Utils.showLockReasonDialog(Const.typeRanking, context, false);
          } else {
            Utils.showLockReasonDialog(StringRes.noOffline, context, true);
          }
        });
      } else if (item.key == Const.typeReward &&
          dashboardLockStatusData != null &&
          dashboardLockStatusData.achievement != null &&
          dashboardLockStatusData.achievement != 1) {
        Utils.isInternetConnected().then((isConnected) {
          if (isConnected) {
            Utils.showLockReasonDialog(Const.typeReward, context, false);
          } else {
            Utils.showLockReasonDialog(StringRes.noOffline, context, true);
          }
        });
      } else if (item.key == Const.typeChallenges &&
          dashboardLockStatusData != null &&
          dashboardLockStatusData.challenge != null &&
          dashboardLockStatusData.challenge != 1) {
        Utils.isInternetConnected().then((isConnected) {
          if (isConnected) {
            Utils.showLockReasonDialog(Const.typeChallenges, context, false);
          } else {
            Utils.showLockReasonDialog(StringRes.noOffline, context, true);
          }
        });
      } else {
        if (item.key == Const.typeOrg ||
            item.key == Const.typeChallenges ||
            item.key == Const.typeReward ||
            item.key == Const.typeRanking ||
            item.key == Const.typeProfile ||
            item.key == Const.typePl) {
          Utils.isInternetConnected().then((isConnected) {
            if (isConnected) {
              navigationOnScreen(item);
            } else {
              Utils.showLockReasonDialog(StringRes.noOffline, context, true);
            }
          });
        } else {
          navigationOnScreen(item);
        }
      }
    } else {
      if (_scaffoldKey.currentState.isDrawerOpen) {
        _scaffoldKey.currentState.openEndDrawer();
      }
    }
  }

  void navigationOnScreen(DrawerItem item) {
    Navigator.of(context).pop(); //
    if (_currentPage == Const.typeHelp) {
      Navigator.push(context, FadeRouteIntro());
    } else {
      navigationBloc.updateNavigation(
          HomeData(initialPageType: item.key)); // close the drawer
    }
  }

  Widget coinWidget(double top, double left) {
    return AnimatedPositioned(
      duration: Duration(seconds: duration),
      top: !isCoinViseble ? top : 5,
      left: !isCoinViseble ? left : Utils.getDeviceWidth(context) / 1.1,
      onEnd: () {
        isCoinViseble = false;
        if (Injector.customerValueData != null)
          customerValueBloc.setCustomerValue(Injector.customerValueData);

        setState(() {});
      },
      child: Container(
        child: isCoinViseble ? MyHomePage() : Container(),
        width: 40,
        height: 40,
      ),
    );
  }

  showMainItem(DrawerItem item) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Injector.isBusinessMode ? 8 : 5, horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode
              ? null
              : item.key == _currentPage
                  ? ColorRes.blueMenuSelected
                  : ColorRes.blueMenuUnSelected,
          border: (!Injector.isBusinessMode && item.key == _currentPage)
              ? Border.all(
                  color: ColorRes.white,
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg(item.key == _currentPage
                      ? "slide_menu_highlight"
                      : "bg_menu")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(item.icon)),
              height: Injector.isBusinessMode ? 45 : 45,
              width: Injector.isBusinessMode ? 80 : 70,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(color: ColorRes.white, fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  void getCustomerValues() {
    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) customerValueBloc?.getCustomerValue(rq);
    });
  }

  void initStreamController() async {
    Injector.homeStreamController.stream.listen((data) async {
      if (data == "${Const.openPendingChallengeDialog}") {
        getPendingChallenges();
      }
    }, onDone: () {}, onError: (error) {});
  }

  void initCheckNetworkConnectivity() {
    WidgetsBinding.instance.addObserver(this);

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        Utils.callSubmitAnswerApi(context);
      }
    });
  }

  void getPendingChallenges() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        GetChallengesRequest rq = GetChallengesRequest();
        rq.userId = Injector.userData.userId;

        WebApi().callAPI(WebApi.rqGetChallenge, rq.toJson()).then((data) {
          if (data != null) {
            QuestionData questionData = QuestionData.fromJson(data);
            if (questionData != null && questionData.challengeId != null) {
              if (questionData.isFirstQuestion == 1) {
                DisplayDialogs.showChallengeDialog(
                    context,
                    questionData.firstName + " " + questionData.lastName,
                    questionData);
              } else {
//                Utils.showChallengeQuestionDialog(context, questionData);
                navigationBloc.updateNavigation(HomeData(
                  initialPageType: Const.typeEngagement,
                  questionHomeData: questionData,
                  isChallenge: true,
                ));
              }
            } else {
              // if there are no more question to attempt then navigate to HOME
              navigationBloc
                  .updateNavigation(HomeData(initialPageType: Const.typeHome));
            }
          }
        }).catchError((e) {
          // Utils.showToast(e.toString());
          print("getChallenges_" + e.toString());
        });
      }
    });
  }

  void initDrawerItems() {
    drawerItems = [];


    drawerItems.add(DrawerItem(
        Utils.getText(context, StringRes.businessSector),
        Injector.isBusinessMode ? "main_screen_icon" : "ic_pro_home",
        Const.typeHome));

    drawerItems.add(DrawerItem(
        Utils.getText(context, StringRes.businessSector),
        Injector.isBusinessMode ? "business_sectors" : "ic_pro_home_business",
        Const.typeBusinessSector));

    drawerItems.add(DrawerItem(
        Utils.getText(context, StringRes.newCustomers),
        Injector.isBusinessMode ? "new-customer" : "ic_pro_home_customer",
        Const.typeNewCustomer));

    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.existingCustomers),
          Injector.isBusinessMode ? "existing" : "ic_pro_home_exis_customer",
          Const.typeExistingCustomer),
    );

    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.rewards),
          Injector.isBusinessMode ? "rewards" : "ic_pro_home_rewards",
          Const.typeReward),
    );

    if (Injector.isManager())
      drawerItems.add(
        DrawerItem(
            Utils.getText(context, StringRes.team),
            Injector.isBusinessMode ? "team" : "ic_pro_home_team",
            Const.typeTeam),
      );

    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.challenges),
          Injector.isBusinessMode ? "challenges" : "ic_pro_home_challenges",
          Const.typeChallenges),
    );
    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.organizations),
          Injector.isBusinessMode ? "organization" : "ic_pro_home_organization",
          Const.typeOrg),
    );
    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.pl),
          Injector.isBusinessMode ? "profit-loss" : "ic_pro_home_pl",
          Const.typePl),
    );
    drawerItems.add(DrawerItem(
        Utils.getText(context, StringRes.ranking),
        Injector.isBusinessMode ? "ranking" : "ic_pro_home_ranking",
        Const.typeRanking));
    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.profile),
          Injector.isBusinessMode ? "profile_icon" : "ic_pro_profile",
          Const.typeProfile),
    );
    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.help),
          Injector.isBusinessMode ? "help_icon" : "ic_pro_help",
          Const.typeHelp),
    );
  }

  void initContent() async {
//    BackgroundFetch.start().then((int status) async {
//      print('[BackgroundFetch] start success: $status');

    Future.delayed(const Duration(milliseconds: 500), () {
      PushNotificationHelper pushNotificationHelper =
          PushNotificationHelper(context);

      if (pushNotificationHelper != null) {
        pushNotificationHelper.initPush();
      }
    });

    localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));

    initStreamController();
    getCustomerValues();

    initCheckNetworkConnectivity();

    initPlatformState();

    if (homeData == null ||
        homeData.page == null ||
        (homeData.initialPageType != Const.typeChallenges &&
            homeData.initialPageType != Const.typeCustomerSituation &&
            homeData.initialPageType != Const.typeEngagement)) {
      if (homeData == null ||
          homeData.isChallenge == null ||
          homeData.isChallenge) getPendingChallenges();
    }
//    }).catchError((e) {
//      print('[BackgroundFetch] start FAILURE: $e');
//    });
  }

  void updateVersionDialog() async {
    UpdateDialogModel status = await Injector.getCurrentVersion(context);
    if (status != null) {
      if (status.status != "0" || status.status == "2") {
        if (status.status == "2") {
          if (Injector.prefs.get(PrefKeys.isCancelDialog) == null) {
            DisplayDialogs.showUpdateDialog(
                context, status.headlineText, status.message, true);
          } else {
            DateTime clickedTime =
                DateTime.parse(Injector.prefs.get(PrefKeys.isCancelDialog));
            if (DateTime.now().difference(clickedTime).inDays >= 1) {
              DisplayDialogs.showUpdateDialog(
                  context, status.headlineText, status.message, true);
            }
          }
        } else {
          DisplayDialogs.showUpdateDialog(
              context, status.headlineText, status.message, false);
        }
      }
    }
  }

  /*
  * we need to call thi API here because we want to restrict features from
  * menu-drawer items as well as top Header
  *
  * */
  static Future getLockStatus() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardLockStatusRequest rq = DashboardLockStatusRequest();
        rq.userId = Injector.userId;
        rq.mode = Injector.mode ?? Const.businessMode;

        WebApi()
            .callAPI(WebApi.rqDashboardLockStatus, rq.toJson())
            .then((data) async {
          if (data != null) {
            DashboardLockStatusData dashboardLockStatusData =
                DashboardLockStatusData.fromJson(data);
            await Injector.prefs.setString(PrefKeys.lockStatusData,
                jsonEncode(dashboardLockStatusData.toJson()));
            Injector.dashboardLockStatusData = dashboardLockStatusData;
//            if (mounted) setState(() {});
          }
        }).catchError((e) {
          print("getDashboardValue_" + e.toString());
        });
      }
    });
  }
}
