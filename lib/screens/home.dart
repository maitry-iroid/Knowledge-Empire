import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ke_employee/BLoC/learning_module_bloc.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/models/get_challenges.dart';
import 'package:ke_employee/push_notification/PushNotificationHelper.dart';
import 'package:ke_employee/screens/challenges.dart';
import 'package:ke_employee/screens/dashboard_prof.dart';
import 'package:ke_employee/screens/dashboard_game.dart';
import 'package:ke_employee/screens/existing_customers.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/intro_screen.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/screens/new_customer.dart';
import 'package:ke_employee/screens/organization2.dart';
import 'package:ke_employee/screens/powerups.dart';
import 'package:ke_employee/screens/profile.dart';
import 'package:ke_employee/screens/ranking.dart';
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

class FadeRouteHome extends PageRouteBuilder {
  final Widget page;
  final String initialPageType;
  final bool isCameFromDashboard;

//  final GetFriendsData friendsData;
  List<GetFriendsData> arrFriends = List();

  FadeRouteHome({this.page, this.initialPageType, this.isCameFromDashboard})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: HomePage(
              initialPageType: initialPageType,
            ),
          ),
        );
}

class HomePage extends StatefulWidget {
  final String initialPageType;

  final bool isCameFromDashboard;

  HomePage({Key key, this.initialPageType, this.isCameFromDashboard})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class DrawerItem {
  String title;
  String icon;

  DrawerItem(this.title, this.icon);
}

List<DrawerItem> drawerItems = List();

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedDrawerIndex = 0;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool startAnim = false;
  int duration = 4;
  bool isCoinViseble = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    initStreamController();

    initCheckNetworkConnectivity();

    setSelectedIndex();

    PushNotificationHelper(context, "home").initPush();

    getCustomerValues();

    if (Injector.isDev) getPendingChallenges();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  startAnimation() {
    isCoinViseble = true;
    if (isCoinViseble) {
      startAnim = true;
    } else {
      startAnim = false;
    }
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {}
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
        return Injector.isDev ? RewardsPage() : Container();
      case 5:
//        return TeamPage();
        return Injector.isDev
            ? Injector.isManager() ? TeamPage() : ChallengesPage()
            : Container();
      case 6:
//        return (Injector.isManager()
//            ? ChallengesPage()
//            : (Injector.isBusinessMode
//                ? OrganizationsPage2()
//                : PowerUpsPage()));
        return Injector.isDev
            ? (Injector.isManager()
                ? ChallengesPage()
                : (Injector.isBusinessMode
                    ? OrganizationsPage2()
                    : PowerUpsPage()))
            : Container();
      case 7:
        return Injector.isDev
            ? Injector.isManager()
                ? Injector.isBusinessMode
                    ? OrganizationsPage2()
                    : PowerUpsPage()
                : PLPage()
            : Container();
      case 8:
        return Injector.isDev
            ? Injector.isManager() ? PLPage() : RankingPage()
            : Container();

      case 9:
        return Injector.isDev ? RankingPage() : Container();
        return Container();
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

  openProfile() {
    if (mounted) {
      setState(() =>
          _selectedDrawerIndex = Utils.getHomePageIndex(Const.typeProfile));
    }
  }

  _onSelectItem(int index) {
    Utils.playClickSound();

    if (_selectedDrawerIndex != index) {
      if (mounted) {
        setState(() => _selectedDrawerIndex = index);

        if (!Injector.isDev) {
          if (index == Utils.getHomePageIndex(Const.typePl) ||
              index == Utils.getHomePageIndex(Const.typeReward) ||
              index == Utils.getHomePageIndex(Const.typeChallenges) ||
              index == Utils.getHomePageIndex(Const.typeTeam) ||
              index == Utils.getHomePageIndex(Const.typeRanking)) {
            Utils.showComingSoonDialog(context);
          } else {
            Navigator.of(context).pop(); // close the drawer
            if (_selectedDrawerIndex ==
                Utils.getHomePageIndex(Const.typeHelp)) {
              Navigator.push(context, FadeRouteIntro());
            }
          }
        } else {
          Navigator.of(context).pop(); // close the drawer
          if (_selectedDrawerIndex == Utils.getHomePageIndex(Const.typeHelp)) {
            Navigator.push(context, FadeRouteIntro());
          }
        }
      }
    }
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
          onTap: () => _onSelectItem(i)));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: new SizedBox(
        width: Utils.getDeviceWidth(context) / 2.5,
        child: Drawer(
            child: Container(
          color:
              Injector.isBusinessMode ? ColorRes.bgMenu : ColorRes.headerBlue,
          child: new ListView(children: drawerOptions),
        )),
      ),
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          getPage(),
          Container(
            color: ColorRes.white.withOpacity(0.5),
            width: 0,
            height: 0,
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "Welcome to Knowledge Empire",
                    style: TextStyle(color: ColorRes.black),
                  )
                ],
              ),
            ),
          ),
          HeaderView(
            scaffoldKey: _scaffoldKey,
            isShowMenu: true,
            openProfile: openProfile,
          ),
//          isCoinViseble
//              ? Stack(
//                  children: <Widget>[
//                    coinWidget(250, 150),
//                    coinWidget(310, 50),
//                    coinWidget(70, 50),
//                    coinWidget(150, 20),
//                    coinWidget(350, 320),
//                    coinWidget(350, 450),
//                    coinWidget(180, 300),
//                    coinWidget(200, 550),
//                    coinWidget(350, 650),
//                  ],
//                )
//              : Container()
        ],
      )),
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

  Widget coinWidget(double top, double left) {
    print("isCoinViseble=====>" +
        isCoinViseble.toString() +
        "====>startAnim===>" +
        startAnim.toString());
    AnimatedPositioned(
      duration: Duration(seconds: duration),
      top: !isCoinViseble ? top : 20,
      left: !isCoinViseble ? left : 750,
      onEnd: () {
        isCoinViseble = false;
        setState(() {});
      },
      child: Container(
        child: isCoinViseble ? MyHomePage() : Container(),
        width: 40,
        height: 40,
      ),
    );
  }

  getPage() {
    if (_selectedDrawerIndex == Utils.getHomePageIndex(Const.typeProfile))
      return ProfilePage();
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
    _selectedDrawerIndex = Utils.getHomePageIndex(widget.initialPageType);
  }

  void initStreamController() async {
    await Injector.getInstance();

    if (Injector.streamController == null)
      Injector.streamController = StreamController.broadcast();

    Injector.streamController.stream.listen((data) {
      if (data == "${Const.typeProfile}") {
        if (_selectedDrawerIndex != Utils.getHomePageIndex(Const.typeProfile) &&
            mounted)
          setState(() {
            _selectedDrawerIndex = Utils.getHomePageIndex(Const.typeProfile);
          });
      } else if (data == "${Const.typeOrg}") {
        if (_selectedDrawerIndex != Utils.getHomePageIndex(Const.typeOrg) &&
            mounted)
          setState(() {
            _selectedDrawerIndex = Utils.getHomePageIndex(Const.typeOrg);
          });
      } else if (data == "${Const.typeTeam}") {
        if (_selectedDrawerIndex != Utils.getHomePageIndex(Const.typeTeam) &&
            mounted)
          setState(() {
            _selectedDrawerIndex = Utils.getHomePageIndex(Const.typeTeam);
          });
      } else if (data == "${Const.typeNewCustomer}") {
        if (_selectedDrawerIndex !=
                Utils.getHomePageIndex(Const.typeNewCustomer) &&
            mounted)
          setState(() {
            _selectedDrawerIndex =
                Utils.getHomePageIndex(Const.typeNewCustomer);
          });
      } else if (data == "${Const.typeExistingCustomer}") {
        if (_selectedDrawerIndex !=
                Utils.getHomePageIndex(Const.typeExistingCustomer) &&
            mounted)
          setState(() {
            _selectedDrawerIndex =
                Utils.getHomePageIndex(Const.typeExistingCustomer);
          });
      } else if (data == "${Const.typeRanking}") {
        if (_selectedDrawerIndex != Utils.getHomePageIndex(Const.typeRanking) &&
            mounted)
          setState(() {
            _selectedDrawerIndex = Utils.getHomePageIndex(Const.typeRanking);
          });
      } else if (data == "${Const.typePl}") {
        if (_selectedDrawerIndex != Utils.getHomePageIndex(Const.typePl) &&
            mounted)
          setState(() {
            _selectedDrawerIndex = Utils.getHomePageIndex(Const.typePl);
          });
      } else if (data == "${Const.openPendingChallengeDialog}") {
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
          setState(() {
            isLoading = false;
          });

          if (data != null) {
            QuestionData questionData = QuestionData.fromJson(data);

            if (questionData != null && questionData.challengeId != null)
              Utils.showChallengeQuestionDialog(_scaffoldKey, questionData);
          }
        }).catchError((e) {
          Utils.showToast(e.toString());
          print("getChallenges_" + e.toString());
          setState(() {
            isLoading = false;
          });
        });
      }
    });
  }

  void initDrawerItems() {
    drawerItems = [];

    drawerItems.add(DrawerItem(Utils.getText(context, StringRes.home),
        Injector.isBusinessMode ? "main_screen_icon" : "ic_pro_home"));

    drawerItems.add(DrawerItem(Utils.getText(context, StringRes.businessSector),
        Injector.isBusinessMode ? "business_sectors" : "ic_pro_home_business"));

    drawerItems.add(DrawerItem(Utils.getText(context, StringRes.newCustomers),
        Injector.isBusinessMode ? "new-customer" : "ic_pro_home_customer"));

    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.existingCustomers),
          Injector.isBusinessMode ? "existing" : "ic_pro_home_exis_customer"),
    );

    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.rewards),
          Injector.isBusinessMode ? "rewards" : "ic_pro_home_rewards"),
    );

    if (Injector.isManager())
      drawerItems.add(
        DrawerItem(Utils.getText(context, StringRes.team),
            Injector.isBusinessMode ? "team" : "ic_pro_home_team"),
      );

    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.challenges),
          Injector.isBusinessMode ? "challenges" : "ic_pro_home_challenges"),
    );
    drawerItems.add(
      DrawerItem(
          Utils.getText(context, StringRes.organizations),
          Injector.isBusinessMode
              ? "organization"
              : "ic_pro_home_organization"),
    );
    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.pl),
          Injector.isBusinessMode ? "profit-loss" : "ic_pro_home_pl"),
    );
    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.ranking),
          Injector.isBusinessMode ? "ranking" : "ic_pro_home_ranking"),
    );
    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.profile),
          Injector.isBusinessMode ? "profile_icon" : "ic_pro_profile"),
    );
    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.help),
          Injector.isBusinessMode ? "help_icon" : "ic_pro_help"),
    );
  }
}
