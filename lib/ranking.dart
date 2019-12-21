import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';

import 'commonview/background.dart';

Notifier _notifier;

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    _notifier = NotifierProvider.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CommonView.showBackground(context),
          Padding(
            padding: EdgeInsets.only(
              top: Utils.getHeaderHeight(context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[showFirstColumn(), showSecondColumn()],
            ),
          )
        ],
      ),
    );
  }

  showFirstColumn() {
//   return ListView.builder(
//      scrollDirection: Axis.vertical,
////      shrinkWrap: true,
//      physics: ClampingScrollPhysics(),
//      itemCount: arrTime.length,
//      itemBuilder: (BuildContext context, int index) {
//        return TimeItem(
//          selectTime, // callback function, setstate for parent
//          index: index,
//          isSelected: _selectedTime == index ? true : false,
//          title: arrTime[index],
//        );
//      },
//    );

    var selecteded = 0;
    bool selected = true;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: InkResponse(
            onTap: () {
              selecteded = 0;
              _notifier.notify('rankingAction', "0");
//              Image(image: AssetImage(Utils.getAssetsImg('ranking_deselect_profit')),
//                  width: 80);
            },

//            child: ClipRect(
//              clipBehavior: Clip.hardEdge,
//              child: OverflowBox(
//                maxHeight: 250,
//                maxWidth: 250,
//                child: Center(
//                  child: Container(
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      shape: BoxShape.circle,
//                    ),
//                  ),
//                ),
//              ),
//            ),

            child:
                Notifier.of(context).register<String>('rankingAction', (data) {
              return Image(
                  image: AssetImage(data.data == "0"
                      ? Utils.getAssetsImg('ranking_select_revenue')
                      : Utils.getAssetsImg('ranking_deselect_profit')),
                  width: 80);
            }),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkResponse(
            onTap: () {
              selecteded = 1;
              _notifier.notify('rankingAction', '1');
            },
            child:
                Notifier.of(context).register<String>('rankingAction', (data) {
              return Image(
                  image: AssetImage(data.data != "1"
                      ? Utils.getAssetsImg('ranking_deselect_profit')
                      : Utils.getAssetsImg('ranking_select_revenue')),
                  width: 80);
            }),
          ),
        ),
        Expanded(
            flex: 1,
            child: InkResponse(
              onTap: () {
                selecteded = 2;
                _notifier.notify('rankingAction', '2');
              },
              child: Notifier.of(context).register<String>('rankingAction',
                  (data) {
                return Image(
                    image: AssetImage(data.data != "2"
                        ? Utils.getAssetsImg('ranking_deselect_customers')
                        : Utils.getAssetsImg('ranking_select_revenue')),
                    width: 80);
              }),
            )),
        Expanded(
          flex: 1,
          child: InkResponse(
            onTap: () {
              selecteded = 3;
              _notifier.notify('rankingAction', '3');
            },
            child:
                Notifier.of(context).register<String>('rankingAction', (data) {
              return Image(
                  image: AssetImage(data.data != "3"
                      ? Utils.getAssetsImg('ranking_deselect_brand')
                      : Utils.getAssetsImg('ranking_select_revenue')),
                  width: 80);
            }),
          ),
        )
      ],
    );
  }

  int _selectedItem = 0;
  int _selectedTime = 0;
  int _selectedOption = 0;

  var arr = ['World', 'Country', 'Friends', 'Group A', 'Group B'];
  var arrTime = ['Day', 'Month', 'Year'];

  showSecondColumn() {
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
                  Expanded(
                    child: ListView.builder(
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
                  )
                ],
              )),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg("bg_you")),
                          fit: BoxFit.fill)),
                  child: Text(
                    'You',
                    style: TextStyle(color: ColorRes.white, fontSize: 15),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_ranking_header")),
                            fit: BoxFit.fill)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Company Name gggggggggggggg',
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              maxLines: 1,
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text('Score',
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              textAlign: TextAlign.right),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 0),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_ranking_header_1")),
                            fit: BoxFit.fill)),
                    child: Text(
                      'Challenge',
                      style: TextStyle(color: ColorRes.white, fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 45,
                    height: 30,
                    margin: EdgeInsets.only(left: 2, right: 5),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_ranking_header_1")),
                            fit: BoxFit.fill)),
                    child: Text(
                      'Friend',
                      style: TextStyle(color: ColorRes.white, fontSize: 15),
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
              itemCount: 10,
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
      height: 38,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 16,
            child: Container(
              width: Utils.getDeviceWidth(context) / 12,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
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
                                  color: ColorRes.textBlue, fontSize: 16),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: ColorRes.greyText,
                    width: 1,
                    margin: EdgeInsets.symmetric(vertical: 5),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Company Name',
                        maxLines: 1,
                        style:
                            TextStyle(color: ColorRes.textBlue, fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    margin: EdgeInsets.only(right: 1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Utils.getAssetsImg('value')),
                          fit: BoxFit.fill),
                    ),
                    child: Text(
                      '90',
                      style: TextStyle(color: ColorRes.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkResponse(
              child: Image(
                image: AssetImage(Utils.getAssetsImg('ic_challenge')),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkResponse(
                onTap: () {
                  print("hello$index");
//                index ? :
                  _isSelected(index);
                },
                child: Image(
                  image: AssetImage(
                      selectedIndex != null && selectedIndex == index
                          ? Utils.getAssetsImg('add_emplyee')
                          : Utils.getAssetsImg('add_emp_check')),
                )

                /*      onTap: () {
                print("hello$index");
//                selctedIndex = index;
                _notifier.notify('addemp', "");
                 showIndex();
              },
              child: Notifier.of(context).register<String>('addemp', (data) {
                return Image(
                  image: AssetImage(Utils.getAssetsImg('add_emplyee') ),
//                  image: AssetImage(showIndex()),
                );
              }),  */

                ),
          ),
        ],
      ),
    );
  }

  int selectedIndex = -1;

  _isSelected(int index) {
    //pass the selected index to here and set to 'isSelected'
    setState(() {
      selectedIndex = index;
    });
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
          Utils.playClickSound();
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
        Utils.playClickSound();
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
          style: TextStyle(color: ColorRes.white, fontSize: 15),
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
        Utils.playClickSound();
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
//-----------------------

class ProfitItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;

  ProfitItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);

  _ProfitItemState createState() => _ProfitItemState();
}

class _ProfitItemState extends State<TimeItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
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
