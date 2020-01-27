import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/header_utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/screens/intro_screen.dart';
import 'package:ke_employee/screens/profile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HeaderView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isShowMenu;
  final Function openProfile;

  HeaderView({this.scaffoldKey, this.isShowMenu, this.openProfile});

//  List<Organization> arrOrganization = Injector.customerValueData.organization;

  @override
  HeaderViewState createState() => HeaderViewState();
}

class HeaderViewState extends State<HeaderView> {
  @override
  void initState() {
    super.initState();

    if (Injector.streamController == null)
      Injector.streamController = StreamController.broadcast();

    Injector.streamController.stream.listen((data) {
//      print("DataReceived1: " + data);

      if (mounted) setState(() {});
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  @override
  void dispose() {
    super.dispose();

//    if (Injector.streamController != null) Injector.streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return showHeaderView(context);
  }

  showHeaderView(BuildContext context) {
    return Container(
      height: Utils.getHeaderHeight(context),
//      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      color: Injector.isBusinessMode
          ? ColorRes.headerDashboard
          : ColorRes.headerBlue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          showMenuView(),
          showProfile(context),
          showUserNameCompanyName(context),
          showHeaderItem(Const.typeEmployee, context),
          showHeaderItem(Const.typeSalesPersons, context),
          showHeaderItem(Const.typeServicesPerson, context),
          showHeaderItem(Const.typeBrandValue, context),
          showHeaderItem(Const.typeMoney, context),
          showHelpView(context)
        ],
      ),
    );
  }

  showHeaderItem(int type, BuildContext context) {
    return InkResponse(
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
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: ColorRes.titleBlueProf,
                            border: Border.all(color: ColorRes.white, width: 1),
                            borderRadius: BorderRadius.circular(12.5)),
                      ),
                Injector.isBusinessMode
                    ? Image(
                        image: AssetImage(Utils.getAssetsImg(
                            HeaderUtils.getHeaderIcon(type))),
                        height: 26,
                      )
                    : Text(
                        getHeadText(type),
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
                                : Border.all(color: ColorRes.white, width: 1)),
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: Injector.isBusinessMode ? 0 : 1),
                        child: LinearPercentIndicator(
                          width: Utils.getDeviceWidth(context) / 12,
                          lineHeight: 19.0,
                          percent: HeaderUtils.getProgressInt(type) >= 0 &&
                                  HeaderUtils.getProgressInt(type) <= 1
                              ? HeaderUtils.getProgressInt(type)?.toDouble() ??
                                  0.toDouble()
                              : 0.0,
                          backgroundColor: Colors.transparent,
                          progressColor: Injector.isBusinessMode
                              ? Colors.blue
                              : ColorRes.titleBlueProf,
                        ),
                      ),
                      Positioned(
                        left: 4,
                        child: Text(
                          HeaderUtils.getProgress(type),
                          style: TextStyle(color: ColorRes.white, fontSize: 14),
                        ),
                      )
                    ],
                  )
                : Text(
                    ' \$ ' +
                        (Injector.customerValueData != null
                            ? Injector.customerValueData.totalBalance.toString()
                            : "00.00"),
                    style: TextStyle(color: ColorRes.white, fontSize: 16),
                  ),
          ],
        ),
      ),
      onTap: () {
        //TODO perform click

        if (type == Const.typeEmployee) {
          /*  open organization / power-ups screen  */
          if (Injector.isBusinessMode == true) {
            Injector.streamController?.add("${Const.typeOrg}");
          } else {
            Injector.streamController?.add("${Const.typeTeam}");
          }
        } else if (type == Const.typeSalesPersons) {
          /*  open new customer screen  */
          Injector.streamController?.add("${Const.typeNewCustomer}");
        } else if (type == Const.typeServicesPerson) {
          /*  open existing customer screen  */
          Injector.streamController?.add("${Const.typeExistingCustomer}");
        } else if (type == Const.typeBrandValue) {
          /*  open ranking screen  */
          Injector.streamController?.add("${Const.typeRanking}");
        } else if (type == Const.typeMoney) {
          /*  open PL screen  */
          Injector.streamController?.add("${Const.typePL}");
        }
//        else if (type == Const.typeProfile) {
//          Injector.streamController?.add("profile open");
//        }
      },
    );
  }

  showProfile(BuildContext context) {
    return InkResponse(
        child: Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: Injector.userData.profileImage != null &&
                          Injector.userData.profileImage.isNotEmpty
                      ? Utils.getCacheNetworkImage(
                          Injector.userData.profileImage)
                      : AssetImage(Utils.getAssetsImg('user_org')),
                  fit: BoxFit.fill),
              border: Border.all(color: ColorRes.textLightBlue)),
        ),
        onTap: () {
          Utils.playClickSound();
//          widget.openProfile();
          Injector.streamController?.add("profile open");

//          Navigator.push(context, MaterialPageRoute(builder: (context) => FadeRouteHome()));
        });
  }

  String getHeadText(int type) {
    if (type == Const.typeEmployee)
      return "PU";
    else if (type == Const.typeSalesPersons)
      return "SP";
    else if (type == Const.typeServicesPerson)
      return "Q";
    else if (type == Const.typeBrandValue)
      return "%";
    else if (type == Const.typeMoney)
      return "LP";
    else
      return "";
  }

  showHelpView(BuildContext context) {
    return InkResponse(
      child: Container(
        height: 25,
        width: 25,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Injector.isBusinessMode
                    ? Utils.getAssetsImg("ic_profile_help")
                    : Utils.getAssetsImg("pro_help")))),
      ),
      onTap: () {
        Utils.playClickSound();
        Navigator.push(context, FadeRouteIntro());
      },
    );
  }

  showUserNameCompanyName(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Injector.userData != null ? Injector.userData.companyName : "",
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
            Injector.userData != null ? Injector.userData.name : "",
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
    );
  }

  showMenuView() {
    return widget.isShowMenu
        ? InkResponse(
            child: Image(
              image: AssetImage(
                Utils.getAssetsImg("menu"),
              ),
              fit: BoxFit.fill,
            ),
            onTap: () {
//                    if(currentVol != 0) {
              Utils.playClickSound();
//                    }
              widget.scaffoldKey.currentState.openDrawer();
            },
          )
        : Container();
  }
}
