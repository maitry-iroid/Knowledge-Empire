import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
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
            ],
          ),
        ),
      ),
    );
  }

  void getDashboardConfig() {
    Utils.isInternetConnected().then((isConnected) {
      DashboardRequest rq = DashboardRequest();
      rq.userId = Injector.userId;
      rq.mode = Injector.mode ?? Injector.isBusinessMode;

      WebApi().callAPI(WebApi.rqDashboard, rq.toJson()).then((data) {
        if (data != null) {
          data.forEach((v) {
            dashboardData.add(GetDashboardData.fromJson(v));
          });

          if (dashboardData.isNotEmpty) setState(() {});
        }
      });
    }).catchError((e) {
      print("getDashboardValue_" + e.toString());
    });
  }
}
