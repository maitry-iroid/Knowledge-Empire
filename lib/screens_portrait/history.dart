import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/manager/theme_manager.dart';

class HistoryPortrait extends StatefulWidget {
  @override
  _HistoryPortraitState createState() => _HistoryPortraitState();
}

class _HistoryPortraitState extends State<HistoryPortrait> {
  final List<int> _listData = List<int>.generate(100, (i) => i);
  final List<Map<String, dynamic>> historyDataList = [
    {"dateTime" : "Sat, 25th April", "data" : ["",""]},
    {"dateTime" : "Sun, 26th April", "data" : ["","",""]},
    {"dateTime" : "Mon, 27th April", "data" : ["",""]},
    {"dateTime" : "Tue, 28th April", "data" : ["","",""]},
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: AppBar(
            elevation: 0,
            title: Text("All challenges", style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 17)),
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 24, color: ThemeManager().getTextColor()), onPressed: (){Navigator.of(context).pop();}),
          )),
      body: Container(
        color: ThemeManager().getStaticGradientColor(),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                showWinningPointsAndScore(),
                showHistoryData()
              ],
            ),
//            this.customDropdown(),
          ],
        ),
      ),
    );
  }

  showWinningPointsAndScore() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: Utils.getDeviceWidth(context) * 0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showWinningPoints(),
          showScore()
        ],
      ),
    );
  }

  showWinningPoints() {
    return Column(
      children: [
        Text("+1.6k", style: TextStyle(
            color: ThemeManager().getDarkColor(),
            fontSize: 20,
            fontWeight: FontWeight.bold
        )),
        Text("Winning(kpt)", style: TextStyle(
            color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()),
            fontSize: 12,
            fontWeight: FontWeight.normal
        )),
      ],
    );
  }

  showScore() {
    return Column(
      children: [
        Row(
          children: [
            Text("43-", style: TextStyle(
                color: ThemeManager().getDarkColor(),
                fontSize: 20,
                fontWeight: FontWeight.bold
            )),
            Text("21", style: TextStyle(
                color: ThemeManager().getBadgeColor(),
                fontSize: 20,
                fontWeight: FontWeight.bold
            )),
          ],
        ),
        Text("Score", style: TextStyle(
            color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()),
            fontSize: 12,
            fontWeight: FontWeight.normal
        )),
      ],
    );
  }

  showHistoryData() {
    return Expanded(
        child: Container(
          color: ThemeManager().getBgGradientLight(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 1),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("History", style: TextStyle(
                            color: ThemeManager().getDarkColor(),
                            fontSize: 15,
                            fontWeight: FontWeight.normal
                        )),
                        Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              itemCount: this.historyDataList.length,
                              itemBuilder: (context, index){
                                List<String> dataList = this.historyDataList[index]["data"];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    showHeaderTitle(this.historyDataList[index]["dateTime"]),
                                    ...dataList.map((e) => showHistoryItem()).toList(),
                                    SizedBox(height: 5),
                                    index == 3 ? Container() : Divider(height: 1),
                                    index == 3 ? Container() : SizedBox(height: 10)
                                  ],
                                );
                              }
                            ))
                      ],
                    ),))
            ],
          ),
        )
    );
  }

  Widget showHeaderTitle(String date){
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Text(date,
          style: TextStyle(
            fontSize: 12.0,
            color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()),
          )),
    );
  }

  Widget showHistoryItem() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5)
                  ),
                  child : Image.asset(Utils.getAssetsImg("book"), height: Utils.getDeviceHeight(context) * 0.11)
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Introduction to Finance", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 15)),
                      Text("+750 kpt", style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()), fontSize: 13))
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

}
