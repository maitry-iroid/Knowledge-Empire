import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'helper/Utils.dart';
import 'helper/constant.dart';
import 'helper/string_res.dart';

class OrganizationsPage extends StatefulWidget {
  @override
  _OrganizationsPageState createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: CommonView.getBGDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CommonView.showTitle(context, StringRes.organizations),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: Utils.getDeviceWidth(context),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: Utils.getDeviceWidth(context) / 10,
                        right: Utils.getDeviceWidth(context) / 10,
                        top: Utils.getDeviceHeight(context) / 5),
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(
                          Injector.isBusinessMode
                              ? 'table_org'
                              : 'org_table_prof')),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: Utils.getDeviceHeight(context) / 4.5,
                    child: showItem(Const.typeCRM),
                  ),
                  Positioned(
                    left: Utils.getDeviceWidth(context) / 6,
                    top: Utils.getDeviceHeight(context) / 10,
                    child: showItem(Const.typeHR),
                  ),
                  Positioned(
                    left: Utils.getDeviceWidth(context) / 2.6,
                    top: Utils.getDeviceHeight(context) / 15,
                    child: showItem(Const.typeServices),
                  ),
                  Positioned(
                    right: Utils.getDeviceWidth(context) / 6,
                    top: Utils.getDeviceHeight(context) / 10,
                    child: showItem(Const.typeMarketing),
                  ),
                  Positioned(
                    left: Utils.getDeviceWidth(context) / 6,
                    bottom: Utils.getDeviceHeight(context) / 8,
                    child: showItem(Const.typeSales),
                  ),
                  Positioned(
                    left: Utils.getDeviceWidth(context) / 2.6,
                    bottom: Utils.getDeviceHeight(context) / 12,
                    child: showItem(Const.typeOperations),
                  ),
                  Positioned(
                    right: Utils.getDeviceWidth(context) / 6,
                    bottom: Utils.getDeviceHeight(context) / 8,
                    child: showItem(Const.typeLegal),
                  ),
                  Positioned(
                    right: 0,
                    top: Utils.getDeviceHeight(context) / 4.5,
                    child: showItem(Const.typeFinance),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showItem(int type) {
    return InkResponse(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTitle(type),
                style: TextStyle(
                    fontSize: 15,
                    color: Injector.isBusinessMode
                        ? ColorRes.white
                        : ColorRes.hintColor),
              ),
              SizedBox(
                width: 5,
              ),
              Image(
                image: AssetImage(
                  Utils.getAssetsImg('info'),
                ),
                color: Injector.isBusinessMode
                    ? ColorRes.white
                    : ColorRes.hintColor,
                fit: BoxFit.fill,
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(Utils.getAssetsImg('user_org')),
            fit: BoxFit.fill,
            width: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(Utils.getAssetsImg('minus')),
                fit: BoxFit.fill,
                width: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 15,
                    width: Utils.getDeviceWidth(context) / 13,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage(Utils.getAssetsImg('bg_progress_2')),
                            fit: BoxFit.fill)),
//                padding: EdgeInsets.symmetric(vertical: 2),
                  ),
                  LinearPercentIndicator(
                    width: Utils.getDeviceWidth(context) / 12,
                    lineHeight: 15.0,
                    percent: 0.05,
                    backgroundColor: Colors.transparent,
                    progressColor: Colors.blue,
                  )
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Image(
                image: AssetImage(Utils.getAssetsImg('plus')),
                fit: BoxFit.fill,
                width: 15,
              )
            ],
          ),
        ],
      ),
      onTap: () {
        Utils.showOrgInfoDialog(_scaffoldKey, type);
      },
    );
  }

  String getTitle(int type) {
    if (type == Const.typeCRM)
      return "CRM";
    else if (type == Const.typeHR)
      return "HR";
    else if (type == Const.typeServices)
      return "Service";
    else if (type == Const.typeMarketing)
      return "Marketing";
    else if (type == Const.typeSales)
      return "Sales";
    else if (type == Const.typeOperations)
      return "Operations";
    else if (type == Const.typeLegal)
      return "Legal";
    else if (type == Const.typeFinance)
      return "Finance";
    else
      return "";
  }
}
