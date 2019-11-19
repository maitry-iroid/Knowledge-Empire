import 'package:flutter/material.dart';
import 'package:ke_employee/challenges.dart';
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
          Utils.getText(context, StringResBusiness.home), "organization"),
      DrawerItem(Utils.getText(context, StringResBusiness.businessSector),
          "business_sectors"),
      DrawerItem(Utils.getText(context, StringResBusiness.newCustomers),
          "new-customer"),
      DrawerItem(Utils.getText(context, StringResBusiness.existingCustomers),
          "existing"),
      DrawerItem(Utils.getText(context, StringResBusiness.rewards), "rewards"),
      DrawerItem(Utils.getText(context, StringResBusiness.team), "team"),
      DrawerItem(
          Utils.getText(context, StringResBusiness.challenges), "challenges"),
      DrawerItem(Utils.getText(context, StringResBusiness.organizations),
          "organization"),
      DrawerItem(Utils.getText(context, StringResBusiness.pl), "profit-loss"),
      DrawerItem(Utils.getText(context, StringResBusiness.ranking), "ranking"),
      DrawerItem(Utils.getText(context, StringResBusiness.profile), "team"),
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
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new DashboardNewPage();
      case 1:
        return new BusinessSectorPage();
      case 2:
        return new NewCustomerPage();
      case 3:
        return new ExistingCustomerPage();
      case 4:
        return new RewardsPage();
      case 5:
        return new TeamPage();
      case 6:
        return new ChallengesPage();
      case 7:
        return new OrganizationsPage();
      case 8:
        return new PLPage();
      case 9:
        return new RankingPage();
      case 10:
        return new ProfilePage();
      default:
        return new Text("Error");
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
            border: i == _selectedDrawerIndex
                ? Border.all(
                    color: ColorRes.white,
                    width: 1,
                  )
                : null,
            borderRadius: BorderRadius.circular(10),
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_menu")),
                    fit: BoxFit.fill)
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage(Utils.getAssetsImg(item.icon)),
                height: Injector.isBusinessMode ? 45 : 40,
                width: 80,
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
