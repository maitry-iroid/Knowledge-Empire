import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_tooltip/flutter_introduction_tooltip.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/home.dart';

import 'helper/constant.dart';

class DashboardNewPage extends StatefulWidget {
  DashboardNewPage({Key key}) : super(key: key);

  DashboardNewPageState createState() => DashboardNewPageState();
}

class DashboardNewPageState extends State<DashboardNewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (Injector.prefs.getInt(PrefKeys.mode) == null) {
      Injector.prefs.setInt(PrefKeys.mode, Const.businessMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              showMainView(),
//              HeaderView(
//                scaffoldKey: _scaffoldKey,
//                isShowMenu: true,
//              ),
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
              image: AssetImage(Utils.getAssetsImg("bg_dashboard_new")),
              fit: BoxFit.fill)),
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            top: 40,
            right: Utils.getDeviceWidth(context) / 10,
            child: Row(
              children: <Widget>[
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("organization")),
                    height: Utils.getDeviceHeight(context) / 2.8,
                  ),
                  onTap: () {
                    performItemClick(Const.typeOrg);
                  },
                ),
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("profit-loss")),
                    height: Utils.getDeviceHeight(context) / 2.8,
                  ),
                  onTap: () {
                    performItemClick(Const.typePL);
                  },
                ),
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("ranking")),
                    height: Utils.getDeviceHeight(context) / 2.8,
                  ),
                  onTap: () {
                    performItemClick(Const.typeTeam);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: Utils.getDeviceWidth(context),
            margin: EdgeInsets.only(
              top: Utils.getDeviceHeight(context) / 2.8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("rewards")),
                      height: Utils.getDeviceHeight(context) / 2.9,
                    ),
                    onTap: () {
                      performItemClick(Const.typeReward);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Image(
                  image: AssetImage(Utils.getAssetsImg("pencils")),
                  height: Utils.getDeviceHeight(context) / 5,
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("team")),
                      height: Utils.getDeviceHeight(context) / 2.4,
                    ),
                    onTap: () {
                      performItemClick(Const.typeTeam);
                    },
                  ),
                ),
                Image(
                  image: AssetImage(Utils.getAssetsImg("papers_rack")),
                  height: Utils.getDeviceHeight(context) / 9,
                ),
                InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("challenges")),
                      height: Utils.getDeviceHeight(context) / 3.3,
                    ),
                    onTap: () {
                      performItemClick(Const.typeChallenges);
//                showTutorial(context);
                    }),
              ],
            ),
          ),
          Container(
//            color: ColorRes.blue,
            width: Utils.getDeviceWidth(context),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("business_sectors")),
                      height: Utils.getDeviceHeight(context) / 2.85,
                    ),
                    onTap: () {
                      performItemClick(Const.typeBusinessSector);
                    }),
                InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("new-customer")),
                      height: Utils.getDeviceHeight(context) / 2.5,
                    ),
                    onTap: () {
                      performItemClick(Const.typeNewCustomer);
                    }),
                SizedBox(
                  width: Utils.getDeviceWidth(context) / 20,
                ),
                InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("existing")),
                      height: Utils.getDeviceHeight(context) / 3.1,
                    ),
                    onTap: () {
                      performItemClick(Const.typeExistingCustomer);
                    }),
              ],
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 6,
            left: Utils.getDeviceWidth(context) / 3.3,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("mobile")),
              height: Utils.getDeviceHeight(context) / 12,
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 12,
            left: Utils.getDeviceWidth(context) / 4,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("glasses")),
              height: Utils.getDeviceHeight(context) / 15,
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 8,
            right: Utils.getDeviceWidth(context) / 3.7,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("coffee_cup")),
              height: Utils.getDeviceHeight(context) / 8,
            ),
          ),
        ],
      ),
    );
  }

  performItemClick(int type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  initialPageType: type,
                )));
  }

  bool isShowing = false;

  void showTutorial(BuildContext context) async {
    if (!isShowing) {
      new Timer(Duration(milliseconds: 100), () async {
        try {
          FlutterIntroductionTooltip.showTopTutorialOnWidget(
              context,
              _scaffoldKey,
              Colors.blue,
              () => popAndNextTutorial(context),
              "MAMA",
              "MAMA IS A LOREM IPSUM",
              "ALRIGHT");
          print("SHOWING");
          setState(() {
            isShowing = true;
          });
        } catch (e) {
          print("ERROR $e");
        }
      });
    }
  }

  popAndNextTutorial(BuildContext context) {}
}
