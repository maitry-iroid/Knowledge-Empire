import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/commonview/challenge_header.dart';
import 'package:ke_employee/commonview/dummy_header.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/ResponsiveUi.dart';
import 'package:ke_employee/helper/home_utils.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/listItem/menu_item.dart';
import 'package:ke_employee/models/drawer_item.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/privay_policy.dart';
import 'package:ke_employee/screens/achievement.dart';
import 'package:ke_employee/screens/challenges.dart';
import 'package:ke_employee/screens/customer_situation.dart';
import 'package:ke_employee/screens/dashboard_game.dart';
import 'package:ke_employee/screens/dashboard_prof.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/screens/existing_customers.dart';
import 'package:ke_employee/screens/help_screen.dart';
import 'package:ke_employee/screens/new_customer.dart';
import 'package:ke_employee/screens/organization.dart';
import 'package:ke_employee/screens/powerups.dart';
import 'package:ke_employee/screens/profile.dart';
import 'package:ke_employee/screens/ranking.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';
import 'package:ke_employee/screens/rewards.dart';
import 'package:ke_employee/screens/team.dart';

import '../commonview/header.dart';
import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/res.dart';
import '../helper/string_res.dart';
import '../models/get_friends.dart';
import 'P+L.dart';
import 'business_sector.dart';

/*
*  created by Riddhi
*
* This class contained menu drawer in left side, and Common header, Basic feature logic are added here like
*  Lock- unlock status, intro dialog status, customer value Header data, push notification setup
*
* */

class FadeRouteHome extends PageRouteBuilder {
  List<GetFriendsData> arrFriends = List();

  FadeRouteHome()
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => HomePage(),
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
              FadeTransition(opacity: animation, child: HomePage()),
        );
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver, TickerProviderStateMixin implements RefreshAnimation {
  bool startAnim = false;
  int duration = 1;
  bool isCoinVisible = false;

  HomeData homeData;

  RefreshAnimation mRefreshAnimation;

  @override
  void initState() {
    super.initState();
    mRefreshAnimation = this;
    initStateMethods();
    HomeUtils.initHome(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("---------------------------App state ::: $state-------------------------------");
    if (state == AppLifecycleState.resumed) {
      Utils.removeBadge();
      apiCallPrivacyPolicy(Injector.userData.userId, Const.typeGetPrivacyPolicy.toString(), Injector.userData.activeCompany, (response) {
        if (response.isSeenPrivacyPolicy == 0) {
          Injector.userData.isSeenPrivacyPolicy = 0;
          Injector.setUserData(Injector.userData, false);
        }
        Injector.checkPrivacyPolicy(HomeUtils.scaffoldKey, context);
      });
      if (Injector.isSoundEnable != null && Injector.isSoundEnable) {
        //TODO AUDIO
        // Injector.isBusinessMode ? Injector.audioPlayerBg.resume() : Injector.audioPlayerBg.stop();
      }
    } else if (state == AppLifecycleState.inactive) {
      Injector.performAudioAction(Const.pause);
    } else if (state == AppLifecycleState.paused) {
      Injector.updateIntroData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: navigationBloc?.navigationKey,
        builder: (context, AsyncSnapshot<HomeData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: ColorRes.white,
            );
          } else if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
            homeData = snapshot.data;
            HomeUtils.currentPage = snapshot.data.initialPageType;
            getAnimationStatus();

            return mainLayout(context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Container();
          }
        });
  }

  Widget mainLayout(BuildContext context) {
    return ResponsiveUi(
      builder: (context, size) {
        return Scaffold(
          key: HomeUtils.scaffoldKey,
          drawer: new SizedBox(
            width: Utils.getDeviceWidth(context) / 2.5,
            child: Drawer(
                child: Container(
              color: Injector.isBusinessMode ? ColorRes.bgMenu : ColorRes.headerBlue,
              child: new ListView(children: getDrawerOptions()),
            )),
          ),
          backgroundColor: ColorRes.colorBgDark,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                getDrawerItemWidget(),
                buildHeaderView(),
                coinAnimation(),

                // animatedPositioned(size, HeaderUtils.getHeaderIcon(Const.typeEmployee),   3.16,employeeDrainNotifier),
                //animatedPositioned(size, HeaderUtils.getHeaderIcon(Const.typeSalesPersons),   2.38,saleDrainNotifier),
                // animatedPositioned(size, HeaderUtils.getHeaderIcon(Const.typeServicesPerson),   1.78,serviceDrainNotifier),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget animatedPositioned(Size size, String icon, double left, valueListenable) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (BuildContext context, value, Widget child) {
        return AnimatedPositioned(
          top: value ? 50.0 : size.height / 29,
          left: size.width / left,
          duration: Duration(milliseconds: value ? 400 : 0),
          onEnd: () {
            valueListenable.value = false;
            valueListenable.notifyListeners();
          },
          child: Container(
            width: 26.0,
            height: 26.0,
            child: AnimatedOpacity(
                duration: Duration(milliseconds: value ? 400 : 0),
                opacity: value ? 0.0 : 1.0,
                child: Image.asset(Utils.getAssetsImg(icon), width: 26, height: 26)),
          ),
        );
      },
    );
  }

  Widget getDrawerItemWidget() {
    if (HomeUtils.currentPage == Const.typeHome) {
      return Injector.isBusinessMode ? DashboardGamePage() : DashboardProfPage();
    } else if (HomeUtils.currentPage == Const.typeBusinessSector) {
      return BusinessSectorPage();
    } else if (HomeUtils.currentPage == Const.typeNewCustomer) {
      return NewCustomerPage();
    } else if (HomeUtils.currentPage == Const.typeExistingCustomer) {
      return ExistingCustomerPage();
    } else if (HomeUtils.currentPage == Const.typeTeam) {
      return TeamPage();
    } else if (HomeUtils.currentPage == Const.typeChallenges) {
      return ChallengesPage(homeData: homeData);
    } else if (HomeUtils.currentPage == Const.typeAchievement) {
      return AchievementPage();
    } else if (HomeUtils.currentPage == Const.typeReward) {
      return RewardsPage();
    } else if (HomeUtils.currentPage == Const.typeOrg) {
      return Injector.isBusinessMode ? OrganizationsPage2(mRefreshAnimation: mRefreshAnimation) : PowerUpsPage(mRefreshAnimation: mRefreshAnimation);
    } else if (HomeUtils.currentPage == Const.typeRanking) {
      return RankingPage();
    } else if (HomeUtils.currentPage == Const.typePl) {
      return PLPage();
    } else if (HomeUtils.currentPage == Const.typeProfile) {
      return ProfilePage();
    } else if (HomeUtils.currentPage == Const.typeEngagement) {
      return EngagementCustomer(homeData: homeData);
    } else if (HomeUtils.currentPage == Const.typeCustomerSituation) {
      return CustomerSituationPage(homeData: homeData, mRefreshAnimation: mRefreshAnimation);
    } else if (HomeUtils.currentPage == Const.typeCustomerSituation) {
      return ProfilePage();
    } else {
      return Injector.isBusinessMode ? DashboardGamePage() : DashboardProfPage();
    }
  }

  Widget buildHeaderView() {
    return ValueListenableBuilder(
      valueListenable: HomeUtils.headerNotifier,
      builder: (BuildContext context, value, Widget child) {
        print(value);
        return Stack(
          children: <Widget>[
            HeaderView(
                scaffoldKey: HomeUtils.scaffoldKey,
                isShowMenu: true,
                isChallenge: homeData.isChallenge,
                currentIndex: homeData != null && homeData.questionHomeData != null && homeData.questionHomeData.questionCurrentIndex != null
                    ? homeData.questionHomeData.questionCurrentIndex
                    : 0,
                challengeCount: homeData != null && homeData.questionHomeData != null && homeData.questionHomeData.totalQuestion != null
                    ? homeData.questionHomeData.totalQuestion
                    : 0),
            value
                ? DummyView(
                    scaffoldKey: HomeUtils.scaffoldKey,
                    isShowMenu: true,
                    isChallenge: homeData.isChallenge,
                    currentIndex: homeData != null && homeData.questionHomeData != null && homeData.questionHomeData.questionCurrentIndex != null
                        ? homeData.questionHomeData.questionCurrentIndex
                        : 0,
                    challengeCount: homeData != null && homeData.questionHomeData != null && homeData.questionHomeData.totalQuestion != null
                        ? homeData.questionHomeData.totalQuestion
                        : 0)
                : Container(),
          ],
        );
      },
    );
  }

  Widget coinAnimation() {
    return Stack(
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
        coinWidget(350, 650)
      ],
    );
  }

  Widget coinWidget(double top, double left) {
    return AnimatedPositioned(
      duration: Duration(seconds: duration),
      top: !isCoinVisible ? top : 5,
      left: !isCoinVisible ? left : Utils.getDeviceWidth(context) / 1.1,
      onEnd: () {
        print("=====HONEY====COINANIMATION====");
        isCoinVisible = false;
        if (Injector.customerValueData != null) customerValueBloc.setCustomerValue(Injector.customerValueData);
        homeData.isCameFromNewCustomer = false;
        setState(() {});
      },
      child: Container(
        child: isCoinVisible ? MyHomePage(isCoinViseble: isCoinVisible) : Container(),
        width: 40,
        height: 40,
      ),
    );
  }

  void getAnimationStatus() {
    bool first = false;
    bool second = false;
    if (homeData != null) {
      print(homeData);
      first = HomeUtils.currentPage == Const.typeCustomerSituation &&
          ((homeData.isCameFromNewCustomer != null && homeData.isCameFromNewCustomer && homeData.questionHomeData.isAnsweredCorrect == 1));
      second = homeData.isChallenge != null && homeData.isChallenge && homeData.questionHomeData != null
          ? homeData.questionHomeData.isAnsweredCorrect != null
              ? homeData.questionHomeData.isAnsweredCorrect == 1
              : false
          : false;
    }
    if (first || second) {
      if (!homeData.isChallenge || (Injector.countList.length == homeData.questionHomeData.questionCurrentIndex)) {
        int index = Injector.countList.indexWhere(
            (QuestionCountWithData mQuestionCountWithData) => mQuestionCountWithData.isCorrect != null ? !mQuestionCountWithData.isCorrect : false);
        if (homeData.isCameFromNewCustomer || index == -1) {
          isCoinVisible = true;
        }
      }
    } else
      isCoinVisible = false;
  }

  void initStateMethods() async {
    HomeUtils.callDashboardStatusApi();

    // HomeUtils.callVersionApi(context);

    HomeUtils.initPush(context);

    // localeBloc.setLocale(Utils.getIndexLocale(Injector.userData.language));

    HomeUtils.initPendingChallengeStream(context);

    Utils.callCustomerValuesApi();

    await Utils.playBackgroundMusic();

    WidgetsBinding.instance.addObserver(this);
    HomeUtils.initCheckNetworkConnectivity(context);

    HomeUtils.initPlatformState();

    Utils.removeBadge();

    navigationBloc.updateNavigation(HomeData(initialPageType: HomeUtils.currentPage));
  }

  void onSelectItem(DrawerItem item) {
    Utils.playClickSound();
    if (HomeUtils.scaffoldKey.currentState.isDrawerOpen) {
      HomeUtils.scaffoldKey.currentState.openEndDrawer();
    }
    if (HomeUtils.currentPage != item.key) {
      if (item.key == Const.typeHelp) {
        if (Injector.isBusinessMode) {
          Navigator.push(context, FadeRouteIntro());
        } else {
          navigationBloc.updateNavigation(HomeData(initialPageType: Const.typeHome));
          DisplayDialogs.professionalDialog(context);
        }
      } else
        Utils.performDashboardItemClick(context, item.key);
    }
  }

  @override
  void dispose() {
    // Injector.homeStreamController.close();
    HomeUtils.connectivitySubscription?.cancel();
    HomeUtils.headerNotifier.removeListener(() {});
    super.dispose();
  }

  @override
  onRefreshAchievement(int type) {
    Future.delayed(const Duration(milliseconds: 500), () {
      try {
        HomeUtils.headerNotifier.value = true;
        HomeUtils.headerNotifier.notifyListeners();
        if (type == Const.typeHR) {
          empAnimTimer = Timer.periodic(Duration(milliseconds: 400), (_) {
            employeeDrainNotifier.value = true;
            employeeDrainNotifier.notifyListeners();
          });
          Timer(Duration(seconds: 3), () {
            if (empAnimTimer != null) {
              empAnimTimer.cancel();
              HomeUtils.headerNotifier.value = false;
              HomeUtils.headerNotifier.notifyListeners();
            }
          });
        } else if (type == Const.typeSales) {
          saleAnimTimer = Timer.periodic(Duration(milliseconds: 400), (_) {
            saleDrainNotifier.value = true;
            saleDrainNotifier.notifyListeners();
          });
          Timer(Duration(seconds: 3), () {
            if (saleAnimTimer != null) {
              saleAnimTimer.cancel();
              HomeUtils.headerNotifier.value = false;
              HomeUtils.headerNotifier.notifyListeners();
            }
          });
        } else if (type == Const.typeServices) {
          serviceAnimTimer = Timer.periodic(Duration(milliseconds: 400), (_) {
            serviceDrainNotifier.value = true;
            serviceDrainNotifier.notifyListeners();
          });
          Timer(Duration(seconds: 3), () {
            if (serviceAnimTimer != null) {
              serviceAnimTimer.cancel();
              HomeUtils.headerNotifier.value = false;
              HomeUtils.headerNotifier.notifyListeners();
            }
          });
        } else {
          HomeUtils.headerNotifier.value = false;
          HomeUtils.headerNotifier.notifyListeners();
        }
      } catch (e) {
        print(e);
      }
    });
  }

  getDrawerOptions() {
    var drawerOptions = <Widget>[];
    List<DrawerItem> drawerItems = initDrawerItems();
    drawerOptions = new List();
    for (var i = 0; i < drawerItems.length; i++) {
      drawerOptions.add(new ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          title: MenuItem(drawerItems[i], HomeUtils.currentPage),
          selected: drawerItems[i].key == HomeUtils.currentPage,
          onTap: () => onSelectItem(drawerItems[i])));
    }
    return drawerOptions;
  }

  List<DrawerItem> initDrawerItems() {
    List<DrawerItem> drawerItems = List();

    drawerItems.add(DrawerItem(Utils.getText(context, StringRes.home), Injector.isBusinessMode ? "main_screen_icon" : "ic_pro_home", Const.typeHome));

    drawerItems.add(DrawerItem(Utils.getText(context, StringRes.businessSector),
        Injector.isBusinessMode ? "business_sectors" : "ic_pro_home_business", Const.typeBusinessSector));

    drawerItems.add(DrawerItem(
        Utils.getText(context, StringRes.newCustomers), Injector.isBusinessMode ? "new-customer" : "ic_pro_home_customer", Const.typeNewCustomer));

    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.existingCustomers), Injector.isBusinessMode ? "existing" : "ic_pro_home_exis_customer",
          Const.typeExistingCustomer),
    );

    if (Utils.isFeatureOn(Const.typeAchievement))
      drawerItems.add(
        DrawerItem(
            Utils.getText(context, StringRes.achievement), Injector.isBusinessMode ? "rewards" : "ic_pro_home_achievement", Const.typeAchievement),
      );

    if (Utils.isFeatureOn(Const.typeReward))
      drawerItems.add(
        DrawerItem(Utils.getText(context, StringRes.rewards), Injector.isBusinessMode ? "ic_gift_drawer" : "ic_pro_home_rewards", Const.typeReward),
      );

    if (Injector.isManager() && Utils.isFeatureOn(Const.typeTeam))
      drawerItems.add(
        DrawerItem(Utils.getText(context, StringRes.team), Injector.isBusinessMode ? "team" : "ic_pro_home_team", Const.typeTeam),
      );

    if (Utils.isFeatureOn(Const.typeChallenges))
      drawerItems.add(
        DrawerItem(
            Utils.getText(context, StringRes.challenges), Injector.isBusinessMode ? "challenges" : "ic_pro_home_challenges", Const.typeChallenges),
      );

    if (Utils.isFeatureOn(Const.typeOrg))
      drawerItems.add(
        DrawerItem(
            Utils.getText(context, StringRes.organizations), Injector.isBusinessMode ? "organization" : "ic_pro_home_organization", Const.typeOrg),
      );

    if (Utils.isFeatureOn(Const.typePl))
      drawerItems.add(
        DrawerItem(Utils.getText(context, StringRes.pl), Injector.isBusinessMode ? "profit-loss" : "ic_pro_home_pl", Const.typePl),
      );

    if (Utils.isFeatureOn(Const.typeRanking))
      drawerItems
          .add(DrawerItem(Utils.getText(context, StringRes.ranking), Injector.isBusinessMode ? "ranking" : "ic_pro_home_ranking", Const.typeRanking));

    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.profile), Injector.isBusinessMode ? "profile_icon" : "ic_pro_profile", Const.typeProfile),
    );

    drawerItems.add(
      DrawerItem(Utils.getText(context, StringRes.help), Injector.isBusinessMode ? "help_icon" : "ic_pro_help", Const.typeHelp),
    );
    return drawerItems;
  }
}
