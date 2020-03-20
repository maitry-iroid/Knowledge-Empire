import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';

import '../commonview/header.dart';
import '../helper/constant.dart';

class DashboardGamePage extends StatefulWidget {
  DashboardGamePage({Key key}) : super(key: key);

  DashboardGamePageState createState() => DashboardGamePageState();
}

class DashboardGamePageState extends State<DashboardGamePage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController rotationController;

  List<GetDashboardData> dashboardData = List();
  bool startAnim = false;
  int duration = 4;
  bool isCoinViseble = false;

  @override
  void initState() {
    super.initState();

    if (Injector.prefs.getInt(PrefKeys.mode) == null) {
      Injector.prefs.setInt(PrefKeys.mode, Const.businessMode);
    }

    getDashboardConfig();
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
              CommonView.showDashboardView(context, dashboardData),
              HeaderView(
                scaffoldKey: _scaffoldKey,
                isShowMenu: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: RaisedButton(
                    onPressed: () {
                      isCoinViseble = true;
                      setState(() {});
                    },
                    child: Text("press here")),
              ),
              Stack(
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
                  coinWidget(350, 650),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget coinWidget(double top, double left) {
    return AnimatedPositioned(
      duration: Duration(seconds: duration),
      top: !isCoinViseble ? top : 20,
      left: !isCoinViseble ? left : 750,
      onEnd: () {
        isCoinViseble = false;
        if (mounted) setState(() {});
      },
      child: Container(
        child: isCoinViseble ? MyHomePage() : Container(),
        width: 40,
        height: 40,
      ),
    );
  }

  void getDashboardConfig() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardRequest rq = DashboardRequest();
        rq.userId = Injector.userId;
        rq.mode = Injector.mode ?? Const.businessMode;

        WebApi().callAPI(WebApi.rqDashboard, rq.toJson()).then((data) {
          if (data != null) {
            data.forEach((v) {
              dashboardData.add(GetDashboardData.fromJson(v));
            });

            if (dashboardData.isNotEmpty) if (mounted) setState(() {});
          }
        }).catchError((e) {
          print("getDashboardValue_" + e.toString());
        });
      }
    });
  }
}
