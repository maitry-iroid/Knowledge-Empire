import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/header.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/menu_drawer.dart';

import 'helper/constant.dart';

class DashboardNewPage extends StatefulWidget {
  DashboardNewPage({Key key}) : super(key: key);

  DashboardNewPageState createState() => DashboardNewPageState();
}

class DashboardNewPageState extends State<DashboardNewPage> {
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
                  height: Utils.getDeviceHeight(context) / 2.8,
                ),
                onTap: () {
                  performItemClick(Const.typeBusinessSector);
                }),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 4,
            left: Utils.getDeviceWidth(context) / 6,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("rewards")),
                height: Utils.getDeviceHeight(context) / 3.2,
              ),
              onTap: () {
                performItemClick(Const.typeReward);
              },
            ),
          ),
          Positioned(
            top: 40,
            left: Utils.getDeviceWidth(context) / 1.66,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("ranking")),
                height: Utils.getDeviceHeight(context) / 2.8,
              ),
              onTap: () {
                performItemClick(Const.typeRanking);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: Utils.getDeviceWidth(context) / 1.62,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("organization")),
                height: Utils.getDeviceHeight(context) / 2.7,
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
                height: Utils.getDeviceHeight(context)/2.8,
              ),
              onTap: () {
                performItemClick(Const.typePL);
              },
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 4,
            left: Utils.getDeviceWidth(context) / 2.4,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("team")),
                height: Utils.getDeviceHeight(context)/3.2,
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
                  height: Utils.getDeviceHeight(context)/2.5,
                ),
                onTap: () {
                  performItemClick(Const.typeNewCustomer);
                }),
          ),
          Positioned(
              bottom: 0,
              left: Utils.getDeviceWidth(context) / 1.4,
              child: InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("existing")),
                    height: Utils.getDeviceHeight(context) / 3.1,
                  ),
                  onTap: () {
                    performItemClick(Const.typeExistingCustomer);
                  })),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 5,
            left: Utils.getDeviceWidth(context) / 1.5,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("challenges")),
                  height: Utils.getDeviceHeight(context) / 3,
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
