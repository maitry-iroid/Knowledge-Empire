import 'package:flutter/material.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/dashboard.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:ke_employee/organization.dart';
import 'package:ke_employee/profile.dart';
import 'package:ke_employee/ranking.dart';
import 'package:ke_employee/rewards.dart';
import 'package:ke_employee/team.dart';
import 'package:notifier/main_notifier.dart';

import 'P+L.dart';
import 'business_sector.dart';
import 'commonview/header.dart';
import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/res.dart';
import 'helper/string_res.dart';
import 'Customer_Situation.dart';
import 'engagement_customer.dart';
import 'Debrief.dart';

class DrawerItem {
  String title;
  String icon;

  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.initialPosition}) : super(key: key);
  final int initialPosition;

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

List<DrawerItem> drawerItems;

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drawerItems = [
      DrawerItem(
          Utils.getText(context, StringRes.home), Injector.isBusinessMode ? "main_screen_icon" : "main_screen_icon"),
      DrawerItem(Utils.getText(context, StringRes.businessSector), Injector.isBusinessMode ? "business_sectors" : "ic_pro_business_sectors"),
      DrawerItem(Utils.getText(context, StringRes.newCustomers), Injector.isBusinessMode ? "new-customer" :  "ic_pro_new_cutomer"),
      DrawerItem(Utils.getText(context, StringRes.existingCustomers), Injector.isBusinessMode ? "existing" : "ic_pro_existing_cust"),
      DrawerItem(Utils.getText(context, StringRes.rewards), Injector.isBusinessMode ? "rewards" : "ic_pro_award"),
      DrawerItem(Utils.getText(context, StringRes.team), Injector.isBusinessMode ? "team" : "ic_pro_team"),
      DrawerItem(
          Utils.getText(context, StringRes.challenges), Injector.isBusinessMode ? "challenges" : "ic_pro_challenge"),
      DrawerItem(Utils.getText(context, StringRes.organizations), Injector.isBusinessMode ? "organization" : "ic_pro_organization"),
      DrawerItem(Utils.getText(context, StringRes.pl), Injector.isBusinessMode ? "profit-loss" : "ic_pro_pl"),
      DrawerItem(Utils.getText(context, StringRes.ranking), Injector.isBusinessMode ? "ranking" : "ic_pro_ranking"),
      DrawerItem(Utils.getText(context, StringRes.profile), Injector.isBusinessMode ? "profile_icon" : "profile_icon"),
    ];

//    [
//      DrawerItem(
//          Utils.getText(context, StringRes.home), "main_screen_icon"),
//      DrawerItem(Utils.getText(context, StringRes.businessSector),
//          "business_sectors"),
//      DrawerItem(Utils.getText(context, StringRes.newCustomers),
//          "new-customer"),
//      DrawerItem(Utils.getText(context, StringRes.existingCustomers),
//          "existing"),
//      DrawerItem(Utils.getText(context, StringRes.rewards), "rewards"),
//      DrawerItem(Utils.getText(context, StringRes.team), "team"),
//      DrawerItem(
//          Utils.getText(context, StringRes.challenges), "challenges"),
//      DrawerItem(Utils.getText(context, StringRes.organizations),
//          "organization"),
//      DrawerItem(Utils.getText(context, StringRes.pl), "profit-loss"),
//      DrawerItem(Utils.getText(context, StringRes.ranking), "ranking"),
//      DrawerItem(
//          Utils.getText(context, StringRes.profile), "profile_icon"),
//    ];

    Future.delayed(Duration.zero,(){
      drawerItems = [
        DrawerItem(
            Utils.getText(context, StringRes.home), "main_screen_icon"),
        DrawerItem(Utils.getText(context, StringRes.businessSector),
            "business_sectors"),
        DrawerItem(Utils.getText(context, StringRes.newCustomers),
            "new-customer"),
        DrawerItem(Utils.getText(context, StringRes.existingCustomers),
            "existing"),
        DrawerItem(Utils.getText(context, StringRes.rewards), "rewards"),
        DrawerItem(Utils.getText(context, StringRes.team), "team"),
        DrawerItem(
            Utils.getText(context, StringRes.challenges), "challenges"),
        DrawerItem(Utils.getText(context, StringRes.organizations),
            "organization"),
        DrawerItem(Utils.getText(context, StringRes.pl), "profit-loss"),
        DrawerItem(Utils.getText(context, StringRes.ranking), "ranking"),
        DrawerItem(
            Utils.getText(context, StringRes.profile), "profile_icon"),
      ];

      if (widget.initialPosition == Const.typeHome)
        _selectedDrawerIndex = 0;
      else if (widget.initialPosition == Const.typeBusinessSector)
        _selectedDrawerIndex = 1;
      else if (widget.initialPosition == Const.typeNewCustomer)
        _selectedDrawerIndex = 2;
      else if (widget.initialPosition == Const.typeExistingCustomer)
        _selectedDrawerIndex = 3;
      else if (widget.initialPosition == Const.typeReward)
        _selectedDrawerIndex = 4;
      else if (widget.initialPosition == Const.typeTeam)
        _selectedDrawerIndex = 5;
      else if (widget.initialPosition == Const.typeChallenges)
        _selectedDrawerIndex = 6;
      else if (widget.initialPosition == Const.typeOrg)
        _selectedDrawerIndex = 7;
      else if (widget.initialPosition == Const.typePL)
        _selectedDrawerIndex = 8;
      else if (widget.initialPosition == Const.typeRanking)
        _selectedDrawerIndex = 9;
      else if (widget.initialPosition == Const.typeProfile)
        _selectedDrawerIndex = 10;
      else
        _selectedDrawerIndex = 0;
    });

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
        return new EngagementCustomer();
//        return new Customer();
//        return new Debrief();

      case 6:
        return ChallengesPage();
      case 7:
        return OrganizationsPage();
      case 8:
        return PLPage();
      case 9:
        return RankingPage();
      case 10:
        return ProfilePage();
      default:
        return Text("Error");
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
    if (mounted) {
      setState(() => _selectedDrawerIndex = index);
      Navigator.of(context).pop(); // close the drawer
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Notifier.of(context).register<String>('changeMode', (data) {
          return Container(
            color:
                Injector.isBusinessMode ? ColorRes.bgMenu : ColorRes.headerBlue,
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
                      child: _getDrawerItemWidget(_selectedDrawerIndex),
                    ),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    _getDrawerItemWidget(_selectedDrawerIndex),
                    HeaderView(
                      scaffoldKey: _scaffoldKey,
                      isShowMenu: true,
                      openProfile: openProfile,
                    ),
                  ],
                )),
    );
  }

  showMainItem(DrawerItem item, int i) {
    return Notifier.of(context).register<String>('changeMode', (data) {
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
}
