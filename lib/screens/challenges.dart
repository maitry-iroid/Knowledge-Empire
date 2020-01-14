import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:ke_employee/models/search_friend.dart';
import 'package:ke_employee/models/send_challenge.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
//import 'package:volume/volume.dart';

import '../helper/Utils.dart';
import '../helper/string_res.dart';
import '../helper/web_api.dart';
import '../models/get_friends.dart';


class ChallengesPage extends StatefulWidget {

  final List<GetFriendsData> arrFriends;
  final int userId;

  ChallengesPage({Key key, this.arrFriends, this.userId}) : super(key: key);

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  bool isLoading = false;
  List<GetFriendsData> arrFriends = List();
  List<GetFriendsData> arrSearchFriends = List();

  List<GetFriendsData> responseArrFriends = List();

  List<LearningModuleData> arrLearningModules = List();

  List<String> arrRewards = ["2%", "4%", "6%", "8%", "10%"];

  @override
  void initState() {
    super.initState();
    getFriends();
//    arrFriends = widget.arrFriends;
//    selectedFriendId = arrFriends[0].userId;
//    getBusinessSectors();

    arrSearchFriends = arrFriends;
    if (arrSearchFriends.length > 0) setState(() {});
  }

  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CommonView.showBackground(context),
        Column(
          children: <Widget>[
            SizedBox(
              height: Utils.getHeaderHeight(context) + 10,
            ),
            CommonView.showTitle(context, StringRes.challenges),
            showMainBody(),
          ],
        ),
        Card(
          margin: EdgeInsets.all(0),
          elevation: 10,
          child: Container(
            color: ColorRes.colorBgDark,
            height: 1,
          ),
        ),
        CommonView.showCircularProgress(isLoading)
      ],
    );
  }

  showMainBody() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            showFriends(),
            showBusinessSectors(),
            showRewards()
          ],
        ),
      ),
    );
  }

  showFriends() {
    return Expanded(
      flex: 3,
      child: Card(
        color: ColorRes.bgProf,
        margin: EdgeInsets.all(0),
        shape: getBorderShape(),
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(),
          decoration: getBoxDecoration(),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 25,
                margin: EdgeInsets.only(bottom: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Injector.isBusinessMode
                      ? ColorRes.blue
                      : ColorRes.titleBlueProf,
                ),
                child: Text(
                  Utils.getText(context, StringRes.friends),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
                ),
              ),
              Expanded(
                flex: 1,
//                margin: EdgeInsets.symmetric(vertical: 5),
//                padding: EdgeInsets.only(left: 20, right: 10, top: 2, bottom: 2),
//            color: ColorRes.lightBg,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            height: 30,
//                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                            padding: EdgeInsets.only(top: 13, left: 10),
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorRes.white,
                            ),
//                        alignment: Alignment.center,
                            child: TextField(
                              onChanged: (text) {
                                searchText = text;
                                setState(() {
                                  if (text.isEmpty) {
                                    arrSearchFriends = arrFriends;
                                  }
                                });
                              },
//                          textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              controller: searchController,
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorRes.hintColor,
                              ),
                              decoration: InputDecoration(
//                              contentPadding:  EdgeInsets.symmetric(horizontal: 5),
                                  hintText: Utils.getText(
                                      context, StringRes.searchForKeywords),
                                  hintStyle:
                                      TextStyle(color: ColorRes.hintColor),
                                  border: InputBorder.none),
                            ))),
                    SizedBox(
                      width: 1,
                    ),
                    MaterialButton(
                      height: 10,
                      minWidth: 5,
                      onPressed: () {
                        searchFriends();
                      },
                      child: Icon(
                        Icons.search,
                        color: ColorRes.white,
                      ),
//                      child: Image(image: AssetImage(
//                        Utils.getAssetsImg(
//                            Injector.isBusinessMode ? "search" : 'search_prof'),
//                      ),
////                        fit: BoxFit.fill,
//                      ),
                    )

//                    Image(
//                      height: 35,
//                      width: 40,
//                      image: AssetImage(
//                        Utils.getAssetsImg(
//                            Injector.isBusinessMode ? "search" : 'search_prof'),
//                      ),
//                      fit: BoxFit.fill,
//                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
//                  itemCount: 1,
                  itemCount: arrFriends != null ? arrSearchFriends.length : 0,
//                  var isSelected = true;
                  itemBuilder: (BuildContext context, int index) {
                    return showFriendItem(index, 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchFriends() {
    getSearchFriends();

    /*arrSearchFriends.clear();
    var data = arrFriends
        .where((friendsName) =>
        friendsName.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    print("search_data___" + data.length.toString());
    arrSearchFriends.addAll(data); */
  }

  showBusinessSectors() {
    return Expanded(
      flex: 4,
      child: Card(
        margin: EdgeInsets.only(left: 12),
        elevation: 10,
        shape: getBorderShape(),
        child: Container(
          decoration: getBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(
                              Utils.getAssetsImg("rounded_rect_blue"),
                            ),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  Utils.getText(context, StringRes.businessSector),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: arrLearningModules.length,
                  itemBuilder: (BuildContext context, int index) {
                    return showSectorItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showRewards() {
    return Expanded(
      flex: 4,
      child: Card(
        elevation: 10,
        shape: getBorderShape(),
        margin: EdgeInsets.only(left: 12),
        child: Container(
          decoration: getBoxDecoration(),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 35),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: Injector.isBusinessMode
                        ? null
                        : BorderRadius.circular(20),
                    color:
                        Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                    image: Injector.isBusinessMode
                        ? DecorationImage(
                            image: AssetImage(
                              Utils.getAssetsImg("rounded_rect_blue"),
                            ),
                            fit: BoxFit.fill)
                        : null),
                child: Text(
                  Utils.getText(context, StringRes.rewards),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: arrRewards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return showFriendItem(index, 2);
                  },
                ),
              ),
              InkResponse(
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 5),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              Utils.getAssetsImg("bg_switch_to_prfsnl")),
                          fit: BoxFit.fill)),
                  child: Text(
                    Utils.getText(context, StringRes.sendChallenge),
                    style: TextStyle(color: ColorRes.white),
                  ),
                ),
                onTap: () {
                  sendChallenges();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  int selectedIndex = -1;

  _onSelectedFriend(int index) {
    setState(() {
      selectedIndex = index;

      selectedFriendId = arrFriends[selectedIndex].userId;
    });
  }

  int selectedRewardsIndex = 0;

  _onSelectedRewards(int index) {
    setState(() => selectedRewardsIndex = index);
  }

  selectedItem(int type, int index) {
    if (type == 1) {
      if (arrFriends[index].userId == widget.userId) {
        return Colors.blue;
      } else {
        return ColorRes.greyText;
      }
      /*if(selectedIndex == index) {
        return ColorRes.blue;
      } else {
        return ColorRes.greyText;
      }*/
    } else {
      if (selectedRewardsIndex == index) {
        return ColorRes.blue;
      } else {
        return ColorRes.greyText;
      }
    }
  }

  showFriendItem(int index, int type) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
        type == 1 ? _onSelectedFriend(index) : _onSelectedRewards(index);

        //        Navigator.push(context, MaterialPageRoute(builder: (context) => Customer()));
      },
      child: Container(
        alignment: Alignment.center,
        width: 40,
//        height: 40,
//        width: Utils.getDeviceWidth(context) / 18,
        decoration: BoxDecoration(
          color: Injector.isBusinessMode
              ? selectedItem(type, index)
//            selectedIndex != null && selectedIndex == index ? ColorRes.blue : ColorRes.greyText
              : ColorRes.white,
          borderRadius: BorderRadius.circular(20),
//            image: Injector.isBusinessMode
//                ? DecorationImage(
//                    image: AssetImage(
//                      selectedIndex != null && selectedIndex == index
//                          ? Utils.getAssetsImg('bg_blue')
//                          : Utils.getAssetsImg('rounded_rect_challenges'),
//                    ),
//                    fit: BoxFit.fill)
//                : null
        ),
        margin: EdgeInsets.symmetric(
//            vertical: type == 1 ? 5 : Utils.getDeviceHeight(context) / 7,
            vertical: type == 1 ? 5 : 50,
            horizontal: type == 1 ? 8 : 8),
//        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(
          type != 2 ? arrFriends[index].name : arrRewards[index],
          style: TextStyle(
              color:
                  Injector.isBusinessMode ? ColorRes.white : ColorRes.fontGrey,
              fontSize: 17),
        ),
      ),
    );
  }

  var selectItem = -1;

  _onSelectedSector(int index) {
    setState(() => selectItem = index);
  }

  showSectorItem(int index) {
    return GestureDetector(
      onTap: () {
//        if(currentVol != 0) {
        Utils.playClickSound();
//        }
        _onSelectedSector(index);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Injector.isBusinessMode ? null : ColorRes.white,
            borderRadius: BorderRadius.circular(5),
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(
                      selectItem != null && selectItem == index
                          ? Utils.getAssetsImg('challenges_bg_sector')
                          : Utils.getAssetsImg(''),
                    ),
                    fit: BoxFit.fill)
                : null),
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 5)),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(arrLearningModules[index].moduleName,
                      style: TextStyle(
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.textProf,
                          fontSize: 15)),
                ),
                RotatedBox(
                  quarterTurns: 90,
                  child: Image(
                    image: AssetImage(
                      Utils.getAssetsImg("back"),
                    ),
                    width: 20,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 0,
            ),
//            Padding(padding: EdgeInsets.only(bottom: 0.0,top: 10)),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 35)),
                LinearPercentIndicator(
                  width: Utils.getDeviceWidth(context) / 3.6,
                  lineHeight: 20.0,
                  percent: arrLearningModules[index].moduleProgress / 100,
                  backgroundColor: Colors.grey,
                  progressColor: Injector.isBusinessMode
                      ? Colors.blue
                      : ColorRes.titleBlueProf,
                ),
                Positioned(
                  left: 6,
                  child: Text(
                    arrLearningModules[index].moduleProgress.toString() + "%",
                    style: TextStyle(color: ColorRes.white, fontSize: 14),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  showRewardItem(int index) {
    return Container(
      color: Injector.isBusinessMode ? null : ColorRes.white,
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('HealthCare',
                    style: TextStyle(
                        color: Injector.isBusinessMode
                            ? ColorRes.white
                            : ColorRes.textProf,
                        fontSize: 18)),
              ),
              Image(
                image: AssetImage(
                  Utils.getAssetsImg("back"),
                ),
                width: 25,
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          LinearPercentIndicator(
            width: Utils.getDeviceWidth(context) / 3.4,
            lineHeight: 20.0,
            percent: 0.5,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          )
        ],
      ),
    );
  }

  getBoxDecoration() {
    return BoxDecoration(
        border: Injector.isBusinessMode
            ? null
            : Border.all(width: 2, color: ColorRes.white),
        color: Injector.isBusinessMode ? ColorRes.bgBusSec : ColorRes.bgProf,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)));
  }

  getBorderShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)));
  }

  int selectedFriendId = 3;

  void getFriends() {
    setState(() {
      isLoading = true;
    });

    GetFriendsRequest rq = GetFriendsRequest();
    rq.userId = Injector.userData.userId;
    rq.groupId = 0;
    rq.category = 0;
    rq.searchBy = 0;
    rq.filter = 0;

    WebApi().getFriends(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null) {
            responseArrFriends = response.data;

            if (arrFriends.length > 0) {
              selectedFriendId = arrFriends[0].userId;
              getBusinessSectors();
              setState(() {});
            }
          }
        }
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  void getBusinessSectors() {
    setState(() {
      isLoading = true;
    });

    WebApi().getLearningModule(selectedFriendId, 1).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null) {
            arrLearningModules = response.data;
            print(" ==>>   arrLearningModules $arrLearningModules ");
            setState(() {});
          }
        }
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  void sendChallenges() {
    setState(() {
      isLoading = true;
    });

    SendChallengesRequest rq = SendChallengesRequest();
    rq.userId = Injector.userData.userId;
    rq.friendId = widget.userId;
    rq.moduleId = arrLearningModules[0].moduleId;
    rq.rewards = selectedRewardsIndex;

    WebApi().sendChallenges(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null) {
//            arrFriends = response.data;
            if (response.msg != null) {
              Utils.showToast(response.msg);
            } else {
              Utils.showToast("Send Challeange is success.");
            }
            setState(() {});
          }
        }
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }

  void getSearchFriends() {
    setState(() {
      isLoading = true;
    });

    SearchFriendRequest rq = SearchFriendRequest();
    rq.userId = Injector.userData.userId.toString();
    rq.searchText = searchController.text;

    WebApi().searchFriends(rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null) {
            List<GetFriendsData> getFriendsData = responseArrFriends;

            /*  for(int i = 0; i < getFriendsData.length; i++ ) {
              if(arrSearchFriends[i].name == getFriendsData[i].name) {
                arrSearchFriends = getFriendsData;
              }
            }*/

          }
        }
      }
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      Utils.showToast(e.toString());
    });
  }
}
