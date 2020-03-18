import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/performance.dart';
import 'package:pie_chart/pie_chart.dart';

import '../commonview/background.dart';
import '../helper/Utils.dart';
import '../helper/string_res.dart';

import 'graph.dart';

class PLPage extends StatefulWidget {
  @override
  _PLPageState createState() => _PLPageState();
}

class _PLPageState extends State<PLPage> {
  var arrTime = ['Day', 'Month', 'Year'];
  int selectedTime = 0;

  Map<String, double> dataMap = Map();
  Map<String, double> openCloseMap = Map();

  PerformanceData performanceData;

  int selectedDay = 0;

  List<Color> colorOpenCloseList = [
    ColorRes.firstColor,
    ColorRes.secondColor,
    ColorRes.thirdColor,
    ColorRes.thirdColor,
    ColorRes.thirdColor,
    ColorRes.thirdColor,
    ColorRes.thirdColor,
  ];

  List<Color> colorList = [
    ColorRes.crmColor,
    ColorRes.financeColor,
    ColorRes.legalColor,
    ColorRes.operationColor,
    ColorRes.salesColor,
    ColorRes.marketingColor,
    ColorRes.hrColor,
    ColorRes.hrColor,
    ColorRes.hrColor,
  ];

  @override
  void initState() {
    super.initState();
    openIntroDialog();
  }

  Future openIntroDialog() async {

      await Future.delayed(Duration(milliseconds: 50));
      if (Injector.prefs.getBool(Const.introThePersonYouCanCountOn.toString()) != null && Injector.prefs.getBool(Const.introThePersonYouCanCountOn.toString())) {
      } else {
        await DisplayDialogs.showThePersonYouCanCountOn(context);
      }
    getPerformanceData(Const.plDay);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Padding(
          padding: EdgeInsets.only(top: Utils.getHeaderHeight(context)),
          child: Column(
            children: <Widget>[
              CommonView.showTitle(context, StringRes.pl),
              performanceData != null ? mainBody() : Container()
//             Expanded(
//               child:  Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       physics: ClampingScrollPhysics(),
//                       itemCount: arrTime.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return TimeItem(
//                           selectTime,
//                           index: index,
//                           isSelected: selectedTime == index ? true : false,
//                           title: arrTime[index],
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             )
            ],
          ),
        ),
      ],
    );
  }

  mainBody() {
//    return Expanded(
//        child: ListView(
//          children: <Widget>[
//            Expanded(child: Text("hello")),
//            Container(
//              height: 300,
//              child: Text("hello"),
//            )
//          ],
//        ));
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[showFirstHalf(), showSecondHalf()],
      ),
    ));
  }

  showFirstHalf() {
    return Container(
        height: 500,
        width: Utils.getDeviceWidth(context),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    showDayLine(),
                    showCashLine(),
                    showListHeader(
                        Utils.getText(context, StringRes.cost),
                        Utils.getText(context, StringRes.employees),
                        Utils.getText(context, StringRes.salaries)),
                    showListView(1),
                    showListHeader(
                        Utils.getText(context, StringRes.revenue),
                        Utils.getText(context, StringRes.customers),
                        Utils.getText(context, StringRes.revenue)),
                    showListView(2),
                    showProfitCash(1),
                    showProfitCash(2),
//                  showCashEnd(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: 500,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorRes.white),
                  borderRadius: BorderRadius.circular(12.0),
                  color:
                      Injector.isBusinessMode ? Colors.black45 : ColorRes.white,
                ),
                child: Column(
                  children: <Widget>[
                    firstPieChart(),
                    secondPieChart(),
//                    bottomBusinessList()
                  ],
                ),
              ),
            )
          ],
        ));
  }

  showSecondHalf() {
    return Container(
        height: 310,
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorRes.white),
          borderRadius: BorderRadius.circular(12.0),
          color: Injector.isBusinessMode ? Colors.black45 : ColorRes.white,
        ),
        width: Utils.getDeviceWidth(context),

        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              width: Utils.getDeviceWidth(context) / 4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2, color: ColorRes.white),
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg("bgPlHeader")),
                      fit: BoxFit.fill)),
              child: Text(
                Utils.getText(context, StringRes.sevenDaysDevelopment),
                style: TextStyle(color: ColorRes.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: OrdinalComboBarLineChart.withSampleData(performanceData),
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  bottomOption(),
                ],
              ),
            )
          ],
        ));
  }

  bottomOption() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 15,
            color: Colors.amber,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              Utils.getText(context, StringRes.cost),
              style: TextStyle(color: ColorRes.white),
            ),
          ),
          Container(
            width: 50,
            height: 15,
            color: Colors.green,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              Utils.getText(context, StringRes.revenue),
              style: TextStyle(color: ColorRes.white),
            ),
          ),
          Image.asset(
            Utils.getAssetsImg("cash_graph"),
            height: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              Utils.getText(context, StringRes.cash),
              style: TextStyle(color: ColorRes.white),
            ),
          )
        ],
      ),
    );
  }

  selectTime(index) {
    if (selectedTime != index) {
      if (mounted)setState(() {
        selectedTime = index;
      });
    }
  }

  showDayLine() {
    return Container(
      height: 30,
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) {
                return Expanded(
                  child: InkResponse(
                    child: Container(
//                    width: Utils.getDeviceWidth(context) / 14,
                      margin: Injector.isBusinessMode
                          ? EdgeInsets.symmetric(vertical: 2, horizontal: 5)
                          : EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                      padding: Injector.isBusinessMode
                          ? EdgeInsets.symmetric(vertical: 0, horizontal: 0)
                          : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          /*     color: Injector.isBusinessMode ? Colors.transparent : selectedDay == index ? ColorRes.titleBlueProf : ColorRes.rankingBackGround,
                         borderRadius: BorderRadius.all(Radius.circular(Injector.isBusinessMode ? 0 : 5)),*/
                          image: DecorationImage(
                              image: AssetImage(Utils.getAssetsImg(
                                  selectedDay == index
                                      ? "ranking_bg_time_selected"
                                      : "ranking_bg_time_deselected")),
                              fit: BoxFit.fill)),
                      child: Text(Utils.getText(context, arrTime[index]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              color: selectedDay == index
                                  ? ColorRes.white
                                  : ColorRes.rankingProBg)),
                    ),
                    onTap: () {
                      if (index == 0) {
                        selectedDay = 0;
                        getPerformanceData(Const.plDay);
                        print(0);
                      } else if (index == 1) {
                        selectedDay = 1;
                        getPerformanceData(Const.plMonth);

                        print(1);
                      } else if (index == 2) {
                        selectedDay = 2;
                        getPerformanceData(Const.plYear);
                      }

                      if (mounted)setState(() {});
                    },
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 7, right: 7),
                  decoration: BoxDecoration(
                      color:
                          Injector.isBusinessMode ? null : ColorRes.borderColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Injector.isBusinessMode ? 0 : 3)),
                      image: Injector.isBusinessMode
                          ? DecorationImage(
                              image:
                                  AssetImage(Utils.getAssetsImg("bgPlPeriod")),
                              fit: BoxFit.fill)
                          : null),
                  child: Text(Utils.getText(context, StringRes.lastPeriod),
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 7, right: 7),
                  decoration: BoxDecoration(
                      color:
                          Injector.isBusinessMode ? null : ColorRes.borderColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Injector.isBusinessMode ? 0 : 3)),
                      image: Injector.isBusinessMode
                          ? DecorationImage(
                              image:
                                  AssetImage(Utils.getAssetsImg("bgPlPeriod")),
                              fit: BoxFit.fill)
                          : null),
                  child: Text(Utils.getText(context, StringRes.thisPeriod),
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  showCashLine() {
    return Container(
      height: 30,
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            padding: EdgeInsets.only(left: 10),
            child: Text(Utils.getText(context, StringRes.cashAtStartOfPeriod),
                style: TextStyle(
                    fontSize: 13,
                    color: Injector.isBusinessMode
                        ? ColorRes.white
                        : ColorRes.textProf)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text(
                      getValidText(performanceData.cash.oneDayPreviousCash),
                      style: TextStyle(
                          fontSize: 13,
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.textProf)),
                ),
                Container(
                  child: Text(getValidText(performanceData.cash.previousCash),
                      style: TextStyle(
                          fontSize: 13,
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.textProf)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  showListHeader(String first, String second, String third) {
    return Container(
      height: 25,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bgPlHeader")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Container(
            width: 125,
            padding: EdgeInsets.only(left: 6),
            child: Text(first,
                style: TextStyle(fontSize: 13, color: ColorRes.white)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    second,
                    style: TextStyle(fontSize: 13, color: ColorRes.white),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    third,
                    style: TextStyle(fontSize: 13, color: ColorRes.white),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    second,
                    style: TextStyle(fontSize: 13, color: ColorRes.white),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    third,
                    style: TextStyle(fontSize: 13, color: ColorRes.white),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showListView(int type) {
    return Container(
      height: type == Const.typeCost ? 160 : 120,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: type == Const.typeCost
              ? performanceData?.cost?.length
              : performanceData?.revenue?.length,
//                        physics: NeverScrollableScrollPhysics(),
//                        shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              children: <Widget>[
                Container(
                  width: 125,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                      type == Const.typeCost
                          ? getValidText(performanceData.cost[index].name)
                          : getValidText(performanceData.revenue[index].name),
                      style: TextStyle(
                          fontSize: 13,
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.textProf)),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        type == Const.typeCost
                            ? getValidText(
                                performanceData.cost[index].lastEmployee)
                            : getValidText(performanceData
                                .revenue[index].lastTotalCustomer),
                        style: TextStyle(
                            fontSize: 13,
                            color: Injector.isBusinessMode
                                ? ColorRes.white
                                : ColorRes.textProf),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          type == Const.typeCost
                              ? getValidText(
                                  performanceData.cost[index].lastCost)
                              : getValidText(
                                  performanceData.revenue[index].lastRevenue),
                          style: TextStyle(
                            fontSize: 13,
                            color: Injector.isBusinessMode
                                ? ColorRes.white
                                : ColorRes.textProf,
                          ),
                          textAlign: TextAlign.right),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          type == Const.typeCost
                              ? getValidText(
                                  performanceData.cost[index].currentEmployee)
                              : getValidText(performanceData
                                  .revenue[index].currentTotalCustomer),
                          style: TextStyle(
                              fontSize: 13,
                              color: Injector.isBusinessMode
                                  ? ColorRes.white
                                  : ColorRes.textProf),
                          textAlign: TextAlign.right),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          type == Const.typeCost
                              ? getValidText(
                                  performanceData.cost[index].currentCost)
                              : getValidText(performanceData
                                  .revenue[index].currentRevenue),
                          style: TextStyle(
                              fontSize: 13,
                              color: Injector.isBusinessMode
                                  ? ColorRes.white
                                  : ColorRes.textProf),
                          textAlign: TextAlign.right),
                    )
                  ],
                ))
              ],
            );
          }),
    );
  }

  showProfitCash(int type) {
    return Container(
      height: 25,
      margin: EdgeInsets.only(left: 8, right: 0, bottom: 5, top: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bgPlHeader")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Container(
            width: 160,
            padding: EdgeInsets.only(left: 10),
            child: Text(
              Utils.getText(
                  context,
                  type == Const.typeCost
                      ? StringRes.profit
                      : StringRes.cashAtTheEndOfPeriod),
              style: TextStyle(
                fontSize: 13,
                color: ColorRes.white,
              ),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                      getValidText(type == 1
                          ? getLastProfit()
                          : performanceData.cash.previousCash),
                      style: TextStyle(fontSize: 13, color: ColorRes.white),
                      textAlign: TextAlign.right),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                      getValidText(type == 1
                          ? getCurrentProfit()
                          : performanceData.cash.todayCash),
                      style: TextStyle(fontSize: 13, color: ColorRes.white),
                      textAlign: TextAlign.right),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  firstPieChart() {
    return Container(
      height: 180,
      padding: EdgeInsets.only(left: 5),
      child:
          pieChart(Utils.getText(context, StringRes.costSplit), Const.typeCost),
    );
  }

  secondPieChart() {
    return Container(
      height: 180,
      padding: EdgeInsets.only(left: 0),
      child: pieChart(
          Utils.getText(context, StringRes.revenue), Const.typeRevenue),
    );
  }

  pieChart(String title, int type) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
        height: 25,
        width: 100,
        margin: EdgeInsets.only(left: 20, top: 10),
        decoration: BoxDecoration(
            color: Injector.isBusinessMode ? null : ColorRes.borderColor,
            borderRadius: BorderRadius.all(
                Radius.circular(Injector.isBusinessMode ? 0 : 5)),
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_piechart")),
                    fit: BoxFit.fill)
                : null),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: ColorRes.white),
          ),
        ),
      ),
      Expanded(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                    child: (type == Const.typeCost ? dataMap : openCloseMap) !=
                            null
                        ? PieChart(
                            dataMap:
                                type == Const.typeCost ? dataMap : openCloseMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32.0,
                            chartRadius: MediaQuery.of(context).size.width / 5,
                            showChartValues: false,
                            showChartValuesOutside: false,
                            chartValueBackgroundColor: Colors.transparent,
                            colorList: type == Const.typeCost
                                ? colorList
                                : colorOpenCloseList,
                            legendPosition: LegendPosition.right,
                            showChartValueLabel: false,
                            initialAngle: 0,
                            chartValueStyle: defaultChartValueStyle.copyWith(
                                color: type == Const.typeCost
                                    ? ColorRes.white
                                    : Colors.transparent),
                            showLegends: false,
                            chartType: ChartType.disc,
                          )
                        : Container()),
              ),
            ),
            Expanded(
              child: Container(
                height: 140,
                width: 80,
                margin: EdgeInsets.only(left: 00),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: type == Const.typeCost
                        ? performanceData?.cost?.length
                        : performanceData?.revenue?.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          Container(
                            height: 13,
                            width: 13,
                            margin: EdgeInsets.only(right: 5, top: 5),
                            decoration: BoxDecoration(
                                color: type == Const.typeCost
                                    ? colorList[index]
                                    : colorOpenCloseList[index]),
                          ),
                          Expanded(
                            child: Text(
                              type == Const.typeCost
                                  ? performanceData.cost[index].name
                                  : performanceData.revenue[index].name ?? "",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Injector.isBusinessMode
                                      ? ColorRes.white
                                      : ColorRes.textProf),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            )
//                  : Container()
          ],
        ),
      )
    ]);
  }

//  int selectedType = 1;

  Future getPerformanceData(int plDay) async {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        CommonView.showCircularProgress(true, context);

        PerformanceRequest rq = PerformanceRequest();
        rq.userId = Injector.userId;
        rq.mode = Injector.mode ?? Const.businessMode;
        rq.type = plDay;

        WebApi().callAPI(WebApi.rqGetPerformance, rq.toJson()).then((data) {
          if (data != null) {
            CommonView.showCircularProgress(false, context);
            if (mounted)setState(() {
              performanceData = PerformanceData.fromJson(data);

              performanceData.cost.forEach((cost) {
                dataMap.putIfAbsent(
                    cost.name, () => cost.currentCost.toDouble());
              });

              performanceData.revenue.forEach((revenue) {
                openCloseMap.putIfAbsent(
                    revenue.name, () => revenue.currentRevenue.toDouble());
              });
            });
          }
        }).catchError((e) {
          Utils.showToast(e.toString());
          CommonView.showCircularProgress(false, context);
        });
      }
    });
  }

  getValidText(dynamic text) {
    return (text ?? "").toString();
  }

  getLastProfit() {
    var totalCost = 0;
    var totalProfit = 0;

    performanceData.cost.forEach((cost) {
      totalCost += cost.lastCost ?? 0;
    });

    performanceData.revenue.forEach((cost) {
      totalCost += cost.lastRevenue ?? 0;
    });

    return (totalCost - totalProfit).abs().toString();
  }

  getCurrentProfit() {
    var totalCost = 0;
    var totalProfit = 0;

    performanceData.cost.forEach((cost) {
      totalCost += cost.currentCost ?? 0;
    });

    performanceData.revenue.forEach((cost) {
      totalCost += cost.currentRevenue ?? 0;
    });

    return (totalCost - totalProfit).abs().toString();
  }
}
