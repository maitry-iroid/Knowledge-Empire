import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/header_utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/screens/help_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'challenge_header.dart';

class HeaderView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isShowMenu;
  final bool isChallenge;
  final int challengeCount;
  final int currentIndex;

  HeaderView(
      {this.scaffoldKey,
      this.isShowMenu,
      this.isChallenge,
      this.challengeCount,
      this.currentIndex});

//  List<Organization> arrOrganization = Injector.customerValueData.organization;

  @override
  HeaderViewState createState() => HeaderViewState();
}

class HeaderViewState extends State<HeaderView> {
  @override
  void initState() {
    super.initState();
    if (Injector.headerStreamController == null)
      Injector.headerStreamController = StreamController.broadcast();

    Injector.headerStreamController.stream.listen((data) {
      if (mounted) setState(() {});
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });

//    updateProfileBrodCast();
  }

  /*updateProfileBrodCast() {
    Injector.streamController = StreamController.broadcast();

    Injector.streamController.stream.listen((data) {
      if (data == Const.updateProfileBrod) {
        showHeaderView(context);
      }});
  }*/

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
      child: StreamBuilder(
          stream: customerValueBloc?.customerValue,
          builder: (context, AsyncSnapshot<CustomerValueData> snapshot) {
            if (snapshot.hasData) {
              return _buildSearchResults(snapshot?.data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return _buildSearchResults(snapshot?.data);
//            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  showHeaderItem(String type, BuildContext context) {
    return Container(
      foregroundDecoration:
          /*BoxDecoration(color: ColorRes.white.withOpacity(0.5))*/ null,
      padding:
          EdgeInsets.symmetric(horizontal: Injector.isBusinessMode ? 4 : 2),
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
                        height: Injector.isBusinessMode ? 22 : 23,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorRes.greyText,
                            borderRadius: BorderRadius.circular(12),
                            border: Injector.isBusinessMode
                                ? null
                                : Border.all(color: ColorRes.white, width: 1)),
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: Injector.isBusinessMode ? 0 : 1),
                        child: LinearPercentIndicator(
                          width: Utils.getDeviceWidth(context) / 12,
                          lineHeight: 22.0,
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
                          style: TextStyle(color: ColorRes.white, fontSize: 17),
                        ),
                      )
                    ],
                  )
                : Text(
                    Injector.customerValueData != null
                        ? Injector.customerValueData.totalBalance.toString()
                        : "00.00",
                    style: TextStyle(color: ColorRes.white, fontSize: 18),
                  ),
          ],
        ),
        onTap: () {
          if (type == Const.typeEmployee) {
            if (Injector.dashboardLockStatusData.organization == 1)
              navigationBloc
                  .updateNavigation(HomeData(initialPageType: Const.typeOrg));
            else
              Utils.showLockReasonDialog(Const.typeOrg, context, false);
          } else if (type == Const.typeSalesPersons) {
            navigationBloc.updateNavigation(
                HomeData(initialPageType: Const.typeNewCustomer));
          } else if (type == Const.typeServicesPerson) {
            navigationBloc.updateNavigation(
                HomeData(initialPageType: Const.typeExistingCustomer));
          } else if (type == Const.typeBrandValue) {
            Utils.isInternetConnected().then((isConnected) {
              if (isConnected) {
                if (Injector.dashboardLockStatusData.ranking == 1)
                  navigationBloc.updateNavigation(
                      HomeData(initialPageType: Const.typeRanking));
                else
                  Utils.showLockReasonDialog(Const.typeRanking, context, false);
              } else {
                Utils.showLockReasonDialog(StringRes.noOffline, context, true);
              }
            });
          } else if (type == Const.typeMoney) {
            if (Injector.dashboardLockStatusData.pl == 1) {
              Utils.isInternetConnected().then((isConnected) {
                if (isConnected) {
                  navigationBloc.updateNavigation(
                      HomeData(initialPageType: Const.typePl));
                } else {
                  Utils.showLockReasonDialog(
                      StringRes.noOffline, context, true);
                }
              });
            } else
              Utils.showLockReasonDialog(Const.typePl, context, false);
          }
        },
      ),
    );
  }

  showProfile(BuildContext context) {
    return Expanded(
      child: InkResponse(
          child: Container(
            foregroundDecoration:
                /*
                BoxDecoration(color: ColorRes.white.withOpacity(0.5))*/
                null,
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: Injector.userData == null ||
                                  Injector.userData.profileImage == null ||
                                  Injector.userData.profileImage.isEmpty
                              ? AssetImage(Utils.getAssetsImg('user_org'))
                              : Utils.getCacheNetworkImage(
                                  Injector.userData.profileImage),
                          fit: BoxFit.fill),
                      border: Border.all(color: ColorRes.textLightBlue)),
                ),
                showUserNameCompanyName(context),
              ],
            ),
          ),
          onTap: () {
            Utils.playClickSound();

            navigationBloc
                .updateNavigation(HomeData(initialPageType: Const.typeProfile));
          }),
    );
  }

  showHelpView(BuildContext context) {
    return InkResponse(
      child: Container(
        height: 20,
        width: 20,
        padding: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("question_mark_help")))),
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
              fontSize: 17),
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
              fontSize: 17),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
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

  _buildSearchResults(CustomerValueData data) {
    if (widget.isChallenge != null && widget.isChallenge) {
      if (widget.challengeCount != null) {
        int indexData = Injector.countList.indexWhere(
            (QuestionCountWithData questionCountWithData) =>
                questionCountWithData.questionIndex == widget.currentIndex);
        if (indexData == -1) {
          indexData = 0;
        }
        return ChallengeHeader(
            challengeCount: widget.challengeCount, currentIndex: indexData);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        showMenuView(),
        showProfile(context),
        showHeaderItem(Const.typeEmployee, context),
        showHeaderItem(Const.typeSalesPersons, context),
        showHeaderItem(Const.typeServicesPerson, context),
        showHeaderItem(Const.typeBrandValue, context),
        showHeaderItem(Const.typeMoney, context),
        showHelpView(context)
      ],
    );
  }
}
