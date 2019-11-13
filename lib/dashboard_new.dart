import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/business_sector.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/commonview/header.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/menu_drawer.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:ke_employee/p+L.dart';

import 'helper/constant.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              showMainView(),
              HeaderView(
                isShowMenu: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMainView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("dashboard-background")),
              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            bottom: 0,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("business_sectors")),
                  height: 130,
                ),
                onTap: () {
                  performItemClick(Const.typeBusinessSector);
                }),
          ),
          Positioned(
            bottom: 20,
            left: Utils.getDeviceWidth(context) / 3.7,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("glasses")),
              height: 35,
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 4,
            left: Utils.getDeviceWidth(context) / 8,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("rewards")),
                width: 120,
              ),
              onTap: () {
                performItemClick(Const.typeReward);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 40,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("ranking")),
                width: 220,
              ),
              onTap: () {
                performItemClick(Const.typeRanking);
              },
            ),
          ),
          Positioned(
            top: 40,
            left: 50,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("organization")),
                width: 200,
              ),
              onTap: () {
                performItemClick(Const.typeOrg);
              },
            ),
          ),
          Positioned(
            top: 40,
            left: Utils.getDeviceWidth(context) / 3,
            right: Utils.getDeviceWidth(context) / 2.9,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("profit-loss")),
                height: 150,
              ),
              onTap: () {
                performItemClick(Const.typePL);
              },
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 5,
            left: Utils.getDeviceWidth(context) / 2.5,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("team")),
                height: 130,
              ),
              onTap: () {
                performItemClick(Const.typeTeam);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: Utils.getDeviceWidth(context) / 2.8,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("new-customer")),
                  height: 160,
                ),
                onTap: () {
                  performItemClick(Const.typeNewCustomer);
                }),
          ),
          Positioned(
              bottom: 0,
              right: 20,
              child: InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("existing")),
                    width: 180,
                  ),
                  onTap: () {
                    performItemClick(Const.typeExistingCustomer);
                  })),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 5,
            right: Utils.getDeviceWidth(context) / 13,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("challenges")),
                  width: 180,
                ),
                onTap: () {
                  performItemClick(Const.typeChallenges);
                }),
          )
        ],
      ),
    );
  }

  performItemClick(int type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  initialPosition: type,
                )));
  }
}
