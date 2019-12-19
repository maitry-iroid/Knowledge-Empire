import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/business_sector.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'P+L.dart';
import 'helper/constant.dart';
import 'home.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: Utils.getDeviceHeight(context) / 7.5),
          height: double.infinity,
          width: double.infinity,
          child: showMainView()
        ),
      ),
    );
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
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorRes.greenDot),
                  ),
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
                style: TextStyle(color: ColorRes.colorPrimary, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Utils.playClickSound();
        performItemClick(type);
      },
    );
  }

  performItemClick(int type) {

    Navigator.push(context, FadeRouteHome(initialPageType: type));

//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => HomePage(
//                  initialPageType: type,
//                )));
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

  /*getImage(int type) {
    if (type == Const.typeBusinessSector)
      return "ic_business";
    else if (type == Const.typeNewCustomer)
      return "ic_new_customer";
    else if (type == Const.typeExistingCustomer)
      return "ic_existing_customer";
    else if (type == Const.typeOrg)
      return "ic_org";
    else if (type == Const.typeChallenges)
      return "ic_ranking";
    else if (type == Const.typePL)
      return "ic_PL";
    else if (type == Const.typeReward)
      return "ic_reward";
    else if (type == Const.typeRanking)
      return "ic_ranking";
    else if (type == Const.typeTeam)
      return "ic_team";
    else
      return "";
  }*/

  String getHeaderIcon(int type) {
    if (type == Const.typeSalesPersons)
      return "ic_checked_header";
    else if (type == Const.typeEmployee)
      return "ic_people";
    else if (type == Const.typeBadge)
      return "ic_badge";
    else if (type == Const.typeServicesPerson)
      return "ic_resourses";
    else if (type == Const.typeDollar)
      return "ic_dollar";
    else
      return "";
  }

  getProgress(int type) {
    if (type == Const.typeSalesPersons) {
      return "30/100";
    } else if (type == Const.typeEmployee) {
      return "50/100";
    } else if (type == Const.typeBadge) {
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
    } else if (type == Const.typeBadge) {
      return 0.6;
    } else if (type == Const.typeServicesPerson) {
      return 0.8;
    } else
      return 0.5;
  }
}
