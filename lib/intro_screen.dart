import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_tooltip/flutter_introduction_tooltip.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/home.dart';

import 'helper/constant.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int selectedType = Const.typeName;

  @override
  void initState() {
    super.initState();

    if (Injector.prefs.getInt(PrefKeys.mode) == null) {
      Injector.prefs.setInt(PrefKeys.mode, Const.businessMode);
    }
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
              showMainView(),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            Utils.getAssetsImg("intro_bub_background")),
                        fit: BoxFit.fill)),
              ),
              showIntroMenu(),
//              HeaderView(
//                scaffoldKey: _scaffoldKey,
//                isShowMenu: true,
//              ),
            ],
          ),
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

          Positioned(
            top: Utils.getDeviceHeight(context) / 2.35,
            left: 10,
//            right: Utils.getDeviceWidth(context) / 1.62,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("intro_bub_back")),
                height: Utils.getDeviceHeight(context) / 8,
              ),
              onTap: () {

                setState(() {
                  if (selectedType == Const.typeName) {
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

          Positioned(
            top: Utils.getDeviceHeight(context) / 2.35,
            right: 10,
//            right: Utils.getDeviceWidth(context) / 1.62,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg("intro_bub_next")),
                height: Utils.getDeviceHeight(context) / 8,
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
                    selectedType = Const.typeName;
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
                      image:
                          AssetImage(Utils.getAssetsImg("intro_bub_companyname")),
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
                    onTap: () {
                    },
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
                    onTap: () {
                    },
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
                    onTap: () {
                    },
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
                    onTap: () {
                    },
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
                      image: AssetImage(
                          Utils.getAssetsImg("intro_bub_cash")),
                      height: Utils.getDeviceHeight(context) / 1.6,
                    ),
                    onTap: () {
                    },
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
                    onTap: () {
                    },
                  ),
                )
              : Container(),

          //---------------
        ],
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
}
