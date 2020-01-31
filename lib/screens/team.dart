import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
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

  bool secondScreen = false;

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

              secondScreen != true ?
              CommonView.showTitle(context, StringRes.team) :
              showTitleSecondScreen(context, StringRes.team),
              showMainBody()
            ],
          ),
        ),
      ],
    );
  }

/*  Row showTitle() {
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
  }*/

  showMainBody() {
    return Expanded(
        child: Row(
      children: <Widget>[showFirstHalf(), showSecondHalf()],
    ));
  }

  showFirstHalf() {
    return Expanded(
        flex: secondScreen != true ? 8 : 1,
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
          margin: secondScreen != true ? EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 10) : EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_grey_teamheader")),
                  fit: BoxFit.fill)),
//      color: ColorRes.white,
          padding: secondScreen != true ? EdgeInsets.only(left: 25, right: 15, top: 5, bottom: 5) : EdgeInsets.only(left: 13, right: 15, top: 5, bottom: 5) ,
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
            return showListData(index);
//        return ListTile(
//          title: Text("hello"),
//        );
          }),
    );
  }

  showListData(int index) {
    return InkResponse(
      child: Container(
          height: 30,
          padding: secondScreen != true ?  EdgeInsets.only(left: 30, right: 25, top: 5, bottom: 5) : EdgeInsets.only(left: 23, right: 0, top: 5, bottom: 5),
          margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Utils.getAssetsImg("bg_white_smalldata")),
                  fit: BoxFit.fill)),
          child: secondScreen != true ? Row (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[listTextData(), listTextData(), listTextData(), listTextData()],
          ) : Row (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[listTextData(), listTextData(), listTextData()],
          )
      ),
      onTap: () {
        setState(() {
          secondScreen = true;
        });
      },
    );
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
                  margin: EdgeInsets.only(left: 0, top: 8, bottom: 5, right: 5),
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
        flex: secondScreen != true ? 6 : 1,
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


  showTitleSecondScreen(BuildContext context, String title) {
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
              setState(() {
                secondScreen = false;
              });
//              Utils.performBack(context);
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
}
