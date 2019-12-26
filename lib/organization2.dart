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

class OrganizationsPage2 extends StatefulWidget {
  @override
  _OrganizationsPage2State createState() => _OrganizationsPage2State();
}

class _OrganizationsPage2State extends State<OrganizationsPage2> {
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: Utils.getHeaderHeight(context),
              ),
//              CommonView.showTitle(context, StringRes.organizations),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    CommonView.showBackgroundOrg(context),
                    arrOrganization.length > 0 ? showItems() : Container()
                  ],
                ),
              )
            ],
          ),
          CommonView.showCircularProgress(isLoading)
        ],
      ),
    );
  }

  showItem(int type) {
    int position = type - 1;

    Organization organization = arrOrganization[position];

    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 90,
          height: 50,
          margin: EdgeInsets.only(right: 2, bottom: 2),
          decoration: BoxDecoration(
              color: ColorRes.black.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: 90,
            height: 50,
            decoration: BoxDecoration(
                color: ColorRes.whiteBg.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
//                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(left: 14,right: 5),
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: ColorRes.headerBlue),
                  child: Text(
                    (position + 1).toString(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Injector.isBusinessMode
                            ? ColorRes.white
                            : ColorRes.hintColor),
                  ),
                ),
                Text(
                  getTitle(position),
                  style: TextStyle(
                      fontSize: 12,
                      color: Injector.isBusinessMode
                          ? ColorRes.textBlue
                          : ColorRes.hintColor),
                ),
                SizedBox(
                  width: 5,
                ),
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
                      width: 13,
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
                      width: Utils.getDeviceWidth(context) / 16.4,
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  Utils.getAssetsImg('bg_progress_2')),
                              fit: BoxFit.fill)),
//                padding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    LinearPercentIndicator(
                      width: Utils.getDeviceWidth(context) / 15,
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
                      width: 13,
                    ),
                  ),
                  onTap: () {
                    showConfirmDialog(position, Const.add);
                  },
                ),
              ],
            ),
          ],
        ),
        Positioned(
          right: 5,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: ColorRes.headerBlue),
            child: InkResponse(
              child: Image(
                image: AssetImage(
                  Utils.getAssetsImg('info'),
                ),
                color: Injector.isBusinessMode
                    ? ColorRes.white
                    : ColorRes.hintColor,
                fit: BoxFit.fill,
                width: 14,
              ),
              onTap: () {
                Utils.showOrgInfoDialog(
                    _scaffoldKey, arrOrganization[position].description);
              },
            ),
          ),
        )
      ],
    );
  }

  String getTitle(int position) {
    return Utils.getText(context, arrOrganization[position].name);
  }

  showItems() {
    return Padding(
      padding: EdgeInsets.only(left: 70,right: 70),child:Stack(
      children: <Widget>[

        Positioned(
          left: 10,top: 50,child: showItem(Const.typeCRM),
        ),

        Positioned(
          right: 10,top: 50,child: showItem(Const.typeFinance),
        ),

        Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
child: Container(),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 18, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      showItem(Const.typeHR),
                      showItem(Const.typeSales)
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      showItem(Const.typeServices),
                      showItem(Const.typeOperations)
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 18, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      showItem(Const.typeMarketing),
                      showItem(Const.typeLegal)
                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Container(),
//              child: showItem(Const.typeFinance),
            ),
          ],
        )
      ],
    ) ,
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

    if (progress.toDouble() <= 1 && progress.toDouble() >= 0) {
      return progress.toDouble();
    } else if (progress < 0) {
      return 0.0;
    } else if (progress > 1)
      return 1.0;
    else {
      return 0.0;
    }
  }

  Future<void> showConfirmDialog(int position, int action) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(action == Const.add
              ? arrOrganization[position].addLevelConfirmMessage
              : arrOrganization[position].subtractLevelConfirmMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                manageLevel(position, action);
                //alert pop
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                //alert pop
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
          .then((getOrganizationData) async {
        setState(() {
          isLoading = false;
        });

        if (getOrganizationData != null) {
          organizationData = getOrganizationData;
          arrOrganization[position] = organizationData.organization[0];

          setState(() {});

          CustomerValueData customerValueData = Injector.customerValueData;
          customerValueData.totalEmployeeCapacity =
              organizationData.totalEmpCount;
          customerValueData.totalBalance = organizationData.totalBalance;

          await Injector.prefs.setString(PrefKeys.customerValueData,
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
