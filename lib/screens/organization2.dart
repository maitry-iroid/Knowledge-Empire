import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/manage_organization.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';
import 'package:ke_employee/screens/refreshAnimation.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/string_res.dart';

int position1;

bool isCheckLoad = false;

class OrganizationsPage2 extends StatefulWidget {
  final RefreshAnimation mRefreshAnimation;

  const OrganizationsPage2({Key key, this.mRefreshAnimation}) : super(key: key);
  @override
  _OrganizationsPage2State createState() => _OrganizationsPage2State();
}

class _OrganizationsPage2State extends State<OrganizationsPage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Organization> arrOrganization = List();
  bool isLoading = false;




  @override
  initState() {
    super.initState();
    showIntroDialog();
  }

  Future showIntroDialog() async {
    if (Injector.introData != null && Injector.introData.org1 == 0)
      await DisplayDialogs.showIntroOrg1(context);

    Utils.isInternetConnectedWithAlert(context).then((isConnected) {
      if (isConnected) getOrganization();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          showBack(),
          CommonView.showLoderView(isLoading)
        ],
      ),
    );
  }

  showItem(int type) {
//    int position = type - 1;

    Organization org = arrOrganization.firstWhere((org) => org.type == type);

    return InkResponse(
      child: Container(
        height: 110,
        width: 110,
        child: Card(
          margin: EdgeInsets.only(
              left: 4,
              right: 4,
              top: type == Const.typeSales ||
                      type == Const.typeOperations ||
                      type == Const.typeFinance
                  ? 60
                  : 4,
              bottom: type == Const.typeSales ||
                      type == Const.typeOperations ||
                      type == Const.typeFinance
                  ? 4
                  : 60),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: ColorRes.headerBlue),
                    child: Text(
                      org != null && org.level != null
                          ? org.level.toString()
                          : "",
                      style: TextStyle(
                          fontSize: 14,
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.hintColor),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      org != null && org.name != null ? org.name : "",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      minFontSize: 4,
                      style: TextStyle(
                          fontSize: 12,
                          color: Injector.isBusinessMode
                              ? ColorRes.textBlue
                              : ColorRes.hintColor),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 15,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage(Utils.getAssetsImg('bg_progress_2')),
                            fit: BoxFit.fill)),
                  ),
                  LinearPercentIndicator(
                    alignment: MainAxisAlignment.center,
                    lineHeight: 15.0,
                    percent: Utils.getProgress(org),
                    backgroundColor: Colors.transparent,
                    progressColor: Colors.blue,
                  )
                ],
//                    ),
              )
            ],
          ),
        ),
      ),
      onTap: () async {
        if (type == Const.typeLegal && !Utils.isFeatureOn(Const.typeChallenges))
          return;

        var data = await showDialog(
            context: _scaffoldKey.currentContext,
            builder: (BuildContext context) => OrgInfoDialog(
                  text: org.description,
                  isForIntroDialog: false,
                ));
        if (data != null) manageLevel(org, data, type);
      },
    );
  }

  showItems() {
    return Padding(
      padding: EdgeInsets.only(
          left: Utils.getDeviceWidth(context) / 12,
          right: Utils.getDeviceWidth(context) / 10),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 50,
            child: showItem(Const.typeCRM),
          ),
          Positioned(
            right: 5,
            top: 50,
            child: Utils.isFeatureOn(Const.typeChallenges)
                ? showItem(Const.typeLegal)
                : Container(),
          ),
          Positioned(
            left: Utils.getDeviceWidth(context) / 6,
            top: 20,
            child: showItem(Const.typeHR),
          ),
          Positioned(
            right: Utils.getDeviceWidth(context) / 6.2,
            top: 20,
            child: showItem(Const.typeMarketing),
          ),
          Positioned(
            left: 50,
            bottom: 15,
            child: showItem(Const.typeSales),
          ),
          Positioned(
            right: 80,
            bottom: 15,
            child: showItem(Const.typeFinance),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: Utils.getDeviceWidth(context) / 6.0,
              padding: EdgeInsets.only(top: 5),
              child: showItem(Const.typeServices),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Utils.getDeviceWidth(context) / 6.0,
              padding: EdgeInsets.only(bottom: 5),
              child: showItem(Const.typeOperations),
            ),
          ),
        ],
      ),
    );
  }

  void getOrganization() {
    Utils.isInternetConnectedWithAlert(context).then((_) {
      GetOrganizationRequest rq = GetOrganizationRequest();
      rq.userId = Injector.userData.userId;
      rq.mode = Injector.isBusinessMode ? 1 : 2;

      if (mounted)
        setState(() {
          isLoading = true;
        });

      WebApi().callAPI(WebApi.rqGetOrganization, rq.toJson()).then((data) {
        if (mounted)
          setState(() {
            isLoading = false;
          });

        if (data != null) {
          arrOrganization = OrganizationData.fromJson(data).organization;

          if (mounted) setState(() {});
        }
      });
    }).catchError((e) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      // Utils.showToast(e.toString());
    });
  }

  getProgress(int position) {
    int totalEmployeeCount = Injector.customerValueData.totalEmployeeCapacity -
        Injector.customerValueData.remainingEmployeeCapacity;

    if (totalEmployeeCount == null) return 0.0;

    var progress = arrOrganization[position].employeeCount / totalEmployeeCount;

    if (progress <= 1 && progress >= 0) {
      return progress;
    } else if (progress < 0) {
      return 0.0;
    } else if (progress > 1)
      return 1.0;
    else {
      return 0.0;
    }
  }

  void manageLevel(Organization organization, int action, int type) {
    Utils.isInternetConnectedWithAlert(context).then((_) {
      ManageOrganizationRequest rq = ManageOrganizationRequest();
      rq.userId = Injector.userData.userId;
      rq.action = action;
      rq.type = organization.type;
      rq.mode = Injector.mode;

      if (mounted)
        setState(() {
          isLoading = true;
        });

      WebApi()
          .callAPI(WebApi.rqManageOrganization, rq.toJson())
          .then((data) async {
        if (mounted)
          setState(() {
            isLoading = false;
          });

        if (data != null) {
          ManageOrgData manageOrgData = ManageOrgData.fromJson(data);

          for (int i = 0; i < arrOrganization.length; i++) {
            if (arrOrganization[i].type == organization.type) {
              arrOrganization[i] = manageOrgData.organization[0];
              break;
            }
          }

          if (mounted) setState(() {});

          if (action == Const.subtract) {
            triggerAnimation(type);
          }

          Utils.performManageLevel(manageOrgData);
        } else {
          Utils.getText(context, StringRes.somethingWrong);
        }
      }).catchError((e) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        // Utils.showToast(e.toString());
      });
    });
  }

  Widget showBack() {
    return Positioned(
      top: DimenRes.titleBarHeight,
      child: InkResponse(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Image(
            image: AssetImage(Utils.getAssetsImg("back")),
            width: 35,
          ),
        ),
        onTap: () {
          Utils.playClickSound();
          Utils.performBack(context);
        },
      ),
    );
  }

  void triggerAnimation(int type) {
    try {

      widget.mRefreshAnimation.onRefreshAchievement(type);

    } catch (e) {
      print(e);
    }
  }
}

//alert dialog open

class OrgInfoDialog extends StatefulWidget {
  OrgInfoDialog({
    Key key,
    this.text,
    this.organizationsPage2,
    this.position,
    this.isForIntroDialog,
  }) : super(key: key);

  final String text;
  final _OrganizationsPage2State organizationsPage2;
  final int position;
  final bool isForIntroDialog;

  @override
  OrgInfoDialogState createState() => new OrgInfoDialogState();
}

class OrgInfoDialogState extends State<OrgInfoDialog> {
  bool isLoading = false;

  List<Organization> arrOrganization = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: showBody(context),
    );
  }

  showBody(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(40),
              alignment: Alignment.center,
              width: widget.isForIntroDialog != null && !widget.isForIntroDialog
                  ? Utils.getDeviceWidth(context) / 1.8
                  : Utils.getDeviceWidth(context) / 2.5,
              height:
                  widget.isForIntroDialog != null && !widget.isForIntroDialog
                      ? Utils.getDeviceHeight(context) / 1.8
                      : Utils.getDeviceHeight(context) / 2.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorRes.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        Utils.getText(context, widget.text),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorRes.blue, fontSize: 18),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 13)),
                    widget.isForIntroDialog != null && !widget.isForIntroDialog
                        ? InkResponse(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 3, bottom: 3),
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, top: 3, bottom: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: ColorRes.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text(
                                  Utils.getText(context, StringRes.hireEmp),
                                  style: TextStyle(
                                      color: ColorRes.blue, fontSize: 17)),
                            ),
                            onTap: () {
                              Navigator.pop(context, Const.add);
                            },
                          )
                        : Container(),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    widget.isForIntroDialog != null && !widget.isForIntroDialog
                        ? InkResponse(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 3, bottom: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: ColorRes.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text(
                                  Utils.getText(context, StringRes.fireEmp),
                                  style: TextStyle(
                                      color: ColorRes.red, fontSize: 17)),
                            ),
                            onTap: () {
                              Navigator.pop(context, Const.subtract);
                            },
                          )
                        : Container(),
                  ],
                ),
              )),
          Positioned(
              right: 10,
              child: InkResponse(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg('close_dialog')),
                    width: 20,
                  ),
                ),
                onTap: () {
                  Utils.playClickSound();
                  Navigator.pop(context, null);
                },
              ))
        ],
      ),
    );
  }
}
