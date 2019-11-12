import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBgDark,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[showFirstColumn(), showSecondColumn()],
      ),
    );
  }

  showFirstColumn() {
    var arrProfit = ['Day', 'Month'];

//    return Container(
//      height: 50,
//      child: ListView.builder(
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        itemCount: arrProfit.length,
//        itemBuilder: (BuildContext context, int index) {
//          return OptionItem(
//            selectOption, // callback function, setstate for parent
//            index: index,
//            isSelected: _selectedOption == index ? true : false,
//            title: arrProfit[index],
//          );
//        },
//      ),
//    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: InkResponse(
            child: Image(
                image: AssetImage(Utils.getAssetsImg('ranking_profit')),
                width: 80),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkResponse(
            child: Image(
                image: AssetImage(Utils.getAssetsImg('ranking_profit')),
                width: 80),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkResponse(
            child: Image(
                image: AssetImage(Utils.getAssetsImg('ranking_profit')),
                width: 80),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkResponse(
            child: Image(
                image: AssetImage(Utils.getAssetsImg('ranking_profit')),
                width: 80),
          ),
        )
      ],
    );
  }

  int _selectedItem = 0;
  int _selectedTime = 0;
  int _selectedOption = 0;

  showSecondColumn() {
    var arr = ['World', 'Country', 'Friends', 'Group A', 'Group B'];
    var arrTime = ['Day', 'Month', 'Year'];

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: arr.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomItem(
                        selectItem, // callback function, setstate for parent
                        index: index,
                        isSelected: _selectedItem == index ? true : false,
                        title: arr[index],
                      );
                    },
                  ),
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: arrTime.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TimeItem(
                        selectTime, // callback function, setstate for parent
                        index: index,
                        isSelected: _selectedTime == index ? true : false,
                        title: arrTime[index],
                      );
                    },
                  ),
                ],
              )),
          Container(
            height: 60,
            child: Row(
              children: <Widget>[
                Container(
                  width: 45,
                  height: 45,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg("bg_you")),
                          fit: BoxFit.fill)),
                  child: Text(
                    'You',
                    style: TextStyle(color: ColorRes.white, fontSize: 17),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: Utils.getDeviceWidth(context) / 12,
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_ranking_header")),
                            fit: BoxFit.fill)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: Text(
                            'Name',
                            style:
                                TextStyle(color: ColorRes.white, fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text('Company Name',
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 17),
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text('Score',
                                style: TextStyle(
                                    color: ColorRes.white, fontSize: 17),
                                textAlign: TextAlign.right),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_ranking_header_1")),
                            fit: BoxFit.fill)),
                    child: Text(
                      'Challenge',
                      style: TextStyle(color: ColorRes.white, fontSize: 17),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 45,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_ranking_header_1")),
                            fit: BoxFit.fill)),
                    child: Text(
                      'Friend',
                      style: TextStyle(color: ColorRes.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return getItem(index);
              },
            ),
          )
        ],
      ),
    );
  }

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      print(selectItem.toString());
    });
  }

  selectTime(index) {
    setState(() {
      _selectedTime = index;
      print(selectItem.toString());
    });
  }

  selectOption(index) {
    setState(() {
      _selectedOption = index;
      print(selectItem.toString());
    });
  }

  getItem(int index) {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Container(
              width: Utils.getDeviceWidth(context) / 12,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Image(
                          image: AssetImage(Utils.getAssetsImg('arrow_green')),
                          width: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 25,
                          child: Text((index + 1).toString() + ".",
                              maxLines: 1,
                              style: TextStyle(
                                color: ColorRes.textBlue,
                                fontSize: 20,
                              )),
                        ),
                        Container(
                          height: 38,
                          width: 38,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    Utils.getAssetsImg('add_emplyee'))),
                          ),
                        ),
                        Expanded(
                          child: Text('Name',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: ColorRes.textBlue, fontSize: 17),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Company Name',
                        maxLines: 1,
                        style:
                            TextStyle(color: ColorRes.textBlue, fontSize: 17),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.only(right: 1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg('value')),
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      '90',
                      style: TextStyle(color: ColorRes.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg('ic_challenge')),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg('add_emplyee')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//------------------  option item --------

class OptionItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;

  OptionItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);

  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.selectItem(widget.index);
        },
        child: Image(
          image: AssetImage(Utils.getAssetsImg('ranking_profit')),
          width: 10,
        ));
  }
}

//------------------  header item --------
class CustomItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;

  CustomItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);

  _CustomItemState createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectItem(widget.index);
      },
      child: Container(
        width: Utils.getDeviceWidth(context) / 9,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg(widget.isSelected
                    ? "ranking_selected"
                    : "ranking_unselected")),
                fit: BoxFit.fill)),
        child: Text(
          widget.title,
          style: TextStyle(color: ColorRes.white, fontSize: 17),
        ),
      ),
    );
  }
}

//-----------------------

class TimeItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;

  TimeItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);

  _TimeItemState createState() => _TimeItemState();
}

class _TimeItemState extends State<TimeItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectItem(widget.index);
      },
      child: Container(
        width: Utils.getDeviceWidth(context) / 12,
        margin: EdgeInsets.symmetric(vertical: 11, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg(widget.isSelected
                    ? "ranking_selected"
                    : "ranking_unselected")),
                fit: BoxFit.fill)),
        child: Text(
          widget.title,
          style: TextStyle(color: ColorRes.white, fontSize: 15),
        ),
      ),
    );
  }
}
