import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/models/change_password.dart';

class DashboardIntroDialog extends StatefulWidget {
  DashboardIntroDialog({
    Key key,
    this.isFromProfile,
    this.isOldPasswordRequired,
  }) : super(key: key);

  final bool isFromProfile;
  final bool isOldPasswordRequired;

  @override
  DashboardIntroDialogState createState() => new DashboardIntroDialogState();
}

class DashboardIntroDialogState extends State<DashboardIntroDialog> {
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final pass3Controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: showIntroView(),
    );
  }

  showIntroView() {
    return Stack(
      children: <Widget>[
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
          child: showBottomItem(Const.typeExistingCustomer),
        ),
        Positioned(
          left: Utils.getDeviceWidth(context) / 2.5,
          bottom: 70,
          child: showBottomItem(Const.typeNewCustomer),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: showGotIt(),
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
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorRes.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  showBottomItem(String type) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Positioned(
          left: 50,
          bottom: 0,
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
            height: 110,
            width: 160,
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("dash_intro_box")),
                  fit: BoxFit.contain),
            ),
            child: Text(
              Utils.getText(
                context,
                getText(type),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorRes.white,
                fontSize: 16,
              ),
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

  showGotIt() {
    return InkResponse(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        alignment: Alignment.center,
        child: Text(
          Utils.getText(context, StringRes.gotIt),
          style: TextStyle(
            color: ColorRes.white,
            fontSize: 20,
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg('got_it')))),
      ),
      onTap: () async {
        Injector.introData.dashboard = 1;
        await Injector.setIntroData(Injector.introData);

        await Injector.updateIntroData();

        Navigator.pop(context);
      },
    );
  }
}
