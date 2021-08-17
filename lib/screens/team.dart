import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/customer_value_bloc.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/commonview/common_view.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/manager/encryption_manager.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/team_user.dart';
import 'package:ke_employee/models/team_user_by_id.dart';
import 'package:pie_chart/pie_chart.dart';

import '../helper/Utils.dart';
import '../helper/res.dart';
import '../helper/string_res.dart';

/*
*   created by Riddhi
*
*   This section will be visible for Manager only.
*   All the users under this team will be displayed from API.
*   They can handle bailout request send from users.
*
* */

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  bool secondScreen = false;

  TeamUserData teamUserData = TeamUserData();
  TeamUserByIdData teamUserByIdData = TeamUserByIdData();

  List<String> indexList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    ColorRes.chartOne,
    ColorRes.chartTwo,
    ColorRes.chartThree,
    ColorRes.chartFour,
    ColorRes.chartFive,
    ColorRes.chartSix,
    ColorRes.chartSeven,
    ColorRes.chartEight,
    ColorRes.chartNine,
    ColorRes.chartTen,
  ];

  Map<String, double> openCloseMap = Map();
  List<Color> colorOpenCloseList = [
    ColorRes.chartClose,
    ColorRes.chartOpen,
  ];

  @override
  void initState() {
    getTeamUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Padding(
          padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
//          child: showMainBody(),
          child: Column(
            children: <Widget>[
              !secondScreen ? CommonView.showTitle(context, StringRes.team) : showTitleSecondScreen(context, StringRes.team),
              showMainBody()
            ],
          ),
        ),
      ],
    );
  }

  showMainBody() {
    return Expanded(
        child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[showFirstHalf(), showSecondHalf()],
          ),
        ),
      ],
    ));
  }

  showFirstHalf() {
    return Expanded(
        flex: secondScreen != true ? 8 : 1,
        child: ListView(
          children: <Widget>[showProfile(), showListHeader(), showListView()],
        ));
  }

  showProfile() {
    return Visibility(
      child: Container(
//        height: 200,
        margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 10),
        child: Column(
          children: <Widget>[
            firstColumn(),
            secondColumn(),
            thirdColumn(),
          ],
        ),
      ),
      visible: secondScreen,
    );
  }

  showListHeader() {
    return Container(
        alignment: Alignment.topCenter,
        height: 30,
        margin: !secondScreen ? EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 10) : EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 10),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_grey_teamheader")), fit: BoxFit.fill)),
        padding: !secondScreen ? EdgeInsets.only(left: 30, right: 5, top: 5, bottom: 5) : EdgeInsets.only(left: 13, right: 5, top: 5, bottom: 5),
        child: !secondScreen
            ? Row(
                children: <Widget>[
                  listHeaderText(Utils.getText(context, StringRes.name), TextAlign.left),
                  listHeaderText(Utils.getText(context, StringRes.lastLog), TextAlign.center),
                  listHeaderText(Utils.getText(context, StringRes.points), TextAlign.center),
                  listHeaderText(Utils.getText(context, StringRes.correct), TextAlign.center),
                ],
              )
            : Row(
                children: <Widget>[
                  listHeaderText(Utils.getText(context, StringRes.learningModule), TextAlign.left),
                  listHeaderText(Utils.getText(context, StringRes.levels), TextAlign.center),
                  listHeaderText(Utils.getText(context, StringRes.complete), TextAlign.center),
                ],
              ));
  }

  showListView() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      child: ListView.builder(
          itemCount: secondScreen != true ? teamUserData?.users?.length ?? 0 : teamUserByIdData?.modules?.length ?? 0,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return showListData(index);
          }),
    );
  }

  showListData(int index) {
    Users user;
    Modules module;

    if (!secondScreen)
      user = teamUserData.users[index];
    else
      module = teamUserByIdData.modules[index];

    return InkResponse(
      child: Container(
          height: 30,
          padding:
              secondScreen != true ? EdgeInsets.only(left: 30, right: 0, top: 5, bottom: 5) : EdgeInsets.only(left: 23, right: 0, top: 5, bottom: 5),
          margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
          decoration: BoxDecoration(
              color: Injector.isBusinessMode ? null : ColorRes.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              image: DecorationImage(image: AssetImage(Injector.isBusinessMode ? Utils.getAssetsImg("bg_white_smalldata") : ""), fit: BoxFit.fill)),
          child: secondScreen != true
              ? Row(
                  children: <Widget>[
                    listTextData(user?.name ?? "", TextAlign.left, isForName: true),
                    listTextData(user?.lastLog.toString() ?? "", TextAlign.center),
                    listTextData(user?.points.toString() ?? "", TextAlign.center),
                    listTextData(user?.correct.toString() ?? "", TextAlign.center)
                    /*                   listTextData(user?.name, TextAlign.left),
                    listTextData(user?.lastLog.toString(), TextAlign.right),
                    listTextData(user?.points.toString(), TextAlign.right),
                    listTextData(user?.correct.toString(), TextAlign.right)*/
                  ],
                )
              : Row(
                  children: <Widget>[
                    listTextData(module?.name, TextAlign.left, isForName: true),
                    listTextData(module?.level.toString(), TextAlign.center),
                    listTextData(module?.complete.toString(), TextAlign.center)
                  ],
                )),
      onTap: () {
        if (mounted)
          setState(() {
            secondScreen = true;
            selectedTeamUserId = user.userId;
            getTeamUserById(user.userId);
          });
      },
    );
  }

  int selectedTeamUserId = -1;

  profileBorderShow() {
    return BoxDecoration(
        border: Border.all(width: 1, color: Injector.isBusinessMode ? ColorRes.white : ColorRes.bgDescription),
        borderRadius: BorderRadius.all(Radius.circular(20)));
  }

  listHeaderText(String title, TextAlign textAlign) {
    return Expanded(
//      flex: 1,
      child: Container(
        child: Text(
          title,
          textAlign: textAlign,
          style: TextStyle(color: ColorRes.white, fontSize: 17),
        ),
      ),
    );
  }

  listTextData(String text, TextAlign textAlign, {bool isForName = false}) {
    return Expanded(
      child: Container(
        child: isForName
            ? AutoSizeText(
                text,
                maxLines: 1,
                overflow: TextOverflow.fade,
                minFontSize: 4,
                textAlign: textAlign,
                style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 16),
              )
            : Text(
                text,
                textAlign: textAlign,
                style: TextStyle(color: ColorRes.textRecordBlue, fontSize: 16),
              ),
      ),
    );
  }

  showProfileText(String title) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Text(
        title,
        style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.bgDescription, fontSize: 15),
      ),
    );
  }

  firstColumn() {
    return Container(
      child: Row(
        children: <Widget>[
          showProfileText(
            Utils.getText(context, StringRes.name_),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  margin: EdgeInsets.only(left: 50, top: 8, bottom: 5),
                  decoration: profileBorderShow(),
                  child: Center(
                    child: Text(
                      teamUserByIdData?.name ?? "",
                      style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.textRecordBlue, fontSize: 15),
                    ),
                  ),
                ),
                selectedTeamUserId != -1
                    ? InkResponse(
                        child: Container(
//                  height: 35,
                          width: 80,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                          alignment: Alignment.center,
                          child: Text(
                            Utils.getText(context, StringRes.bailout),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: ColorRes.white, fontSize: 15, letterSpacing: 0.7),
                          ),
                          decoration:
                              BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg('bg_switch_to_prfsnl')), fit: BoxFit.fill)),
                        ),
                        onTap: () async {
                          Utils.playClickSound();
                          _asyncConfirmDialog(context);
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  secondColumn() {
    return Container(
      child: Row(
        children: <Widget>[
          showProfileText(Utils.getText(context, StringRes.department_)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            margin: EdgeInsets.only(left: 10, top: 8, bottom: 5),
            decoration: profileBorderShow(),
            child: Center(
              child: Text(
                teamUserByIdData?.department ?? "",
                style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.textRecordBlue, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  thirdColumn() {
    return Container(
      child: Row(
        children: <Widget>[
          showProfileText(Utils.getText(context, StringRes.resets_)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            margin: EdgeInsets.only(left: 40, top: 8, bottom: 5),
            decoration: profileBorderShow(),
            child: Center(
              child: Text(
                teamUserByIdData?.resets?.toString() ?? "",
                style: TextStyle(color: Injector.isBusinessMode ? ColorRes.white : ColorRes.textRecordBlue, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //second half

  showSecondHalf() {
    return Expanded(
      flex: secondScreen != true ? 6 : 1,
      child: Container(
        margin: EdgeInsets.only(right: 15, bottom: 8),
        decoration: BoxDecoration(
            color: Injector.isBusinessMode ? ColorRes.white.withOpacity(0.2) : ColorRes.white, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              qLevel(),
              qStatus(),
            ],
          ),
        ),
      ),
    );
  }

  qLevel() {
    return Container(
//        height: 200,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 0),
        child: dataMap != null && dataMap.length > 0 ? pieChart(Utils.getText(context, StringRes.qLevel), 1) : Container());
  }

  qStatus() {
    return Container(
//      height: 200,
      width: Utils.getDeviceWidth(context),
//      color: ColorRes.blackTransparent,
      child: openCloseMap != null && openCloseMap.length > 0 ? pieChart(Utils.getText(context, StringRes.qStatus), 2) : Container(),
    );
  }

  pieChart(String title, int type) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        height: 25,
        width: 100,
        margin: EdgeInsets.only(left: 25, top: 10),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Utils.getAssetsImg("bg_piechart")), fit: BoxFit.fill)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: ColorRes.white, fontSize: 17),
          ),
        ),
      ),
      Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: PieChart(
              dataMap: type == 1 ? dataMap : openCloseMap,
//                  dataMap: type == 1 ? dataMap != null ? dataMap : Container()  : openCloseMap != null ? openCloseMap : Container(),
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width / 5,
              colorList: type == 1 ? colorList : colorOpenCloseList,
              // showChartValuesInPercentage: false,
              // showChartValues: false,
              // showChartValuesOutside: false,
              // chartValueBackgroundColor: Colors.white,
              // legendPosition: LegendPosition.right,
              // showChartValueLabel: false,
              // initialAngle: 0.0,
              // legendStyle: defaultLegendStyle.copyWith(color: Injector.isBusinessMode ? Colors.white : ColorRes.textProf),
              // chartValueStyle: defaultChartValueStyle.copyWith(color: ColorRes.white),
              // showLegends: type == 1 ? false : true,
              chartType: ChartType.disc,
            ),
          ),
          type == 1
              ? Container(
                  height: 125,
                  width: 100,
                  margin: secondScreen == true ? EdgeInsets.only(left: 30) : EdgeInsets.only(left: 00),
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 4,
                    children: List.generate(10, (index) {
                      return Row(
                        children: <Widget>[
                          Container(
                            height: 13,
                            width: 13,
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(color: colorList[index]),
                          ),
                          Container(
                            child: Text(
                              indexList[index],
                              style: TextStyle(color: Injector.isBusinessMode ? Colors.white : ColorRes.textProf, fontSize: 15),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                )
              : Container()
        ],
      )
    ]);
  }

  showTitleSecondScreen(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkResponse(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(Injector.isBusinessMode ? "back" : 'back_prof')),
              width: 30,
            ),
            onTap: () {
              Utils.playClickSound();
              if (mounted)
                setState(() {
                  selectedTeamUserId = -1;
                  secondScreen = false;
                });
            },
          ),
          Container(
            alignment: Alignment.center,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: Injector.isBusinessMode ? null : BorderRadius.circular(20),
                border: Injector.isBusinessMode ? null : Border.all(width: 1, color: ColorRes.white),
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

  Future getTeamUsers() async {
    if (Injector.introData != null && Injector.introData.team1 == 0) await DisplayDialogs.showIntroTeam1(context);

    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        CommonView.showCircularProgress(true, context);

        TeamUserRequest rq = TeamUserRequest();

        rq.userId = Injector.userId;

        WebApi().callAPI(WebApi.rqGetTeamUsers, rq.toJson()).then((data) async {
          CommonView.showCircularProgress(false, context);

          if (data != null) {
            print("data================");
            print(data);
            teamUserData = TeamUserData.fromJson(data);
            TeamUserData teamUserData1 = TeamUserData();

            await Future.forEach(teamUserData.users, (Users user) async {
              print("element");
              print(user.name);
              if (user.name.contains(" ")) {
                user.name = await EncryptionManager().stringDecryption(user.name.split(" ").first) +
                    " " +
                    await EncryptionManager().stringDecryption(user.name.split(" ").last);
              } else {
                user.name = await EncryptionManager().stringDecryption(user.name);
              }
            }).then((value) {
              setState(() {});
              print(teamUserData.users.map((e) => e.name).toList());
              initGraphData();
            });
          }
        }).catchError((e) {
          //CommonView.showCircularProgress(false, context);
        });
      }
    });
  }

  void initGraphData() {
    dataMap.clear();
    openCloseMap.clear();

    if (!secondScreen) {
      teamUserData?.qLevel?.forEach((element) {
        dataMap.putIfAbsent(element.level.toString(), () => element.questionCount.toDouble());
      });

      openCloseMap.putIfAbsent(Utils.getText(context, StringRes.strOpen), () => teamUserData.qStatus.open.toDouble());
      openCloseMap.putIfAbsent(Utils.getText(context, StringRes.close), () => teamUserData.qStatus.closed.toDouble());
    } else {
      teamUserByIdData?.qLevel?.forEach((element) {
        dataMap.putIfAbsent(element.level.toString(), () => element.questionCount.toDouble());
      });

      if (teamUserByIdData?.qStatus?.open?.toDouble() != null) {
        openCloseMap.putIfAbsent(Utils.getText(context, StringRes.strOpen), () => teamUserByIdData?.qStatus?.open?.toDouble());
      } else {
        openCloseMap.putIfAbsent(Utils.getText(context, StringRes.strOpen), () => 0.0);
      }

      if (teamUserByIdData?.qStatus?.closed?.toDouble() != null) {
        openCloseMap.putIfAbsent(Utils.getText(context, StringRes.close), () => teamUserByIdData?.qStatus?.closed?.toDouble());
      } else {
        openCloseMap.putIfAbsent(Utils.getText(context, StringRes.close), () => 0.0);
      }
    }
  }

  void getTeamUserById(int teamUserId) {
    Utils.isInternetConnected().then((isConnected) {
      CommonView.showCircularProgress(true, context);

      if (isConnected) {
        TeamUserByIdRequest rq = TeamUserByIdRequest();
        rq.userId = Injector.userId;
        rq.teamUserId = teamUserId;

        WebApi().callAPI(WebApi.rqGetTeamUserById, rq.toJson()).then((data) async {
          CommonView.showCircularProgress(false, context);

          if (data != null) {
            teamUserByIdData = TeamUserByIdData.fromJson(data);
            if (teamUserByIdData.name.contains(" ")) {
              teamUserByIdData.name = await EncryptionManager().stringDecryption(teamUserByIdData.name.split(" ").first) +
                  " " +
                  await EncryptionManager().stringDecryption(teamUserByIdData.name.split(" ").last);
            } else {
              teamUserByIdData.name = await EncryptionManager().stringDecryption(teamUserByIdData.name);
            }
            initGraphData();

            if (mounted) setState(() {});
          }
        }).catchError((e) {
          CommonView.showCircularProgress(false, context);
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(Utils.getText(context, StringRes.alertWantToBailOut)),
          actions: <Widget>[
            FlatButton(
              child: Text(Utils.getText(context, StringRes.yes)),
              onPressed: () {
                //alert pop
                Navigator.of(context).pop();

                performBailOut();
              },
            ),
            FlatButton(
              child: Text(Utils.getText(context, StringRes.no)),
              onPressed: () {
                //alert pop
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void performBailOut() {
    CommonView.showCircularProgress(true, context);
    BailOutRequest rq = BailOutRequest();
    rq.userId = Injector.userData.userId;
    rq.mode = Injector.mode;
    rq.teamUserId = selectedTeamUserId != -1 ? selectedTeamUserId : null;

    WebApi().callAPI(WebApi.rqBailOut, rq.toJson()).then((data) async {
      CommonView.showCircularProgress(false, context);
      if (data != null) {
        if (data is Map) {
          CustomerValueData customerValueData = CustomerValueData.fromJson(data);
          await customerValueBloc?.updateCustomerValue(customerValueData);
          navigationBloc.updateNavigation(HomeData(initialPageType: Const.typeTeam));
          setState(() {});
        } else if (data is String) {
          Utils.showToast(data.toString());
        }
      }
    }).catchError((e) {});
  }
}
