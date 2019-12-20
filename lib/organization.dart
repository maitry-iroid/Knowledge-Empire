import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/injection/dependency_injection.dart' as prefix0;
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/manage_organization.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';
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

  OrganizationData organizationData;
  Notifier _notifier;

  List<Organization> arrOrganization = List();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) getOrganization();
    });
  }

  @override
  Widget build(BuildContext context) {
    _notifier = NotifierProvider.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: CommonView.getBGDecoration(context),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  CommonView.showTitle(context, StringRes.organizations),
                  Expanded(
                    child:
                        arrOrganization.length > 0 ? showItems() : Container(),
                  )
                ],
              ),
              CommonView.showCircularProgress(isLoading)
            ],
          )),
    );
  }

  showItem(int type) {
    int position = type - 1;

    Organization organization = arrOrganization[position];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              getTitle(position),
              style: TextStyle(
                  fontSize: 15,
                  color: Injector.isBusinessMode
                      ? ColorRes.white
                      : ColorRes.hintColor),
            ),
            SizedBox(
              width: 5,
            ),
            InkResponse(
              child: Image(
                image: AssetImage(
                  Utils.getAssetsImg('info'),
                ),
                color: Injector.isBusinessMode
                    ? ColorRes.white
                    : ColorRes.hintColor,
                fit: BoxFit.fill,
                width: 15,
              ),
              onTap: () {
                Utils.showOrgInfoDialog(
                    _scaffoldKey, arrOrganization[position].description);
              },
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Image(
              image: AssetImage(Utils.getAssetsImg('user_org')),
              fit: BoxFit.fill,
              width: 30,
            ),
            Positioned(
              left: 12,
              right: 0,
              bottom: 1,
              child: Text(
                organization.level.toString(),
                style: TextStyle(color: ColorRes.white, fontSize: 15),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkResponse(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image(
                  image: AssetImage(Utils.getAssetsImg('minus')),
                  fit: BoxFit.fill,
                  width: 15,
                ),
              ),
              onTap: () {
                showConfirmDialog(position, Const.subtract);
              },
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
                  percent: getProgress(position),
                  backgroundColor: Colors.transparent,
                  progressColor: Colors.blue,
                )
              ],
            ),
            InkResponse(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image(
                  image: AssetImage(Utils.getAssetsImg('plus')),
                  fit: BoxFit.fill,
                  width: 15,
                ),
              ),
              onTap: () {
                showConfirmDialog(position, Const.add);
              },
            ),
          ],
        ),
      ],
    );
  }

  String getTitle(int position) {
    return Utils.getText(context, arrOrganization[position].name);
  }

  showItems() {
    return Stack(
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
                Injector.isBusinessMode ? 'table_org' : 'org_table_prof')),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: showItem(Const.typeCRM),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  showItem(Const.typeHR),
                  showItem(Const.typeSales)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  showItem(Const.typeServices),
                  showItem(Const.typeOperations)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  showItem(Const.typeMarketing),
                  showItem(Const.typeLegal)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: showItem(Const.typeFinance),
            ),
          ],
        )
      ],
    );
  }

  void getOrganization() {
    Utils.isInternetConnectedWithAlert().then((_) {
      GetOrganizationRequest rq = GetOrganizationRequest();
      rq.userId = Injector.userData.userId;
      rq.mode = Injector.isBusinessMode ? 1 : 2;

      setState(() {
        isLoading = true;
      });

      WebApi()
          .getOrganizations(context, rq.toJson())
          .then((getOrganizationData) {
        if (getOrganizationData != null) {
          organizationData = getOrganizationData;
          arrOrganization = getOrganizationData.organization;

          setState(() {
            isLoading = false;
          });
        }
      });
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  getProgress(int position) {
    if (arrOrganization[position].employeeCount == null) return 0.0;

    var progress = arrOrganization[position].employeeCount /
        (organizationData.totalEmpCount != 0
            ? organizationData.totalEmpCount
            : 1);

    return progress.toDouble();
  }

  Future<void> showConfirmDialog(int position, int action) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure want to perform this operation?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                manageLevel(position, action);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  manageLevel(int position, int action) {
    Utils.isInternetConnectedWithAlert().then((_) {
      ManageOrganizationRequest rq = ManageOrganizationRequest();
      rq.userId = Injector.userData.userId;
      rq.action = action;
      rq.type = arrOrganization[position].type;

      setState(() {
        isLoading = true;
      });

      WebApi()
          .manageOrganizations(context, rq)
          .then((getOrganizationData) {
        setState(() {
          isLoading = false;
        });

        if (getOrganizationData != null) {
          organizationData = getOrganizationData;
          arrOrganization[position] = organizationData.organization[0];

          setState(() {});

          CustomerValueData customerValueData = Injector.customerValueData;
          customerValueData.organization = arrOrganization;
          customerValueData.totalEmployeeCapacity =
              organizationData.totalEmpCount;
          customerValueData.totalBalance = organizationData.totalBalance;

          Injector.prefs.setString(PrefKeys.customerValueData,
              json.encode(customerValueData.toJson()));

          Injector.customerValueData = customerValueData;

          _notifier.notify('updateHeaderValue', 'Sending data from notfier!');
        } else {
          Utils.getText(context, StringRes.somethingWrong);
        }
      }).catchError((e) {
        print(e);
        setState(() {
          isLoading = false;
        });
        Utils.showToast(e.toString());
      });
    });
  }
}
