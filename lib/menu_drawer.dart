import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:ke_employee/profile.dart';

import 'business_sector.dart';
import 'commonview/header.dart';
import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/res.dart';
import 'p+L.dart';

class DrawerItem {
  String title;
  String icon;

  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

List<DrawerItem> drawerItems;

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drawerItems = [
      DrawerItem(Utils.getText(context, StringRes.dashboard), "team"),
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
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new DashboardPage();
      case 1:
        return new ProfilePage();
      case 2:
        return new PLPage();
      case 3:
        return new ChallengesPage();
      case 4:
        return new ChallengesPage();
      case 5:
        return new BusinessSectorPage();
      case 6:
        return new ExistingCustomerPage();
      case 7:
        return new ChallengesPage();
      case 8:
        return new NewCustomerPage();
      case 9:
        return new ChallengesPage();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
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
        child: _selectedDrawerIndex == 0
            ? Stack(
                children: <Widget>[
                  _getDrawerItemWidget(_selectedDrawerIndex),
                  HeaderView(),
                ],
              )
            : Column(
                children: <Widget>[
                  HeaderView(),
                  Expanded(
                    child: _getDrawerItemWidget(_selectedDrawerIndex),
                  )
                ],
              ),
      ),
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
              style: TextStyle(color: ColorRes.colorPrimary, fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  getTitle(int type) {
    if (type == Const.typeBusinessSector)
      return "Business Sector";
    else if (type == Const.typeNewCustomer)
      return "New Customers";
    else if (type == Const.typeExistingCustomer)
      return "Existing Customers";
    else if (type == Const.typeOrg)
      return "Organizations";
    else if (type == Const.typeChallenges)
      return "Challenges";
    else if (type == Const.typePL)
      return "P+L";
    else if (type == Const.typeReward)
      return "Rewards";
    else if (type == Const.typeRanking)
      return "Ranking";
    else if (type == Const.typeTeam)
      return "Team";
    else
      return "";
  }

  getImage(int type) {
    if (type == Const.typeBusinessSector)
      return "ic_business";
    else if (type == Const.typeNewCustomer)
      return "ic_new_customer";
    else if (type == Const.typeExistingCustomer)
      return "ic_existing_customer";
    else if (type == Const.typeOrg)
      return "ic_org";
    else if (type == Const.typeChallenges)
      return "ic_ranking";
    else if (type == Const.typePL)
      return "ic_PL";
    else if (type == Const.typeReward)
      return "ic_reward";
    else if (type == Const.typeRanking)
      return "ic_ranking";
    else if (type == Const.typeTeam)
      return "menu_team";
    else
      return "";
  }
}
