import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_tooltip/flutter_introduction_tooltip.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/header_utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../commonview/header.dart';
import 'dashboard_game.dart';
import '../helper/constant.dart';

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
  String selectedType = Const.typeProfile;

  AnimationController controller;
  Animation<double> animation;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    _notifier.notify('updateHeaderValue', 'Sending data from notfier!');
  }

  @override
  void initState() {
    super.initState();

    Injector.prefs.setBool(PrefKeys.isLoginFirstTime, false);

//    controller = AnimationController(
//      duration: const Duration(milliseconds: 1000),
//    );
//    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

//    controller.forward();
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
              CommonView.showDashboardView(context, null),
              HeaderView(
                scaffoldKey: _scaffoldKey,
                isShowMenu: true,
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            Utils.getAssetsImg("intro_bub_background")),
                        fit: BoxFit.fill)),
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
          SizedBox(
            width: 7,
          ),
          Opacity(
            child: showProfile(context),
            opacity: selectedType == Const.typeProfile ? 1 : 0,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Opacity(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    Injector.userData != null
                        ? Injector.userData.companyName
                        : "",
                    style: TextStyle(
                        color: Injector.isBusinessMode
                            ? ColorRes.textLightBlue
                            : ColorRes.white,
                        fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    Injector.userData != null ? Injector.userData.name : "",
                    style: TextStyle(
                        color: Injector.isBusinessMode
                            ? ColorRes.white
                            : ColorRes.textLightBlue,
                        fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              opacity: selectedType == Const.typeName ? 1 : 0,
            ),
          ),
          showHeaderItem(Const.typeEmployee, context),
          showHeaderItem(Const.typeSalesPersons, context),
          showHeaderItem(Const.typeServicesPerson, context),
          showHeaderItem(Const.typeBrandValue, context),
          showHeaderItem(Const.typeMoney, context),
          Opacity(
            child: showProfile(context),
            opacity: selectedType == Const.typeProfile ? 0 : 0,
          ),
        ],
      ),
    );
  }

//  showHeaderItem(String type, BuildContext context) {
//    return Opacity(
//      opacity: selectedType == type ? 1 : 0,
//      child: Container(
//        height: 40,
//        padding:
//            EdgeInsets.symmetric(horizontal: Injector.isBusinessMode ? 0 : 2),
//        margin: EdgeInsets.symmetric(horizontal: 1),
//        decoration: BoxDecoration(
//            image: Injector.isBusinessMode
//                ? DecorationImage(
//                    image: AssetImage(Utils.getAssetsImg("bg_header_card")),
//                    fit: BoxFit.fill)
//                : null),
//        child: Row(
//          children: <Widget>[
//            Stack(
//              alignment: Alignment.center,
//              children: <Widget>[
//                Injector.isBusinessMode
//                    ? Container()
//                    : Container(
//                        width: 24,
//                        height: 24,
//                        decoration: BoxDecoration(
//                            border: Border.all(color: ColorRes.white, width: 1),
//                            borderRadius: BorderRadius.circular(12.5)),
//                      ),
//                Image(
//                  image: AssetImage(
//                      Utils.getAssetsImg(HeaderUtils.getHeaderIcon(type))),
//                  height: 26,
//                ),
//              ],
//            ),
//            SizedBox(
//              width: 4,
//            ),
//            type != Const.typeMoney
//                ? Stack(
//                    alignment: Alignment.centerLeft,
//                    children: <Widget>[
//                      Container(
//                        height: Injector.isBusinessMode ? 19 : 21,
//                        alignment: Alignment.center,
//                        decoration: BoxDecoration(
//                            color: ColorRes.greyText,
////                          image: Injector.isBusinessMode
////                              ? DecorationImage(
////                                  image: AssetImage(
////                                      Utils.getAssetsImg('bg_progress')),
////                                  fit: BoxFit.fill)
////                              : null,
//                            borderRadius: BorderRadius.circular(12),
//                            border: Injector.isBusinessMode
//                                ? null
//                                : Border.all(color: ColorRes.white, width: 1)),
//                        padding: EdgeInsets.symmetric(
//                            vertical: 0,
//                            horizontal: Injector.isBusinessMode ? 0 : 1),
//                        child: LinearPercentIndicator(
//                          width: Utils.getDeviceWidth(context) / 12,
//                          lineHeight: 19.0,
//                          percent: HeaderUtils.getProgressInt(type) >= 0 &&
//                                  HeaderUtils.getProgressInt(type) <= 1
//                              ? HeaderUtils.getProgressInt(type)
//                              : 0.0,
//                          backgroundColor: Colors.transparent,
//                          progressColor: Colors.blue,
//                        ),
//                      ),
//                      Positioned(
//                        left: 4,
//                        child: Text(
//                          HeaderUtils.getProgress(type),
//                          style: TextStyle(color: ColorRes.white, fontSize: 14),
//                        ),
//                      )
//                    ],
//                  )
//                : Text(
//                    ' \$ ' +
//                        (Injector.customerValueData != null
//                            ? Injector.customerValueData.totalBalance.toString()
//                            : "50000"),
//                    style: TextStyle(color: ColorRes.white, fontSize: 16),
//                  ),
//          ],
//        ),
//      ),
//    );
//  }

  showHeaderItem(String type, BuildContext context) {
    return Opacity(
      opacity: selectedType == type ? 1 : 0,
      child: Container(
        foregroundDecoration:
        /*BoxDecoration(color: ColorRes.white.withOpacity(0.5))*/ null,
        padding:
        EdgeInsets.symmetric(horizontal: Injector.isBusinessMode ? 3 : 2),
        decoration: BoxDecoration(
            image: Injector.isBusinessMode
                ? DecorationImage(
                image: AssetImage(Utils.getAssetsImg("bg_header_card")),
                fit: BoxFit.fill)
                : null),
        child: InkResponse(
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
                        border:
                        Border.all(color: ColorRes.white, width: 1),
                        borderRadius: BorderRadius.circular(12.5)),
                  ),
                  Injector.isBusinessMode
                      ? Image(
                    image: AssetImage(Utils.getAssetsImg(
                        HeaderUtils.getHeaderIcon(type))),
                    height: 26,
                  )
                      : Text(
                    HeaderUtils.getHeadText(type),
                    style: TextStyle(fontSize: 15, color: ColorRes.white),
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
                    height: Injector.isBusinessMode ? 19 : 21,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorRes.greyText,
//                          image: Injector.isBusinessMode
//                              ? DecorationImage(
//                                  image: AssetImage(
//                                      Utils.getAssetsImg('bg_progress')),
//                                  fit: BoxFit.fill)
//                              : null,
                        borderRadius: BorderRadius.circular(12),
                        border: Injector.isBusinessMode
                            ? null
                            : Border.all(
                            color: ColorRes.white, width: 1)),
                    padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: Injector.isBusinessMode ? 0 : 1),
                    child: LinearPercentIndicator(
                      width: Utils.getDeviceWidth(context) / 12,
                      lineHeight: 19.0,
                      percent:
                      HeaderUtils.getProgressInt(type)?.toDouble() ??
                          0.toDouble(),
                      backgroundColor: Colors.transparent,
                      progressColor: Injector.isBusinessMode
                          ? Colors.blue
                          : ColorRes.titleBlueProf,
                    ),
                  ),
                  Positioned(
                    left: 4,
                    child: Text(
                      HeaderUtils.getProgress(type).toString() +
                          (type == Const.typeBrandValue ? "%" : ""),
                      style:
                      TextStyle(color: ColorRes.white, fontSize: 14),
                    ),
                  )
                ],
              )
                  : Text(
                Injector.customerValueData != null
                    ? Injector.customerValueData.totalBalance.toString()
                    : "00.00",
                style: TextStyle(color: ColorRes.white, fontSize: 16),
              ),
            ],
          ),
          onTap: () {
            if (type == Const.typeEmployee) {
              Injector.homeStreamController?.add("${Const.typeOrg}");
            } else if (type == Const.typeSalesPersons) {
              Injector.homeStreamController?.add("${Const.typeNewCustomer}");
            } else if (type == Const.typeServicesPerson) {
              Injector.homeStreamController
                  ?.add("${Const.typeExistingCustomer}");
            } else if (type == Const.typeBrandValue) {
              Injector.homeStreamController?.add("${Const.typeRanking}");
            } else if (type == Const.typeMoney) {
              Injector.homeStreamController?.add("${Const.typePl}");
            }
          },
        ),
      ),
    );
  }

  showProfile(BuildContext context) {
    return InkResponse(
        child: Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: Injector.userData.profileImage != null
                      ? NetworkImage(Injector.userData.profileImage)
                      : AssetImage(Utils.getAssetsImg('user_org')),
                  fit: BoxFit.fill),
              border: Border.all(color: ColorRes.textLightBlue)),
        ),
        onTap: () {}
      /*openProfile () {
        openProfile
//        Route route1 = MaterialPageRoute(builder: (context) => ProfilePage());
//        print(route1.isCurrent);
//        if (!route1.isCurrent) {
//          Navigator.push(context, route1);
//        }
      },*/
    );
  }

  showSelectedMainView() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 40,
//            right: Utils.getDeviceWidth(context) / 10,
          child: Row(
            children: <Widget>[
              selectedType == Const.typeOrg
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
              selectedType == Const.typePl
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
              selectedType == Const.typeRanking
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
                padding: EdgeInsets.only(bottom: 40, left: 20),
                child: selectedType == Const.typeReward
                    ? InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("rewards")),
//                      height: Utils.getDeviceHeight(context) / 2.9,
                    width: Utils.getDeviceHeight(context) / 3.0,
                  ),
                )
                    : Container(
                  width: Utils.getDeviceHeight(context) / 3.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15, left: 40, right: 0),
                child: selectedType == Const.typeTeam
                    ? InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("team")),
//                      height: Utils.getDeviceHeight(context) / 2.4,
                    width: Utils.getDeviceHeight(context) / 3.0,
                  ),
                )
                    : Container(
                  width: Utils.getDeviceHeight(context) / 3.0,
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(bottom: 0, left: 0, right: 30, top: 00),
                child: selectedType == Const.typeChallenges
                    ? InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("challenges")),
//                      height: Utils.getDeviceHeight(context) / 3.3,
                      width: Utils.getDeviceHeight(context) / 2.6,
                    ),
                    onTap: () {})
                    : Container(width: Utils.getDeviceHeight(context) / 2.6),
              ),
            ],
          ),
        ),
        Container(
//            color: ColorRes.blue,
          width: Utils.getDeviceWidth(context),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              selectedType == Const.typeBusinessSector
                  ? Image(
                image: AssetImage(Utils.getAssetsImg("business_sectors")),
//                      height: Utils.getDeviceHeight(context) / 2.85,
                width: Utils.getDeviceWidth(context) / 3.3,
              )
                  : Container(width: Utils.getDeviceWidth(context) / 3.8),
              selectedType == Const.typeNewCustomer
                  ? InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("new-customer")),
                    width: Utils.getDeviceWidth(context) / 4.3,
                  ),
                  onTap: () {
                    performItemClick(Const.typeNewCustomer);
                  })
                  : Container(
                width: Utils.getDeviceWidth(context) / 4.2,
              ),
              selectedType == Const.typeExistingCustomer
//              selectedType == Utils.getHomePageIndex(Const.typeExistingCustomer)
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
      ],
    );
  }

  showMainView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_dashboard_new")),
              fit: BoxFit.fill)),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 40,
//            right: Utils.getDeviceWidth(context) / 10,
            child: Row(
              children: <Widget>[
                InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("organization")),
                    width: Utils.getDeviceWidth(context) / 4.3,
                  ),
                  onTap: () {
                    Utils.showToast("hello");
                  },
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
//                      height: Utils.getDeviceHeight(context) / 2.9,
                        width: Utils.getDeviceHeight(context) / 3.0,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 15, left: 40, right: 0),
                    child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("team")),
//                      height: Utils.getDeviceHeight(context) / 2.4,
                        width: Utils.getDeviceHeight(context) / 3.9,
                      ),
                    )),
                Padding(
                  padding:
                  EdgeInsets.only(bottom: 0, left: 0, right: 30, top: 00),
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("challenges")),
//                      height: Utils.getDeviceHeight(context) / 3.3,
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
//              color: ColorRes.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkResponse(
//                    child: FadeTransition(
//                      opacity: animation,
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("business_sectors")),
//                      height: Utils.getDeviceHeight(context) / 2.85,
                      width: Utils.getDeviceWidth(context) / 3.4,
                    ),
//                    ),
                  ),
                  InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("new-customer")),
                      width: Utils.getDeviceWidth(context) / 4.2,
                    ),
                  ),
//                SizedBox(
//                  width: Utils.getDeviceWidth(context) / 20,
//                ),
                  InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("existing")),
//                      height: Utils.getDeviceHeight(context) / 3.1,
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

  performItemClick(String type) {
    HomeData homeData = HomeData(initialPageType: type);

    Navigator.push(context, FadeRouteHome(homeData: homeData));
  }

  bool isShowing = false;

  void showTutorial(BuildContext context) async {
    if (!isShowing) {
      new Timer(Duration(milliseconds: 100), () async {
        try {
          FlutterIntroductionTooltip.showTopTutorialOnWidget(
              context,
              _scaffoldKey,
              Colors.blue,
                  () => popAndNextTutorial(context),
              "MAMA",
              "MAMA IS A LOREM IPSUM",
              "ALRIGHT");
          print("SHOWING");
          setState(() {
            isShowing = true;
          });
        } catch (e) {
          print("ERROR $e");
        }
      });
    }
  }

  popAndNextTutorial(BuildContext context) {}


  //----------------------

  showIntroBubbleView() {
    return Container(
//      width: double.infinity,
//      height: double.infinity,
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage(Utils.getAssetsImg("dashboard-background")),
//              fit: BoxFit.fill)),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          //-----------

          selectedType == Const.typeProfile
              ? Positioned(
            top: 60,
            right: Utils.getDeviceWidth(context) / 2.3,
//            right: Utils.getDeviceWidth(context) / 2.9,
            child: InkResponse(
              child: Image(
                image:
                AssetImage(Utils.getAssetsImg(introShowBubbleProfile())),
                height: Utils.getDeviceHeight(context) / 1.9,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeName
              ? Positioned(
            top: 65,
            right: Utils.getDeviceWidth(context) / 2.0,
            child: InkResponse(
              child: Image(
                image: AssetImage(
                    Utils.getAssetsImg(introShowBubbleCompanyName())),
                height: Utils.getDeviceHeight(context) / 1.8,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeEmployee
              ? Positioned(
            top: 65,
            left: Utils.getDeviceWidth(context) / 3.9,
            child: InkResponse(
              child: Image(
                image:
                AssetImage(Utils.getAssetsImg(introShowBubbleEmp())),
                height: Utils.getDeviceHeight(context) / 1.4,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeSalesPersons
              ? Positioned(
            top: 65,
            left: Utils.getDeviceWidth(context) / 2.8,
            child: InkResponse(
              child: Image(
                image: AssetImage(
                    Utils.getAssetsImg(introShowBubbleSales())),
                height: Utils.getDeviceHeight(context) / 1.35,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeServicesPerson
              ? Positioned(
            top: 60,
            left: Utils.getDeviceWidth(context) / 2.1,
//            right: Utils.getDeviceWidth(context) / 2.9,
            child: InkResponse(
              child: Image(
                image: AssetImage(
                    Utils.getAssetsImg(introShowBubbleCustomer())),
                height: Utils.getDeviceHeight(context) / 1.4,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeBrandValue
              ? Positioned(
            top: 65,
            left: Utils.getDeviceWidth(context) / 2.8,
//            right: Utils.getDeviceWidth(context) / 2.9,
            child: InkResponse(
              child: Image(
                image: AssetImage(
                    Utils.getAssetsImg(introShowBubbleBrandValue())),
                height: Utils.getDeviceHeight(context) / 1.5,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeMoney
              ? Positioned(
            top: 60,
            left: Utils.getDeviceWidth(context) / 2.6,
//            right: Utils.getDeviceWidth(context) / 2.9,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg(introShowBubbleCash())),
                height: Utils.getDeviceHeight(context) / 1.3,
              ),
              onTap: () {},
            ),
          )
              : Container(),

//--------------------------------------------------------------------------------------------------------------

          selectedType == Const.typeBusinessSector
              ? Positioned(
            bottom: 50,
            left: Utils.getDeviceWidth(context) / 3.2,
            child: InkResponse(
                child: Image(
                  image: AssetImage(
                      Utils.getAssetsImg(introShowBubbleBusinessSectors())),
                  height: Utils.getDeviceHeight(context) / 1.3,
                ),
                onTap: () {}),
          )
              : Container(),

          selectedType == Const.typeNewCustomer
              ? Positioned(
            bottom: 70,
            left: Utils.getDeviceWidth(context) / 3.8,
            child: InkResponse(
                child: Image(
                  image: AssetImage(
                      Utils.getAssetsImg(introShowBubbleNewCustomer())),
                  height: Utils.getDeviceHeight(context) / 1.4,
                ),
                onTap: () {}),
          )
              : Container(),

          selectedType == Const.typeExistingCustomer
              ? Positioned(
            bottom: 40,
            left: Utils.getDeviceWidth(context) / 4.0,
            child: InkResponse(
                child: Image(
                  image: AssetImage(
                      Utils.getAssetsImg(introShowBubbleExistingCustomer())),
                  height: Utils.getDeviceHeight(context) / 1.35,
                ),
                onTap: () {}),
          )
              : Container(),

          selectedType == Const.typeReward
              ? Positioned(
            bottom: Utils.getDeviceHeight(context) / 3.0,
            left: Utils.getDeviceWidth(context) / 3.5,
            child: InkResponse(
              child: Image(
                image:
                AssetImage(Utils.getAssetsImg(introShowBubbleRewards())),
                height: Utils.getDeviceHeight(context) / 2.0,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeTeam
              ? Positioned(
            top: 50,
//                  top: Utils.getDeviceHeight(context) / 6.4,
            left: Utils.getDeviceWidth(context) / 1.7,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg(introShowBubbleTeam())),
                height: Utils.getDeviceHeight(context) / 2.4,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeChallenges
              ? Positioned(
            top: 40,
//                  left: Utils.getDeviceWidth(context) / 4,
            right: Utils.getDeviceWidth(context) / 3.0,
            child: InkResponse(
              child: Image(
                image: AssetImage(
                    Utils.getAssetsImg(introShowBubbleChallenges())),
                height: Utils.getDeviceHeight(context) / 1.8,
              ),
              onTap: () {},
            ),
          )
              : Container(),

          selectedType == Const.typeOrg
              ? Positioned(
            top: 80,
            left: Utils.getDeviceWidth(context) / 2.6,
            child: InkResponse(
                child: Image(
                  image: AssetImage(
                      Utils.getAssetsImg(introShowBubbleOrganization())),
                  height: Utils.getDeviceHeight(context) / 1.55,
                ),
                onTap: () {}),
          )
              : Container(),

          selectedType == Const.typePl
              ? Positioned(
            bottom: 10,
            left: Utils.getDeviceWidth(context) / 4.9,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg(introShowBubblePl())),
                  height: Utils.getDeviceHeight(context) / 1.45,
                ),
                onTap: () {}),
          )
              : Container(),

          selectedType == Const.typeRanking
              ? Positioned(
            bottom: 30,
//            left: Utils.getDeviceWidth(context) / 1.9,
            right: Utils.getDeviceWidth(context) / 2.6,
            child: InkResponse(
              child: Image(
                image:
                AssetImage(Utils.getAssetsImg(introShowBubbleRanking())),
                height: Utils.getDeviceHeight(context) / 1.6,
              ),
              onTap: () {},
            ),
          )
              : Container(),
//-------------------------------------------------------------------------------------------------------

          selectedType == Const.typeProfile
              ? Container()
              : Positioned(
            top: Utils.getDeviceHeight(context) / 2.35,
            left: 10,
//            right: Utils.getDeviceWidth(context) / 1.62,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg(introShowBack())),
                height: Utils.getDeviceHeight(context) / 10,
              ),
              onTap: () {
//                      if(currentVol != 0) {
                Utils.playClickSound();
//                      }

                setState(() {
                  if (selectedType == Const.typeProfile) {
                    selectedType = Const.typeRanking;
                  } else if (selectedType == Const.typeRanking) {
                    selectedType = Const.typePl;
                  } else if (selectedType == Const.typePl) {
                    selectedType = Const.typeOrg;
                  } else if (selectedType == Const.typeOrg) {
                    selectedType = Const.typeChallenges;
                  } else if (selectedType == Const.typeChallenges) {
                    Injector.isManager() ?
                    selectedType = Const.typeTeam : selectedType =
                        Const.typeReward;
                  } else if (selectedType == Const.typeTeam) {
                    selectedType = Const.typeReward;
                  } else if (selectedType == Const.typeReward) {
                    selectedType = Const.typeExistingCustomer;
                  } else if (selectedType == Const.typeExistingCustomer) {
                    selectedType = Const.typeNewCustomer;
                  } else if (selectedType == Const.typeNewCustomer) {
                    selectedType = Const.typeBusinessSector;
                  } else if (selectedType == Const.typeBusinessSector) {
//                          selectedType = Const.typeProfile;
//                        } else if (selectedType == Const.typeProfile) {
                    selectedType = Const.typeMoney;
                  } else if (selectedType == Const.typeMoney) {
                    selectedType = Const.typeBrandValue;
                  } else if (selectedType == Const.typeServicesPerson) {
                    selectedType = Const.typeSalesPersons;
                  } else if (selectedType == Const.typeBrandValue) {
                    selectedType = Const.typeServicesPerson;
                  } else if (selectedType == Const.typeSalesPersons) {
                    selectedType = Const.typeEmployee;
                  } else if (selectedType == Const.typeEmployee) {
                    selectedType = Const.typeName;
                  } else if (selectedType == Const.typeName) {
                    selectedType = Const.typeProfile;
                  }
                });
              },
            ),
          ),

          selectedType == Const.typeRanking
              ? Container(
              child: Positioned(
                  top: Utils.getDeviceHeight(context) / 2.35,
                  right: 10,
                  child: InkResponse(
                    child: Image(
                      image:
                      AssetImage(Utils.getAssetsImg(introShowEnter())),
                      height: Utils.getDeviceHeight(context) / 10,
                    ),
                    onTap: () {
//                          if(currentVol != 0) {
                      Utils.playClickSound();
//                          }
                      setState(() {
                        Navigator.pushAndRemoveUntil(context,
                            FadeRouteHome(), ModalRoute.withName("/home"));
                      });
                    },
                  )))
              : Positioned(
            top: Utils.getDeviceHeight(context) / 2.35,
            right: 10,
//            right: Utils.getDeviceWidth(context) / 1.62,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg(introShowNext())),
                height: Utils.getDeviceHeight(context) / 10,
              ),
              onTap: () {
//                      AudioManager.STREAM_SYSTEM;

//                      if(currentVol != 0) {
                Utils.playClickSound();
//                      }

                setState(() {
                  if (selectedType == Const.typeProfile) {
                    selectedType = Const.typeName;
                  } else if (selectedType == Const.typeName) {
                    selectedType = Const.typeEmployee;
                  } else if (selectedType == Const.typeSalesPersons) {
                    selectedType = Const.typeServicesPerson;
                  } else if (selectedType == Const.typeEmployee) {
                    selectedType = Const.typeSalesPersons;
                  } else if (selectedType == Const.typeBrandValue) {
                    selectedType = Const.typeMoney;
                  } else if (selectedType == Const.typeServicesPerson) {
                    selectedType = Const.typeBrandValue;
                  } else if (selectedType == Const.typeMoney) {
//                          selectedType = Const.typeProfile;
//                        } else if (selectedType == Const.typeProfile) {
                    selectedType = Const.typeBusinessSector;
                  } else if (selectedType == Const.typeBusinessSector) {
                    selectedType = Const.typeNewCustomer;
                  } else if (selectedType == Const.typeNewCustomer) {
                    selectedType = Const.typeExistingCustomer;
                  } else if (selectedType == Const.typeExistingCustomer) {
                    selectedType = Const.typeReward;
                  } else if (selectedType == Const.typeReward) {
                    Injector.isManager() ?
                    selectedType = Const.typeTeam : selectedType =
                        Const.typeChallenges;
                  } else if (selectedType == Const.typeTeam) {
                    selectedType = Const.typeChallenges;
                  } else if (selectedType == Const.typeChallenges) {
                    selectedType = Const.typeOrg;
                  } else if (selectedType == Const.typeOrg) {
                    selectedType = Const.typePl;
                  } else if (selectedType == Const.typePl) {
                    selectedType = Const.typeRanking;
                  } else if (selectedType == Const.typeRanking) {
                    DashboardGamePage();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }


  //show bubble with name

  introShowBubbleProfile() {
      if(Injector.userData.language == "English") {
//        return "intro_bub_profile";
        return "intro_bub_profile_en";
      } else if(Injector.userData.language == "German") {
        return "intro_bub_profile_de";
      } else if(Injector.userData.language == "Chinese") {
        return "intro_bub_profile_zh";
      }
  }

  introShowBubbleCompanyName() {
    if(Injector.userData.language == "English") {
      return "intro_bub_companyname";
//      return "intro_bub_companyname_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_companyname_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_companyname_zh";
    }
  }

  introShowBubbleEmp() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_emp_stat";
      return "intro_bub_emp_stat_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_emp_stat_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_emp_stat_zh";
    }
  }

  introShowBubbleSales() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_sales_stat";
      return "intro_bub_sales_stat_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_sales_stat_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_sales_stat_zh";
    }
  }

  introShowBubbleCustomer() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_customer_stat";
      return "intro_bub_customer_stat_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_customer_stat_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_customer_stat_zh";
    }
  }

  introShowBubbleBrandValue() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_brand_value";
      return "intro_bub_brand_value_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_brand_value_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_brand_value_zh";
    }
  }

  introShowBubbleCash() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_cash";
      return "intro_bub_cash_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_cash_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_cash_zh";
    }
  }

  introShowBubbleBusinessSectors() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_business_sectors";
      return "intro_bub_business_sectors_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_business_sectors_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_business_sectors_zh";
    }
  }

  introShowBubbleNewCustomer() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_new_customer";
      return "intro_bub_new_customer_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_new_customer_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_new_customer_zh";
    }
  }

  introShowBubbleExistingCustomer() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_existing_customer";
      return "intro_bub_existing_customer_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_existing_customer_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_existing_customer_zh";
    }
  }

  introShowBubbleRewards() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_rewards";
      return "intro_bub_rewards_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_rewards_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_rewards_zh";
    }
  }
  introShowBubbleTeam() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_team";
      return "intro_bub_team_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_team_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_team_zh";
    }
  }

  introShowBubbleChallenges() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_challenges";
      return "intro_bub_challenges_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_challenges_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_challenges_zh";
    }
  }

  introShowBubbleOrganization() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_organization";
      return "intro_bub_organization_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_organization_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_organization_zh";
    }
  }

  introShowBubblePl() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_pl";
      return "intro_bub_pl_en";
    } else if(Injector.userData .language == "German") {
      return "intro_bub_pl_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_pl_zh";
    }
  }

  introShowBubbleRanking() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_ranking";
      return "intro_bub_ranking_en";
    } else if(Injector.userData.language == "German") {
      return "intro_bub_ranking_de";
    } else if(Injector.userData.language == "Chinese") {
      return "intro_bub_ranking_zh";
    }
  }

  introShowBack() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_back";
      return "back_eng";
    } else if(Injector.userData.language == "German") {
      return "back_de";
    } else if(Injector.userData.language == "Chinese") {
      return "back_zh";
    }
  }

  introShowEnter() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_enter";
      return "enter_eng";
    } else if(Injector.userData.language == "German") {
      return "enter_de";
    } else if(Injector.userData.language == "Chinese") {
      return "enter_zh";
    }
  }

  introShowNext() {
    if(Injector.userData.language == "English") {
//      return "intro_bub_next";
      return "next_eng";
    } else if(Injector.userData.language == "German") {
      return "next_de";

    } else if(Injector.userData.language == "Chinese") {
      return "next_zh";
    }
  }
}
