import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'helper/Utils.dart';
import 'helper/string_res.dart';

class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  int _selectedItem = 0;

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
              SizedBox(
                height: 10,
              ),
              CommonView.showTitle(context, StringRes.challenges),
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
  }

  showMainBody() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
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

  showFriends() {
    return Expanded(
      flex: 3,
      child: Card(
        color: ColorRes.bgProf,
        margin: EdgeInsets.all(0),
        shape: getBorderShape(),
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(),
          decoration: getBoxDecoration(),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 25,
                margin: EdgeInsets.only(bottom: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Injector.isBusinessMode
                      ? ColorRes.blue
                      : ColorRes.titleBlueProf,
                ),
                child: Text(
                  Utils.getText(context, StringRes.friends),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
//                  var isSelected = true;
                  itemBuilder: (BuildContext context, int index) {
                    return showFriendItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showBusinessSectors() {
    return Expanded(
      flex: 4,
      child: Card(
        margin: EdgeInsets.only(left: 12),
        elevation: 10,
        shape: getBorderShape(),
        child: Container(
          decoration: getBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(
                              Utils.getAssetsImg("rounded_rect_blue"),
                            ),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  Utils.getText(context, StringRes.businessSector),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
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
      ),
    );
  }

  showRewards() {
    return Expanded(
      flex: 4,
      child: Card(
        elevation: 10,
        shape: getBorderShape(),
        margin: EdgeInsets.only(left: 12),
        child: Container(
          decoration: getBoxDecoration(),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 35),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(
                              Utils.getAssetsImg("rounded_rect_blue"),
                            ),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  Utils.getText(context, StringRes.rewards),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
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
                margin: EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 5),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            Utils.getAssetsImg("bg_switch_to_prfsnl")),
                        fit: BoxFit.fill)),
                child: Text(
                  Utils.getText(context, StringRes.sendChallenge),
                  style: TextStyle(color: ColorRes.white),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  showFriendItem(int index) {
    int _selectedIndex = 0;

    _onSelected(int indexs) {
      setState(() => _selectedIndex = indexs);
    }

    return GestureDetector(
      onTap: () {
        _onSelected(index);
//          selectItem(index);
//        Navigator.push(context, MaterialPageRoute(builder: (context) => Customer()));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Injector.isBusinessMode ? null : ColorRes.white,
            borderRadius: BorderRadius.circular(20),
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(
                      Utils.getAssetsImg(
                          _selectedIndex != null && _selectedIndex == index
                              ? 'bg_blue'
                              : 'rounded_rect_challenges'),
                    ),
                    fit: BoxFit.fill)
                : null),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(
          'text',
          style: TextStyle(
              color:
                  Injector.isBusinessMode ? ColorRes.white : ColorRes.fontGrey,
              fontSize: 17),
        ),
      ),
    );
  }

  showSectorItem(int index) {
    var selectItem;

    return GestureDetector(
      onTap: () {
        selectItem(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('HealthCare',
                      style: TextStyle(
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.textProf,
                          fontSize: 15)),
                ),
                RotatedBox(
                  quarterTurns: 90,
                  child: Image(
                    image: AssetImage(
                      Utils.getAssetsImg("back"),
                    ),
                    width: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                LinearPercentIndicator(
                  width: Utils.getDeviceWidth(context) / 3.6,
                  lineHeight: 20.0,
                  percent: 0.5,
                  backgroundColor: Colors.grey,
                  progressColor: Injector.isBusinessMode
                      ? Colors.blue
                      : ColorRes.titleBlueProf,
                ),
                Positioned(
                  left: 6,
                  child: Text(
                    "50%",
                    style: TextStyle(color: ColorRes.white, fontSize: 14),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  showRewardItem(int index) {
    return Container(
      color: Injector.isBusinessMode ? null : ColorRes.white,
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('HealthCare',
                    style: TextStyle(
                        color: Injector.isBusinessMode
                            ? ColorRes.white
                            : ColorRes.textProf,
                        fontSize: 18)),
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

  getBoxDecoration() {
    return BoxDecoration(
        border: Injector.isBusinessMode
            ? null
            : Border.all(width: 2, color: ColorRes.white),
        color: Injector.isBusinessMode ? ColorRes.bgBusSec : ColorRes.bgProf,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)));
  }

  getBorderShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)));
  }
}
