import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/screens/engagement_customer.dart';
import 'package:ke_employee/models/questions.dart';

import '../screens/home.dart';

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
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 20),
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
      BuildContext context, String title, bool checking, String questions) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                questions,
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
                borderRadius:
                    Injector.isBusinessMode ? null : BorderRadius.circular(20),
                border: Injector.isBusinessMode
                    ? null
                    : Border.all(width: 1, color: ColorRes.white),
                color: Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                image: Injector.isBusinessMode
                    ? DecorationImage(
                        image: AssetImage(Utils.getAssetsImg("eddit_profile")),
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
          child: InkResponse(
              onTap: () {
                Utils.playClickSound();

                if (checking)
                  showDialog(
                    context: context,
                    builder: (_) => FunkyOverlay(title: title),
                  );
              },
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
                          )))),
        )
      ],
    );
  }

/*
  static answers(BuildContext context, String title){
    return Stack(
      children: <Widget>[
        Card(
          elevation: 10,
//                          color: ColorRes.whiteDarkBg,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.only(
              top: 25, bottom: 10, right: 10, left: 15),
          child: Container(
            padding: EdgeInsets.only(
                left: 10, right: 10, top: 15, bottom: 18),
            decoration: BoxDecoration(
              color: ColorRes.bgDescription,
              borderRadius: BorderRadius.circular(12),
              border:
              Border.all(color: ColorRes.white, width: 1),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: arrSector.length,
              itemBuilder: (BuildContext context, int index) {
//                                GestureDetector(
//                                  onTap: () {
//                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Customer()));
//                                  },
//                                );
                return CategoryItem(
                  selectItem,
                  // callback function, setstate for parent
                  index: index,
                  isSelected:
                  _selectedItem == index ? true : false,
                  title: arrSector[index],
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.center,
            height: 30,
            margin: EdgeInsets.symmetric(
                horizontal: Utils.getDeviceWidth(context) / 6,
                vertical: 10),
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        Utils.getAssetsImg("eddit_profile")),
                    fit: BoxFit.fill)),
            child: Text(
              'Answers',
              style: TextStyle(
                  color: ColorRes.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
*/

  static topThreeButton(BuildContext context, String firstTitle,
      String secondTitle, int selectedIndex, QuestionData questionData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: InkResponse(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(
                  Injector.isBusinessMode ? "back" : 'back_prof')),
              width: DimenRes.titleBarHeight,
            ),
            onTap: () {
              Utils.playClickSound();
              Utils.performBack(context);
            },
          ),
//          InkResponse(
//          child: Image(
//          image: AssetImage(Utils.getAssetsImg(
//          Injector.isBusinessMode ? "back" : 'back_prof')),
//          width: DimenRes.titleBarHeight,
//          ),
//          onTap: () {
//          Utils.performBack(context);
//          },          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerSituationPage()));
          alignment: Alignment.center,
          height: 30,
          width: 40,

//                        child: Icon(Icons.chevron_left, color: ColorRes.white,),
        ),
        Container(
          alignment: Alignment.center,
          height: 30,
//                          margin: EdgeInsets.only(left: 50.0, right: 50.0),

          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("eddit_profile")),
                  fit: BoxFit.fill)),
          child: Text(
            firstTitle,
            style: TextStyle(color: ColorRes.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        InkResponse(
          onTap: () {
            Utils.playClickSound();
//            questionData.answer = arrAnswerr;
//            Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerSituationPage(questionData: questionData)));

            Navigator.push(
                context,
                FadeRouteHome(
                    initialPageType: Const.typeCustomerSituation,
                    questionDataSituation: questionData));

//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => HomePage(
//                        initialPageType: Const.typeDebrief,
//                        questionDataSituation: questionData,
//                      )),
//            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_engage_now")),
                    fit: BoxFit.fill)),
            child: Text(
              secondTitle,
              maxLines: 1,
              style: TextStyle(color: ColorRes.white, fontSize: 5),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  static Widget showCircularProgress(bool isLoading) {
    if (isLoading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: ColorRes.white,
      ));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
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
                      Utils.showUnreadCount(Const.typePL, 17, 5, data)
                    ],
                  ),
                  onTap: () {
                    Utils.playClickSound();
                    Utils.performDashboardItemClick(context, Const.typePL);
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
                Padding(
                    padding: EdgeInsets.only(bottom: 15, left: 40, right: 0),
                    child: InkResponse(
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage(Utils.getAssetsImg("team")),
                            width: Utils.getDeviceHeight(context) / 3.0,
                          ),
                          Utils.showUnreadCount(Const.typeTeam, 18, 20, data)
                        ],
                      ),
                      onTap: () {
                        Utils.playClickSound();
                        Utils.performDashboardItemClick(
                            context, Const.typeTeam);
                      },
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 0, left: 0, right: 30, top: 00),
                  child: InkResponse(
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage(Utils.getAssetsImg("challenges")),
                            width: Utils.getDeviceHeight(context) / 2.6,
                          ),
                          Utils.showUnreadCount(Const.typeChallenges, 17, 17, data)
                        ],
                      ),
                      onTap: () {
                        Utils.playClickSound();
                        Utils.performDashboardItemClick(
                            context, Const.typeChallenges);
                      }),
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
                            width: Utils.getDeviceWidth(context) / 3.5,
                          ),
                          Utils.showUnreadCount(Const.typeBusinessSector, 10, 35, data)
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
                          Utils.showUnreadCount(Const.typeNewCustomer, 10, 15, data)
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
                          Utils.showUnreadCount(Const.typeExistingCustomer, 10, 35, data)
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
}
