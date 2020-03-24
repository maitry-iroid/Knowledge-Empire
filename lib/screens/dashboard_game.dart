import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
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
              HeaderView(scaffoldKey: _scaffoldKey, isShowMenu: true),
              showIntroView()
            ],
          ),
        ),
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

  showIntroView() {
    return Stack(
      children: <Widget>[
        Container(
          color: ColorRes.blackTransparent.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          left: 0,
          top: 50,
          child: showItem(Const.typeName),
        ),
        Positioned(
          left: Utils.getDeviceWidth(context) / 3.5,
          top: 50,
          child: showItem(Const.typeSalesPersons),
        ),
        Positioned(
          left: Utils.getDeviceWidth(context) / 1.9,
          top: 50,
          child: showItem(Const.typeServicesPerson),
        ),
        Positioned(
          right: 0,
          top: 50,
          child: showItem(Const.typeMoney),
        ),
        Positioned(
          left: 50,
          bottom: 50,
          child: showBottomItem(Const.typeBusinessSector),
        ),
        Positioned(
          right: 50,
          bottom: 50,
          child: showBottomItem(Const.typeNewCustomer),
        ),
        Positioned(
          left: Utils.getDeviceWidth(context) / 2.5,
          bottom: 70,
          child: showBottomItem(Const.typeExistingCustomer),
        )
      ],
    );
  }

  showItem(String type) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Positioned(
          left: type == Const.typeSalesPersons
              ? null
              : type == Const.typeServicesPerson ? 50 : 50,
          right: type == Const.typeSalesPersons
              ? 0
              : type == Const.typeServicesPerson ? null : 50,
          top: 5,
          child: Image(
            image: AssetImage(Utils.getAssetsImg("arrow")),
            width: 50,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 150,
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("dash_intro_box")),
                  fit: BoxFit.contain),
            ),
            child: Text(
              Utils.getText(context, getText(type)),
              style: TextStyle(color: ColorRes.white),
            ),
          ),
        ),
      ],
    );
  }

  showBottomItem(String typeProfile) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Positioned(
          left: 50,
          bottom: 5,
          child: RotatedBox(
            quarterTurns: 2,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("arrow")),
              width: 50,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 150,
            margin: EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("dash_intro_box")),
                  fit: BoxFit.contain),
            ),
            child: Text(
              Utils.getText(context, StringRes.dashboardProfile),
              style: TextStyle(color: ColorRes.white),
            ),
          ),
        ),
      ],
    );
  }

  String getText(String type) {
    if (type == Const.typeSalesPersons) {
      return StringRes.dashboardSales;
    } else if (type == Const.typeServicesPerson) {
      return StringRes.dashboardServices;
    } else if (type == Const.typeName) {
      return StringRes.dashboardProfile;
    } else if (type == Const.typeBusinessSector) {
      return StringRes.dashboardBusiness;
    } else if (type == Const.typeNewCustomer) {
      return StringRes.dashboardNewCustomer;
    } else if (type == Const.typeExistingCustomer) {
      return StringRes.dashboardExistingCustomer;
    } else if (type == Const.typeMoney) {
      return StringRes.dashboardBalance;
    }
    return "";
  }
}
