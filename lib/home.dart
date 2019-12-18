import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/customer_situation.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/dashboard.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/engagement_customer.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/help.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/intro_screen.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:ke_employee/organization.dart';
import 'package:ke_employee/powerups.dart';
import 'package:ke_employee/profile.dart';
import 'package:ke_employee/ranking.dart';
import 'package:ke_employee/rewards.dart';
import 'package:ke_employee/team.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';

import 'Debrief.dart';
import 'P+L.dart';
import 'business_sector.dart';
import 'commonview/header.dart';
import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';

class HomePage extends StatefulWidget {
  final int initialPageType;

  final QuestionData questionDataHomeScr;
  final QuestionData questionDataSituation;

  HomePage(
      {Key key,
      this.initialPageType,
      this.questionDataHomeScr,
      this.questionDataSituation})
      : super(key: key);

//  final  QuestionData questionData;
//
//  HomePage({Key key, this.questionData}) : super(key: key);

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
  Notifier _notifier;
  int _selectedDrawerIndex = 0;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _notifier = NotifierProvider.of(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        Utils.showToast(result.toString());

        Utils.callSubmitAnswerApi(context, _notifier);
      }
    });

    if (widget.initialPageType == Const.typeHome)
      _selectedDrawerIndex = 0;
    else if (widget.initialPageType == Const.typeBusinessSector)
      _selectedDrawerIndex = 1;
    else if (widget.initialPageType == Const.typeNewCustomer)
      _selectedDrawerIndex = 2;
    else if (widget.initialPageType == Const.typeExistingCustomer)
      _selectedDrawerIndex = 3;
    else if (widget.initialPageType == Const.typeReward)
      _selectedDrawerIndex = 4;
    else if (widget.initialPageType == Const.typeTeam)
      _selectedDrawerIndex = 5;
    else if (widget.initialPageType == Const.typeChallenges)
      _selectedDrawerIndex = 6;
    else if (widget.initialPageType == Const.typeOrg)
      _selectedDrawerIndex = 7;
    else if (widget.initialPageType == Const.typePL)
      _selectedDrawerIndex = 8;
    else if (widget.initialPageType == Const.typeRanking)
      _selectedDrawerIndex = 9;
    else if (widget.initialPageType == Const.typeProfile)
      _selectedDrawerIndex = 10;
    else if (widget.initialPageType == Const.typeHelp)
      _selectedDrawerIndex = 11;
    else if (widget.initialPageType == Const.typeEngagement)
      _selectedDrawerIndex = 12;
    else if (widget.initialPageType == Const.typeDebrief)
      _selectedDrawerIndex = 13;
    else
      _selectedDrawerIndex = 0;

    getCustomerValues();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription?.cancel();
    _notifier.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
//    if (state == AppLifecycleState.resumed) {
////
//    } else if (state == AppLifecycleState.inactive) {
////      Utils.showToast("inactive");
//
//
//    }
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
        return RewardsPage();
      case 5:
        return TeamPage();
      case 6:
        return ChallengesPage();
      case 7:
        return Injector.isBusinessMode?OrganizationsPage():PowerUpsPage();
      case 8:
        return PLPage();
      case 9:
        return RankingPage();
      case 10:
        return ProfilePage();
//      case 11:
//        return IntroPage();
      default:
        return Text("");
    }
  }

  openProfile() {
//    _onSelectItem(10);

    if (mounted) {
      setState(() => _selectedDrawerIndex = 10);
//      Navigator.of(context).pop(); // close the drawer
    }
  }

  _onSelectItem(int index) {
    Utils.playClickSound();

    if (mounted) {
//      Injector.audioPlayer.play("assets/sounds/all_button_clicks.wav",isLocal: true);

      setState(() => _selectedDrawerIndex = index);
      Navigator.of(context).pop(); // close the drawer
    }
  }

  @override
  Widget build(BuildContext context) {
    return Notifier.of(context).register<String>('changeMode', (data) {
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

      var drawerOptions = <Widget>[];
      for (var i = 0; i < drawerItems.length; i++) {
        drawerOptions.add(new ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          title: showMainItem(drawerItems[i], i),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ));
      }

      return new Scaffold(
        key: _scaffoldKey,
        drawer: new SizedBox(
          width: Utils.getDeviceWidth(context) / 2.5,
          child: Drawer(
              child:
                  Notifier.of(context).register<String>('updateHeaderValue', (data) {
            return Container(
              color: Injector.isBusinessMode
                  ? ColorRes.bgMenu
                  : ColorRes.headerBlue,
              child: new ListView(children: drawerOptions),
            );
          })),
        ),
        backgroundColor: ColorRes.colorBgDark,
        body: SafeArea(
            child: _selectedDrawerIndex != 0
                ? Column(
                    children: <Widget>[
                      HeaderView(
                        scaffoldKey: _scaffoldKey,
                        isShowMenu: true,
                        openProfile: openProfile,
                      ),
                      Expanded(
                        child: getPage(),
                      ),
                    ],
                  )
                : Stack(
                    children: <Widget>[
                      getPage(),
                      HeaderView(
                        scaffoldKey: _scaffoldKey,
                        isShowMenu: true,
                        openProfile: openProfile,
                      ),
                    ],
                  )),
      );
    });
  }

  showMainItem(DrawerItem item, int i) {
    return Notifier.of(context).register<String>('updateHeaderValue', (data) {
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
                    image: AssetImage(Utils.getAssetsImg(
                        i == _selectedDrawerIndex
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
    });
  }

  getPage() {
    if (_selectedDrawerIndex == 12)
      return EngagementCustomer(
          questionDataEngCustomer: widget.questionDataHomeScr);
//    return DebriefPage(questionDataCustomerSituation: widget.questionDataHomeScr,);

    else if (_selectedDrawerIndex == 13)
      return CustomerSituationPage(
          questionDataCustomerSituation: widget.questionDataSituation);
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

        try {
            _notifier.notify('updateHeaderValue', 'Sending data from notfier!');
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
