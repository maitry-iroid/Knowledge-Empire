import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/models/get_challenges.dart';
import 'package:ke_employee/models/register_for_push.dart';
import 'package:ke_employee/screens/customer_situation.dart';
import 'package:ke_employee/screens/challenges.dart';
import 'package:ke_employee/screens/dashboard.dart';
import 'package:ke_employee/screens/dashboard_new.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/screens/existing_customers.dart';
import 'package:ke_employee/helper/prefkeys.dart';
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
  final int initialPageType;

  final QuestionData questionDataHomeScr;
  final QuestionData questionDataSituation;

  final int value;
  final int friendId;

  final int questionPosition;
  final int challengePosition;
  final List<GetChallengeData> getChallengeData;

//  final GetFriendsData friendsData;
  List<GetFriendsData> arrFriends = List();

  FadeRouteHome(
      {this.page,
      this.initialPageType,
      this.questionDataHomeScr,
      this.questionDataSituation,
      this.value,
      this.arrFriends,
      this.friendId,
      this.questionPosition,
      this.challengePosition,
      this.getChallengeData})
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
              questionDataHomeScr: questionDataHomeScr,
              questionDataSituation: questionDataSituation,
              value: value,
              arrFriends: arrFriends,
              friendId: friendId,
            ),
          ),
        );
}

class HomePage extends StatefulWidget {
  final int initialPageType;

  final QuestionData questionDataHomeScr;
  final QuestionData questionDataSituation;

  final int value;
  final int friendId;

  final int questionPosition;
  final int challengePosition;
  final List<GetChallengeData> getChallengeData;

  final List<GetFriendsData> arrFriends;

  HomePage(
      {Key key,
      this.initialPageType,
      this.questionDataHomeScr,
      this.questionDataSituation,
      this.value,
      this.arrFriends,
      this.friendId,
      this.questionPosition,
      this.challengePosition,
      this.getChallengeData})
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

//    print("home_init");

    initStreamController();

    initCheckNetworkConnectivity();

    setSelectedIndex();

    if (widget.initialPageType != 12 && widget.initialPageType != 13 ||
        widget.initialPageType != 6) {
      getCustomerValues();
//      getPendingChallenges();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {}
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Injector.isBusinessMode ? DashboardNewPage() : DashboardPage();
      case 1:
        return BusinessSectorPage();
      case 2:
        return NewCustomerPage();
      case 3:
        return ExistingCustomerPage();
      case 4:
        return /*RewardsPage()*/ Container();
      case 5:
        return /*TeamPage()*/ Container();
      case 6:
        return /*ChallengesPage()*/ Container();
      case 7:
        return Injector.isBusinessMode ? OrganizationsPage2() : PowerUpsPage();
      case 8:
        return /*PLPage()*/ Container();
      case 9:
        return RankingPage();
      case 10:
        return ProfilePage();
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
      setState(() => _selectedDrawerIndex = 10);
    }
  }

  _onSelectItem(int index) {
    Utils.playClickSound();

    if (mounted) {
      setState(() => _selectedDrawerIndex = index);

      if (index == Const.typePL || index == Const.typeTeam) {
        Utils.showComingSoonDialog(context);
      } else {
        Navigator.of(context).pop(); // close the drawer
        if (_selectedDrawerIndex == Const.typeHelp) {
          Navigator.push(context, FadeRouteIntro());
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
          HeaderView(
            scaffoldKey: _scaffoldKey,
            isShowMenu: true,
            openProfile: openProfile,
          ),
          CommonView.showCircularProgress(isLoading)
        ],
      )),
    );
  }

  showMainItem(DrawerItem item, int i) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
              height: Injector.isBusinessMode ? 45 : 40,
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
    if (_selectedDrawerIndex == Const.typeEngagement)
      return EngagementCustomer(
          questionDataEngCustomer: widget.questionDataHomeScr,
          getChallengeData: widget.getChallengeData,
          challengePosition: widget.challengePosition,
          questionPosition: widget.questionPosition);
    else if (_selectedDrawerIndex == Const.typeCustomerSituation)
      return CustomerSituationPage(
        questionDataCustomerSituation: widget.questionDataSituation,
        getChallengeData: widget.getChallengeData,
        challengePosition: widget.challengePosition,
        questionPosition: widget.questionPosition,
      );
    else if (_selectedDrawerIndex == Const.typeChallenges)
      return ChallengesPage(
        arrFriends: widget.arrFriends,
        userId: widget.friendId,
      );
    else
      return _getDrawerItemWidget(_selectedDrawerIndex);
  }

  void getCustomerValues() {
    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    WebApi()
        .getCustomerValue(context, rq.toJson())
        .then((customerValueData) async {
      if (customerValueData != null) {
        await Injector.prefs.setString(PrefKeys.customerValueData,
            json.encode(customerValueData.toJson()));

        Injector.customerValueData = customerValueData;

        Injector.streamController?.add("This a test data");
      }
    }).catchError((e) {
      print(e);
//      setState(() {
//        isLoading = false;
//      });
      Utils.showToast(e.toString());
    });
  }

  void setSelectedIndex() {
    _selectedDrawerIndex = widget.initialPageType != null
        ? widget.initialPageType
        : Const.typeHome;
  }

  void initStreamController() {
    if (Injector.streamController == null)
      Injector.streamController = StreamController.broadcast();

    Injector.streamController.stream.listen((data) {
      if (mounted) {
        setState(() {});
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
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
        setState(() {
          isLoading = true;
        });

        GetChallengesRequest rq = GetChallengesRequest();
        rq.userId = Injector.userData.userId;
        rq.challengeId = 0;

        WebApi().getChallenges(context, rq).then((response) {
          setState(() {
            isLoading = false;
          });

          if (response != null) {
            if (response.flag == "true") {
              if (response.data.length > 0)
                showChallengeQuestionDialog(_scaffoldKey, response.data);
            } else {
              Utils.showToast(response.msg);
            }
          }
        }).catchError((e) {
          Utils.showToast(e.toString());

          setState(() {
            isLoading = false;
          });
        });
      }
    });
  }

  static showChallengeQuestionDialog(
    GlobalKey<ScaffoldState> _scaffoldKey,
    List<GetChallengeData> data,
  ) async {
    await showDialog(
        context: _scaffoldKey.currentContext,
        builder: (BuildContext context) => EngagementCustomer(
            questionDataEngCustomer: data[0].challenge[0],
            challengePosition: 0,
            questionPosition: 0,
            getChallengeData: data));
  }

  void initDrawerItems() {
    drawerItems = [
      DrawerItem(Utils.getText(context, StringRes.home),
          Injector.isBusinessMode ? "main_screen_icon" : "ic_home_prof"),
      DrawerItem(
          Utils.getText(context, StringRes.businessSector),
          Injector.isBusinessMode
              ? "business_sectors"
              : "ic_pro_business_sectors"),
      DrawerItem(Utils.getText(context, StringRes.newCustomers),
          Injector.isBusinessMode ? "new-customer" : "ic_pro_new_cutomer"),
      DrawerItem(Utils.getText(context, StringRes.existingCustomers),
          Injector.isBusinessMode ? "existing" : "ic_pro_existing_cust"),
      DrawerItem(Utils.getText(context, StringRes.rewards),
          Injector.isBusinessMode ? "rewards" : "ic_pro_award"),
      DrawerItem(Utils.getText(context, StringRes.team),
          Injector.isBusinessMode ? "team" : "ic_pro_team"),
      DrawerItem(Utils.getText(context, StringRes.challenges),
          Injector.isBusinessMode ? "challenges" : "ic_pro_challenge"),
      DrawerItem(Utils.getText(context, StringRes.organizations),
          Injector.isBusinessMode ? "organization" : "ic_pro_organization"),
      DrawerItem(Utils.getText(context, StringRes.pl),
          Injector.isBusinessMode ? "profit-loss" : "ic_pro_pl"),
      DrawerItem(Utils.getText(context, StringRes.ranking),
          Injector.isBusinessMode ? "ranking" : "ic_pro_ranking"),
      DrawerItem(Utils.getText(context, StringRes.profile),
          Injector.isBusinessMode ? "profile_icon" : "ic_profile_prof"),
      DrawerItem(Utils.getText(context, StringRes.help),
          Injector.isBusinessMode ? "help_icon" : "help_icon"),
    ];
  }
}
