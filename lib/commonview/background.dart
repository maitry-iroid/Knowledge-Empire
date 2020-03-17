import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/screens/engagement_customer.dart';


class CommonView {
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
            margin: EdgeInsets.symmetric(horizontal: 10),
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
                      fontSize: 15),
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
                style: TextStyle(color: ColorRes.white, fontSize: 18),
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

  List<GetDashboardData> data = List();

  static Widget showDashboardView(
      BuildContext context, List<GetDashboardData> data) {
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
                        image: AssetImage(Utils.getAssetsImg("organization")),
                        width: Utils.getDeviceWidth(context) / 4.5,
                      ),
                      Utils.showUnreadCount(Const.typeOrg, 17, 5, data)
                    ],
                  ),
                  onTap: () {
                    Utils.playClickSound();
                    Utils.performDashboardItemClick(context, Const.typeOrg);
                  },
                ),
                InkResponse(
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage(Utils.getAssetsImg("profit-loss")),
                        width: Utils.getDeviceWidth(context) / 4.5,
                      ),
                      Utils.showUnreadCount(Const.typePl, 17, 5, data)
                    ],
                  ),
                  onTap: () {
                    Utils.playClickSound();
                    Utils.performDashboardItemClick(context, Const.typePl);
                  },
                ),
                InkResponse(
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage(Utils.getAssetsImg("ranking")),
                        width: Utils.getDeviceWidth(context) / 4.5,
                      ),
                      Utils.showUnreadCount(Const.typeRanking, 17, 5, data)
                    ],
                  ),
                  onTap: () {
                    Utils.playClickSound();
                    Utils.performDashboardItemClick(context, Const.typeRanking);
//                    CommonView().pushNotificationAlert(context);

                  },
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
                              image: AssetImage(Utils.getAssetsImg("rewards")),
                              width: Utils.getDeviceHeight(context) / 3.0,
                            ),
                            Utils.showUnreadCount(Const.typeReward, 17, 5, data)
                          ],
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          Utils.performDashboardItemClick(
                              context, Const.typeReward);
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
                                image: AssetImage(Utils.getAssetsImg("team")),
                                width: Utils.getDeviceHeight(context) / 3.0,
                              ),
                              Utils.showUnreadCount(
                                  Const.typeTeam, 18, 20, data)
                            ],
                          ),
                          onTap: () {
                            Utils.playClickSound();
                            Utils.performDashboardItemClick(
                                context, Const.typeTeam);
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
                              image:
                                  AssetImage(Utils.getAssetsImg("challenges")),
                              width: Utils.getDeviceHeight(context) / 2.6,
                            ),
                            Utils.showUnreadCount(
                                Const.typeChallenges, 17, 17, data)
                          ],
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          Utils.performDashboardItemClick(
                              context, Const.typeChallenges);
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
                            image:
                                AssetImage(Utils.getAssetsImg("new-customer")),
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
                            image: AssetImage(Utils.getAssetsImg("existing")),
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
  }

  //push notification alert

  pushNotificationAlert(BuildContext context) {
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
        });
  }
}
