import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/commonview/my_home.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/manage_organization.dart';
import 'package:ke_employee/models/organization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/string_res.dart';

int position1;

bool isCheckLoad = false;

class OrganizationsPage2 extends StatefulWidget {
  @override
  _OrganizationsPage2State createState() => _OrganizationsPage2State();
}

class _OrganizationsPage2State extends State<OrganizationsPage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Organization> arrOrganization = List();

  @override
  void initState() {
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) getOrganization();
    });
//    initStreamControllerProfile();
  }

  void initStreamControllerProfile() {
    if (Injector.streamController == null)
      Injector.streamController = StreamController.broadcast();

    Injector.streamController.stream.listen((data) {
      if (mounted) {
        setState(() {
          print(data);

          if (isCheckLoad == true) {
            if (data == "update plus") {
              manageLevel(position1, Const.add);
              isCheckLoad = false;
//            showConfirmDialog(position1, Const.add);
            } else if (data == "update minus") {
              manageLevel(position1, Const.subtract);
              isCheckLoad = false;
            }
          }
        });
      }
    }, onDone: () {
      print("Task Done11");
    }, onError: (error) {
      print("Some Error11");
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
        ],
      ),
    );
  }

  showItem(int type) {
    int position = type - 1;
    initStreamControllerProfile();

    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        InkResponse(
          child: Container(
            height: 110,
//            color: Colors.black,
            child: Card(
              margin: EdgeInsets.only(
                  left: 4,
                  right: 4,
                  top: type == Const.typeSales ||
                          type == Const.typeOperations ||
                          type == Const.typeLegal
                      ? 60
                      : 4,
                  bottom: type == Const.typeSales ||
                          type == Const.typeOperations ||
                          type == Const.typeLegal
                      ? 4
                      : 60),
//              margin: EdgeInsets.all(4),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
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
                          arrOrganization[position].level.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Injector.isBusinessMode
                                  ? ColorRes.white
                                  : ColorRes.hintColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          getTitle(position),
                          style: TextStyle(
                              fontSize: 12,
                              color: Injector.isBusinessMode
                                  ? ColorRes.textBlue
                                  : ColorRes.hintColor),
                          overflow: TextOverflow.ellipsis,
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    Utils.getAssetsImg('bg_progress_2')),
                                fit: BoxFit.fill)),
                      ),
                      LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        lineHeight: 15.0,
                        percent: Utils.getProgress(arrOrganization[position]),
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
          onTap: () {
//            showBody(context, arrOrganization[position].description);
            Utils.showOrgInfoDialog(_scaffoldKey,
                arrOrganization[position].description, position, true);
          },
        ),
        /*  Positioned(
          right: 2,
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
        )*/
      ],
    );
  }

  String getTitle(int position) {
    return Utils.getText(context, arrOrganization[position].name);
  }

  showItems() {
    return Padding(
      padding: EdgeInsets.only(left: 70, right: 70),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 10,
            top: 50,
            child: showItem(Const.typeCRM),
          ),
          Positioned(
            right: 5,
            top: 50,
            child: showItem(Const.typeFinance),
          ),
          Positioned(
            left: Utils.getDeviceWidth(context) / 6.2,
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
            child: showItem(Const.typeLegal),
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
    Utils.isInternetConnectedWithAlert().then((_) {
      GetOrganizationRequest rq = GetOrganizationRequest();
      rq.userId = Injector.userData.userId;
      rq.mode = Injector.isBusinessMode ? 1 : 2;

      CommonView.showCircularProgress(true, context);

      WebApi().callAPI(WebApi.rqGetOrganization, rq.toJson()).then((data) {
        CommonView.showCircularProgress(false, context);

        if (data != null) {
          arrOrganization = OrganizationData.fromJson(data).organization;
          setState(() {});
        }
      });
    }).catchError((e) {
      print("getOrganizations_" + e.toString());
      CommonView.showCircularProgress(false, context);
      Utils.showToast(e.toString());
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

  manageLevel(int position, int action) {
    Utils.isInternetConnectedWithAlert().then((_) {
      ManageOrganizationRequest rq = ManageOrganizationRequest();
      rq.userId = Injector.userData.userId;
      rq.action = action;
      rq.type = arrOrganization[position].type;
      rq.mode = Injector.mode;

      CommonView.showCircularProgress(true, context);

      WebApi()
          .callAPI(WebApi.rqManageOrganization, rq.toJson())
          .then((data) async {
        CommonView.showCircularProgress(false, context);

        if (data != null) {
          ManageOrgData manageOrgData = ManageOrgData.fromJson(data);

          arrOrganization[position] = manageOrgData.organization[0];
          setState(() {});
          Utils.performManageLevel(manageOrgData);
        } else {
          Utils.getText(context, StringRes.somethingWrong);
        }
      }).catchError((e) {
        print("manageOrg_" + e.toString());
        CommonView.showCircularProgress(false, context);
        Utils.showToast(e.toString());
      });
    });
  }

  showBack() {
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
}

//alert dialog open

class OrgInfoDialog extends StatefulWidget {
  OrgInfoDialog(
      {Key key,
      this.text,
      this.organizationsPage2,
      this.position,
      this.checkUpdate})
      : super(key: key);

  final String text;
  final _OrganizationsPage2State organizationsPage2;
  final int position;
  final bool checkUpdate;

  @override
  OrgInfoDialogState createState() => new OrgInfoDialogState();
}

class OrgInfoDialogState extends State<OrgInfoDialog> {
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final pass3Controller = TextEditingController();
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
              width: Utils.getDeviceWidth(context) / 1.8,
              height: Utils.getDeviceHeight(context) / 1.8,
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
                        style: TextStyle(color: ColorRes.blue, fontSize: 17),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 13)),

                    InkResponse(
                      child: InkResponse(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 3),
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: ColorRes.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(Utils.getText(context, StringRes.hireEmp),
                              style: TextStyle(
                                  color: ColorRes.blue, fontSize: 17)),
                        ),
                        onTap: () {
//                            widget.organizationsPage2.showConfirmDialog(widget.position, Const.add);
//                          widget.organizationsPage2.manageLevel(widget.position, Const.add);
//                          widget.organizationsPage2.refresh();
                          Navigator.pop(context);
                          Injector.streamController.add("update plus");
                          setState(() {
                            position1 = widget.position;
                            isCheckLoad = widget.checkUpdate;
                          });
//                          widget.organizationsPage2.reference();
                        },
                      ),
                    ),

//                      showTextEmp("Fire 10 employees", "minus", 1)),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    InkResponse(
                      child: InkResponse(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: ColorRes.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(Utils.getText(context, StringRes.fireEmp),
                              style:
                                  TextStyle(color: ColorRes.red, fontSize: 17)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Injector.streamController.add("update minus");
                          setState(() {
                            position1 = widget.position;
                            isCheckLoad = widget.checkUpdate;
                          });
                        },
                      ),
                    ),
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
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
