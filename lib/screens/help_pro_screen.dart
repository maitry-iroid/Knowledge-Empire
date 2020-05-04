import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/questions.dart';

class HelpProScreen {
  String icons;
  String title;
  String description;
  static int selectedIndex = 1;
  static List<String> arrType = List();

  static showChallengeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: Utils.getDeviceWidth(context) / 1.5,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 28, left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: ColorRes.helpProBox, width: 5),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        image: DecorationImage(
                            image:
                                AssetImage(Utils.getAssetsImg(showIcons())))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "hello",
                            style: TextStyle(
                                color: ColorRes.helpProBox, fontSize: 16),
                          ),
                          SizedBox(height: 9),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 50, right: 50, top: 8, bottom: 8),
                              child: Text("helloo hello hello hello hello hello")

//                              child: Text(
//                                  Utils.getText(context, showDescription()))
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: Utils.getDeviceHeight(context) / 6,
                    width: Utils.getDeviceHeight(context) / 6,
//                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: ColorRes.titleBlueProf,
                        border:
                            Border.all(color: ColorRes.helpProBox, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                )),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkResponse(
                    child: Container(
                      width: Utils.getDeviceWidth(context) / 18,
                      height: Utils.getDeviceHeight(context) / 11,
//                    margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Icon(Icons.chevron_left),
                    ),
                    onTap: () {
                      if (selectedIndex > 0) {
                        selectedIndex -= 1;
                      }
//                      setState(() {});
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkResponse(
                    child: Container(
                      width: Utils.getDeviceWidth(context) / 18,
                      height: Utils.getDeviceHeight(context) / 11,
//                    margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Icon(Icons.chevron_right),
                    ),
                    onTap: () {
                      if (selectedIndex < arrType.length - 1) {
                        selectedIndex += 1;
//                        setState(() {});
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }


  static showIcons() {
    if (getSelectedType() == Const.typeOrg) {
      return 'ic_pro_home_organization';
    } else if (getSelectedType() == Const.typePl) {
      return 'ic_pro_home_pl';
    } else if (getSelectedType() == Const.typeRanking) {
      return 'ic_pro_home_ranking';
    } else if (getSelectedType() == Const.typeReward) {
      return 'ic_pro_home_rewards';
    } else if (getSelectedType() == Const.typeTeam) {
      return 'ic_pro_home_team';
    } else if (getSelectedType() == Const.typeChallenges) {
      return 'ic_pro_home_challenges';
    } else if (getSelectedType() == Const.typeBusinessSector) {
      return 'ic_pro_home_business';
    } else if (getSelectedType() == Const.typeNewCustomer) {
      return 'ic_pro_home_customer';
    } else if (getSelectedType() == Const.typeExistingCustomer) {
      return 'ic_pro_home_exis_customer';
    } else if (getSelectedType() == Const.typeProfile) {
      return '';
    } else if (getSelectedType() == Const.typeEmployee) {
      return '';
    } else if (getSelectedType() == Const.typeSalesPersons) {
      return '';
    } else if (getSelectedType() == Const.typeServicesPerson) {
      return '';
    } else if (getSelectedType() == Const.typeBrandValue) {
      return '';
    } else if (getSelectedType() == Const.typeMoney) {
      return '';
    }
  }


  showTitle() {}

  static showDescription() {
    if (getSelectedType() == Const.typeOrg) {
      return 'helpProOrganization';
    } else if (getSelectedType() == Const.typePl) {
      return 'helpProP';
    } else if (getSelectedType() == Const.typeRanking) {
      return 'helpProRanking';
    } else if (getSelectedType() == Const.typeReward) {
      return 'helpProRewards';
    } else if (getSelectedType() == Const.typeTeam) {
      return 'helpProTeam';
    } else if (getSelectedType() == Const.typeChallenges) {
      return 'helpProChallenges';
    } else if (getSelectedType() == Const.typeBusinessSector) {
      return 'helpProBusinessSector';
    } else if (getSelectedType() == Const.typeNewCustomer) {
      return 'helpProNewCustomers';
    } else if (getSelectedType() == Const.typeExistingCustomer) {
      return 'helpProExistingCustomer';
    } /*else if (getSelectedType() == Const.typeProfile) {
      return 'helpProProfile';
    } else if (getSelectedType() == Const.typeEmployee) {
      return 'helpProEmployMeter';
    } else if (getSelectedType() == Const.typeSalesPersons) {
      return 'helpProSalesMeter';
    } else if (getSelectedType() == Const.typeServicesPerson) {
      return 'helpProServiceMeter';
    } else if (getSelectedType() == Const.typeBrandValue) {
      return 'helpProBrandValue';
    } else if (getSelectedType() == Const.typeMoney) {
      return 'helpProCash';
    }*/
  }

  static getSelectedType() {
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

    if (Utils.isFeatureOn(Const.typeReward)) arrTypeData.add(Const.typeReward);

    if (Utils.isFeatureOn(Const.typeTeam) && Injector.isManager())
      arrTypeData.add(Const.typeTeam);
    if (Utils.isFeatureOn(Const.typeChallenges))
      arrTypeData.add(Const.typeChallenges);

    if (Utils.isFeatureOn(Const.typeOrg)) arrTypeData.add(Const.typeOrg);
    if (Utils.isFeatureOn(Const.typePl)) arrTypeData.add(Const.typePl);

    if (Utils.isFeatureOn(Const.typeRanking))
      arrTypeData.add(Const.typeRanking);

    return arrTypeData;
  }



/*ic_pro_help.png
  ic_pro_home_business.png
  ic_pro_home_challenges.png
  ic_pro_home_customer.png
  ic_pro_home_exis_customer.png
  ic_pro_home_organization.png
  ic_pro_home_pl.png
  ic_pro_home_ranking.png
  ic_pro_home_rewards.png
  ic_pro_home_team.png
  ic_pro_home.png*/
/* ic_pro_award.png
  ic_pro_business_sectors.png
  ic_pro_challenge.png
  ic_pro_existing_cust.png
  ic_pro_new_cutomer.png
  ic_pro_organization.png
  ic_pro_pl.png
  ic_pro_ranking.png
  ic_pro_team.png
  ic_profile_help.png
  ic_profile_prof.png */

/*ic_pro_home_business.png  1
    ic_pro_home_customer.png   2
  ic_pro_home_exis_customer.png   3
  ic_pro_home_rewards.png  4
  ic_pro_home_challenges.png 5
  ic_pro_home_organization.png   6
  ic_pro_home_pl.png         7
  ic_pro_home_ranking.png   8

  ic_pro_home.png
  ic_pro_profile.png       2 */
}









//----------------------------------//----------------------------------//----------------------------------//


/*class FadeRouteProIntro extends PageRouteBuilder {
  final Widget page;

  FadeRouteProIntro({this.page})
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
            child: HelpProPage(),
          ),
        );
}

class HelpProPage extends StatefulWidget {
//  HelpProPage({Key key}) : super(key: key);

  @override
  _HelpProPageState createState() => _HelpProPageState();
}

class _HelpProPageState extends State<HelpProPage> {
  List<String> arrType = List();
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arrType = initFeatureDataArray();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Container(
            height: 200,
            color: Colors.cyanAccent,
            child: showChallengeDialog(context),
          ),
      ),
    );
  }

  showChallengeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: Utils.getDeviceWidth(context) / 1.5,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 28, left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                        Border.all(color: ColorRes.helpProBox, width: 5),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        image: DecorationImage(
                            image:
                            AssetImage(Utils.getAssetsImg(showIcons())))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "hello",
                            style: TextStyle(
                                color: ColorRes.helpProBox, fontSize: 16),
                          ),
                          SizedBox(height: 9),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 50, right: 50, top: 8, bottom: 8),
                              child: Text(
                                  Utils.getText(context, showDescription()))),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: Utils.getDeviceHeight(context) / 6,
                        width: Utils.getDeviceHeight(context) / 6,
//                    alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: ColorRes.titleBlueProf,
                            border:
                            Border.all(color: ColorRes.helpProBox, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                      ),
                    )),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkResponse(
                    child: Container(
                      width: Utils.getDeviceWidth(context) / 18,
                      height: Utils.getDeviceHeight(context) / 11,
//                    margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Icon(Icons.chevron_left),
                    ),
                    onTap: () {
                      if (selectedIndex > 0) {
                        selectedIndex -= 1;
                      }
//                      setState(() {});
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkResponse(
                    child: Container(
                      width: Utils.getDeviceWidth(context) / 18,
                      height: Utils.getDeviceHeight(context) / 11,
//                    margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Icon(Icons.chevron_right),
                    ),
                    onTap: () {
                      if (selectedIndex < arrType.length - 1) {
                        selectedIndex += 1;
//                        setState(() {});
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  showIcons() {
    if (getSelectedType() == Const.typeOrg) {
      return 'ic_pro_home_organization';
    } else if (getSelectedType() == Const.typePl) {
      return 'ic_pro_home_pl';
    } else if (getSelectedType() == Const.typeRanking) {
      return 'ic_pro_home_ranking';
    } else if (getSelectedType() == Const.typeReward) {
      return 'ic_pro_home_rewards';
    } else if (getSelectedType() == Const.typeTeam) {
      return 'ic_pro_home_team';
    } else if (getSelectedType() == Const.typeChallenges) {
      return 'ic_pro_home_challenges';
    } else if (getSelectedType() == Const.typeBusinessSector) {
      return 'ic_pro_home_business';
    } else if (getSelectedType() == Const.typeNewCustomer) {
      return 'ic_pro_home_customer';
    } else if (getSelectedType() == Const.typeExistingCustomer) {
      return 'ic_pro_home_exis_customer';
    } else if (getSelectedType() == Const.typeProfile) {
      return '';
    } else if (getSelectedType() == Const.typeEmployee) {
      return '';
    } else if (getSelectedType() == Const.typeSalesPersons) {
      return '';
    } else if (getSelectedType() == Const.typeServicesPerson) {
      return '';
    } else if (getSelectedType() == Const.typeBrandValue) {
      return '';
    } else if (getSelectedType() == Const.typeMoney) {
      return '';
    }
  }


  showTitle() {}

  showDescription() {
    if (getSelectedType() == Const.typeOrg) {
      return 'helpProOrganization';
    } else if (getSelectedType() == Const.typePl) {
      return 'helpProP';
    } else if (getSelectedType() == Const.typeRanking) {
      return 'helpProRanking';
    } else if (getSelectedType() == Const.typeReward) {
      return 'helpProRewards';
    } else if (getSelectedType() == Const.typeTeam) {
      return 'helpProTeam';
    } else if (getSelectedType() == Const.typeChallenges) {
      return 'helpProChallenges';
    } else if (getSelectedType() == Const.typeBusinessSector) {
      return 'helpProBusinessSector';
    } else if (getSelectedType() == Const.typeNewCustomer) {
      return 'helpProNewCustomers';
    } else if (getSelectedType() == Const.typeExistingCustomer) {
      return 'helpProExistingCustomer';
    } else if (getSelectedType() == Const.typeProfile) {
      return 'helpProProfile';
    } else if (getSelectedType() == Const.typeEmployee) {
      return 'helpProEmployMeter';
    } else if (getSelectedType() == Const.typeSalesPersons) {
      return 'helpProSalesMeter';
    } else if (getSelectedType() == Const.typeServicesPerson) {
      return 'helpProServiceMeter';
    } else if (getSelectedType() == Const.typeBrandValue) {
      return 'helpProBrandValue';
    } else if (getSelectedType() == Const.typeMoney) {
      return 'helpProCash';
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

    if (Utils.isFeatureOn(Const.typeReward)) arrTypeData.add(Const.typeReward);

    if (Utils.isFeatureOn(Const.typeTeam) && Injector.isManager())
      arrTypeData.add(Const.typeTeam);
    if (Utils.isFeatureOn(Const.typeChallenges))
      arrTypeData.add(Const.typeChallenges);

    if (Utils.isFeatureOn(Const.typeOrg)) arrTypeData.add(Const.typeOrg);
    if (Utils.isFeatureOn(Const.typePl)) arrTypeData.add(Const.typePl);

    if (Utils.isFeatureOn(Const.typeRanking))
      arrTypeData.add(Const.typeRanking);

    return arrTypeData;
  }
}

*/