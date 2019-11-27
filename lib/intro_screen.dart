import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_tooltip/flutter_introduction_tooltip.dart';
import 'package:ke_employee/dashboard_new.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'commonview/header.dart';
import 'helper/constant.dart';

class IntroScreen extends StatefulWidget {
//  final GlobalKey<ScaffoldState> scaffoldKey;
//  final bool isShowMenu;
//  final Function openProfile;
//
//  IntroScreen({this.scaffoldKey, this.isShowMenu, this.openProfile});

  IntroScreen({Key key}) : super(key: key);

  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
//  final GlobalKey<ScaffoldState> scaffoldKey;
//  final bool isShowMenu;
//  final Function openProfile;

//  IntroScreen({this.scaffoldKey, this.isShowMenu, this.openProfile});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int selectedType = Const.typeName;

  @override
  void initState() {
    super.initState();

    if (Injector.prefs.getInt(PrefKeys.mode) == null) {
      Injector.prefs.setInt(PrefKeys.mode, Const.businessMode);
    }
  }

//  bg_dashboard_trans

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorRes.colorBgDark,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Column(
              children: <Widget>[

                Stack(
                  children: <Widget>[
                    HeaderView(
                      scaffoldKey: _scaffoldKey,
                      isShowMenu: true,
                    ),
                    Container(
                      width: double.infinity,
                      height: Utils.getDeviceHeight(context) / 7.5,
                      color: ColorRes.transparent.withOpacity(0.5),
                    ),
                    showHighlightedHeader(),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Image(image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),fit: BoxFit.fill,),
//                      showMainView(),
//                      Container(
//                        decoration: BoxDecoration(
//                            image: DecorationImage(
//                                image: AssetImage(
//                                    Utils.getAssetsImg("intro_bub_background")),
//                                fit: BoxFit.fill)),
//                      ),
                      showIntroMenu(),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  showIntroMenu() {
    return Container(
//      width: double.infinity,
//      height: double.infinity,
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage(Utils.getAssetsImg("dashboard-background")),
//              fit: BoxFit.fill)),
      child: Stack(
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
                          selectedType = Const.typeResources;
                        } else if (selectedType == Const.typeResources) {
                          selectedType = Const.typeBadge;
                        } else if (selectedType == Const.typeBadge) {
                          selectedType = Const.typePeople;
                        } else if (selectedType == Const.typePeople) {
                          selectedType = Const.typeChecked;
                        } else if (selectedType == Const.typeChecked) {
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
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardNewPage()));
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
                      setState(() {
                        if (selectedType == Const.typeName) {
                          selectedType = Const.typeChecked;
                        } else if (selectedType == Const.typeChecked) {
                          selectedType = Const.typePeople;
                        } else if (selectedType == Const.typePeople) {
                          selectedType = Const.typeBadge;
                        } else if (selectedType == Const.typeBadge) {
                          selectedType = Const.typeResources;
                        } else if (selectedType == Const.typeResources) {
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
                  top: 70,
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

          selectedType == Const.typeChecked
              ? Positioned(
                  top: 70,
                  left: Utils.getDeviceWidth(context) / 3.30,
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

          selectedType == Const.typePeople
              ? Positioned(
                  top: 70,
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
                  top: 70,
                  left: Utils.getDeviceWidth(context) / 2.10,
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

          selectedType == Const.typeResources
              ? Positioned(
                  top: 70,
                  left: Utils.getDeviceWidth(context) / 2.30,
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
                  top: 70,
                  left: Utils.getDeviceWidth(context) / 2.30,
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
                  left: Utils.getDeviceWidth(context) / 1.9,
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

          selectedType == Const.typeBusinessSector
              ? Positioned(
                  left: 18,
                  bottom: 5,
                  child: InkResponse(
                      child: Image(
                        image:
                            AssetImage(Utils.getAssetsImg("business_sectors")),
                        height: Utils.getDeviceHeight(context) / 2.85,
                      ),
                      onTap: () {}),
                )
              : Container(),

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
                  bottom: 0,
                  left: Utils.getDeviceWidth(context) / 2.8,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("new-customer")),
                        height: Utils.getDeviceHeight(context) / 2.5,
                      ),
                      onTap: () {}),
                )
              : Container(),

          selectedType == Const.typeNewCustomer
              ? Positioned(
                  bottom: 110,
                  left: Utils.getDeviceWidth(context) / 3.5,
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
                  bottom: 0,
                  left: Utils.getDeviceWidth(context) / 1.4,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("existing")),
                        height: Utils.getDeviceHeight(context) / 3.1,
                      ),
                      onTap: () {}))
              : Container(),

          selectedType == Const.typeExistingCustomer
              ? Positioned(
                  bottom: 50,
                  left: Utils.getDeviceWidth(context) / 3.2,
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
                  bottom: Utils.getDeviceHeight(context) / 3.9,
                  left: Utils.getDeviceWidth(context) / 6,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("rewards")),
                      height: Utils.getDeviceHeight(context) / 3.2,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeReward
              ? Positioned(
                  bottom: Utils.getDeviceHeight(context) / 2.8,
                  left: Utils.getDeviceWidth(context) / 3.0,
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
                  bottom: Utils.getDeviceHeight(context) / 4,
                  left: Utils.getDeviceWidth(context) / 2.4,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("team")),
                      height: Utils.getDeviceHeight(context) / 3.2,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeTeam
              ? Positioned(
                  top: Utils.getDeviceHeight(context) / 6.0,
                  left: Utils.getDeviceWidth(context) / 1.8,
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
                  bottom: Utils.getDeviceHeight(context) / 5,
                  left: Utils.getDeviceWidth(context) / 1.5,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(Utils.getAssetsImg("challenges")),
                        height: Utils.getDeviceHeight(context) / 3,
                      ),
                      onTap: () {
//                showTutorial(context);
                      }),
                )
              : Container(),

          selectedType == Const.typeChallenges
              ? Positioned(
                  top: 60,
                  left: Utils.getDeviceWidth(context) / 4,
                  right: Utils.getDeviceWidth(context) / 3.2,
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
                  top: 40,
                  right: Utils.getDeviceWidth(context) / 1.62,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("organization")),
                      height: Utils.getDeviceHeight(context) / 2.7,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeOrg
              ? Positioned(
                  top: 100,
                  left: Utils.getDeviceWidth(context) / 2.8,
                  child: InkResponse(
                      child: Image(
                        image: AssetImage(
                            Utils.getAssetsImg("intro_bub_organization")),
                        height: Utils.getDeviceHeight(context) / 1.7,
                      ),
                      onTap: () {}),
                )
              : Container(),

          selectedType == Const.typePL
              ? Positioned(
                  top: 40,
                  left: Utils.getDeviceWidth(context) / 3,
                  right: Utils.getDeviceWidth(context) / 2.9,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("profit-loss")),
                      height: Utils.getDeviceHeight(context) / 2.8,
                    ),
                    onTap: () {},
                  ),
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
                  top: 40,
                  left: Utils.getDeviceWidth(context) / 1.66,
                  child: InkResponse(
                    child: Image(
                      image: AssetImage(Utils.getAssetsImg("ranking")),
                      height: Utils.getDeviceHeight(context) / 2.8,
                    ),
                    onTap: () {},
                  ),
                )
              : Container(),

          selectedType == Const.typeRanking
              ? Positioned(
                  bottom: 80,
//            left: Utils.getDeviceWidth(context) / 1.9,
                  right: Utils.getDeviceWidth(context) / 2.7,
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

          //---------------
        ],
      ),
    );
  }

  showMainView() {
    return Stack(
      children: <Widget>[
    Container(
    width: double.infinity,
      height: double.infinity,
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage(Utils.getAssetsImg("dashboard-background")),
//              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 18,
            bottom: 5,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("business_sectors")),
                  height: Utils.getDeviceHeight(context) / 2.85,
                ),
                onTap: () {
                  performItemClick(Const.typeBusinessSector);
                }),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 3.9,
            left: Utils.getDeviceWidth(context) / 6,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("rewards")),
                height: Utils.getDeviceHeight(context) / 3.2,
              ),
              onTap: () {
                performItemClick(Const.typeReward);
              },
            ),
          ),
          Positioned(
            top: 40,
            left: Utils.getDeviceWidth(context) / 1.66,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("ranking")),
                height: Utils.getDeviceHeight(context) / 2.8,
              ),
              onTap: () {
                performItemClick(Const.typeRanking);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: Utils.getDeviceWidth(context) / 1.62,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("organization")),
                height: Utils.getDeviceHeight(context) / 2.7,
              ),
              onTap: () {
                performItemClick(Const.typeOrg);
              },
            ),
          ),
          Positioned(
            top: 40,
            left: Utils.getDeviceWidth(context) / 3,
            right: Utils.getDeviceWidth(context) / 2.9,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("profit-loss")),
                height: Utils.getDeviceHeight(context) / 2.8,
              ),
              onTap: () {
                performItemClick(Const.typePL);
              },
            ),
          ),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 4,
            left: Utils.getDeviceWidth(context) / 2.4,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("team")),
                height: Utils.getDeviceHeight(context) / 3.2,
              ),
              onTap: () {
                performItemClick(Const.typeTeam);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: Utils.getDeviceWidth(context) / 2.8,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("new-customer")),
                  height: Utils.getDeviceHeight(context) / 2.5,
                ),
                onTap: () {
                  performItemClick(Const.typeNewCustomer);
                }),
          ),
          Positioned(
              bottom: 0,
              left: Utils.getDeviceWidth(context) / 1.4,
              child: InkResponse(
                  child: Image(
                    image: AssetImage(Utils.getAssetsImg("existing")),
                    height: Utils.getDeviceHeight(context) / 3.1,
                  ),
                  onTap: () {
                    performItemClick(Const.typeExistingCustomer);
                  })),
          Positioned(
            bottom: Utils.getDeviceHeight(context) / 5,
            left: Utils.getDeviceWidth(context) / 1.5,
            child: InkResponse(
                child: Image(
                  image: AssetImage(Utils.getAssetsImg("challenges")),
                  height: Utils.getDeviceHeight(context) / 3,
                ),
                onTap: () {
                  performItemClick(Const.typeChallenges);
//                showTutorial(context);
                }),
          ),
        ],
      ),
    )
      ],
    );
  }

  performItemClick(int type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  initialPosition: type,
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

  showHighlightedHeader() {
//    return Notifier.of(context).register<String>('changeMode', (data) {
    return Container(
      height: Utils.getDeviceHeight(context) / 7.5,
//      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      color: Injector.isBusinessMode
          ? ColorRes.transparent.withOpacity(0.5)
          : ColorRes.headerBlue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(
            flex: 1,
            child: selectedType == Const.typeSideMenu
                ? Image(
                    image: AssetImage(
                      Utils.getAssetsImg("menu"),
                    ),
                    fit: BoxFit.fill,
                  )
                : Container(),
          ),

          Expanded(
            flex: 1,
            child: InkResponse(
              child: selectedType == Const.typeName
                  ? Image(
                      image: AssetImage(
                        Utils.getAssetsImg("ic_menu"),
                      ),
                      color: Injector.isBusinessMode
                          ? ColorRes.textLightBlue
                          : ColorRes.white,
                      width: 25,
//                      width: Utils.getDeviceHeight(context) / 15,
                      height: Utils.getDeviceHeight(context) / 15,
                    )
                  : Container(),
              onTap: () {},
            ),
          ),

          Expanded(
//              flex: 3,
            child: selectedType == Const.typeName
                ? Column(
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
                        Injector.userData != null
                            ? Injector.userData.manager
                            : "",
                        style: TextStyle(
                            color: Injector.isBusinessMode
                                ? ColorRes.white
                                : ColorRes.textLightBlue,
                            fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                : Container(),
          ),
          Expanded(
              flex: 2,
              child: selectedType == Const.typeChecked
                  ? showHeaderItem(Const.typeChecked, context)
                  : Container()),
          Expanded(
            flex: 2,
            child: selectedType == Const.typePeople
                ? showHeaderItem(Const.typePeople, context)
                : Container(),
          ),
          Expanded(
            flex: 2,
            child: selectedType == Const.typeBadge
                ? showHeaderItem(Const.typeBadge, context)
                : Container(),
          ),
          Expanded(
            flex: 2,
            child: selectedType == Const.typeResources
                ? showHeaderItem(Const.typeResources, context)
                : Container(),
          ),
          Expanded(
            flex: 2,
            child: selectedType == Const.typeDollar
                ? showHeaderItem(Const.typeDollar, context)
                : Container(),
          ),
          Expanded(
            flex: 1,
            child: selectedType == Const.typeProfile
                ? showProfile(context)
                : Container(),
          ),

        ],
      ),
    );
  }

  showHeaderItem(int type, BuildContext context) {
    return Container(
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
                        width: Utils.getDeviceWidth(context) / 12.1,
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
                  ' \$ 120.00',
                  style: TextStyle(color: ColorRes.white, fontSize: 16),
                ),
        ],
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
    if (type == Const.typeChecked) {
      return "30/100";
    } else if (type == Const.typePeople) {
      return "50/100";
    } else if (type == Const.typeBadge) {
      return "97%";
    } else if (type == Const.typeResources) {
      return "80/100";
    } else
      return "50/100";
  }

  getProgressInt(int type) {
    if (type == Const.typeChecked) {
      return 0.3;
    } else if (type == Const.typePeople) {
      return 0.5;
    } else if (type == Const.typeBadge) {
      return 0.97;
    } else if (type == Const.typeResources) {
      return 0.8;
    } else
      return 0.5;
  }
}
