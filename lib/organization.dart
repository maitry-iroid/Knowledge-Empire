import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'helper/Utils.dart';
import 'helper/constant.dart';

class OrganizationsPage extends StatefulWidget {
  @override
  _OrganizationsPageState createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
              fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          showTitle(),
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
                    image: AssetImage(Utils.getAssetsImg('table_org')),
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
                  left: Utils.getDeviceWidth(context) / 2.7,
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
                  left: Utils.getDeviceWidth(context) / 2.7,
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
    );
  }

  showTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        InkResponse(
          child: Image(
            image: AssetImage(Utils.getAssetsImg("back")),
            width: DimenRes.titleBarHeight,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          alignment: Alignment.center,
          height: DimenRes.titleBarHeight,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Utils.getAssetsImg("bg_setting"),
                  ),
                  fit: BoxFit.fill)),
          child: Text(
            Utils.getText(context, StringRes.organizations),
            style: TextStyle(
              color: ColorRes.colorPrimary,
              fontSize: DimenRes.titleTextSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  showItem(int type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              getTitle(type),
              style: TextStyle(fontSize: 15, color: ColorRes.white),
            ),
            SizedBox(
              width: 5,
            ),
            Image(
              image: AssetImage(Utils.getAssetsImg('info')),
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
            LinearPercentIndicator(
              width: Utils.getDeviceWidth(context) / 12,
              lineHeight: 15.0,
              percent: 0.5,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
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
    else if (type == Const.typeFinance) return "Finance";
  }
}
