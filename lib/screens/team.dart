import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:pie_chart/pie_chart.dart';

import '../helper/Utils.dart';
import '../helper/res.dart';
import '../helper/string_res.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  var arrSector = ["Healthcare", "Industrials", "Technology", "Financials"];

  bool secondScreen = true;

  List<String> indexList = ['1','2','3,','4','5','6','7','8','9','10'];

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
              CommonView.showTitle(context, StringRes.team),
              showMainBody()
            ],
          ),
        ),
      ],
    );
  }

  Row showTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkResponse(
          child: Image(
            image: AssetImage(Utils.getAssetsImg("back")),
            width: 35,
          ),
          onTap: () {
            Utils.playClickSound();
            Utils.performBack(context);
          },
        ),
        Container(
          alignment: Alignment.center,
          height: 35,
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_blue")),
                  fit: BoxFit.fill)),
          child: Text(
            Utils.getText(context, StringRes.team),
            style: TextStyle(color: ColorRes.colorPrimary, fontSize: 17),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  showMainBody() {
    return Expanded(
        child: Row(
      children: <Widget>[showFirstHalf(), showSecondHalf()],
    ));
  }

  showFirstHalf() {
    return Expanded(
        flex: 8,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            showProfile(),
            showListHeader(),
          ],
        )));
  }

  showProfile() {
    return Visibility(child: Container(
//        height: 200,
        margin: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 10),
        child: Column(
          children: <Widget>[
            firstColumn(),
            secondColumn(),
            thirdColumn(),
          ],
        )),
      visible: secondScreen,
    );
  }

  showListHeader() {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_grey_teamheader")),
                  fit: BoxFit.fill)),
//      color: ColorRes.white,
          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          child:
          secondScreen != true ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              listHeaderText(StringRes.name),
              listHeaderText(StringRes.lastLog),
              listHeaderText(StringRes.points),
              listHeaderText(StringRes.correct),
            ],
          ) : Row (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              listHeaderText(StringRes.learningModule),
              listHeaderText(StringRes.levels),
              listHeaderText(StringRes.complete),
            ],
          )
        ),
        showListView()
      ],
    );
  }

  showListView() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      child: ListView.builder(
          itemCount: 30,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return showListData();
//        return ListTile(
//          title: Text("hello"),
//        );
          }),
    );
  }

  showListData() {
    return Container(
        height: 30,
        padding: EdgeInsets.only(left: 65, right: 35, top: 5, bottom: 5),
        margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("bg_white_smalldata")),
                fit: BoxFit.fill)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[listTextData(), listTextData(), listTextData()],
        ));
  }

  profileBorderShow() {
    return BoxDecoration(
        border: Border.all(width: 1, color: ColorRes.white),
        borderRadius: BorderRadius.all(Radius.circular(20)));
  }

  listHeaderText(String title) {
    return Container(
      child: Text(title),
    );
  }

  listTextData() {
    return Container(
      child: Text(
        "helll",
        textAlign: TextAlign.right,
        style: TextStyle(color: ColorRes.textRecordBlue),
      ),
    );
  }

  showProfileText(String title) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5),
      child: Text(title),
    );
  }

  firstColumn() {
    return Container(
      child: Row(
        children: <Widget>[
          showProfileText("Name:"),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 25,
                  width: 110,
                  margin: EdgeInsets.only(left: 50, top: 8, bottom: 5),
                  decoration: profileBorderShow(),
                  child: Center(
                    child: Text("eric androld"),
                  ),
                ),
                Container(
                  height: 25,
                  width: 70,
                  margin: EdgeInsets.only(left: 0, top: 8, bottom: 5),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg("bg_change_pw")),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: Text(StringRes.bailout),
                  ),
                ),
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
          showProfileText("Department:"),
          Container(
            height: 25,
            width: 150,
//                    padding: EdgeInsets.only(left: 15, top: 8),
            margin: EdgeInsets.only(left: 10, top: 8, bottom: 5),
            decoration: profileBorderShow(),
            child: Center(
              child: Text("sales department"),
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
          showProfileText("Resets:"),
          Container(
            height: 25,
            width: 60,
//                    padding: EdgeInsets.only(left: 57, top: 8),
            margin: EdgeInsets.only(left: 40, top: 8, bottom: 5),
            decoration: profileBorderShow(),
            child: Center(
              child: Text("5"),
            ),
          ),
        ],
      ),
    );
  }

  //second half

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

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("1", () => 5);
    dataMap.putIfAbsent("2", () => 3);
    dataMap.putIfAbsent("3", () => 2);
    dataMap.putIfAbsent("4", () => 2);
    dataMap.putIfAbsent("5", () => 5);
    dataMap.putIfAbsent("6", () => 3);
    dataMap.putIfAbsent("7", () => 2);
    dataMap.putIfAbsent("8", () => 2);
    dataMap.putIfAbsent("9", () => 2);
    dataMap.putIfAbsent("10", () => 2);

    openCloseMap.putIfAbsent("Open", () => 5);
    openCloseMap.putIfAbsent("Close", () => 3);
  }

  Map<String, double> openCloseMap = Map();
  List<Color> colorOpenCloseList = [
    ColorRes.chartOpen,
    ColorRes.chartClose,
  ];

  showSecondHalf() {
    return Expanded(
        flex: 6,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            qLevel(),
//            pieChart("Q Level",1),
            qStatus(),
//            pieChart("Q Status",2),
          ],
        )));
  }

  qLevel() {
    return Container(
        height: 200,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 0),
        child: pieChart(StringRes.qLevel, 1));
  }

  qStatus() {
    return Container(
      height: 200,
      width: Utils.getDeviceWidth(context),
//      color: ColorRes.blackTransparent,
      child: pieChart(StringRes.qStatus, 2),
    );
  }

  pieChart(String title, int type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 25,
          width: 100,
          margin: EdgeInsets.only(left: 25, top: 10),
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
                showLegends: type == 1 ? false : true,
                chartType: ChartType.disc,
              )),
//              ),
            ),



            type == 1 ?
            Container(
              height: 125,
              width: 150,
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                scrollDirection: Axis.horizontal,
                crossAxisCount: 4,
                // Generate 100 Widgets that display their index in the List
                children: List.generate(10, (index) {
                  return Row(
                    children: <Widget>[
                      Container(
                        height: 13,
                        width: 13,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: colorList[index]
                        ),
                      ),
                      Container(
                        child: Text(indexList[index]),
                      )
                    ],
                  );
                }),
              ),
            ) : Container()


            /* Container(
                width: 150,
                child: GridView.count(crossAxisCount: 4,
                  children: List.generate(10, (index) {
                    return Center(
                      child: Text("hello"),
                    );
                  }),
                )
              /*Column(
                      children: <Widget>[
                        firstColumnColor(),
                        firstColumnColor(),
                        secondColumnColor(),
                        secondColumnColor()
                      ],
                    ),
                  )*/
//                : Container()
//          ],
            ) */
      ],)]
    );
  }


  firstColumnColor() {
    return Row(
      children: <Widget>[rightSideData(), rightSideData(), rightSideData()],
    );
  }

  secondColumnColor() {
    return Row(
      children: <Widget>[rightSideData(), rightSideData()],
    );
  }

  rightSideData() {
    return Container(
      padding: EdgeInsets.all(4),
      child: indexColor(),
    );
  }

  indexColor() {
    return Row(
      children: <Widget>[
        Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(color: ColorRes.chartSix),
        ),
        Container(
          height: 15,
          width: 30,
          padding: EdgeInsets.only(left: 7),
          child: Text("10"),
        )
      ],
    );
  }

/*
  Container showSubHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Utils.getAssetsImg("bg_rounded")),
              fit: BoxFit.fill)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              'Sector',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Size',
              style: TextStyle(color: ColorRes.colorPrimary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Container(
            height: 32,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage(Utils.getAssetsImg("bg_new_customer_item")),
                    fit: BoxFit.fill)),
            child: Text(
              arrSector[index],
              style: TextStyle(color: ColorRes.blue, fontSize: 15),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 35,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 5, right: 10),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("value")),
                    fit: BoxFit.fill)),
            child: Text(
              '10',
              style: TextStyle(color: ColorRes.white, fontSize: 22),
            ),
          ),
        ),
      ],
    );
  }

  showFirstHalf() {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          showTitle(),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
//            color: ColorRes.lightBg,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  child: TextField(
                    textAlign: TextAlign.center,
//                      controller: searchCtrl,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
//                        hintText: 'Search for keywords',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: ColorRes.colorPrimary,
                    ),
                  ),
                )),
                SizedBox(
                  width: 5,
                ),
                Image(
                  height: 35,
                  image: AssetImage(
                    Utils.getAssetsImg("search"),
                  ),
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
          showSubHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return showItem(index);
              },
            ),
          )
        ],
      ),
    );
  }

  showSecondHalf() {
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      color: ColorRes.whiteDarkBg,
                      margin: EdgeInsets.only(
                          top: 20, bottom: Utils.getDeviceHeight(context) / 7),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 10),
                        decoration: BoxDecoration(
                          color: ColorRes.bgDescription,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: ColorRes.colorPrimary, width: 1),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            "qwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar riddhi govindbhaoqwywer shankar ",
                            style: TextStyle(color: ColorRes.colorPrimary),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        margin: EdgeInsets.symmetric(
                            horizontal: Utils.getDeviceWidth(context) / 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage(Utils.getAssetsImg("bg_blue")),
                                fit: BoxFit.fill)),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              color: ColorRes.colorPrimary, fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: InkResponse(
                        child: Image(
                          image:
                              AssetImage(Utils.getAssetsImg("engage_segment")),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
}
