
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
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
class OrganizationsPage2 extends StatefulWidget {
  @override
  _OrganizationsPage2State createState() => _OrganizationsPage2State();
}

class _OrganizationsPage2State extends State<OrganizationsPage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  List<Organization> arrOrganization = List();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) getOrganization();
    });
//    initStreamControllerProfile();
  }

  reference() {
    setState(() {
    });
  }

//  void initStreamControllerProfile() {
//    if (Injector.streamController == null)
//      Injector.streamController = StreamController.broadcast();
//
//    Injector.streamController.stream.listen((data) {
//      if (mounted) {
//        setState(() {
//          print(data);
//
//          if (data == "update plus") {
//            manageLevel(position1, Const.add);
////            showConfirmDialog(position1, Const.add);
//          } else if(data == "update minus") {
//            manageLevel(position1, Const.subtract);
//          }
//
//        });
//      }
//    }, onDone: () {
//      print("Task Done11");
//    }, onError: (error) {
//      print("Some Error11");
//    });
//  }

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
          CommonView.showCircularProgress(isLoading)
        ],
      ),
    );
  }

  showItem(int type) {
    int position = type - 1;

//    setState(() {
//      position1 = position;
//    });

    if (Injector.streamController == null)
      Injector.streamController = StreamController.broadcast();

    Injector.streamController.stream.listen((data) {
      if (mounted) {
        setState(() {
          print(data);

          if (data == "update plus") {
            manageLevel(position, Const.add);
//            showConfirmDialog(position1, Const.add);
          } else if(data == "update minus") {
            manageLevel(position, Const.subtract);
          }

        });
      }
    }, onDone: () {
      print("Task Done11");
    }, onError: (error) {
      print("Some Error11");
    });

    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        InkResponse(
          child: Container(
            height: 60,
            child: Card(
              margin: EdgeInsets.all(4),
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
                          arrOrganization[position].level.toString(),
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

//                      InkResponse(
//                        child: Padding(
//                          padding: EdgeInsets.all(5),
//                          child: Image(
//                            image: AssetImage(Utils.getAssetsImg('minus')),
//                            fit: BoxFit.fill,
//                            width: 13,
//                          ),
//                        ),
//                        onTap: () {
//                          showConfirmDialog(position, Const.subtract);
//                        },
//                      ),

                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            height: 15,
                            width: Utils.getDeviceWidth(context) / 10,
//                            width: Utils.getDeviceWidth(context) / 16.4,
                            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg('bg_progress_2')),
                                    fit: BoxFit.fill)),
//                padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          LinearPercentIndicator(
                            width: Utils.getDeviceWidth(context) / 9,
                            lineHeight: 15.0,
                            percent: Utils.getProgress(arrOrganization[position]),
                            backgroundColor: Colors.transparent,
                            progressColor: Colors.blue,
                          )
                        ],
                      ),

//                     InkResponse(
//                        child: Padding(
//                          padding: EdgeInsets.all(5),
//                          child: Image(
//                            image: AssetImage(Utils.getAssetsImg('plus')),
//                            fit: BoxFit.fill,
//                            width: 13,
//                          ),
//                        ),
//                        onTap: () {
//                          showConfirmDialog(position, Const.add);
//                        },
//                      )

                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
//            showBody(context, arrOrganization[position].description);
            Utils.showOrgInfoDialog(_scaffoldKey, arrOrganization[position].description, position);
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
            right: 10,
            top: 50,
            child: showItem(Const.typeFinance),
          ),
          Positioned(
            left: Utils.getDeviceWidth(context) / 6.5,
            top: 20,
            child: showItem(Const.typeHR),
          ),
          Positioned(
            right: Utils.getDeviceWidth(context) / 6.5,
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
              width: Utils.getDeviceWidth(context) / 6.4,
              padding: EdgeInsets.only(top: 5),
              child: showItem(Const.typeServices),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Utils.getDeviceWidth(context) / 6.4,
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

      setState(() {
        isLoading = true;
      });

      WebApi()
          .getOrganizations(context, rq.toJson())
          .then((getOrganizationData) {
        if (getOrganizationData != null) {
          arrOrganization = getOrganizationData.organization;

          setState(() {
            isLoading = false;
          });
        }
      });
    }).catchError((e) {
      print("getOrganizations_"+e.toString());
      setState(() {
        isLoading = false;
      });
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
          arrOrganization[position] = getOrganizationData.organization[0];
          setState(() {});
          Utils.performManageLevel(getOrganizationData);
        } else {
          Utils.getText(context, StringRes.somethingWrong);
        }
      }).catchError((e) {
        print("manageOrg_"+e.toString());
        setState(() {
          isLoading = false;
        });
        Utils.showToast(e.toString());
      });
    });
  }


  showBody(BuildContext context, String arrayData) {
    return showDialog(context: context,

      builder: (BuildContext context) {
      return Center(
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(40),
                alignment: Alignment.center,
                width: Utils.getDeviceWidth(context) / 2.5,
                height: Utils.getDeviceHeight(context) / 2.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        Utils.getText(context, arrayData),
                        style: TextStyle(color: ColorRes.blue, fontSize: 17),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 13)),
                    Container(
                        child: showTextEmp("Fire 10 employees", "minus", 1)),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    Container(child: showTextEmp("Hire 10 employees", "plus", 2)),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    InkResponse(
                      child: Container(
                        child: Text("Cancel",
                            style: TextStyle(color: ColorRes.blue, fontSize: 17)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
//          Container(),
//          Container(),
//          Container(),
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
    );
  }


  showTextEmp(String textShow, String img, int type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text('$textShow',
              style: TextStyle(color: ColorRes.blue, fontSize: 17)),
        ),
        InkResponse(
          child: Container(
            child: Image(
                height: 20,
                width: 20,
                image: AssetImage(Utils.getAssetsImg('$img'))),
          ),
          onTap: () {
//            type == 1
//                ? showConfirmDialog(position, Const.add)
//                : showConfirmDialog(position, Const.add);
          },
        )
      ],
    );
  }

}



//alert dialog open

class OrgInfoDialog extends StatefulWidget {
  OrgInfoDialog({
    Key key,
    this.text,
    this.organizationsPage2,
    this.position
  }) : super(key: key);

  final String text;
  final _OrganizationsPage2State organizationsPage2;
  final int position;


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
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(40),
              alignment: Alignment.center,
              width: Utils.getDeviceWidth(context) / 2.0,
              height: Utils.getDeviceHeight(context) / 2.0,
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
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: ColorRes.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Text('Fire 10 employees',
                              style: TextStyle(color: ColorRes.blue, fontSize: 17)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Injector.streamController.add("update minus");
                        },
                      ),
                    ),
//                      showTextEmp("Fire 10 employees", "minus", 1)),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    InkResponse(
                      child: InkResponse(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: ColorRes.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Text('Hire 10 employees',
                              style: TextStyle(color: ColorRes.blue, fontSize: 17)),
                        ),
                        onTap: () {
//                            widget.organizationsPage2.showConfirmDialog(widget.position, Const.add);
//                          widget.organizationsPage2.manageLevel(widget.position, Const.add);
//                          widget.organizationsPage2.refresh();
                          Navigator.pop(context);
                          Injector.streamController.add("update plus");
                          widget.organizationsPage2.reference();


                        },
                      ),
                    ),
//                  Container(child: showTextEmp("Hire 10 employees", "plus", 2)),
                    Padding(padding: EdgeInsets.only(top: 12)),
                    InkResponse(
                      child: Container(
                        child: Text("Cancel",
                            style: TextStyle(color: ColorRes.blue, fontSize: 17)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )
          ),
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

