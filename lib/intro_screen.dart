import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_tooltip/flutter_introduction_tooltip.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/home.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'commonview/header.dart';
import 'dashboard_new.dart';
import 'helper/constant.dart';
import 'helper/web_api.dart';
import 'login.dart';
import 'models/get_customer_value.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Notifier _notifier;
  int selectedType = Const.typeName;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    _notifier.notify('changeMode', 'Sending data from notfier!');
  }

  @override
  void initState() {
    super.initState();

    Injector.prefs.setBool(PrefKeys.isLoginFirstTime, false);
  }

  void getCustomerValues() {
    CustomerValueRequest rq = CustomerValueRequest();
    rq.userId = Injector.userData.userId;

    WebApi()
        .getCustomerValue(context, rq.toJson())
        .then((customerValueData) async {
      if (customerValueData != null) {
        await Injector.prefs.setString(PrefKeys.customerValueData,
            json.encode(customerValueData.toJson()));

        Injector.customerValueData = customerValueData;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _notifier = NotifierProvider.of(context);

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
          Visibility(
            child: Image(
              image: AssetImage(
                Utils.getAssetsImg("menu"),
              ),
              fit: BoxFit.fill,
            ),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: false,
          ),
          SizedBox(
            width: 8,
          ),
          Visibility(
            child: InkResponse(
              child: Image(
                image: AssetImage(
                  Utils.getAssetsImg("ic_menu"),
                ),
                color: Injector.isBusinessMode
                    ? ColorRes.textLightBlue
                    : ColorRes.white,
                width: 25,
              ),
              onTap: () {},
            ),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: selectedType == Const.typeSideMenu ? true : false,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Visibility(
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
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    Injector.userData != null ? Injector.userData.manager : "",
                    style: TextStyle(
                        color: Injector.isBusinessMode
                            ? ColorRes.white
                            : ColorRes.textLightBlue,
                        fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: selectedType == Const.typeName ? true : false,
            ),
          ),
          showHeaderItem(Const.typeSalesPersons, context),
          showHeaderItem(Const.typeEmployee, context),
          showHeaderItem(Const.typeBadge, context),
          showHeaderItem(Const.typeServicesPerson, context),
          showHeaderItem(Const.typeDollar, context),
          Visibility(
            child: showProfile(context),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: selectedType == Const.typeProfile ? true : false,
          ),
        ],
      ),
    );
  }

  showHeaderItem(int type, BuildContext context) {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: selectedType == type ? true : false,
      child: Container(
        height: 40,
        padding:
            EdgeInsets.symmetric(horizontal: Injector.isBusinessMode ? 4 : 2),
        margin: EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_header_card")),
                    fit: BoxFit.fill)
                : null),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Injector.isBusinessMode
                    ? Container()
                    : Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorRes.white, width: 1),
                            borderRadius: BorderRadius.circular(12.5)),
                      ),
                Image(
                  image: AssetImage(Utils.getAssetsImg(getHeaderIcon(type))),
                  height: 26,
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            type != Const.typeDollar
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
                                : Border.all(color: ColorRes.white, width: 1)),
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: Injector.isBusinessMode ? 0 : 1),
                        child: LinearPercentIndicator(
                          width: Utils.getDeviceWidth(context) / 12,
                          lineHeight: 19.0,
                          percent: getProgressInt(type),
                          backgroundColor: Colors.transparent,
                          progressColor: Colors.blue,
                        ),
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          getProgress(type),
                          style: TextStyle(color: ColorRes.white, fontSize: 14),
                        ),
                      )
                    ],
                  )
                : Text(
                    ' \$ '+Injector.customerValueData.totalBalance.toString(),
                    style: TextStyle(color: ColorRes.white, fontSize: 16),
                  ),
          ],
        ),
      ),
    );
  }

  showProfile(BuildContext context) {
    return InkResponse(
        child: Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 5),
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
      return "97%";
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
      return 0.97;
    } else if (type == Const.typeServicesPerson) {
      return 0.8;
    } else
      return 0.5;
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
              selectedType == Const.typePL
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
                  : Container(width: Utils.getDeviceWidth(context) / 3.5),
              selectedType == Const.typeNewCustomer
                  ? InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("new-customer")),
                        width: Utils.getDeviceWidth(context) / 4.2,
                      ),
                      onTap: () {
                        performItemClick(Const.typeNewCustomer);
                      })
                  : Container(
                      width: Utils.getDeviceWidth(context) / 4.2,
                    ),
              selectedType == Const.typeExistingCustomer
                  ? InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("existing")),
                        width: Utils.getDeviceWidth(context) / 4.4,
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
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("business_sectors")),
//                      height: Utils.getDeviceHeight(context) / 2.85,
                      width: Utils.getDeviceWidth(context) / 3.4,
                    ),
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

  performItemClick(int type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  initialPageType: type,
                )));
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

          selectedType == Const.typeName
              ? Container()
              : Positioned(
                  top: Utils.getDeviceHeight(context) / 2.35,
                  left: 10,
//            right: Utils.getDeviceWidth(context) / 1.62,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("intro_bub_back")),
                      height: Utils.getDeviceHeight(context) / 10,
                    ),
                    onTap: () {
                      Utils.playClickSound();

                      setState(() {
                        if (selectedType == Const.typeName) {
                          selectedType = Const.typeRanking;
                        } else if (selectedType == Const.typeRanking) {
                          selectedType = Const.typePL;
                        } else if (selectedType == Const.typePL) {
                          selectedType = Const.typeOrg;
                        } else if (selectedType == Const.typeOrg) {
                          selectedType = Const.typeChallenges;
                        } else if (selectedType == Const.typeChallenges) {
                          selectedType = Const.typeTeam;
                        } else if (selectedType == Const.typeTeam) {
                          selectedType = Const.typeReward;
                        } else if (selectedType == Const.typeReward) {
                          selectedType = Const.typeExistingCustomer;
                        } else if (selectedType == Const.typeExistingCustomer) {
                          selectedType = Const.typeNewCustomer;
                        } else if (selectedType == Const.typeNewCustomer) {
                          selectedType = Const.typeBusinessSector;
                        } else if (selectedType == Const.typeBusinessSector) {
                          selectedType = Const.typeProfile;
                        } else if (selectedType == Const.typeProfile) {
                          selectedType = Const.typeDollar;
                        } else if (selectedType == Const.typeDollar) {
                          selectedType = Const.typeServicesPerson;
                        } else if (selectedType == Const.typeServicesPerson) {
                          selectedType = Const.typeBadge;
                        } else if (selectedType == Const.typeBadge) {
                          selectedType = Const.typeEmployee;
                        } else if (selectedType == Const.typeEmployee) {
                          selectedType = Const.typeSalesPersons;
                        } else if (selectedType == Const.typeSalesPersons) {
                          selectedType = Const.typeName;
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
                              AssetImage(Utils.getAssetsImg("intro_bub_enter")),
                          height: Utils.getDeviceHeight(context) / 10,
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                ModalRoute.withName("/home"));
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => HomePage()));
                          });
                        },
                      )))
              : Positioned(
                  top: Utils.getDeviceHeight(context) / 2.35,
                  right: 10,
//            right: Utils.getDeviceWidth(context) / 1.62,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("intro_bub_next")),
                      height: Utils.getDeviceHeight(context) / 10,
                    ),
                    onTap: () {
                      Utils.playClickSound();

                      setState(() {
                        if (selectedType == Const.typeName) {
                          selectedType = Const.typeSalesPersons;
                        } else if (selectedType == Const.typeSalesPersons) {
                          selectedType = Const.typeEmployee;
                        } else if (selectedType == Const.typeEmployee) {
                          selectedType = Const.typeBadge;
                        } else if (selectedType == Const.typeBadge) {
                          selectedType = Const.typeServicesPerson;
                        } else if (selectedType == Const.typeServicesPerson) {
                          selectedType = Const.typeDollar;
                        } else if (selectedType == Const.typeDollar) {
                          selectedType = Const.typeProfile;
                        } else if (selectedType == Const.typeProfile) {
                          selectedType = Const.typeBusinessSector;
                        } else if (selectedType == Const.typeBusinessSector) {
                          selectedType = Const.typeNewCustomer;
                        } else if (selectedType == Const.typeNewCustomer) {
                          selectedType = Const.typeExistingCustomer;
                        } else if (selectedType == Const.typeExistingCustomer) {
                          selectedType = Const.typeReward;
                        } else if (selectedType == Const.typeReward) {
                          selectedType = Const.typeTeam;
                        } else if (selectedType == Const.typeTeam) {
                          selectedType = Const.typeChallenges;
                        } else if (selectedType == Const.typeChallenges) {
                          selectedType = Const.typeOrg;
                        } else if (selectedType == Const.typeOrg) {
                          selectedType = Const.typePL;
                        } else if (selectedType == Const.typePL) {
                          selectedType = Const.typeRanking;
                        } else if (selectedType == Const.typeRanking) {
                          DashboardNewPage();
                        }
                      });
                    },
                  ),
                ),

          selectedType == Const.typeName
              ? Positioned(
                  top: 65,
                  right: Utils.getDeviceWidth(context) / 1.9,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(
                          Utils.getAssetsImg("intro_bub_companyname")),
                      height: Utils.getDeviceHeight(context) / 2.4,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeSalesPersons
              ? Positioned(
                  top: 65,
                  left: Utils.getDeviceWidth(context) / 3.40,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(
                          Utils.getAssetsImg("intro_bub_sales_stat")),
                      height: Utils.getDeviceHeight(context) / 1.60,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeEmployee
              ? Positioned(
                  top: 65,
                  left: Utils.getDeviceWidth(context) / 2.35,
                  child: InkResponse(
                    child: Image(
                      image:
                          AssetImage(Utils.getAssetsImg("intro_bub_emp_stat")),
                      height: Utils.getDeviceHeight(context) / 1.55,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeBadge
              ? Positioned(
                  top: 65,
                  left: Utils.getDeviceWidth(context) / 2.00,
//            right: Utils.getDeviceWidth(context) / 2.9,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(
                          Utils.getAssetsImg("intro_bub_customer_stat")),
                      height: Utils.getDeviceHeight(context) / 1.9,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeServicesPerson
              ? Positioned(
                  top: 65,
                  left: Utils.getDeviceWidth(context) / 2.35,
//            right: Utils.getDeviceWidth(context) / 2.9,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(
                          Utils.getAssetsImg("intro_bub_brand_value")),
                      height: Utils.getDeviceHeight(context) / 1.90,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeDollar
              ? Positioned(
                  top: 65,
                  left: Utils.getDeviceWidth(context) / 2.10,
//            right: Utils.getDeviceWidth(context) / 2.9,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("intro_bub_cash")),
                      height: Utils.getDeviceHeight(context) / 1.6,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeProfile
              ? Positioned(
                  top: 65,
                  left: Utils.getDeviceWidth(context) / 1.8,
//            right: Utils.getDeviceWidth(context) / 2.9,
                  child: InkResponse(
                    child: Image(
                      image:
                          AssetImage(Utils.getAssetsImg("intro_bub_profile")),
                      height: Utils.getDeviceHeight(context) / 2.3,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

//--------------------------------------------------------------------------------------------------------------

          selectedType == Const.typeBusinessSector
              ? Positioned(
                  bottom: 70,
                  left: Utils.getDeviceWidth(context) / 3.0,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(
                            Utils.getAssetsImg("intro_bub_business_sectors")),
                        height: Utils.getDeviceHeight(context) / 1.6,
                      ),
                      onTap: () {}),
                )
              : Container(),

          selectedType == Const.typeNewCustomer
              ? Positioned(
                  bottom: 70,
                  left: Utils.getDeviceWidth(context) / 3.2,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(
                            Utils.getAssetsImg("intro_bub_new_customer")),
                        height: Utils.getDeviceHeight(context) / 1.8,
                      ),
                      onTap: () {}),
                )
              : Container(),

          selectedType == Const.typeExistingCustomer
              ? Positioned(
                  bottom: 50,
                  left: Utils.getDeviceWidth(context) / 3.4,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(
                            Utils.getAssetsImg("intro_bub_existing_customer")),
                        height: Utils.getDeviceHeight(context) / 1.6,
                      ),
                      onTap: () {}),
                )
              : Container(),

          selectedType == Const.typeReward
              ? Positioned(
                  bottom: Utils.getDeviceHeight(context) / 2.8,
                  left: Utils.getDeviceWidth(context) / 3.5,
                  child: InkResponse(
                    child: Image(
                      image:
                          AssetImage(Utils.getAssetsImg("intro_bub_rewards")),
                      height: Utils.getDeviceHeight(context) / 2.8,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeTeam
              ? Positioned(
                  top: Utils.getDeviceHeight(context) / 6.4,
                  left: Utils.getDeviceWidth(context) / 1.7,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("intro_bub_team")),
                      height: Utils.getDeviceHeight(context) / 2.6,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeChallenges
              ? Positioned(
                  top: 60,
                  left: Utils.getDeviceWidth(context) / 4,
                  right: Utils.getDeviceWidth(context) / 3.0,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(
                          Utils.getAssetsImg("intro_bub_challenges")),
                      height: Utils.getDeviceHeight(context) / 1.9,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeOrg
              ? Positioned(
                  top: 100,
                  left: Utils.getDeviceWidth(context) / 2.6,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(
                            Utils.getAssetsImg("intro_bub_organization")),
                        height: Utils.getDeviceHeight(context) / 1.8,
                      ),
                      onTap: () {}),
                )
              : Container(),

          selectedType == Const.typePL
              ? Positioned(
                  bottom: 30,
                  left: Utils.getDeviceWidth(context) / 4.1,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("intro_bub_pl")),
                        height: Utils.getDeviceHeight(context) / 1.8,
                      ),
                      onTap: () {}),
                )
              : Container(),

          selectedType == Const.typeRanking
              ? Positioned(
                  bottom: 80,
//            left: Utils.getDeviceWidth(context) / 1.9,
                  right: Utils.getDeviceWidth(context) / 2.6,
                  child: InkResponse(
                    child: Image(
                      image:
                          AssetImage(Utils.getAssetsImg("intro_bub_ranking")),
                      height: Utils.getDeviceHeight(context) / 2.3,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),
//-------------------------------------------------------------------------------------------------------
        ],
      ),
    );
  }
}
