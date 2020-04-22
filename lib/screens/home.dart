import 'dart:async';
import 'dart:convert';

import 'package:background_fetch/background_fetch.dart';
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
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/intro.dart';
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

class HomePageState extends State<HomePage>
    with WidgetsBindingObserver
    implements RefreshAnimation {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedDrawerIndex = 0;
  String _currentPage = Const.typeHome;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool startAnim = false;
  int duration = 1;
  bool isCoinViseble = false;
  DashboardLockStatusData dashboardLockStatusData;
  RefreshAnimation mRefreshAnimation;

  HomeData homeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    print("init_______home");
    dashboardLockStatusData = Injector.dashboardLockStatusData;
//    setSelectedIndex();
    initStateMethods();
  }

  @override
  Widget build(BuildContext context) {
    initDrawerItems();

    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      drawerOptions.add(new ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          title: showMainItem(drawerItems[i], i),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i, drawerItems[i])));
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
              _selectedDrawerIndex = Utils.getHomePageIndex(snapshot.data.initialPageType);
              _currentPage = snapshot.data.initialPageType;
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
                    getPage(),
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
    mRefreshAnimation = this;
  }

  /*
  * we need to call thi API here because we want to restrict features from
  * menu-drawer items as well as top Header
  *
  * */

  void getLockStatus() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardLockStatusRequest rq = DashboardLockStatusRequest();
        rq.userId = Injector.userId;
        rq.mode = Injector.mode ?? Const.businessMode;

        WebApi()
            .callAPI(WebApi.rqDashboardLockStatus, rq.toJson())
            .then((data) async {
          if (data != null) {
            dashboardLockStatusData = DashboardLockStatusData.fromJson(data);
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
    _connectivitySubscription?.cancel();
    super.dispose();
  }

//  startAnimation() {
//    isCoinViseble = true;
//    if (isCoinViseble) {
//      startAnim = true;
//    } else {
//      startAnim = false;
//    }
//    if (mounted) setState(() {});
//  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("=============");
    print(state.toString());

    if (state == AppLifecycleState.resumed) {
//      print("====== resume ======");
      Utils.removeBadge();
    } else if (state == AppLifecycleState.inactive) {
//      print("====== inactive ======");
    } else if (state == AppLifecycleState.paused) {
//      print("====== paused ======");
    }
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Injector.isBusinessMode
            ? DashboardGamePage()
            : DashboardProfPage();
      case 1:
        return BusinessSectorPage();
      case 2:
        return NewCustomerPage();
      case 3:
        return ExistingCustomerPage();
      case 4:
        return RewardsPage();
      case 5:
        return Injector.isManager() ? TeamPage() : ChallengesPage();
      case 6:
        return (Injector.isManager()
            ? ChallengesPage()
            : (Injector.isBusinessMode
                ? OrganizationsPage2()
                : PowerUpsPage()));

      case 7:
        return Injector.isManager()
            ? Injector.isBusinessMode ? OrganizationsPage2() : PowerUpsPage()
            : PLPage();
      case 8:
        return Injector.isManager() ? PLPage() : RankingPage();

      case 9:
        return RankingPage();
//      case 10:
//        return ProfilePage();
//      case 11:
//        return IntroPage();
//        return FadeRouteIntro();
//        return Navigator.push(context, FadeRouteIntro());
      default:
        return Text("");
    }
  }

//
//  openProfile() {
//    if (mounted)
//      setState(() =>
//          _selectedDrawerIndex = Utils.getHomePageIndex(Const.typeProfile));
//  }

  _onSelectItem(int index, DrawerItem item) {
    _currentPage = item.key;

    Utils.playClickSound();
    if (_selectedDrawerIndex != index) {
      if (index == Utils.getHomePageIndex(Const.typeOrg) &&
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
      } else if (index == Utils.getHomePageIndex(Const.typePl) &&
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
      } else if (index == Utils.getHomePageIndex(Const.typeRanking) &&
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
      } else if (index == Utils.getHomePageIndex(Const.typeReward) &&
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
      } else if (index == Utils.getHomePageIndex(Const.typeChallenges) &&
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
        if (index == Utils.getHomePageIndex(Const.typeOrg) ||
            index == Utils.getHomePageIndex(Const.typeChallenges) ||
            index == Utils.getHomePageIndex(Const.typeReward) ||
            index == Utils.getHomePageIndex(Const.typeRanking) ||
            index == Utils.getHomePageIndex(Const.typeProfile) ||
            index == Utils.getHomePageIndex(Const.typePl)) {
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
//    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); //
    navigationBloc.updateNavigation(HomeData(initialPageType: _currentPage)); // close the drawer
    if (_selectedDrawerIndex == Utils.getHomePageIndex(Const.typeHelp)) {
      Navigator.push(context, FadeRouteIntro());
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

  showMainItem(DrawerItem item, int i) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Injector.isBusinessMode ? 8 : 5, horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode
              ? null
              : i == _selectedDrawerIndex
                  ? ColorRes.blueMenuSelected
                  : ColorRes.blueMenuUnSelected,
          border: (!Injector.isBusinessMode && i == _selectedDrawerIndex)
              ? Border.all(
                  color: ColorRes.white,
                  width: 1,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg(i == _selectedDrawerIndex
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

  getPage() {
    if (_selectedDrawerIndex == Utils.getHomePageIndex(Const.typeProfile))
      return ProfilePage();
    else if (_selectedDrawerIndex ==
        Utils.getHomePageIndex(Const.typeEngagement))
      return EngagementCustomer(
          questionDataEngCustomer: homeData.questionDataHomeScr,
          isChallenge: homeData.isChallenge);
    else if (_selectedDrawerIndex ==
        Utils.getHomePageIndex(Const.typeCustomerSituation))
      return CustomerSituationPage(
        questionDataCustomerSituation: homeData.questionDataSituation,
        isChallenge: homeData.isChallenge,
        isCameFromNewCustomer: homeData.isCameFromNewCustomer,
        mRefreshAnimation: mRefreshAnimation,
      );
    else if (_selectedDrawerIndex ==
        Utils.getHomePageIndex(Const.typeChallenges))
      return ChallengesPage(
        arrFriends: homeData?.arrFriends,
        friendId: homeData?.friendId,
      );
    else
      return _getDrawerItemWidget(_selectedDrawerIndex);
  }

  void getCustomerValues() {
    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) customerValueBloc?.getCustomerValue(rq);
    });
  }

  void setSelectedIndex() {
    if (homeData != null) {
      _selectedDrawerIndex =
          Utils.getHomePageIndex(homeData?.initialPageType);
      _currentPage = homeData?.initialPageType;
    }

  }

  void initStreamController() async {
    Injector.homeStreamController.stream.listen((data) {

      if (data == "${Const.openPendingChallengeDialog}") {
        getPendingChallenges();
      } else if (data == "${Const.typeMoneyAnim}") {
        isCoinViseble = true;
//        startAnimation();
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

  bool isLoading = false;

  void getPendingChallenges() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        GetChallengesRequest rq = GetChallengesRequest();
        rq.userId = Injector.userData.userId;

        WebApi().callAPI(WebApi.rqGetChallenge, rq.toJson()).then((data) {
          if (mounted)
            setState(() {
              isLoading = false;
            });

          if (data != null) {
            QuestionData questionData = QuestionData.fromJson(data);
            if (questionData != null && questionData.challengeId != null) {
              if (questionData.isFirstQuestion == 1) {
                DisplayDialogs.showChallengeDialog(
                    context,
                    questionData.firstName + " " + questionData.lastName,
                    questionData);
              } else {
                Utils.showChallengeQuestionDialog(context, questionData);
              }
            }
          }
        }).catchError((e) {
          // Utils.showToast(e.toString());
          print("getChallenges_" + e.toString());
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        });
      }
    });
  }

  void initDrawerItems() {
    drawerItems = [];

    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.home),
          Injector.isBusinessMode ? "main_screen_icon" : "ic_pro_home",
          Const.typeHome),
    );

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

//    if (Injector.headerStreamController == null)
//      Injector.headerStreamController = StreamController.broadcast();
//
//    Injector.headerStreamController.add("event");

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

  @override
  onRefresh() {
    setState(() {
      isCoinViseble = true;
    });
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
}
