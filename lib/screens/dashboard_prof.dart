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
        rq.mode = Injector.mode;

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

  showMainView() {
    return Container(
      margin: EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 2.1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: <Widget>[
          showMainItem(Const.typeBusinessSector),
          showMainItem(Const.typeNewCustomer),
          showMainItem(Const.typeExistingCustomer),
          showMainItem(Const.typeReward),
          showMainItem(Const.typeTeam),
          showMainItem(Const.typeChallenges),
          showMainItem(Const.typeOrg),
          showMainItem(Const.typePL),
          showMainItem(Const.typeRanking),
        ],
      ),
    );
  }

  showMainItem(int type) {
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

  getTitle(int type) {
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
    else if (type == Const.typePL)
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

  getImage(int type) {
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
    else if (type == Const.typePL)
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

  String getHeaderIcon(int type) {
    if (type == Const.typeSalesPersons)
      return "ic_checked_header";
    else if (type == Const.typeEmployee)
      return "ic_people";
    else if (type == Const.typeBrandValue)
      return "ic_badge";
    else if (type == Const.typeServicesPerson)
      return "ic_resourses";
    else if (type == Const.typeMoney)
      return "ic_dollar";
    else
      return "";
  }

  getProgress(int type) {
    if (type == Const.typeSalesPersons) {
      return "30/100";
    } else if (type == Const.typeEmployee) {
      return "50/100";
    } else if (type == Const.typeBrandValue) {
      return "60/100";
    } else if (type == Const.typeServicesPerson) {
      return "80/100";
    } else
      return "50/100";
  }

  getProgressInt(int type) {
    if (type == Const.typeSalesPersons) {
      return 0.3;
    } else if (type == Const.typeEmployee) {
      return 0.5;
    } else if (type == Const.typeBrandValue) {
      return 0.6;
    } else if (type == Const.typeServicesPerson) {
      return 0.8;
    } else
      return 0.5;
  }
}
