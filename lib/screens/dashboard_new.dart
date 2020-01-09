import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

import '../commonview/header.dart';
import '../helper/constant.dart';

class DashboardNewPage extends StatefulWidget {
  DashboardNewPage({Key key}) : super(key: key);

  DashboardNewPageState createState() => DashboardNewPageState();
}

class DashboardNewPageState extends State<DashboardNewPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController rotationController;

  @override
  void initState() {
    super.initState();

//    rotationController = AnimationController(
//        vsync: this, duration: Duration(seconds: 5), upperBound: pi * 2);
//    rotationController.forward(from: 0.0);

    if (Injector.prefs.getInt(PrefKeys.mode) == null) {
      Injector.prefs.setInt(PrefKeys.mode, Const.businessMode);
    }

//    _getListings();
  }

  List<Widget> _getListings() {
    List listings = new List<Widget>();
    int i = 0;
    for (i = 0; i < 5; i++) {
      listings.add(new Image(
        image: AssetImage(
          Utils.getAssetsImg('back'),
        ),
      ));
    }
    return listings;
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
              CommonView.showDashboardView(context),
              HeaderView(
                scaffoldKey: _scaffoldKey,
                isShowMenu: true,
              ),
//              RotationTransition(
//                  turns:
//                      Tween(begin: 0.0, end: 1.0).animate(rotationController),
//                  child: Image(
//                    image: AssetImage(Utils.getAssetsImg('back')),
//                  ))
            ],
          ),
        ),
      ),
    );
  }
}
