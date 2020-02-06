import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:pie_chart/pie_chart.dart';

import '../commonview/background.dart';
import '../helper/Utils.dart';
import '../helper/string_res.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class PLPage extends StatefulWidget {
  @override
  _PLPageState createState() => _PLPageState();
}

class _PLPageState extends State<PLPage> {

  List<charts.Series<Pollution, String>> _seriesData;

  _generateData() {
    var data1 = [
      new Pollution(1980, 'USA', 30),
      new Pollution(1980, 'Asia', 40),
      new Pollution(1980, 'Europe', 10),
    ];
    var data2 = [
      new Pollution(1985, 'USA', 100),
      new Pollution(1980, 'Asia', 150),
      new Pollution(1985, 'Europe', 80),
    ];
    var data3 = [
      new Pollution(1985, 'USA', 200),
      new Pollution(1980, 'Asia', 300),
      new Pollution(1985, 'Europe', 180),
    ];

    var piedata = [
      new Task('Work', 35.8, Color(0xff3366cc)),
      new Task('Eat', 8.3, Color(0xff990099)),
      new Task('Commute', 10.8, Color(0xff109618)),
      new Task('TV', 15.6, Color(0xfffdbe19)),
      new Task('Sleep', 19.2, Color(0xffff9900)),
      new Task('Other', 10.3, Color(0xffdc3912)),
    ];

    var linesalesdata = [
      new Sales(0, 45),
      new Sales(1, 56),
      new Sales(2, 55),
      new Sales(3, 60),
      new Sales(4, 61),
      new Sales(5, 70),
    ];
    var linesalesdata1 = [
      new Sales(0, 35),
      new Sales(1, 46),
      new Sales(2, 45),
      new Sales(3, 50),
      new Sales(4, 51),
      new Sales(5, 60),
    ];

    var linesalesdata2 = [
      new Sales(0, 20),
      new Sales(1, 24),
      new Sales(2, 25),
      new Sales(3, 40),
      new Sales(4, 45),
      new Sales(5, 60),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

//    _seriesPieData.add(
//      charts.Series(
//        domainFn: (Task task, _) => task.task,
//        measureFn: (Task task, _) => task.taskvalue,
//        colorFn: (Task task, _) =>
//            charts.ColorUtil.fromDartColor(task.colorval),
//        id: 'Air Pollution',
//        data: piedata,
//        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
//      ),
//    );
//
//    _seriesLineData.add(
//      charts.Series(
//        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
//        id: 'Air Pollution',
//        data: linesalesdata,
//        domainFn: (Sales sales, _) => sales.yearval,
//        measureFn: (Sales sales, _) => sales.salesval,
//      ),
//    );
//    _seriesLineData.add(
//      charts.Series(
//        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
//        id: 'Air Pollution',
//        data: linesalesdata1,
//        domainFn: (Sales sales, _) => sales.yearval,
//        measureFn: (Sales sales, _) => sales.salesval,
//      ),
//    );
//    _seriesLineData.add(
//      charts.Series(
//        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
//        id: 'Air Pollution',
//        data: linesalesdata2,
//        domainFn: (Sales sales, _) => sales.yearval,
//        measureFn: (Sales sales, _) => sales.salesval,
//      ),
//    );
  }


  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];
  var arrTime = ['Day', 'Month', 'Year'];
  int selectedTime = 0;

  Map<String, double> dataMap = Map();
  Map<String, double> openCloseMap = Map();

  List<String> costSplitList = [
    'HR',
    'Markeing',
    'Sales',
    'Operations',
    'Legal',
    'Finaces',
    'CRM'
  ];

  List<String> revenueSplitList = [
    '<Name of Business Sector 1 >',
    '<Name of Business Sector 2 >',
    '<Name of Business Sector 3 >',
  ];

  List<Color> colorOpenCloseList = [
    ColorRes.firstColor,
    ColorRes.secondColor,
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
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataMap.putIfAbsent("1", () => 5);
    dataMap.putIfAbsent("2", () => 3);
    dataMap.putIfAbsent("3", () => 2);
    dataMap.putIfAbsent("4", () => 2);
    dataMap.putIfAbsent("5", () => 5);
    dataMap.putIfAbsent("6", () => 3);
    dataMap.putIfAbsent("7", () => 2);

    openCloseMap.putIfAbsent("Open", () => 5);
    openCloseMap.putIfAbsent("Close", () => 3);
    openCloseMap.putIfAbsent("Close1", () => 3);
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
              mainBody()
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
                    bottomBusinessList()
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
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorRes.white)
        ),
        width: Utils.getDeviceWidth(context),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Text("7 days developments"),
            ),
            Expanded(
              child: charts.BarChart(
                _seriesData,
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                //behaviors: [new charts.SeriesLegend()],
                animationDuration: Duration(milliseconds: 400),
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
                  bottomOption(),
                  bottomOption()
                ],
              ),
            )
          ],
        ));
  }

  bottomOption() {
    return  Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 15,
            color: Colors.amber,
          ),
          Container(
            child: Text("Cost"),
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
                  child: Text("Day", style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text("Month", style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text("Year", style: TextStyle(fontSize: 13)),
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
                  child: Text("Last Period", style: TextStyle(fontSize: 13)),
                ),
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg("bgPlPeriod")),
                          fit: BoxFit.fill)),
                  child: Text("This Period", style: TextStyle(fontSize: 13)),
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
            child:
                Text("Cash at start of Period", style: TextStyle(fontSize: 13)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text("195000", style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text("215000", style: TextStyle(fontSize: 13)),
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
      margin: EdgeInsets.only(left: 8, right: 10, bottom: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bgPlHeader")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Container(
            width: 125,
            padding: EdgeInsets.only(left: 6),
            child: Text(first, style: TextStyle(fontSize: 13)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text(second, style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text(third, style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text(second, style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text(third, style: TextStyle(fontSize: 13)),
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
      height: type == 1 ? 160 : 120,
      child: ListView.builder(
          itemCount: type == 1 ? 10 : 6,
//                        physics: NeverScrollableScrollPhysics(),
//                        shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              children: <Widget>[
                Container(
                  width: 125,
                  padding: EdgeInsets.only(left: 10),
                  child: Text(type == 1 ? "total cost" : "total Revenue",
                      style: TextStyle(fontSize: 13)),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Text(type == 1 ? "110" : "30",
                          style: TextStyle(fontSize: 13)),
                    ),
                    Container(
                      child: Text(type == 1 ? "30000" : "50000",
                          style: TextStyle(fontSize: 13)),
                    ),
                    Container(
                      child: Text(type == 1 ? "110" : "15",
                          style: TextStyle(fontSize: 13)),
                    ),
                    Container(
                      child: Text(type == 1 ? "30000" : "45000",
                          style: TextStyle(fontSize: 13)),
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
          Container(
            width: 180,
            padding: EdgeInsets.only(left: 10),
            child: Text("Other Revenue(e.g. achievements)",
                style: TextStyle(fontSize: 13)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text("5000", style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text("20", style: TextStyle(fontSize: 13)),
                ),
                Container(
                  child: Text("4000", style: TextStyle(fontSize: 13)),
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
            child: Text(type == 1 ? "Profit" : "Cash at end of period",
                style: TextStyle(fontSize: 13)),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Text("20,000", style: TextStyle(fontSize: 13)),
              ),
              Container(
                child: Text("15,000", style: TextStyle(fontSize: 13)),
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
      child: pieChart("Cost Split", 1),
    );
  }

  secondPieChart() {
    return Container(
      height: 180,
      padding: EdgeInsets.only(left: 0),
      child: pieChart("Revenue Split", 2),
    );
  }

  pieChart(String title, int type) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 25,
            width: 100,
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_piechart")),
                    fit: BoxFit.fill)),
            child: Center(
              child: Text(title),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
//                width: 150,
//            height: 150,
//              child: Expanded(
                child: Center(
                    child: PieChart(
                  dataMap: type == 1 ? dataMap : openCloseMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32.0,
                  chartRadius: MediaQuery.of(context).size.width / 5,
//                showChartValuesInPercentage: true,
                  showChartValues: false,
                  showChartValuesOutside: false,
                  chartValueBackgroundColor: Colors.transparent,
                  colorList: type == 1 ? colorList : colorOpenCloseList,
//                showLegends: true,
                  legendPosition: LegendPosition.right,
                  showChartValueLabel: false,
                  initialAngle: 0,
                  chartValueStyle: defaultChartValueStyle.copyWith(
//                    color: Colors.blueGrey[900].withOpacity(0.9),
                      color: type == 1 ? ColorRes.white : Colors.transparent),
                  showLegends: false,
//                      showLegends: type == 1 ? false : true,
                  chartType: ChartType.disc,
                )),
//              ),
              ),
//              type == 1
//                  ?
              Container(
//                      height: type == 1 ? 140 : 100,
                height: 140,
                width: 80,
//                      alignment: Alignment.center,
                margin: EdgeInsets.only(left: 00),
//                padding: EdgeInsets.only(top: 05),
                child: ListView.builder(
                    itemCount: type == 1
                        ? costSplitList.length
                        : revenueSplitList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          Container(
                            height: 13,
                            width: 13,
                            margin: EdgeInsets.only(right: 5, top: 5),
                            decoration: BoxDecoration(
                                color: type == 1
                                    ? colorList[index]
                                    : colorOpenCloseList[index]),
                          ),
                          Expanded(
                            child: Text(
                              type == 1
                                  ? costSplitList[index]
                                  : revenueSplitList[index],
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      );
                    }),
              )
//                  : Container()
            ],
          )
        ]);
  }

  bottomBusinessList() {
    return Expanded(
//                      height: 100,
      child: ListView.builder(
          itemCount: 6,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 15,
                  width: 15,
                  margin: EdgeInsets.only(left: 20, bottom: 10),
                  color: ColorRes.greyText,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 10),
                  child: Text("<Name of Business Sector>"),
                )
              ],
            );
          }),
    );
  }
}


class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}







