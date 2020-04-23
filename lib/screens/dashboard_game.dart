import 'dart:convert';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/dialogs/dashboard_intro_dialog.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/dashboard_lock_status.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/models/intro.dart';

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

  List<UnreadBubbleCountData> unreadBubbleCountData = new List();
  bool startAnim = false;
  int duration = 4;
  bool isCoinViseble = false;
  DashboardLockStatusData dashboardLockStatusData;

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
    getUnreadBubbleCount();
    getLockStatus();

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
  void dispose() {
    print("dispose=======");
    super.dispose();
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
              CommonView.showDashboardView(context, unreadBubbleCountData),
              HeaderView(scaffoldKey: _scaffoldKey, isShowMenu: true),
            ],
          ),
        ),
      ),
    );
  }

  void getUnreadBubbleCount() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardRequest rq = DashboardRequest();
        rq.userId = Injector.userId;
        rq.mode = Injector.mode ?? Const.businessMode;

        WebApi()
            .callAPI(WebApi.rqUnreadBubbleCount, rq.toJson())
            .then((data) async {
          if (data != null) {
            List<String> listCount = new List();
            data.forEach((v) {
              unreadBubbleCountData.add(UnreadBubbleCountData.fromJson(v));
              listCount.add(jsonEncode(v));
            });

            await Injector.prefs
                .setStringList(PrefKeys.unreadBubbleCountData, listCount);
            Injector.unreadBubbleCountData = unreadBubbleCountData;
            if (unreadBubbleCountData.isNotEmpty) if (mounted) setState(() {});
          }
        }).catchError((e) {
          print("getDashboardValue_" + e.toString());
        });
      }
    });
  }

  void getLockStatus() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardLockStatusRequest rq = DashboardLockStatusRequest();
        rq.userId = Injector.userId;
        rq.mode = Injector.mode ?? Const.businessMode;

        WebApi()
            .callAPI(WebApi.rqDashboardLockStatus, rq.toJson())
            .then((data) {
          if (data != null) {
            dashboardLockStatusData = DashboardLockStatusData.fromJson(data);
            Injector.dashboardLockStatusData = dashboardLockStatusData;
            if (mounted) setState(() {});
          }
        }).catchError((e) {
          print("getDashboardValue_" + e.toString());
        });
      }
    });
  }
}
