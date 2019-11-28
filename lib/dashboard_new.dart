import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

import 'commonview/header.dart';
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
              CommonView.showDashboardView(context),
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
}
