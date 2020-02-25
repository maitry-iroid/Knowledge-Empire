import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/performance.dart';
import 'package:ke_employee/screens/organization2.dart';
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

  PerformanceData performanceData ;

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

    getPerformanceData();
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
              performanceData!=null ? mainBody() : Container()
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
                    showListHeader("Cost", "Employees", "Salaries"),
                    showListView(1),
                    showListHeader("Revenue", "Customers", "Revenue"),
                    showListView(2),
                    showOtherRev(),
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
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorRes.white)),
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
        height: 300,
        padding: EdgeInsets.only(top: 10),
        margin: EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: ColorRes.white)),
        width: Utils.getDeviceWidth(context),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Text(
                "7 days developments",
                style: TextStyle(color: ColorRes.white),
              ),
            ),
            Expanded(
              child: OrdinalComboBarLineChart.withSampleData(performanceData),
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
              "Cost",
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
              "Revenue",
              style: TextStyle(color: ColorRes.white),
            ),
          ),
          Container(
            width: 50,
            height: 15,
            color: Colors.amber,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Cash",
              style: TextStyle(color: ColorRes.white),
            ),
          )
        ],
      ),
    );
  }

  selectTime(index) {
    if (selectedTime != index) {
      setState(() {
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text("Day",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Container(
                  child: Text("Month",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Container(
                  child: Text("Year",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg("bgPlPeriod")),
                          fit: BoxFit.fill)),
                  child: Text("Last Period",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg("bgPlPeriod")),
                          fit: BoxFit.fill)),
                  child: Text("This Period",
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
            child: Text("Cash at start of Period",
                style: TextStyle(fontSize: 13, color: ColorRes.white)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text("195000",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Container(
                  child: Text("215000",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
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
                          ? performanceData.cost[index].name
                          : performanceData.revenue[index].name,
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        type == Const.typeCost
                            ? performanceData.cost[index].lastEmployee
                                .toString()
                            : performanceData.revenue[index].lastTotalCustomer
                                .toString(),
                        style: TextStyle(fontSize: 13, color: ColorRes.white),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          type == Const.typeCost
                              ? performanceData.cost[index].lastCost.toString()
                              : performanceData.revenue[index].lastRevenue
                                  .toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: ColorRes.white,
                          ),
                          textAlign: TextAlign.right),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          type == Const.typeCost
                              ? performanceData.cost[index].currentEmployee
                                  .toString()
                              : performanceData
                                  .revenue[index].currentTotalCustomer
                                  .toString(),
                          style: TextStyle(fontSize: 13, color: ColorRes.white),
                          textAlign: TextAlign.right),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                          type == Const.typeCost
                              ? performanceData.cost[index].currentCost
                                  .toString()
                              : performanceData.revenue[index].currentRevenue
                                  .toString(),
                          style: TextStyle(fontSize: 13, color: ColorRes.white),
                          textAlign: TextAlign.right),
                    )
                  ],
                ))
              ],
            );
          }),
    );
  }

  showOtherRev() {
    return Container(
      height: 30,
      child: Row(
        children: <Widget>[
//          Container(
//            width: 180,
//            padding: EdgeInsets.only(left: 10),
//            child: Text("Other Revenue(e.g. achievements)",
//                style: TextStyle(fontSize: 13, color: ColorRes.white)),
//          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text("5000",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Container(
                  child: Text("20",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
                Container(
                  child: Text("4000",
                      style: TextStyle(fontSize: 13, color: ColorRes.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showProfitCash(int type) {
    return Container(
      height: 25,
      margin: EdgeInsets.only(left: 8, right: 10, bottom: 5, top: 5),
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
                type == Const.typeCost ? "Profit" : "Cash at end of period",
                style: TextStyle(fontSize: 13, color: ColorRes.white)),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Text("20,000",
                    style: TextStyle(fontSize: 13, color: ColorRes.white)),
              ),
              Container(
                child: Text("15,000",
                    style: TextStyle(fontSize: 13, color: ColorRes.white)),
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
      child: pieChart("Cost Split", Const.typeCost),
    );
  }

  secondPieChart() {
    return Container(
      height: 180,
      padding: EdgeInsets.only(left: 0),
      child: pieChart("Revenue Split", Const.typeRevenue),
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
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("bg_piechart")),
                fit: BoxFit.fill)),
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
            Container(
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
            Container(
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
                                : performanceData.revenue[index].name,
                            style:
                                TextStyle(fontSize: 12, color: ColorRes.white),
                          ),
                        )
                      ],
                    );
                  }),
            )
//                  : Container()
          ],
        ),
      )
    ]);
  }

  bottomBusinessList() {
    return Expanded(
      child: ListView.builder(
          itemCount: 6,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              children: <Widget>[
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.only(left: 20, bottom: 10),
                  color: ColorRes.greyText,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    "<Name of Business Sector>",
                    style: TextStyle(color: ColorRes.white),
                  ),
                )
              ],
            );
          }),
    );
  }

  int selectedType = 1;

  void getPerformanceData() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
        CommonView.showCircularProgress(true, context);



        PerformanceRequest rq = PerformanceRequest();
        rq.userId = Injector.userId;
        rq.mode = Injector.mode ?? Const.businessMode;
        rq.type = selectedType;

        WebApi().callAPI(WebApi.rqGetPerformance, rq.toJson()).then((data) {
          if (data != null) {
            CommonView.showCircularProgress(false, context);
            setState(() {
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
}
