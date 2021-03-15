import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/common_view.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/header_utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../commonview/header.dart';
import '../helper/constant.dart';

/*
*   created by Riddhi
*
*   User can get brief details about all the features here
*
* */

class FadeRouteIntro extends PageRouteBuilder {
  final Widget page;

  FadeRouteIntro({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: HelpPage(),
          ),
        );
}

class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  AnimationController controller;
  Animation<double> animation;
  List<String> arrType = List();

  @override
  void initState() {
    super.initState();

    arrType = initFeatureDataArray();

    Injector.prefs.setBool(PrefKeys.isLoginFirstTime, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              CommonView.showDashboardView(context),
              HeaderView(
                scaffoldKey: _scaffoldKey,
                isShowMenu: true,
              ),
              Container(
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg("intro_bub_background")), fit: BoxFit.fill)),
              ),
              showIntroBubbleView(),
              showSelectedMainView(),
              showHeaderView(context)
            ],
          ),
        ),
      ),
    );
  }

  showHeaderView(BuildContext context) {
    return Container(
      width: Utils.getDeviceWidth(context),
      height: Utils.getDeviceHeight(context) / 7.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Opacity(
            child: Image(
              image: AssetImage(
                Utils.getAssetsImg("menu"),
              ),
              fit: BoxFit.fill,
            ),
            opacity: 0.1,
          ),
          showProfile(context),
          showHeaderItem(Const.typeEmployee, context),
          showHeaderItem(Const.typeSalesPersons, context),
          showHeaderItem(Const.typeServicesPerson, context),
          showHeaderItem(Const.typeBrandValue, context),
          showHeaderItem(Const.typeMoney, context),
          Opacity(
            child: Container(
              width: 20,
            ),
            opacity: getSelectedType() == Const.typeProfile ? 0 : 0,
          ),
        ],
      ),
    );
  }

  showHeaderItem(String type, BuildContext context) {
    return Opacity(
      opacity: getSelectedType() == type ? 1 : 0,
      child: Container(
        foregroundDecoration: null,
        padding: EdgeInsets.symmetric(horizontal: Injector.isBusinessMode ? 4 : 2),
        decoration: BoxDecoration(
            image: Injector.isBusinessMode ? DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_header_card")), fit: BoxFit.fill) : null),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Injector.isBusinessMode
                    ? Container()
                    : Container(
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: ColorRes.titleBlueProf,
                            border: Border.all(color: ColorRes.white, width: 1),
                            borderRadius: BorderRadius.circular(12.5)),
                      ),
                Image(
                  image: AssetImage(Utils.getAssetsImg(HeaderUtils.getHeaderIcon(type))),
                  height: 26,
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            type != Const.typeMoney
                ? Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Container(
                        height: Injector.isBusinessMode ? 22 : 23,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorRes.greyText,
                            borderRadius: BorderRadius.circular(12),
                            border: Injector.isBusinessMode ? null : Border.all(color: ColorRes.white, width: 1)),
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: Injector.isBusinessMode ? 0 : 1),
                        child: LinearPercentIndicator(
                          width: Utils.getDeviceWidth(context) / 12,
                          lineHeight: 22.0,
                          percent: HeaderUtils.getProgressInt(type)?.toDouble() ?? 0.toDouble(),
                          backgroundColor: Colors.transparent,
                          progressColor: Injector.isBusinessMode ? Colors.blue : ColorRes.titleBlueProf,
                        ),
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          HeaderUtils.getProgress(type).toString() + (type == Const.typeBrandValue ? "%" : ""),
                          style: TextStyle(color: ColorRes.white, fontSize: 17),
                        ),
                      )
                    ],
                  )
                : Text(
                    Injector.customerValueData != null ? Injector.customerValueData.totalBalance.toString() : "00.00",
                    style: TextStyle(color: ColorRes.white, fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }

  showProfile(BuildContext context) {
    return Expanded(
      child: Container(
        foregroundDecoration: null,
        child: Row(
          children: <Widget>[
            Opacity(
              opacity: getSelectedType() == Const.typeProfile ? 1 : 0,
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: Injector.userData == null || Injector.userData.profileImage == null || Injector.userData.profileImage.isEmpty
                            ? AssetImage(Utils.getAssetsImg('user_org'))
                            : Utils.getCacheNetworkImage(Injector.userData.profileImage),
                        fit: BoxFit.fill),
                    border: Border.all(color: ColorRes.textLightBlue)),
              ),
            ),
            showUserNameCompanyName(context),
          ],
        ),
      ),
    );
  }

  showUserNameCompanyName(BuildContext context) {
    return Expanded(
        child: Opacity(
      opacity: getSelectedType() == Const.typeName ? 1 : 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Injector.userData != null ? Injector.userData.companyName : "",
            style: TextStyle(color: Injector.isBusinessMode ? ColorRes.textLightBlue : ColorRes.white, fontSize: 17),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            Injector.userData != null ? Injector.userData.name : "",
            style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.textLightBlue, fontSize: 17),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ));
  }

  showSelectedMainView() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 40,
          child: Row(
            children: <Widget>[
              getSelectedType() == Const.typeOrg
                  ? InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("organization")),
                        width: Utils.getDeviceWidth(context) / 4.5,
                      ),
                      onTap: () {},
                    )
                  : Container(
                      width: Utils.getDeviceWidth(context) / 4.5,
                    ),
              getSelectedType() == Const.typePl
                  ? InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("profit-loss")),
                        width: Utils.getDeviceWidth(context) / 4.4,
                      ),
                      onTap: () {},
                    )
                  : Container(
                      width: Utils.getDeviceWidth(context) / 4.5,
                    ),
              getSelectedType() == Const.typeRanking
                  ? InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("ranking")),
                        width: Utils.getDeviceWidth(context) / 4.3,
                      ),
                      onTap: () {},
                    )
                  : Container(
                      width: Utils.getDeviceWidth(context) / 4.5,
                    ),
            ],
          ),
        ),
        Container(
          width: Utils.getDeviceWidth(context),
          margin: EdgeInsets.only(
            top: Utils.getDeviceHeight(context) / 4.2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 40, left: 38),
                child: getSelectedType() == Const.typeAchievement
                    ? InkResponse(
                        child: Image(
                          image: AssetImage(Utils.getAssetsImg("rewards")),
                          width: Utils.getDeviceHeight(context) / 3.0,
                        ),
                      )
                    : Container(
                        width: Utils.getDeviceHeight(context) / 3.0,
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15, left: 55, right: 0),
                child: getSelectedType() == Const.typeTeam
                    ? InkResponse(
                        child: Image(
                          image: AssetImage(Utils.getAssetsImg("team")),
                          width: Utils.getDeviceHeight(context) / 3.0,
                        ),
                      )
                    : Container(
                        width: Utils.getDeviceHeight(context) / 3.0,
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0, left: 0, right: 28, top: 00),
                child: getSelectedType() == Const.typeChallenges
                    ? InkResponse(
                        child: Image(
                          image: AssetImage(Utils.getAssetsImg("challenges")),
                          width: Utils.getDeviceHeight(context) / 2.6,
                        ),
                        onTap: () {})
                    : Container(width: Utils.getDeviceHeight(context) / 2.6),
              ),
            ],
          ),
        ),
        Container(
          width: Utils.getDeviceWidth(context),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              getSelectedType() == Const.typeBusinessSector
                  ? Image(
                      image: AssetImage(Utils.getAssetsImg("business_sectors")),
                      width: Utils.getDeviceWidth(context) / 3.3,
                    )
                  : Container(width: Utils.getDeviceWidth(context) / 3.8),
              getSelectedType() == Const.typeNewCustomer
                  ? Image(
                      image: AssetImage(Utils.getAssetsImg("new-customer")),
                      width: Utils.getDeviceWidth(context) / 4.3,
                    )
                  : Container(
                      width: Utils.getDeviceWidth(context) / 4.2,
                    ),
              getSelectedType() == Const.typeExistingCustomer
                  ? InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("existing")),
                        width: Utils.getDeviceWidth(context) / 4.3,
                      ),
                      onTap: () {})
                  : Container(
                      width: Utils.getDeviceWidth(context) / 4.6,
                    ),
            ],
          ),
        ),
        getSelectedType() == Const.typeReward ? Container(
           child: Positioned(
              bottom: Utils.getDeviceHeight(context) / 6.5,
              left: Utils.getDeviceWidth(context) / 3.5,
              child: Image(
                image: AssetImage(Utils.getAssetsImg('ic_gift_drawer')),
              )
            )
        ) : Container()
      ],
    );
  }

  showMainView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_dashboard_new")), fit: BoxFit.fill)),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 40,
            child: Row(
              children: <Widget>[
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("organization")),
                    width: Utils.getDeviceWidth(context) / 4.3,
                  ),
                  onTap: () {},
                ),
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("profit-loss")),
                    width: Utils.getDeviceWidth(context) / 4.2,
                  ),
                ),
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("ranking")),
                    width: Utils.getDeviceWidth(context) / 4.2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 3.2,
            right: Utils.getDeviceWidth(context) / 3.5,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("papers_rack")),
              height: Utils.getDeviceHeight(context) / 9,
            ),
          ),
          Container(
            width: Utils.getDeviceWidth(context),
            margin: EdgeInsets.only(
              top: Utils.getDeviceHeight(context) / 4.2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 40, left: 20),
                    child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("rewards")),
                        width: Utils.getDeviceHeight(context) / 3.0,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 15, left: 40, right: 0),
                    child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("team")),
                        width: Utils.getDeviceHeight(context) / 3.9,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 0, left: 0, right: 30, top: 00),
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("challenges")),
                      width: Utils.getDeviceHeight(context) / 2.6,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              width: Utils.getDeviceWidth(context),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("business_sectors")),
                      width: Utils.getDeviceWidth(context) / 3.4,
                    ),
                  ),
                  InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("new-customer")),
                      width: Utils.getDeviceWidth(context) / 4.2,
                    ),
                  ),
                  InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("existing")),
                      width: Utils.getDeviceWidth(context) / 4.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 3.2,
            left: Utils.getDeviceWidth(context) / 3.5,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("pencils")),
              height: Utils.getDeviceHeight(context) / 5,
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 6,
            left: Utils.getDeviceWidth(context) / 3.3,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("mobile")),
              height: Utils.getDeviceHeight(context) / 12,
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 12,
            left: Utils.getDeviceWidth(context) / 4,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("glasses")),
              height: Utils.getDeviceHeight(context) / 15,
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 8,
            right: Utils.getDeviceWidth(context) / 3.7,
            child: Image(
              image: AssetImage(Utils.getAssetsImg("coffee_cup")),
              height: Utils.getDeviceHeight(context) / 8,
            ),
          ),
        ],
      ),
    );
  }

  popAndNextTutorial(BuildContext context) {}

  showIntroBubbleView() {
    double headerBubHeight = Utils.getDeviceHeight(context) - 70;
    double topMargin = DimenRes.titleBarHeight + 10;

    return Container(
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          getSelectedType() == Const.typeProfile
              ? Positioned(
                  top: topMargin,
                  left: 40,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleProfile())),
                      fit: BoxFit.fitWidth,
                      height: headerBubHeight,
//                      width: Utils.getDeviceHeight(context) / 1.3,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeName
              ? Positioned(
                  top: topMargin,
                  left: 60,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleCompanyName())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeEmployee
              ? Positioned(
                  top: topMargin,
                  left: Utils.getDeviceWidth(context) / 3.0,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleEmp())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeSalesPersons
              ? Positioned(
                  top: topMargin,
                  left: Utils.getDeviceWidth(context) / 2,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleSales())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeServicesPerson
              ? Positioned(
                  top: topMargin,
                  right: 0,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleCustomer())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeBrandValue
              ? Positioned(
                  top: topMargin,
                  right: 50,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleBrandValue())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeMoney
              ? Positioned(
                  top: topMargin,
                  right: 20,
//            right: Utils.getDeviceWidth(context) / 2.9,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleCash())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

//--------------------------------------------------------------------------------------------------------------

          getSelectedType() == Const.typeBusinessSector
              ? Positioned(
                  bottom: 30,
                  left: Utils.getDeviceWidth(context) / 3.2,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg(introShowBubbleBusinessSectors())),
                        height: headerBubHeight,
                      ),
                      onTap: () {}),
                )
              : Container(),

          getSelectedType() == Const.typeNewCustomer
              ? Positioned(
                  bottom: 50,
                  left: Utils.getDeviceWidth(context) / 3.4,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg(introShowBubbleNewCustomer())),
                        height: headerBubHeight,
                      ),
                      onTap: () {}),
                )
              : Container(),

          getSelectedType() == Const.typeExistingCustomer
              ? Positioned(
                  bottom: 15,
                  left: Utils.getDeviceWidth(context) / 3.6,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg(introShowBubbleExistingCustomer())),
                        height: headerBubHeight,
                      ),
                      onTap: () {}),
                )
              : Container(),

          getSelectedType() == Const.typeAchievement
              ? Positioned(
                  bottom: Utils.getDeviceHeight(context) / 4.2,
                  left: Utils.getDeviceWidth(context) / 3.5,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleAchievements())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeReward
              ? Positioned(
                  bottom: Utils.getDeviceHeight(context) / 4.2,
                  left: Utils.getDeviceWidth(context) / 3.5,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleRewards())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeTeam
              ? Positioned(
                  bottom: 80,
                  left: Utils.getDeviceWidth(context) / 1.8,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleTeam())),
                      height: headerBubHeight,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeChallenges
              ? Positioned(
                  top: 00,
                  right: Utils.getDeviceWidth(context) / 4,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleChallenges())),
                      height: headerBubHeight + 70,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          getSelectedType() == Const.typeOrg
              ? Positioned(
                  top: topMargin,
                  left: Utils.getDeviceWidth(context) / 2.7,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg(introShowBubbleOrganization())),
                        height: headerBubHeight + 50,
                      ),
                      onTap: () {}),
                )
              : Container(),

          getSelectedType() == Const.typePl
              ? Positioned(
                  top: 40,
                  left: Utils.getDeviceWidth(context) / 3.8,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg(introShowBubblePl())),
                        height: headerBubHeight + 40,
                      ),
                      onTap: () {}),
                )
              : Container(),

          getSelectedType() == Const.typeRanking
              ? Positioned(
                  top: 50,
                  right: Utils.getDeviceWidth(context) / 2.7,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBubbleRanking())),
                      height: headerBubHeight + 40,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),
//-------------------------------------------------------------------------------------------------------

          selectedIndex > 0
              ? Positioned(
                  top: Utils.getDeviceHeight(context) / 2.35,
                  left: 10,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowBack())),
                      height: Utils.getDeviceHeight(context) / 10,
                    ),
                    onTap: () {
//                      if(currentVol != 0) {
                      Utils.playClickSound();
//                      }

                      if (selectedIndex > 0) {
                        selectedIndex -= 1;
                        setState(() {});
                      }
                    },
                  ),
                )
              : Container(),

          selectedIndex < arrType.length - 1
              ? Positioned(
                  top: Utils.getDeviceHeight(context) / 2.35,
                  right: 10,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg(introShowNext())),
                      height: Utils.getDeviceHeight(context) / 10,
                    ),
                    onTap: () {
                      Utils.playClickSound();
                      if (selectedIndex < arrType.length - 1) {
                        selectedIndex += 1;
                        setState(() {});
                      }
                    },
                  ),
                )
              : Container(
                  child: Positioned(
                      top: Utils.getDeviceHeight(context) / 2.35,
                      right: 10,
                      child: InkResponse(
                        child: Image(
                          image: AssetImage(Utils.getAssetsImg(introShowEnter())),
                          height: Utils.getDeviceHeight(context) / 10,
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                      )))
        ],
      ),
    );
  }

  //show bubble with name

  introShowBubbleProfile() {
    if (Injector.userData.language == "English") {
      return "intro_bub_profile_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_profile_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_profile_zh";
    }
  }

  introShowBubbleCompanyName() {
    if (Injector.userData.language == "English") {
      return "intro_bub_companyname_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_companyname_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_companyname_zh";
    }
  }

  introShowBubbleEmp() {
    if (Injector.userData.language == "English") {
      return "intro_bub_emp_stat_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_emp_stat_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_emp_stat_zh";
    }
  }

  introShowBubbleSales() {
    if (Injector.userData.language == "English") {
      return "intro_bub_sales_stat_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_sales_stat_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_sales_stat_zh";
    }
  }

  introShowBubbleCustomer() {
    if (Injector.userData.language == "English") {
      return "intro_bub_customer_stat_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_customer_stat_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_customer_stat_zh";
    }
  }

  introShowBubbleBrandValue() {
    if (Injector.userData.language == "English") {
      return "intro_bub_brand_value_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_brand_value_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_brand_value_zh";
    }
  }

  introShowBubbleCash() {
    if (Injector.userData.language == "English") {
      return "intro_bub_cash_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_cash_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_cash_zh";
    }
  }

  introShowBubbleBusinessSectors() {
    if (Injector.userData.language == "English") {
      return "intro_bub_business_sectors_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_business_sectors_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_business_sectors_zh";
    }
  }

  introShowBubbleNewCustomer() {
    if (Injector.userData.language == "English") {
      return "intro_bub_new_customer_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_new_customer_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_new_customer_zh";
    }
  }

  introShowBubbleExistingCustomer() {
    if (Injector.userData.language == "English") {
      return "intro_bub_existing_customer_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_existing_customer_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_existing_customer_zh";
    }
  }

  introShowBubbleAchievements() {
    if (Injector.userData.language == "English") {
      return "intro_bub_achievement_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_achievement_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_achievement_zh";
    }
  }

  introShowBubbleRewards() {
    if (Injector.userData.language == "English") {
      return "intro_bub_rewards_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_rewards_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_rewards_zh";
    }
  }

  introShowBubbleTeam() {
    if (Injector.userData.language == "English") {
      return "intro_bub_team_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_team_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_team_zh";
    }
  }

  introShowBubbleChallenges() {
    if (Injector.userData.language == "English") {
      return "intro_bub_challenges_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_challenges_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_challenges_zh";
    }
  }

  introShowBubbleOrganization() {
    if (Injector.userData.language == "English") {
      return "intro_bub_organization_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_organization_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_organization_zh";
    }
  }

  introShowBubblePl() {
    if (Injector.userData.language == "English") {
      return "intro_bub_pl_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_pl_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_pl_zh";
    }
  }

  introShowBubbleRanking() {
    if (Injector.userData.language == "English") {
      return "intro_bub_ranking_en";
    } else if (Injector.userData.language == "German") {
      return "intro_bub_ranking_de";
    } else if (Injector.userData.language == "Chinese") {
      return "intro_bub_ranking_zh";
    }
  }

  introShowBack() {
    if (Injector.userData.language == "English") {
      return "back_eng";
    } else if (Injector.userData.language == "German") {
      return "back_de";
    } else if (Injector.userData.language == "Chinese") {
      return "back_zh";
    }
  }

  introShowEnter() {
    if (Injector.userData.language == "English") {
      return "enter_eng";
    } else if (Injector.userData.language == "German") {
      return "enter_de";
    } else if (Injector.userData.language == "Chinese") {
      return "enter_zh";
    }
  }

  introShowNext() {
    if (Injector.userData.language == "English") {
//      return "intro_bub_next";
      return "next_eng";
    } else if (Injector.userData.language == "German") {
      return "next_de";
    } else if (Injector.userData.language == "Chinese") {
      return "next_zh";
    }
  }

  getSelectedType() {
    return arrType[selectedIndex];
  }

  List<String> initFeatureDataArray() {
    List<String> arrTypeData = List();

    arrTypeData.add(Const.typeProfile);
    arrTypeData.add(Const.typeName);

    if (Utils.isFeatureOn(Const.typeOrg)) {
      arrTypeData.add(Const.typeEmployee);
      arrTypeData.add(Const.typeSalesPersons);
      arrTypeData.add(Const.typeServicesPerson);
    }
    arrTypeData.add(Const.typeBrandValue);
    arrTypeData.add(Const.typeMoney);

    arrTypeData.add(Const.typeBusinessSector);
    arrTypeData.add(Const.typeNewCustomer);
    arrTypeData.add(Const.typeExistingCustomer);

    if (Utils.isFeatureOn(Const.typeAchievement)) arrTypeData.add(Const.typeAchievement);

    if (Utils.isFeatureOn(Const.typeReward)) arrTypeData.add(Const.typeReward);

    if (Utils.isFeatureOn(Const.typeTeam) && Injector.isManager()) arrTypeData.add(Const.typeTeam);
    if (Utils.isFeatureOn(Const.typeChallenges)) arrTypeData.add(Const.typeChallenges);

    if (Utils.isFeatureOn(Const.typeOrg)) arrTypeData.add(Const.typeOrg);
    if (Utils.isFeatureOn(Const.typePl)) arrTypeData.add(Const.typePl);

    if (Utils.isFeatureOn(Const.typeRanking)) arrTypeData.add(Const.typeRanking);

    return arrTypeData;
  }
}
