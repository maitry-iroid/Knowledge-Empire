import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../helper/Utils.dart';
import '../helper/constant.dart';
import '../helper/res.dart';
import '../models/manage_organization.dart';
import '../models/organization.dart';

class PowerUpsPage extends StatefulWidget {
  @override
  _PowerUpsPageState createState() => _PowerUpsPageState();
}

class _PowerUpsPageState extends State<PowerUpsPage> {

  TextEditingController searchController = TextEditingController();
  String searchText = "";
  Organization selectedOrg = Organization();
  int selectedIndex = 0;


  OrganizationData organizationData;

  List<Organization> arrOrganization = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) getOrganization();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          organizationData = OrganizationData.fromJson(data);
          arrOrganization = organizationData.organization;
          selectedOrg = arrOrganization[0];

          if (mounted)setState(() {});
        }
      }).catchError((e) {
        print("getOrganizations_" + e.toString());
        CommonView.showCircularProgress(false, context);
        // Utils.showToast(e.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Padding(
          padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
          child: arrOrganization.length > 0
              ? Row(
                  children: <Widget>[
                    showFirstHalf(),
                    Expanded(
                      flex: 1,
                      child: Injector.isBusinessMode
                          ? Card(
                              color: Colors.transparent,
                              elevation: 20,
                              margin: EdgeInsets.all(0),
                              child: showSecondHalf(),
                            )
                          : showSecondHalf(),
                    )
                  ],
                )
              : Container(),
        ),
      ],
    );
  }

  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
          borderRadius:
              Injector.isBusinessMode ? null : BorderRadius.circular(20),
          image: Injector.isBusinessMode
              ? DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("business_sec_header")),
                  fit: BoxFit.fill)
              : null),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              Utils.getText(context, StringRes.sector),
              style: TextStyle(color: ColorRes.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              Utils.getText(context, StringRes.size),
              style: TextStyle(color: ColorRes.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return InkResponse(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 10),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 8),
        decoration: BoxDecoration(
            image: (selectedOrg.type == arrOrganization[index].type)
                ? DecorationImage(
                    image: AssetImage(Utils.getAssetsImg(
                        Injector.isBusinessMode ? "bs_bg" : "bg_bs_prof")),
                    fit: BoxFit.fill)
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Container(
                height: 32,
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Injector.isBusinessMode ? null : ColorRes.white,
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_bus_sector_item")),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  arrOrganization[index].name,
                  style: TextStyle(
                    color: Injector.isBusinessMode
                        ? ColorRes.blue
                        : ColorRes.textProf,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5, right: 10, top: 2, bottom: 2),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(Utils.getAssetsImg("value")),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  arrOrganization[index].level.toString(),
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 22,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Utils.playClickSound();
        if (mounted)setState(() {
          selectedOrg = arrOrganization[index];
          selectedIndex = index;
        });
      },
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CommonView.showTitle(context, StringRes.organizations),
//          showSubHeader(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: arrOrganization.length,
            itemBuilder: (BuildContext context, int index) {
              return showItem(index);
            },
          )
        ],
      ),
    );
  }

  showSecondHalf() {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(0),
      child: Container(
        color: Injector.isBusinessMode ? null : Color(0xFFeaeaea),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Injector.isBusinessMode
                        ? ColorRes.whiteDarkBg
                        : ColorRes.white,
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 30, bottom: 10),
                      decoration: BoxDecoration(
                        color: Injector.isBusinessMode
                            ? ColorRes.bgDescription
                            : ColorRes.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Injector.isBusinessMode
                            ? Border.all(color: ColorRes.white, width: 1)
                            : null,
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          arrOrganization[selectedIndex].description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Injector.isBusinessMode
                                  ? ColorRes.white
                                  : ColorRes.textProf,fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: Utils.getTitleHeight(),
                      margin: EdgeInsets.only(
                          top: Injector.isBusinessMode ? 3 : 5,
                          left: Utils.getDeviceWidth(context) / 10,
                          right: Utils.getDeviceWidth(context) / 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                          color: Injector.isBusinessMode
                              ? null
                              : ColorRes.titleBlueProf,
                          borderRadius: BorderRadius.circular(20),
                          image: Injector.isBusinessMode
                              ? DecorationImage(
                                  image:
                                      AssetImage(Utils.getAssetsImg("bg_blue")),
                                  fit: BoxFit.fill)
                              : null),
                      child: Text(
                        Utils.getText(context, StringRes.description),
                        style: TextStyle(color: ColorRes.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 35,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkResponse(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg('minus_pro')),
                        width: 30,
                      ),
                    ),
                    onTap: () {
                      showConfirmDialog(Const.subtract);
                    },
                  ),
                  arrOrganization.length > 0
                      ? Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Container(
                              height: 27,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorRes.greyText,
//                          image: Injector.isBusinessMode
//                              ? DecorationImage(
//                                  image: AssetImage(
//                                      Utils.getAssetsImg('bg_progress')),
//                                  fit: BoxFit.fill)
//                              : null,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Injector.isBusinessMode
                                      ? null
                                      : Border.all(
                                          color: ColorRes.white, width: 1)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Injector.isBusinessMode ? 0 : 3),
                              child: LinearPercentIndicator(
                                width: Utils.getDeviceWidth(context) / 7,
                                lineHeight: 25.0,
                                percent: Utils.getProgress(
                                    arrOrganization[selectedIndex]),
                                backgroundColor: Colors.transparent,
                                progressColor: ColorRes.titleBlueProf,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  InkResponse(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg('plus_pro')),
                        width: 30,
                      ),
                    ),
                    onTap: () {
                      showConfirmDialog(Const.add);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getProgress() {
    if (arrOrganization[selectedIndex].employeeCount == null) return 0.0;

    var progress = arrOrganization[selectedIndex].employeeCount /
        (organizationData.totalEmployeeCapacity != 0
            ? organizationData.totalEmployeeCapacity
            : 1);

    return progress.toDouble();
  }

  Future<void> showConfirmDialog(int action) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(action == Const.add
              ? selectedOrg.addLevelConfirmMessage != null
                  ? selectedOrg.addLevelConfirmMessage
                  : ""
              : selectedOrg.subtractLevelConfirmMessage != null
                  ? selectedOrg.subtractLevelConfirmMessage
                  : ""),
          actions: <Widget>[
            FlatButton(
              child: Text(Utils.getText(context, StringRes.yes)),
              onPressed: () {
                manageLevel(action);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(Utils.getText(context, StringRes.no)),
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

  manageLevel(int action) {
    Utils.isInternetConnectedWithAlert().then((_) {
      ManageOrganizationRequest rq = ManageOrganizationRequest();
      rq.userId = Injector.userData.userId;
      rq.action = action;
      rq.type = selectedOrg.type;
      rq.mode = Injector.mode;

      CommonView.showCircularProgress(true, context);

      WebApi().callAPI(WebApi.rqManageOrganization, rq.toJson()).then((data) {
        CommonView.showCircularProgress(false, context);

        if (data != null) {
          ManageOrgData manageOrgData = ManageOrgData.fromJson(data);

          arrOrganization[selectedIndex] = manageOrgData.organization[0];
          organizationData.organization = arrOrganization;
          selectedOrg =  manageOrgData.organization[0];

          Utils.performManageLevel(manageOrgData);

          if (mounted)setState(() {});
        } else {
          Utils.getText(context, StringRes.somethingWrong);
        }
      }).catchError((e) {
        print("manageOrg_" + e.toString());
        CommonView.showCircularProgress(false, context);
        // Utils.showToast(e.toString());
      });
    });
  }
}
