import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:volume/volume.dart';

import 'helper/Utils.dart';
import 'helper/string_res.dart';


int currentVol;


class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<String> arrFriends = [
    "hello",
    "world",
    "good",
    "morning",
    "hello",
    "world",
    "good",
    "morning",
    "hello",
    "world",
    "good",
    "morning"
  ];
  List<String> arrRewards = ["hello", "world", "good", "morning", "hello"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    updateVolumes();
  }

  Future<void> initPlatformState() async {
    // pass any stream as parameter as per requirement
    var hello = await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + hello);
  }

  updateVolumes() async {
    // get Current Volume
    currentVol = await Volume.getVol;
    print(currentVol);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Column(
          children: <Widget>[
            SizedBox(
              height:Utils.getHeaderHeight(context)+ 10,
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
                  itemCount: arrFriends.length,
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
                  itemCount: arrRewards.length,
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

  int selectedIndex = -1;

  _onSelected(int index) {
    setState(() => selectedIndex = index);
  }

  showFriendItem(int index) {
    return GestureDetector(
      onTap: () {
        if(currentVol != 0) {
          _onSelected(index);
        }
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
                      selectedIndex != null && selectedIndex == index
                          ? Utils.getAssetsImg('bg_blue')
                          : Utils.getAssetsImg('rounded_rect_challenges'),
                    ),
                    fit: BoxFit.fill)
                : null),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(
          arrFriends[index],
          style: TextStyle(
              color:
                  Injector.isBusinessMode ? ColorRes.white : ColorRes.fontGrey,
              fontSize: 17),
        ),
      ),
    );
  }

  var selectItem = -1;

  _onSelectedSector(int index) {
    setState(() => selectItem = index);
  }

  showSectorItem(int index) {
    return GestureDetector(
      onTap: () {
        if(currentVol != 0) {
          Utils.playClickSound();
        }
        _onSelectedSector(index);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Injector.isBusinessMode ? null : ColorRes.white,
            borderRadius: BorderRadius.circular(5),
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(
                      selectItem != null && selectItem == index
                          ? Utils.getAssetsImg('challenges_bg_sector')
                          : Utils.getAssetsImg(''),
                    ),
                    fit: BoxFit.fill)
                : null),
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 5)),
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
              height: 0,
            ),
//            Padding(padding: EdgeInsets.only(bottom: 0.0,top: 10)),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 35)),
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
