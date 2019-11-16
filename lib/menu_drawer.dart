import 'package:flutter/material.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:ke_employee/organization.dart';
import 'package:ke_employee/ranking.dart';
import 'package:ke_employee/rewards.dart';
import 'package:ke_employee/team.dart';

import 'P+L.dart';
import 'business_sector.dart';
import 'commonview/header.dart';
import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/res.dart';

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
          Utils.getText(context, StringRes.organizations), "organization"),
      DrawerItem(Utils.getText(context, StringRes.pl), "profit-loss"),
      DrawerItem(Utils.getText(context, StringRes.ranking), "ranking"),
      DrawerItem(Utils.getText(context, StringRes.rewards), "rewards"),
      DrawerItem(
          Utils.getText(context, StringRes.businessSector), "business_sectors"),
      DrawerItem(
          Utils.getText(context, StringRes.existingCustomers), "existing"),
      DrawerItem(Utils.getText(context, StringRes.challenges), "challenges"),
      DrawerItem(
          Utils.getText(context, StringRes.newCustomers), "new-customer"),
      DrawerItem(Utils.getText(context, StringRes.team), "team"),
    ];


    if(widget.initialPosition==Const.typeOrg)
      _selectedDrawerIndex = 0;
    else if(widget.initialPosition==Const.typePL)
      _selectedDrawerIndex = 1;
     else if(widget.initialPosition==Const.typeRanking)
      _selectedDrawerIndex = 2;
     else if(widget.initialPosition==Const.typeReward)
      _selectedDrawerIndex = 3;
     else if(widget.initialPosition==Const.typeBusinessSector)
      _selectedDrawerIndex = 4;
     else if(widget.initialPosition==Const.typeExistingCustomer)
      _selectedDrawerIndex = 5;
     else if(widget.initialPosition==Const.typeChallenges)
      _selectedDrawerIndex = 6;
     else if(widget.initialPosition==Const.typeNewCustomer)
      _selectedDrawerIndex = 7;
     else if(widget.initialPosition==Const.typeTeam)
      _selectedDrawerIndex = 8;

//    _selectedDrawerIndex = widget.initialPosition;
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new OrganizationsPage();
      case 1:
        return new PLPage();
      case 2:
        return new RankingPage();
      case 3:
        return new RewardsPage();
      case 4:
        return new BusinessSectorPage();
      case 5:
        return new ExistingCustomerPage();
      case 6:
        return new ChallengesPage();
      case 7:
        return new NewCustomerPage();
      case 8:
        return new TeamPage();
      default:
        return new Text("Error");
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
        title: showMainItem(drawerItems[i]),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      key: _scaffoldKey,
      drawer: new SizedBox(
        width: Utils.getDeviceWidth(context) / 2.5,
        child: Drawer(
          child: Container(
            color: ColorRes.bgMenu,
            child: new ListView(children: drawerOptions),
          ),
        ),
      ),
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          HeaderView(
            scaffoldKey: _scaffoldKey,
            isShowMenu: true,
          ),
          Expanded(
            child: _getDrawerItemWidget(_selectedDrawerIndex),
          ),

        ],
      )),
    );
  }

  showMainItem(DrawerItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_menu")),
              fit: BoxFit.fill)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(item.icon)),
              height: 50,
              width: 80,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(color: ColorRes.colorPrimary, fontSize: 18),
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
}
