import 'package:flutter/material.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/listItem/group_item.dart';
import 'package:ke_employee/listItem/time_item.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/friendUnfriendUser.dart';
import 'package:ke_employee/models/get_friends.dart';
import 'package:ke_employee/models/get_user_group.dart';
//import 'package:volume/volume.dart';

import '../commonview/background.dart';
import '../helper/constant.dart';

//AudioManager audioManager;
//int currentVol;

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  int selectedLeftCategory = 0;
  int selectedGroup = 0;
  int selectedTime = 0;
  bool isLoading = false;
  List<GetFriendsData> arrFriends = List();
  List<GetUserGroupData> arrGroups = List();

  List<String> allCategoryList = List();

  int selectedUser = -1;

  bool isCheckFriend = false;

  @override
  void initState() {
    super.initState();

//    audioManager = AudioManager.STREAM_SYSTEM;
//    initPlatformState();
//    updateVolumes();

    getUserGroups();
    getFriends();
  }

//  Future<void> initPlatformState() async {
//    await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
////    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
//  }
//
//  updateVolumes() async {
//    // get Current Volume
//    currentVol = await Volume.getVol;
//    print("helloooo =======>>>  $currentVol");
//    setState(() {});
//  }

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

  selectGroup(index) {
    if (index != selectedGroup) {
      setState(() {
        selectedGroup = index;
        print(selectGroup.toString());
      });
      getFriends();
    }
  }

  selectTime(index) {
    if (selectedTime != index) {
      setState(() {
        selectedTime = index;
        print(selectedTime.toString());
      });
      getFriends();
    }
  }

  showFirstColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        showLeftItem(0),
        showLeftItem(1),
        showLeftItem(2),
        showLeftItem(3),
      ],
    );
  }

  var arrCategory = ['World', 'Country', 'Friends'];

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
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: arrGroups.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GroupItem(
                          selectGroup,
                          index: index,
                          isSelected: selectedGroup == index ? true : false,
                          title: arrGroups[index].name != null
                              ? arrGroups[index].name
                              : "",
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
                        isSelected: selectedTime == index ? true : false,
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
                          child: Text('Company Name',
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
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                Utils.getAssetsImg("bg_ranking_header_1")),
                            fit: BoxFit.fill)),
                    child: Text(
                      Utils.getText(context, StringRes.challenges),
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

  getItem(int index) {
    return Container(
      height: 38,
      child: Row(
        children: <Widget>[
          showUserDetails(index),
          showChallengeButton(index),
          showFriendUnFriendButton(index)
        ],
      ),
    );
  }

  getBgImage(int index) {
    return AssetImage(Utils.getAssetsImg(
        selectedLeftCategory != index ? "ranking_bg_gray" : "rankinf_bg_blue"));
  }

  showLeftItem(int index) {
    return Expanded(
      flex: 1,
      child: InkResponse(
        onTap: () {
          if (selectedLeftCategory != index) {
            setState(() {
//              if(currentVol != 0) {
              Utils.playClickSound();
//              }
              selectedLeftCategory = index;
            });

            getFriends();
          }
        },
        child: Container(
          height: 80,
          width: 80,
          padding: EdgeInsets.all(25),
          decoration:
              BoxDecoration(image: DecorationImage(image: getBgImage(index))),
          child: Image(
            image: AssetImage(Utils.getAssetsImg(getInnerImage(index))),
          ),
        ),
      ),
    );
  }

  String getInnerImage(int type) {
    if (type == 0) {
      return "ic_bs_rk_revenue";
    } else if (type == 1) {
      return "ic_bs_rk_rich";
    } else if (type == 2) {
      return "ic_bs_rk_communication";
    } else if (type == 3) {
      return "ic_bs_rk_price_tag";
    } else {
      return "ic_bs_rk_revenue";
    }
  }

  getUserGroups() {
    setState(() {
      isLoading = true;
    });

    GetUserGroupData grp1 = GetUserGroupData();
    grp1.groupId = 1;
    grp1.name = "World";
    GetUserGroupData grp2 = GetUserGroupData();
    grp2.groupId = 2;
    grp2.name = "Country";
    GetUserGroupData grp3 = GetUserGroupData();
    grp3.groupId = 3;
    grp3.name = "Friends";

    arrGroups.add(grp1);
    arrGroups.add(grp2);
    arrGroups.add(grp3);

    GetUserGroupRequest rq = GetUserGroupRequest();
    rq.userId = Injector.userData.userId;

    WebApi().getUserGroup(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (response.data != null) {
            arrGroups.addAll(response.data);

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
    rq.category = selectedLeftCategory + 1;
    rq.searchBy = selectedGroup >= 0 && selectedGroup <= 1
        ? selectedGroup + 1
        : arrGroups[selectedGroup].groupId;
    rq.filter = selectedTime + 1;

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

  void friendUnFriendUser(int index, int i) {
    setState(() {
      isLoading = true;
    });

    GetFriendsUnfriendReuest rq = GetFriendsUnfriendReuest();
    rq.userId = Injector.userData.userId;
    rq.requestedTo = arrFriends[index].userId;
    rq.action = i;

    WebApi().friendUnFriendUser(context, rq).then((response) {
      setState(() {
        isLoading = false;
      });

      if (response != null) {
        if (response.flag == "true") {
          if (i == 1) {
            Utils.showToast("friend request send successfully");
          } else {
            Utils.showToast("unfriend successfully");
          }
        }
      }
    });
  }

  showChallengeButton(int index) {
    return Expanded(
      flex: 3,
      child: InkResponse(
        child: arrFriends[index].isFriend == 0
            ? Image(
                image: AssetImage(Utils.getAssetsImg('ic_challenge_disable')))
            : Image(image: AssetImage(Utils.getAssetsImg('ic_challenge'))),
        onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          if (arrFriends[index].isFriend == 1) {
            Navigator.push(
                context,
                FadeRouteHome(
                    arrFriends: arrFriends,
                    initialPageType: Const.typeChallenges,
                    friendId: arrFriends[index].userId));
            print(arrFriends[index].isFriend);
          }
        },
      ),
    );
  }

  showFriendUnFriendButton(int index) {
    return Expanded(
      flex: 3,
      child: InkResponse(
          onTap: () {
            print("hello$index");
            Utils.playClickSound();
            setState(() {
              if (arrFriends[index].isFriend == 0) {
                arrFriends[index].isFriend = 1;
                friendUnFriendUser(index, 1);
              } else {
                arrFriends[index].isFriend = 0;
                friendUnFriendUser(index, 2);
              }
            });
          },
          child: Image(
            image: AssetImage(
                selectedUser != null && arrFriends[index].isFriend == 0
                    ? Utils.getAssetsImg('add_emplyee')
                    : Utils.getAssetsImg('remove_friend')),
          )),
    );
  }

  showUserDetails(int index) {
    return Expanded(
      flex: 16,
      child: Container(
        width: Utils.getDeviceWidth(context) / 12,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorRes.white, borderRadius: BorderRadius.circular(20)),
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
                          image: AssetImage(Utils.getAssetsImg('add_emplyee'))),
                    ),
                  ),
                  Expanded(
                    child: Text(arrFriends[index].name,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: ColorRes.textBlue, fontSize: 16),
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
                  style: TextStyle(color: ColorRes.textBlue, fontSize: 16),
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
    );
  }
}
