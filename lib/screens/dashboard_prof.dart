import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';

import '../helper/constant.dart';

class DashboardProfPage extends StatefulWidget {
  DashboardProfPage({Key key}) : super(key: key);

  DashboardProfPageState createState() => DashboardProfPageState();
}

class DashboardProfPageState extends State<DashboardProfPage> {
  List<GetDashboardData> arrDashboardData = List();

  @override
  void initState() {
    super.initState();

    getDashboardConfig();
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

  void getDashboardConfig() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        DashboardRequest rq = DashboardRequest();
        rq.userId = Injector.userData.userId;
        rq.mode = Injector.mode ?? Injector.isBusinessMode;

        WebApi().callAPI(WebApi.rqDashboard, rq.toJson()).then((data) {
          if (data != null) {
            data.forEach((v) {
              arrDashboardData.add(GetDashboardData.fromJson(v));
            });

            if (arrDashboardData.isNotEmpty) setState(() {});
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

  var arrTypeManager = [
    Const.typeBusinessSector,
    Const.typeNewCustomer,
    Const.typeExistingCustomer,
    Const.typeReward,
    Const.typeTeam,
    Const.typeChallenges,
    Const.typeOrg,
    Const.typePl,
    Const.typeRanking
  ];
  var arrType = [
    Const.typeBusinessSector,
    Const.typeNewCustomer,
    Const.typeExistingCustomer,
    Const.typeReward,
//    Const.typeTeam,
    Const.typeChallenges,
    Const.typeOrg,
    Const.typePl,
    Const.typeRanking
  ];

  showMainView() {
    return Container(
        margin: EdgeInsets.all(5),
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 2.1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: List.generate(
              Injector.isManager() ? arrTypeManager.length : arrType.length,
              (index) {
            return showMainItem(
                Injector.isManager() ? arrTypeManager[index] : arrType[index]);
          }),
        ));
  }

  showMainItem(String type) {
    return InkResponse(
      child: Container(
//         height: Utils.getDeviceHeight(context) / 15,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("ic_pro_bg_main_card")),
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
                Utils.showUnreadCount(type, 2, 2, arrDashboardData)
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                getTitle(type),
                maxLines: 2,
                style: TextStyle(color: ColorRes.colorPrimary, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Utils.playClickSound();

        Utils.performDashboardItemClick(context, type);
      },
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
}
