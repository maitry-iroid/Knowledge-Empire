import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'helper/Utils.dart';

class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: CommonView.getBGDecoration(),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              showTitle(),
              showMainBody(),
            ],
          ),
          Card(
            margin: EdgeInsets.all(0),
            elevation: 10,
            child: Container(
              color: ColorRes.colorBgDark,
              height: 1,
            ),
          ),
        ],
      ),
    );


    return Stack(
      children: <Widget>[
        Image(
          image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Column(
          children: <Widget>[
            showTitle(),
            showMainBody(),
          ],
        ),
        Card(
          margin: EdgeInsets.all(0),
          elevation: 10,
          child: Container(
            color: ColorRes.colorBgDark,
            height: 1,
          ),
        ),
      ],
    );
  }

  showTitle() {
    return Container(
//        padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(top: 10),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkResponse(
            child: Image(
              image: AssetImage(Utils.getAssetsImg("back")),
              width: DimenRes.titleBarHeight,
            ),
            onTap: () {
              Utils.performBack(context);
            },
          ),
          Container(
            alignment: Alignment.center,
            height: DimenRes.titleBarHeight,
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_blue")),
                    fit: BoxFit.fill)),
            child: Text(
              'Challenges',
              style: TextStyle(
                  color: ColorRes.colorPrimary,
                  fontSize: DimenRes.titleTextSize),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  showMainBody() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            showFriends(),
            showBusinessSectors(),
            showRewards()
          ],
        ),
      ),
    );
  }

  showFriendItem(int index) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                Utils.getAssetsImg("rounded_rect_challenges"),
              ),
              fit: BoxFit.fill)),
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        'text',
        style: TextStyle(color: ColorRes.white, fontSize: 20),
      ),
    );
  }

  showFriends() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
            border: Border.all(color: ColorRes.white, width: 1)),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 30,
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: ColorRes.blue,
              ),
              child: Text(
                'Friends',
                style: TextStyle(color: ColorRes.white, fontSize: 20),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return showFriendItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showBusinessSectors() {
    return Expanded(
      flex: 4,
      child: Container(
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: ColorRes.bgBusSec,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
//              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("rounded_rect_blue")),
              )),
              child: Text(
                'Business Sectors',
                style: TextStyle(color: ColorRes.white, fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return showSectorItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showRewards() {
    return Expanded(
      flex: 4,
      child: Container(
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: ColorRes.bgBusSec,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
//              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("rounded_rect_blue")),
              )),
              child: Text(
                'Rewards',
                style: TextStyle(color: ColorRes.white, fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return showFriendItem(index);
                },
              ),
            ),
            InkResponse(
                child: Container(
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Image(
                image: AssetImage(Utils.getAssetsImg("bg_switch_to_prfsnl")),
                height: 25,
                fit: BoxFit.fill,
              ),
            )),
          ],
        ),
      ),
    );
  }

  showSectorItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('HealthCare',
                    style: TextStyle(color: ColorRes.white, fontSize: 18)),
              ),
              Image(
                image: AssetImage(
                  Utils.getAssetsImg("back"),
                ),
                width: 25,
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          LinearPercentIndicator(
            width: Utils.getDeviceWidth(context) / 3.4,
            lineHeight: 20.0,
            percent: 0.5,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          )
        ],
      ),
    );
  }

  showRewardItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('HealthCare',
                    style: TextStyle(color: ColorRes.white, fontSize: 18)),
              ),
              Image(
                image: AssetImage(
                  Utils.getAssetsImg("back"),
                ),
                width: 25,
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          LinearPercentIndicator(
            width: Utils.getDeviceWidth(context) / 3.4,
            lineHeight: 20.0,
            percent: 0.5,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
