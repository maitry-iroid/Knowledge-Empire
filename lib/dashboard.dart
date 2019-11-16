import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/business_sector.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'P+L.dart';
import 'helper/constant.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              showHeaderView(),
              Expanded(
                child: showMainView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  showHeaderItem(int type) {
    return Container(
      width: Utils.getDeviceWidth(context) / 6.6,
      height: 40,
      padding: EdgeInsets.only(left: 4),
      margin: EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_header_card")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(Utils.getAssetsImg(getHeaderIcon(type))),
            height: 30,
          ),
          SizedBox(
            width: 2,
          ),
          type!=Const.typeDollar?Expanded(
            child: Stack(
              children: <Widget>[
                LinearPercentIndicator(
                  width: Utils.getDeviceWidth(context) / 11,
                  lineHeight: 20.0,
                  percent: getProgressInt(type),
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
                Positioned(
                  top: 3,
                  left: 4,
                  bottom: 0,
                  child: Text(
                    getProgress(type),
                    style: TextStyle(color: ColorRes.white,),
                  ),
                )
              ],
            ),
          ): Text(' \$ 120.00',style: TextStyle(color: ColorRes.colorPrimary,fontSize: 20),),
        ],
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

  showHeaderView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      color: ColorRes.headerDashboard,
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(Utils.getAssetsImg("ic_menu")),
            width: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Riddhi",
                style: TextStyle(color: ColorRes.colorPrimary, fontSize: 15),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Patel",
                style: TextStyle(color: ColorRes.colorPrimary, fontSize: 15),
              )
            ],
          ),
          Expanded(
            child: Row(
              children: <Widget>[],
            ),
          ),
          showHeaderItem(Const.typeChecked),
          showHeaderItem(Const.typePeople),
          showHeaderItem(Const.typeBadge),
          showHeaderItem(Const.typeResources),
          showHeaderItem(Const.typeDollar),
          showProfile()
        ],
      ),
    );
  }

  showMainView() {
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 2.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          showMainItem(Const.typeBusinessSector),
          showMainItem(Const.typeNewCustomer),
          showMainItem(Const.typeExistingCustomer),
          showMainItem(Const.typeOrg),
          showMainItem(Const.typeChallenges),
          showMainItem(Const.typePL),
          showMainItem(Const.typeReward),
          showMainItem(Const.typeRanking),
          showMainItem(Const.typeTeam),
        ],
      ),
    );
  }

  showMainItem(int type) {
    return InkResponse(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("bg_main_card")),
                fit: BoxFit.fill)),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image(
                  image: AssetImage(Utils.getAssetsImg(getImage(type))),
                  width: Utils.getDeviceHeight(context) / 5.5,
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
        if (type == Const.typeBusinessSector) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BusinessSectorPage()));
        } else if (type == Const.typeNewCustomer) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewCustomerPage()));
        } else if (type == Const.typeExistingCustomer) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ExistingCustomerPage()));
        } else if (type == Const.typeChallenges) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChallengesPage()));
        }else if (type == Const.typePL) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PLPage()));
        }
      },
    );
  }

  getTitle(int type) {
    if (type == Const.typeBusinessSector)
      return "Business\nSector";
    else if (type == Const.typeNewCustomer)
      return "New\nCustomers";
    else if (type == Const.typeExistingCustomer)
      return "Existing\nCustomers";
    else if (type == Const.typeOrg)
      return "Organizations";
    else if (type == Const.typeChallenges)
      return "Challenges";
    else if (type == Const.typePL)
      return "P+L";
    else if (type == Const.typeReward)
      return "Rewards";
    else if (type == Const.typeRanking)
      return "Ranking";
    else if (type == Const.typeTeam)
      return "Team";
    else
      return "";
  }

  getImage(int type) {
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
  }

  String getHeaderIcon(int type) {
    if (type == Const.typeChecked)
      return "ic_checked_header";
    else if (type == Const.typePeople)
      return "ic_people";
    else if (type == Const.typeBadge)
      return "ic_badge";
    else if (type == Const.typeResources)
      return "ic_resourses";
    else if (type == Const.typeDollar)
      return "ic_dollar";
    else
      return "";
  }

   getProgress(int type) {
    if(type==Const.typeChecked){
      return "30/100";
    }else if(type==Const.typePeople){
      return "50/100";
    }else if(type==Const.typeBadge){
      return "60/100";
    }else if(type==Const.typeResources){
      return "80/100";
    }else return "50/100";
  }

  getProgressInt(int type) {
    if(type==Const.typeChecked){
      return 0.3;
    }else if(type==Const.typePeople){
      return 0.5;
    }else if(type==Const.typeBadge){
      return 0.6;
    }else if(type==Const.typeResources){
      return 0.8;
    }else return 0.5;
  }
}
