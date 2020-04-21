import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ke_employee/animation/Particles.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/ResponsiveUi.dart';

import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/dashboard_lock_status.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/models/push_model.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/screens/organization2.dart';
import 'package:shimmer/shimmer.dart';

class CommonView {
  static bool isShowLayout = false;

  static getBGDecoration(BuildContext context) {
    return Injector.isBusinessMode
        ?
//    CommonView.showDashboardView(context)
        BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg('bg_dashboard_trans')),
                fit: BoxFit.fill))
        : BoxDecoration(color: ColorRes.bgProf);
  }

  static showTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkResponse(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(
                  Injector.isBusinessMode ? "back" : 'back_prof')),
              width: 30,
            ),
            onTap: () {
              Utils.playClickSound();
              Utils.performBack(context);
            },
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            margin: title == StringRes.challenges
                ? EdgeInsets.only(right: 60)
                : EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius:
                    Injector.isBusinessMode ? null : BorderRadius.circular(20),
                border: Injector.isBusinessMode
                    ? null
                    : Border.all(width: 1, color: ColorRes.white),
                color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(
                          Utils.getAssetsImg("bg_blue"),
                        ),
                        fit: BoxFit.fill)
                    : null),
            child: Text(
              Utils.getText(context, Utils.getText(context, title)),
              style: TextStyle(
                color: ColorRes.white,
                fontSize: DimenRes.titleTextSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 30,
          )
        ],
      ),
    );
  }

  //http://www.pdf995.com/samples/pdf.pdf
  //https://www.radiantmediaplayer.com/media/bbb-360p.mp4
  static image(BuildContext context, String image) {
    //VideoPlayerController _videoPlay
    /* return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 20),
      decoration: BoxDecoration(
        color: ColorRes.white,
        image: DecorationImage(
            image: image != null ? new NetworkImage(image) : null,
            fit: BoxFit.fill),

        /* image: image != null && image.isNotEmpty
            ? DecorationImage(
//            image: image != null ? new NetworkImage(image) : null,

                image: AssetImage(
                  Utils.getAssetsImg(image),
                ),
                fit: BoxFit.fill)
            : null,*/

        borderRadius: BorderRadius.circular(10),
      ),
    );*/

    //video show code: -

//    return Container(
//      margin: EdgeInsets.only(left: 7, right: 7, bottom: 7, top: 7),
//
//      child:  _videoPlay.value.initialized
//          ? AspectRatio(
//        aspectRatio: _videoPlay.value.aspectRatio,
//        child: VideoPlayer(_videoPlay),
//      )
//          : Container(),
//
//    );

    //pdf show codeing.
  }

  static questionAndExplanation(
      BuildContext context, String title, bool checking, String content) {
    return InkResponse(
      onTap: () {
        Utils.playClickSound();

        if (checking)
          showDialog(
            context: context,
            builder: (_) => FunkyOverlay(
              title: title,
              content: content,
            ),
          );
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 10),
            child: Container(
              margin: EdgeInsets.only(top: 0),
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              decoration: BoxDecoration(
                color: Injector.isBusinessMode ? ColorRes.bgDescription : null,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorRes.white, width: 1),
              ),
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: TextStyle(
                      color: Injector.isBusinessMode
                          ? ColorRes.white
                          : ColorRes.textProf,
                      fontSize: 17),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              margin: (checking == true
                  ? EdgeInsets.symmetric(
                      horizontal: Utils.getDeviceWidth(context) / 7)
                  : EdgeInsets.symmetric(
                      horizontal: Utils.getDeviceWidth(context) / 3)),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(20),
                  border: Injector.isBusinessMode
                      ? null
                      : Border.all(width: 1, color: ColorRes.white),
                  color:
                      Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                  image: Injector.isBusinessMode
                      ? DecorationImage(
                          image:
                              AssetImage(Utils.getAssetsImg("eddit_profile")),
                          fit: BoxFit.fill)
                      : null),
              child: Text(
                title,
                style: TextStyle(color: ColorRes.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //Full Screen Alert Show
          Align(
            alignment:
                (checking == true ? Alignment.bottomRight : Alignment.topRight),
//          Alignment.bottomRight,
            child: (checking == true
                ? Container(
                    alignment: Alignment.center,
                    height: Utils.getDeviceWidth(context) / 20,
                    width: Utils.getDeviceWidth(context) / 20,
                    decoration: BoxDecoration(
                        image:
//                          Injector.isBusinessMode ?
                            DecorationImage(
                                image: AssetImage(Injector.isBusinessMode
                                    ? Utils.getAssetsImg(
                                        "full_expand_question_answers")
                                    : Utils.getAssetsImg("expand_pro")),
                                fit: BoxFit.fill)
//                              : null
                        ))
                : Container(
                    alignment: Alignment.center,
                    height: Utils.getDeviceWidth(context) / 40,
                    width: Utils.getDeviceWidth(context) / 40,
                    decoration: BoxDecoration(
                        image:
//                          Injector.isBusinessMode ?
                            DecorationImage(
                                image: AssetImage(
                                    Utils.getAssetsImg("close_dialog")),
                                fit: BoxFit.fill)
//                              : null
                        ))),
          )
        ],
      ),
    );
  }

//
//  static Widget showCircularProgress(bool isLoading) {
//    if (isLoading) {
//      return Center(
//          child: CircularProgressIndicator(
//        backgroundColor: ColorRes.white,
//      ));
//    }
//    return Container(
//      height: 0.0,
//      width: 0.0,
//    );
//  }

  static showCircularProgress(bool isLoading, BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      elevation: 0.0,
      content: new Container(
          height: 40.0,
          color: Colors.transparent,
          child: new Center(
            child: SpinKitThreeBounce(color: Colors.white),
          )),
    );
    if (!isLoading) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }
  }

  static showBackground(BuildContext context) {
    return Injector.isBusinessMode
        ? Stack(
            children: <Widget>[
              showDashboardView(context, null),
              Container(
                color: ColorRes.black.withOpacity(0.75),
              )
            ],
          )
        : Container(
            color: ColorRes.bgProf,
          );
  }

  static showBackgroundOrg(BuildContext context) {
    return Injector.isBusinessMode
        ? Image(
            image: AssetImage(Utils.getAssetsImg('organization_bg')),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          )
        : Container(
            color: ColorRes.bgProf,
          );
  }

  static Widget showBGDashboardView(BuildContext context) {
//    CommonView.showDashboardView(context);
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("intro_bub_background")),
                fit: BoxFit.fill)));
  }

  List<UnreadBubbleCountData> data = List();

  static Widget showDashboardView(
      BuildContext context, List<UnreadBubbleCountData> data) {
    DashboardLockStatusData dashboardLockStatusData =
        Injector.dashboardLockStatusData;
    data = Injector.unreadBubbleCountData;
    return ResponsiveUi(
      builder: (context, size) {
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
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image:
                                AssetImage(Utils.getAssetsImg("organization")),
                            width: Utils.getDeviceWidth(context) / 4.5,
                          ),
                          dashboardLockStatusData != null &&
                                  dashboardLockStatusData.organization !=
                                      null &&
                                  dashboardLockStatusData.organization == 1
                              ? Utils.showUnreadCount(
                                  Const.typeOrg, 17, 5, data)
                              : Container(),
                          dashboardLockStatusData != null &&
                                  dashboardLockStatusData.organization !=
                                      null &&
                                  dashboardLockStatusData.organization == 1
                              ? Container()
                              : Image(
                                  image: AssetImage(
                                      Utils.getAssetsImg("lock_org")),
                                  width: Utils.getDeviceWidth(context) / 4.5,
                                ),
                        ],
                      ),
                      onTap: () {
                        Utils.playClickSound();
                        Utils.isInternetConnected().then((isConnected) {
                          if (isConnected) {
                            Utils.performDashboardItemClick(
                                context, Const.typeOrg);
                          } else {
                            Utils.showLockReasonDialog(
                                StringRes.noOffline, context, true);
                          }
                        });
                      },
                    ),
                    InkResponse(
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image:
                                AssetImage(Utils.getAssetsImg("profit-loss")),
                            width: Utils.getDeviceWidth(context) / 4.5,
                          ),
                          dashboardLockStatusData != null &&
                                  dashboardLockStatusData.pl != null &&
                                  dashboardLockStatusData.pl == 1
                              ? Utils.showUnreadCount(Const.typePl, 17, 5, data)
                              : Container(),
                          dashboardLockStatusData != null &&
                                  dashboardLockStatusData.pl != null &&
                                  dashboardLockStatusData.pl == 1
                              ? Container()
                              : Image(
                                  image:
                                      AssetImage(Utils.getAssetsImg("lock_pl")),
                                  width: Utils.getDeviceWidth(context) / 4.5,
                                ),
                        ],
                      ),
                      onTap: () {
                        Utils.playClickSound();
                        Utils.isInternetConnected().then((isConnected) {
                          if (isConnected) {
                            Utils.performDashboardItemClick(
                                context, Const.typePl);
                          } else {
                            Utils.showLockReasonDialog(
                                StringRes.noOffline, context, true);
                          }
                        });
                      },
                    ),
                    InkResponse(
                        child: Stack(
                          children: <Widget>[
                            Image(
                              image: AssetImage(Utils.getAssetsImg("ranking")),
                              width: Utils.getDeviceWidth(context) / 4.5,
                            ),
                            dashboardLockStatusData != null &&
                                    dashboardLockStatusData.ranking != null &&
                                    dashboardLockStatusData.ranking == 1
                                ? Utils.showUnreadCount(
                                    Const.typeRanking, 17, 5, data)
                                : Container(),
                            dashboardLockStatusData != null &&
                                    dashboardLockStatusData.ranking != null &&
                                    dashboardLockStatusData.ranking == 1
                                ? Container()
                                : Image(
                                    image: AssetImage(
                                        Utils.getAssetsImg("lock_ranking")),
                                    width: Utils.getDeviceWidth(context) / 4.5,
                                  ),
                          ],
                        ),
                        onTap: () {
                          Utils.playClickSound();

                          Utils.isInternetConnected().then((isConnected) {
                            if (isConnected) {
                              Utils.performDashboardItemClick(
                                  context, Const.typeRanking);
                            } else {
                              Utils.showLockReasonDialog(
                                  StringRes.noOffline, context, true);
                            }
                          });

//                      Utils.achievement();
//                      CommonView().collectorDialog(context, '1000');
                        }
//                    DisplayDialogs.showChallengeDialog(context,"Ravi",null);
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
                alignment: Alignment.center,
                width: Utils.getDeviceWidth(context),
                margin: EdgeInsets.only(
                    top: Utils.getDeviceHeight(context) / 4.2,
                    left: Utils.getDeviceWidth(context) / 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 40,
                              left: 20,
                              right: Utils.getDeviceWidth(context) / 13),
                          child: InkResponse(
                            child: Stack(
                              children: <Widget>[
                                Image(
                                  image:
                                      AssetImage(Utils.getAssetsImg("rewards")),
                                  width: Utils.getDeviceHeight(context) / 3.0,
                                ),
                                dashboardLockStatusData != null &&
                                        dashboardLockStatusData.achievement !=
                                            null &&
                                        dashboardLockStatusData.achievement == 1
                                    ? Utils.showUnreadCount(Const.typeReward,
                                        17, size.width / 20, data)
                                    : ConstrainedBox(
                                        constraints: new BoxConstraints(
                                        minHeight: 25.0,
                                        minWidth: 25.0,
                                      )),
                                dashboardLockStatusData != null &&
                                        dashboardLockStatusData.achievement !=
                                            null &&
                                        dashboardLockStatusData.achievement == 1
                                    ? ConstrainedBox(
                                        constraints: new BoxConstraints(
                                        minHeight: 25.0,
                                        minWidth: 25.0,
                                      ))
                                    : Image(
                                        image: AssetImage(
                                            Utils.getAssetsImg("lock_rewards")),
                                        width: Utils.getDeviceHeight(context) /
                                            3.0,
                                      ),
                              ],
                            ),
                            onTap: () {
                              Utils.playClickSound();
                              Utils.isInternetConnected().then((isConnected) {
                                if (isConnected) {
                                  Utils.performDashboardItemClick(
                                      context, Const.typeReward);
                                } else {
                                  Utils.showLockReasonDialog(
                                      StringRes.noOffline, context, true);
                                }
                              });
                            },
                          )),
                    ),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 15,
                              left: Utils.getDeviceWidth(context) / 14,
                              right: Utils.getDeviceWidth(context) / 14),
                          child: Opacity(
                            child: InkResponse(
                              child: Stack(
                                children: <Widget>[
                                  Image(
                                    image:
                                        AssetImage(Utils.getAssetsImg("team")),
                                    width: Utils.getDeviceHeight(context) / 3.0,
                                  ),
                                  Utils.showUnreadCount(
                                      Const.typeTeam, 18, 20, data)
                                ],
                              ),
                              onTap: () {
                                Utils.playClickSound();
                                Utils.isInternetConnected().then((isConnected) {
                                  if (isConnected) {
                                    Utils.performDashboardItemClick(
                                        context, Const.typeTeam);
                                  } else {
                                    Utils.showLockReasonDialog(
                                        StringRes.noOffline, context, true);
                                  }
                                });
                              },
                            ),
                            opacity: Injector.isManager() ? 1 : 0,
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 0,
                            left: 0,
                            right: Utils.getDeviceWidth(context) / 10,
                            top: 00),
                        child: InkResponse(
                            child: Stack(
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                      Utils.getAssetsImg("challenges")),
                                  width: Utils.getDeviceHeight(context) / 2.6,
                                ),
                                dashboardLockStatusData != null &&
                                        dashboardLockStatusData.challenge !=
                                            null &&
                                        dashboardLockStatusData.challenge == 1
                                    ? Utils.showUnreadCount(
                                        Const.typeChallenges, 17, 17, data)
                                    : ConstrainedBox(
                                        constraints: new BoxConstraints(
                                        minHeight: 25.0,
                                        minWidth: 25.0,
                                      )),
                                dashboardLockStatusData != null &&
                                        dashboardLockStatusData.challenge !=
                                            null &&
                                        dashboardLockStatusData.challenge == 1
                                    ? ConstrainedBox(
                                        constraints: new BoxConstraints(
                                        minHeight: 25.0,
                                        minWidth: 25.0,
                                      ))
                                    : Image(
                                        image: AssetImage(Utils.getAssetsImg(
                                            "lock_challenges")),
                                        width: Utils.getDeviceHeight(context) /
                                            2.6,
                                      ),
                              ],
                            ),
                            onTap: () {
                              Utils.playClickSound();
                              Utils.isInternetConnected().then((isConnected) {
                                if (isConnected) {
                                  Utils.performDashboardItemClick(
                                      context, Const.typeChallenges);
                                } else {
                                  Utils.showLockReasonDialog(
                                      StringRes.noOffline, context, true);
                                }
                              });
                            }),
                      ),
                    ),
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
                          child: Stack(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    Utils.getAssetsImg("business_sectors")),
                                width: Utils.getDeviceWidth(context) / 3.8,
                              ),
                              Utils.showUnreadCount(
                                  Const.typeBusinessSector, 10, 35, data)
                            ],
                          ),
                          onTap: () {
                            Utils.playClickSound();
                            Utils.performDashboardItemClick(
                                context, Const.typeBusinessSector);
                          }),
                      InkResponse(
                          child: Stack(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    Utils.getAssetsImg("new-customer")),
                                width: Utils.getDeviceWidth(context) / 4.2,
                              ),
                              Utils.showUnreadCount(
                                  Const.typeNewCustomer, 10, 15, data)
                            ],
                          ),
                          onTap: () {
                            Utils.playClickSound();
                            Utils.performDashboardItemClick(
                                context, Const.typeNewCustomer);
                          }),
//                SizedBox(
//                  width: Utils.getDeviceWidth(context) / 20,
//                ),
                      InkResponse(
                          child: Stack(
                            children: <Widget>[
                              Image(
                                image:
                                    AssetImage(Utils.getAssetsImg("existing")),
                                width: Utils.getDeviceWidth(context) / 4.6,
                              ),
                              Utils.showUnreadCount(
                                  Const.typeExistingCustomer, 10, 35, data)
                            ],
                          ),
                          onTap: () {
                            Utils.playClickSound();
                            Utils.performDashboardItemClick(
                                context, Const.typeExistingCustomer);
                          }),
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
                bottom: Utils.getDeviceHeight(context) / 20,
                left: Utils.getDeviceWidth(context) / 3.4,
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
      },
    );
  }

  //push notification alert

  pushNotificationAlert(BuildContext context, String bonus, String level,
      String type, String achievementType) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(40),
                      width: Utils.getDeviceWidth(context) / 2.0,
                      height: Utils.getDeviceHeight(context) / 2.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorRes.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 35,
                              width: Utils.getDeviceWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: ColorRes.blue,
                              ),
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text(
                                  Utils.getText(context, StringRes.achievement),
                                  style: TextStyle(
                                      color: ColorRes.white, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 13)),
                            Text(
                              Utils.getText(context,
                                  "${StringRes.congratulations}" /*+bonus.toString()!="null"?bonus.toString():""+*/ "${StringRes.rewards}!"),
                              style: TextStyle(
                                color: ColorRes.greenDot,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  "assets/images/coin_reward.gif",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill),
                            ),
//                            InkResponse(
//                              child: Container(
//                                width: 100,
//                                height: 30,
//                                padding: EdgeInsets.only(
//                                    left: 10, right: 10, top: 3, bottom: 3),
//                                margin: EdgeInsets.only(
//                                    left: 10, right: 10, top: 3, bottom: 3),
//                                decoration: BoxDecoration(
//                                    color: ColorRes.borderRewardsName,
//                                    border: Border.all(
//                                        width: 2,
//                                        color: ColorRes.borderRewardsName),
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(20)),
//                                    boxShadow: [
//                                      BoxShadow(
//                                        color: Colors.grey,
//                                        blurRadius: 5.0,
//                                      ),
//                                    ]),
//                                child: Center(
//                                  child: Text(Utils.getText(context, "CLAIM"),
//                                      style: TextStyle(
//                                          color: ColorRes.white, fontSize: 17)),
//                                ),
//                              ),
//                              onTap: () {
//                                switch (type) {
//                                  case 0:
//                                    break;
//                                  case 1:
//                                    break;
//                                  case 3:
//                                    break;
//                                  case 8:
//                                    break;
//                                }
//                                Navigator.pop(context, Const.add);
//                              },
//                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      right: 10,
                      child: InkResponse(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image:
                                AssetImage(Utils.getAssetsImg('close_dialog')),
                            width: 20,
                          ),
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          Navigator.pop(context, null);
                        },
                      ))
                ],
              ),
            ),
          );
        });
    /*showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                  width: Utils.getDeviceWidth(context) / 2,
                  height: Utils.getDeviceHeight(context) / 2,
                  decoration: BoxDecoration(
                      color: ColorRes.greyText,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Text("Notification Alert"),
                      ),
                      Expanded(child: Text("Count of Notification.")),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.only(bottom: 0),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: ColorRes.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: InkResponse(
                          child: Text("hello", textAlign: TextAlign.center,),
                          onTap: () {
                              Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )),
            ),
          );
        })*/
  }

  pushNotificationAlert2(BuildContext context, String bonus, String level,
      String type, String achievementType) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              color: ColorRes.colorBgDark,
              height: Utils.getDeviceHeight(context) / 1.6,
              width: Utils.getDeviceWidth(context) / 2,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorRes.white),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: Utils.getDeviceWidth(context) / 8,
                        height: Utils.getDeviceHeight(context) / 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: ColorRes.borderRewardsName, width: 1)),
                        child: Center(
                            child: Text(
                          Utils.getText(context, StringRes.collector),
                          style: TextStyle(fontSize: 18, color: ColorRes.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(Utils.getAssetsImg("won"),
                            height: Utils.getDeviceHeight(context) / 5,
                            width: Utils.getDeviceWidth(context) / 6),
                      ),
                      SizedBox(height: 8),
                      Text(
                        Utils.getText(context, "${StringRes.addFriend}$bonus"),
                        style: TextStyle(fontSize: 18, color: ColorRes.white),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 12),
                      Image.asset(Utils.getAssetsImg("next_prof"),
                          width: Utils.getDeviceWidth(context) / 5,
                          height: Utils.getDeviceHeight(context) / 12)
                    ],
                  ),
                ),
              ),
            ),
          );
        });
    /*showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                  width: Utils.getDeviceWidth(context) / 2,
                  height: Utils.getDeviceHeight(context) / 2,
                  decoration: BoxDecoration(
                      color: ColorRes.greyText,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Text("Notification Alert"),
                      ),
                      Expanded(child: Text("Count of Notification.")),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.only(bottom: 0),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: ColorRes.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: InkResponse(
                          child: Text("hello", textAlign: TextAlign.center,),
                          onTap: () {
                              Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  )),
            ),
          );
        })*/
  }

  collectorDialog(BuildContext context, PushModel mPushModel, String btnText) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.75),
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 25),
                  width: Utils.getDeviceWidth(context) / 2.2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: ColorRes.fontDarkGrey,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    color: ColorRes.borderRewardsName)),
                            child: Text(mPushModel.achievementName??"",
                                style: TextStyle(
                                    color: ColorRes.white, fontSize: 15)),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: Utils.getDeviceWidth(context) / 3.5,
                            height: Utils.getDeviceHeight(context) / 3.5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Utils.getAssetsImg("bg_collector")))),
                            child: Image.asset(imageFomType(mPushModel.level),
                                fit: BoxFit.contain),
                          ),
                          SizedBox(height: 15),
                          Text("${mPushModel.achievementText??""}",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.body2.copyWith(
                                  color: ColorRes.white, fontSize: 20)),
                          SizedBox(height: 10),
                          InkResponse(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: ColorRes.header,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: ColorRes.white)),
                              child: Text(btnText,
                                  style: TextStyle(
                                      color: ColorRes.white, fontSize: 15)),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  imageFomType(String level) {
    switch (level) {
      case "0":
        return Utils.getAssetsImg("trophy0");
        break;
      case "1":
        return Utils.getAssetsImg("trophy1");
        break;
      case "2":
        return Utils.getAssetsImg("trophy2");
        break;
      case "3":
        return Utils.getAssetsImg("trophy3");
        break;
      case "4":
        return Utils.getAssetsImg("trophy4");
        break;
      case "5":
        return Utils.getAssetsImg("trophy5");
        break;
      case "6":
        return Utils.getAssetsImg("trophy6");
        break;
      case "7":
        return Utils.getAssetsImg("trophy7");
        break;
      case "8":
        return Utils.getAssetsImg("trophy8");
        break;
      case "9":
        return Utils.getAssetsImg("trophy9");
        break;
      case "10":
        return Utils.getAssetsImg("trophy10");
        break;
    }
  }

  static showShimmer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: ColorRes.lightGrey.withOpacity(0.5),
              highlightColor: Colors.grey[100],
              enabled: true,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
