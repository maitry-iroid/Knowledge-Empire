import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_achievement.dart';
import 'package:ke_employee/models/get_friends.dart';
//import 'package:volume/volume.dart';

import 'commonview/background.dart';
import 'models/achievement_category.dart';
import 'dart:math' as math;

//int currentVol;

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  int selected = 0;
  bool isLoading = false;
  List<GetFriendsData> arrFriends = List();
  List<AchievementCategoryData> arrCategories = List();

  List<String> allCategoryList = List();

  @override
  void initState() {
    super.initState();

    getAchievementCategories();
    getFriends();
    jointArray();
  }

  @override
  Widget build(BuildContext context) {
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
          ),
          CommonView.showCircularProgress(isLoading)
        ],
      ),
    );
  }

  showFirstColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        showLeftItem(1),
        showLeftItem(2),
        showLeftItem(3),
        showLeftItem(4),
      ],
    );
  }

  int selectedCategory = 0;
  int _selectedTime = 0;
  int _selectedOption = 0;

//  var arrCategory = ['World', 'Country', 'Friends', 'Group A', 'Group B'];
  var arrCategory = ['World', 'Country', 'Friends'];

  var arrTime = ['Day', 'Month', 'Year'];


  jointArray() {

    allCategoryList = arrCategory + arrTime;
    print(allCategoryList);

    for(int i = 0; i < allCategoryList.length + 3 ; i++) {
      
    }

  }

//  List<arrsearchByModel> searchDataList = [
//    arrsearchByModel(name: "world", categoryId: "1"),
//    arrsearchByModel(name: "country", categoryId: "2"),
//    arrsearchByModel(name: "friends", categoryId: "3"),
//  ];

  List searchDataList = [{
      "name": "world",
      "categoryId": "1",
    },
    {
      "name": "country",
      "categoryId": "2",
    },
    {
      "name": "friends",
      "categoryId": "3",
    },
  ];

  showSecondColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
//                      itemCount: arrCategories.length,
                      itemCount: allCategoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomItem(
                          selectItem,
                          index: index,
                          isSelected: selectedCategory == index ? true : false,
//                          title: searchDataList[index].searchBy + arrCategories[index].name,
                          title: allCategoryList[index],

                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: arrTime.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TimeItem(
                        selectTime,
                        index: index,
                        isSelected: _selectedTime == index ? true : false,
                        title: arrTime[index],
                      );
                    },
                  ),
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
              itemCount: arrFriends.length,
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
      selectedCategory = index;
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
                          child: Text(arrFriends[index].name,
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
                    child: Text(arrFriends[index].name,
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
                      arrFriends[index].score.toString(),
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
                child:
                arrFriends[index].isFriend == 0 ?
                Image(image: AssetImage(
                    Utils.getAssetsImg('ic_challenge_disable'))) :
                Image(image: AssetImage(Utils.getAssetsImg('ic_challenge')))
            ),
          ),
          Expanded(
            flex: 3,
            child: InkResponse(
                onTap: () {
                  print("hello$index");
                  Utils.playClickSound();

//                index ? :
//                  _isSelected(index);
                  setState(() {
//                    arrFriends[index].isFriends = !arrFriends[index].isFriends;
                    if (arrFriends[index].isFriend == 0) {
                      arrFriends[index].isFriend = 1;
                    } else {
                      arrFriends[index].isFriend = 0;
                    }
                  });
//                  selectedIndex == index;  0 arrCategories[index].isFriend == true
                },
                child: Image(
                  image: AssetImage(
                      selectedIndex != null && arrFriends[index].isFriend == 0
                          ? Utils.getAssetsImg('add_emplyee')
                          : Utils.getAssetsImg('remove_friend')),
                )
            ),
          ),
        ],
      ),
    );
  }

  int selectedIndex = -1;

  bool isCheckFreiend = false;

  _isSelected(int index) {
    //pass the selected index to here and set to 'isSelected'
    setState(() {
      selectedIndex = index;
    });
  }


  getBgImage(int i) {
    return AssetImage(Utils.getAssetsImg(
        selected != i ? "ranking_bg_gray" : "rankinf_bg_blue"));
  }

  showLeftItem(int type) {
    return Expanded(
      flex: 1,
      child: InkResponse(
        onTap: () {
          setState(() {
            Utils.playClickSound();
            selected = type;
          });
        },
        child: Container(
          height: 80,
          width: 80,
          padding: EdgeInsets.all(20),
          decoration:
          BoxDecoration(image: DecorationImage(image: getBgImage(type))),
          child: Image(
            image: AssetImage(Utils.getAssetsImg(getInnerImage(type))),
          ),
        ),
//              child: Image(
//                  height: 40,
//                  width: 40,
//                  image: AssetImage(selected == 1
//                      ? Utils.getAssetsImg('rankinf_bg_blue')
//                      : Utils.getAssetsImg('ic_bs_rk_rich')),
//              )
      ),
    );
  }

  String getInnerImage(int type) {
    if (type == 1) {
      return "ic_bs_rk_revenue";
    } else if (type == 2) {
      return "ic_bs_rk_rich";
    }
    if (type == 3) {
      return "ic_bs_rk_communication";
    } else if (type == 4) {
      return "ic_bs_rk_price_tag";
    } else {
      return "ic_bs_rk_revenue";
    }
  }

  Future getAchievementCategories() {
    setState(() {
      isLoading = true;
    });

    AchievementCategoryRequest rq = AchievementCategoryRequest();
    rq.userId = Injector.userData.userId;

    WebApi().getAchievementCategory(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null) {
            arrCategories = response.data;
            setState(() {});
          }
        }
      }
    });
  }

  void getFriends() {
    setState(() {
      isLoading = true;
    });

    GetFriendsRequest rq = GetFriendsRequest();
    rq.userId = Injector.userData.userId;
    rq.category = 1;
    rq.searchBy = 1;
    rq.filter = 1;

    WebApi().getFriends(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null) {
            arrFriends = response.data;
            setState(() {});
          }
        }
      }
    });
  }
}
//------------------  option item --------

class OptionItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;

  OptionItem(this.selectItem, {
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
//          if (currentVol != 0) {
          Utils.playClickSound();
//          }
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

  CustomItem(this.selectItem, {
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
//        if (currentVol != 0) {
        Utils.playClickSound();
//        }
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

  TimeItem(this.selectItem, {
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
//        if (currentVol != 0) {
        Utils.playClickSound();
//        }
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

  ProfitItem(this.selectItem, {
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
//        if (currentVol != 0) {
        Utils.playClickSound();
//        }
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

class arrsearchByModel {
  String name;
  String categoryId;

  arrsearchByModel({this.name, this.categoryId});
}
