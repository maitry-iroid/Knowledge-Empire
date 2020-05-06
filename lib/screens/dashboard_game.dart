import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/dialogs/dashboard_intro_dialog.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/intro.dart';
import 'package:ke_employee/models/on_off_feature.dart';

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

  bool startAnim = false;
  int duration = 4;
  bool isCoinViseble = false;

  @override
  void initState() {
    super.initState();

    if (Injector.prefs.getInt(PrefKeys.mode) == null) {
      Injector.prefs.setInt(PrefKeys.mode, Const.businessMode);
    }

    if (Injector.introData == null) {
      getIntroData();
    } else if (Injector.introData.dashboard == 0) {
      showIntroDialog();
    }
    getDashboardStatus();

  }

  getIntroData() {
    if (Injector.getIntroData() != null) return;

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        CommonView.showCircularProgress(true, context);

        IntroRequest rq = IntroRequest();
        rq.userId = Injector.userId;
        rq.type = 1;

        WebApi().callAPI(WebApi.rqGameIntro, rq.toJson()).then((data) async {
          CommonView.showCircularProgress(false, context);
          if (data != null) {
            IntroData introData = IntroData.fromJson(data);
            await Injector.setIntroData(introData);

            if (Injector.introData == null || Injector.introData.dashboard == 0)
              showIntroDialog();
          }
        }).catchError((e) {
          CommonView.showCircularProgress(false, context);
          print("getIntro" + e.toString());
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  Future showIntroDialog() async {
    await Future.delayed(Duration(milliseconds: 1000));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DashboardIntroDialog();
        });
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
              HeaderView(scaffoldKey: _scaffoldKey, isShowMenu: true),
              CommonView.showDashboardView(context, unreadBubbleCountData),
             // HeaderView(scaffoldKey: _scaffoldKey, isShowMenu: true),
            ],
          ),
        ),
      ),
    );
  }

  getDashboardStatus() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardStatusRequest rq = DashboardStatusRequest();
        rq.userId = Injector.userData.userId;

        WebApi().callAPI(WebApi.rqGetDashboardStatus, rq.toJson()).then((data) {
          if (data != null) {
            DashboardStatusResponse response = DashboardStatusResponse.fromJson(data);

            if (response.data.isNotEmpty) {
              Injector.prefs.setString(
                  PrefKeys.onOffStatusData, jsonEncode(response.toJson()));
              Injector.dashboardStatusResponse = response;

              if (mounted) setState(() {});
            }
          }
        }).catchError((e) {
          print("getDashboardValue_" + e.toString());
        });
      }
    });
  }

}
