import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/business_sector.dart';
import 'package:ke_employee/challenges.dart';
import 'package:ke_employee/commonview/header.dart';
import 'package:ke_employee/existing_customers.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/new_customer.dart';
import 'package:ke_employee/p+L.dart';

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
          child: Stack(
            children: <Widget>[
              showMainView(),
              HeaderView(),
            ],
          ),
        ),
      ),
    );
  }

  showMainView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("dashboard-background")),
              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            bottom: 0,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("business_sectors")),
                height: 130,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessSectorPage()));
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: Utils.getDeviceWidth(context) / 3.7,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("glasses")),
              height: 35,
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 4,
            left: Utils.getDeviceWidth(context) / 8,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("rewards")),
              width: 120,
            ),
          ),
          Positioned(
            top: 40,
            right: 40,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("ranking")),
              height: 150,
            ),
          ),
          Positioned(
            top: 40,
            left: 50,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("organization")),
              height: 150,
            ),
          ),
          Positioned(
            top: 40,
            left: Utils.getDeviceWidth(context) / 2.9,
            right: Utils.getDeviceWidth(context) / 2.9,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("profit-loss")),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PLPage()));
              },
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 5,
            left: Utils.getDeviceWidth(context) / 2.5,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("team")),
              width: 130,
            ),
          ),
          Positioned(
            bottom: 0,
            left: Utils.getDeviceWidth(context) / 2.8,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("new-customer")),
                  height: 160,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCustomerPage()));
                }),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("existing")),
                  width: 180,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExistingCustomerPage()));
                }),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 5,
            right: Utils.getDeviceWidth(context) / 13,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("challenges")),
                width: 180,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChallengesPage()));
              },
            ),
          )
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
        } else if (type == Const.typePL) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PLPage()));
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


}
