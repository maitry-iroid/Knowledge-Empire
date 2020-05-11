import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/intro.dart';
import 'package:ke_employee/models/on_off_feature.dart';

import '../helper/constant.dart';

class DashboardProfPage extends StatefulWidget {
  DashboardProfPage({Key key}) : super(key: key);

  DashboardProfPageState createState() => DashboardProfPageState();
}

class DashboardProfPageState extends State<DashboardProfPage> {
  List<String> arrType = List();

  @override
  void initState() {
    super.initState();

    arrType = initFeatureDataArray();
    getDashboardStatus();

    if (Injector.introData == null) {
      getIntroData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.only(top: Utils.getDeviceHeight(context) / 7.5),
            height: double.infinity,
            width: double.infinity,
            child: showMainView()),
      ),
    );
  }

  getDashboardStatus() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardStatusRequest rq = DashboardStatusRequest();
        rq.userId = Injector.userData.userId;

        WebApi().callAPI(WebApi.rqGetDashboardStatus, rq.toJson()).then((data) {
          if (data != null) {
            DashboardStatusResponse response =
                DashboardStatusResponse.fromJson(data);

            if (response.data.isNotEmpty) {
              Injector.prefs.setString(
                  PrefKeys.dashboardStatusData, jsonEncode(response.toJson()));
              Injector.dashboardStatusResponse = response;

              arrType = initFeatureDataArray();

              if (mounted) setState(() {});
            }
          }
        }).catchError((e) {
          print("getDashboardValue_" + e.toString());
        });
      }
    });
  }

  showProfile() {
    return Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorRes.colorPrimary)),
    );
  }

  showMainView() {
    return Container(
        margin: EdgeInsets.all(5),
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 2.1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: List.generate(arrType.length, (index) {
            return showMainItem(arrType[index]);
          }),
        ));
  }

  showMainItem(String type) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InkResponse(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage(Utils.getAssetsImg("ic_pro_bg_main_card")),
                    //bg_main_card
                    fit: BoxFit.fill)),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage(Utils.getAssetsImg(getImage(type))),
                      width: Utils.getDeviceHeight(context) / 5.8,
                    ),
                    Utils.isShowUnreadCount(type)
                        ? Utils.showUnreadCount(type, 2, 2)
                        : Container(
                            width: 25,
                            height: 25,
                          )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    getTitle(type),
                    maxLines: 2,
                    style:
                        TextStyle(color: ColorRes.colorPrimary, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Utils.performDashboardItemClick(context, type);
          },
        ),
        Utils.isShowLock(type) ? Utils.lockUi(type, context) : Container(),
      ],
    );
  }

  getTitle(String type) {
    if (type == Const.typeBusinessSector)
      return Utils.getText(context, StringRes.businessSector);
    else if (type == Const.typeNewCustomer)
      return Utils.getText(context, StringRes.newCustomers);
    else if (type == Const.typeExistingCustomer)
      return Utils.getText(context, StringRes.existingCustomers);
    else if (type == Const.typeOrg)
      return Utils.getText(context, StringRes.organizations);
    else if (type == Const.typeChallenges)
      return Utils.getText(context, StringRes.challenges);
    else if (type == Const.typePl)
      return Utils.getText(context, StringRes.pl);
    else if (type == Const.typeReward)
      return Utils.getText(context, StringRes.rewards);
    else if (type == Const.typeRanking)
      return Utils.getText(context, StringRes.ranking);
    else if (type == Const.typeTeam)
      return Utils.getText(context, StringRes.team);
    else
      return "";
  }

  getImage(String type) {
    if (type == Const.typeBusinessSector)
      return "ic_pro_home_business";
    else if (type == Const.typeNewCustomer)
      return "ic_pro_home_customer";
    else if (type == Const.typeExistingCustomer)
      return "ic_pro_home_exis_customer";
    else if (type == Const.typeOrg)
      return "ic_pro_home_organization";
    else if (type == Const.typeChallenges)
      return "ic_pro_home_challenges";
    else if (type == Const.typePl)
      return "ic_pro_home_pl";
    else if (type == Const.typeReward)
      return "ic_pro_home_rewards";
    else if (type == Const.typeRanking)
      return "ic_pro_home_ranking";
    else if (type == Const.typeTeam)
      return "ic_pro_home_team";
    else
      return "";
  }

  getIntroData() {
    if (Injector.getIntroData() != null) return;

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        CommonView.showCircularProgress(true, context);

        IntroRequest rq = IntroRequest();
        rq.userId = Injector.userId;
        rq.type = 1;

        WebApi().callAPI(WebApi.rqGameIntro, rq.toJson()).then((data) async {
          CommonView.showCircularProgress(false, context);
          if (data != null) {
            IntroData introData = IntroData.fromJson(data);
            await Injector.setIntroData(introData);
          }
        }).catchError((e) {
          CommonView.showCircularProgress(false, context);
          print("getIntro" + e.toString());
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  List<String> initFeatureDataArray() {
    List<String> arrTypeData = List();

    arrTypeData.add(Const.typeBusinessSector);
    arrTypeData.add(Const.typeNewCustomer);
    arrTypeData.add(Const.typeExistingCustomer);

    if (Utils.isFeatureOn(Const.typeReward)) arrTypeData.add(Const.typeReward);

    if (Utils.isFeatureOn(Const.typeTeam) && Injector.isManager()) arrTypeData.add(Const.typeTeam);

    if (Utils.isFeatureOn(Const.typeChallenges)) arrTypeData.add(Const.typeChallenges);

    if (Utils.isFeatureOn(Const.typeOrg)) arrTypeData.add(Const.typeOrg);

    if (Utils.isFeatureOn(Const.typePl)) arrTypeData.add(Const.typePl);

    if (Utils.isFeatureOn(Const.typeRanking)) arrTypeData.add(Const.typeRanking);

    return arrTypeData;
  }
}
