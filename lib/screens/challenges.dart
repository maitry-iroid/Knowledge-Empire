import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/prefkeys.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/friendUnfriendUser.dart';
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
  final int friendId;

  ChallengesPage({Key key, this.arrFriends, this.friendId}) : super(key: key);

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<GetFriendsData> arrFriends = List();

  List<GetFriendsData> arrFriendsToShow = List();
  List<GetFriendsData> arrSearchFriends = List();

  List<LearningModuleData> arrLearningModules = List();

  List<int> arrRewards = [2, 4, 6, 8, 10];
  var selectedModuleIndex = -1;
  int selectedRewardsIndex = 0;

  @override
  initState() {
    super.initState();

    showIntroDialog();

    getSearchFriends(searchText);

//    arrFriends = widget.arrFriends;
//    selectedFriendId = arrFriends[0].userId;
//    getBusinessSectors();

    if (widget.arrFriends != null) {
      arrSearchFriends = widget.arrFriends;
      if (arrSearchFriends.length > 0) if (mounted) setState(() {});
    }
  }

  Future showIntroDialog() async {
    if (Injector.prefs
                .getBool(PrefKeys.introYourWillIsAtYourCommand.toString()) !=
            null &&
        Injector.prefs
            .getBool(PrefKeys.introYourWillIsAtYourCommand.toString())) {
    } else {
      await DisplayDialogs.showYourWillIsAtYourCommand(context);
    }
  }

  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    timeHandle.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.friendId != null) selectedFriendId = widget.friendId;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CommonView.showBackground(context),
//          Card(
//            margin: EdgeInsets.all(0),
//            elevation: 10,
//            child: Container(
//              color: ColorRes.colorBgDark,
//              height: 1,
//            ),
//          ),
          ListView(
            shrinkWrap: false,
            children: <Widget>[
              SizedBox(
                height: Utils.getHeaderHeight(context) + 10,
              ),
              CommonView.showTitle(context, StringRes.challenges),
              showMainBody(),
            ],
          ),
        ],
      ),
    );
  }

  showMainBody() {
    return Container(
      height: Utils.getDeviceHeight(context) - 150,
      margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[showFriends(), showBusinessSectors(), showRewards()],
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
                  Utils.getText(context, StringRes.competitor),
                  style: TextStyle(color: ColorRes.white, fontSize: 17),
                ),
              ),
              showSearchView(),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: arrFriendsToShow.length,
                  itemBuilder: (BuildContext context, int index) {
                    return showFriendItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
//                  physics: NeverScrollableScrollPhysics(),
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
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: arrRewards.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return showRewardItem(index);
                      },
                    ),
                  ),
                ),
              ),
              InkResponse(
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
//                  unFriend(context);
                  if (selectedModuleIndex != null && selectedModuleIndex != -1)
                    sendChallenges();
                  else {
                    Utils.showToast(
                        Utils.getText(context, StringRes.alertNoModuleFound));
                  }
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
    if (mounted)
      setState(() {
        selectedIndex = index;

        selectedFriendId = arrFriends[selectedIndex].userId;

        getBusinessSectors();
      });
  }

  _onSelectedRewards(int index) {
    if (mounted) setState(() => selectedRewardsIndex = index);
  }

  selectedItem(int type, int index) {
    if (type == 1) {
      if (arrFriendsToShow[index].userId == selectedFriendId) {
        return Colors.blue;
      } else {
        return ColorRes.greyText;
      }
    } else {
      if (selectedRewardsIndex == index) {
        return ColorRes.blue;
      } else {
        return Injector.isBusinessMode ? ColorRes.greyText : ColorRes.white;
      }
    }
  }

  showFriendItem(int index) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
        _onSelectedFriend(index);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              Injector.isBusinessMode ? selectedItem(1, index) : ColorRes.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                arrFriendsToShow[index].name ?? "",
                style: TextStyle(
                    color: Injector.isBusinessMode
                        ? ColorRes.white
                        : ColorRes.fontGrey,
                    fontSize: 15),
              ),
            ),
            InkResponse(
                onTap: () {
                  Utils.playClickSound();

                  if (mounted)
                    setState(() {
                      if (arrFriendsToShow[index].isFriend == 0) {
                        arrFriendsToShow[index].isFriend = 1;
                        friendUnFriendUser(index, 1);
                      } else {
//                        unFriend(context, index);
                        _showUnFriend(context, index);
                      }
                    });
                },
                child: Image(
                  image: AssetImage(
                    selectedFriendId != null &&
                            arrFriendsToShow[index].isFriend == 0
                        ? Utils.getAssetsImg('add_emplyee')
                        : Utils.getAssetsImg('remove_friend'),
                  ),
                  width: 20,
                )),
          ],
        ),
      ),
    );
  }


  _showUnFriend(BuildContext context, int index) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(Utils.getText(context, StringRes.no)),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(Utils.getText(context, StringRes.yes)),
      onPressed:  () {
        arrFriendsToShow[index].isFriend = 0;
        friendUnFriendUser(index, 2);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Utils.getText(context, StringRes.alert)),
      content: Text(Utils.getText(context, StringRes.alertUnFriend), style: TextStyle(color: ColorRes.textProf)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


/*
  unFriend(BuildContext context, int index) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: ColorRes.blackTransparentColor,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(40),
                      width: Utils.getDeviceWidth(context) / 3.0,
                      height: Utils.getDeviceHeight(context) / 2.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorRes.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 35,
                              width: Utils.getDeviceWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: ColorRes.blue,
                              ),
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text(
                                  Utils.getText(context, "Alert"),
                                  style: TextStyle(
                                      color: ColorRes.white, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 13)),

                            Container(
                              height: 50,
                              width: Utils.getDeviceWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
//                                color: ColorRes.blue,
                              ),
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text(
                                  Utils.getText(context, "Are sure want to unfriend this user?"),
                                  style: TextStyle(
                                      color: ColorRes.textProf, fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Padding(padding: EdgeInsets.only(top: 13)),

                            Row(

                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                InkResponse(
                                  child: Container(
                                    height: 33,
                                    width: 65,
                                    decoration: BoxDecoration(
//                                    color: ColorRes.blue,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(
                                            color: ColorRes.blue, width: 1)),
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 10, left: 10, right: 10),
                                    margin: EdgeInsets.only(
                                        top: 0, bottom: 25, left: 0, right: 10),
                                    child: Center(child: Text('No', style: TextStyle(color: ColorRes.blue),)),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                InkResponse(
                                  child: Container(
                                    height: 35,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        color: ColorRes.blue,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(
                                            color: ColorRes.white, width: 1)),
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 10, left: 10, right: 10),
                                    margin: EdgeInsets.only(
                                        top: 0, bottom: 25, left: 0, right: 10),
                                    child: Center(
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: ColorRes.white),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    arrFriendsToShow[index].isFriend = 0;
                                    friendUnFriendUser(index, 2);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),

                            Padding(padding: EdgeInsets.only(top: 13)),

//                            languageSelectCell(StringRes.english, 0),
//                            languageSelectCell(StringRes.german, 1),
//                            languageSelectCell(StringRes.chinese, 2),
                          ],
                        ),
                      )),
                  Positioned(
                      right: 10,
                      child: InkResponse(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image:
                                AssetImage(Utils.getAssetsImg('close_dialog')),
                            width: 20,
                          ),
                        ),
                        onTap: () {
                          Utils.playClickSound();
                          Navigator.pop(context, null);
                        },
                      ))
                ],
              ),
            ),
          );
        });
  }
*/

  showRewardItem(int index) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
        _onSelectedRewards(index);
      },
      child: Container(
        alignment: Alignment.center,
        width: 40,
        decoration: BoxDecoration(
          color: Injector.isBusinessMode
              ? selectedItem(2, index)
              : selectedItem(2, index),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          arrRewards[index].toString() + "%",
          style: TextStyle(
              color: Injector.isBusinessMode
                  ? ColorRes.white
                  : isRewardSelected(index)
                      ? ColorRes.white
                      : ColorRes.fontGrey,
              fontSize: 17),
        ),
      ),
    );
  }

  isRewardSelected(int index) {
    return selectedRewardsIndex == index;
  }

  _onSelectedSector(int index) {
    if (mounted) setState(() => selectedModuleIndex = index);
  }

  showSectorItem(int index) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
        _onSelectedSector(index);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Injector.isBusinessMode ? null : ColorRes.white,
            borderRadius: BorderRadius.circular(5),
            image: Injector.isBusinessMode
                ? DecorationImage(
                    image: AssetImage(
                      selectedModuleIndex != null &&
                              selectedModuleIndex == index
                          ? Utils.getAssetsImg('challenges_bg_sector')
                          : Utils.getAssetsImg(''),
                    ),
                    fit: BoxFit.fill)
                : null),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
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
                  lineHeight: 20.0,
                  percent:
                      ((arrLearningModules[index].moduleProgress ?? 0) / 100)
                          .toDouble(),
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

  void friendUnFriendUser(int index, int action) {
    CommonView.showCircularProgress(true, context);
    GetFriendsUnfriendReuest rq = GetFriendsUnfriendReuest();
    rq.userId = Injector.userData.userId;
    rq.requestedTo = arrFriendsToShow[index].userId;
    rq.action = action;

    WebApi().callAPI(WebApi.rqFriendUnFriendUser, rq.toJson()).then((data) {
      CommonView.showCircularProgress(false, context);

      if (data != null) {
        if (action == 1) {
          Utils.showToast(Utils.getText(context, StringRes.alertFriendSuccess));
          getSearchFriends("");
        } else {
          if (arrSearchFriends.length > 0) arrSearchFriends.removeAt(index);
          if (arrFriendsToShow.length > 0) arrFriendsToShow.removeAt(index);
          if (mounted) setState(() {});
          Utils.showToast(
              Utils.getText(context, StringRes.alertUnFriendSuccess));
        }
      }
    }).catchError(() {
      CommonView.showCircularProgress(false, context);
    });
  }

  void getBusinessSectors() {
    Utils.isInternetConnected().then((isConnected) {
      if (isConnected) {
//        CommonView.showCircularProgress(true, context);

        GetLearningModuleRequest rq = GetLearningModuleRequest();
        rq.userId = selectedFriendId;
        rq.isChallenge = 1;

        WebApi().callAPI(WebApi.rqGetLearningModule, rq.toJson()).then((data) {
//          CommonView.showCircularProgress(false, context);

          if (data != null) {
            arrLearningModules.clear();
            data.forEach((v) {
              arrLearningModules.add(LearningModuleData.fromJson(v));
            });

            if (arrLearningModules.length > 0) {
              selectedModuleIndex = 0;
            }
            if (mounted) setState(() {});
          }
        }).catchError((e) {
          print("getLearningModule_" + e.toString());
//          CommonView.showCircularProgress(false, context);
          Utils.showToast(e.toString());
        });
      }
    });
  }

  void sendChallenges() {
    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) {
        CommonView.showCircularProgress(true, context);

        SendChallengesRequest rq = SendChallengesRequest();
        rq.userId = Injector.userData.userId;
        rq.friendId = selectedFriendId;
        rq.moduleId = arrLearningModules[selectedModuleIndex].moduleId;
        rq.rewards = arrRewards[selectedRewardsIndex];

        WebApi().callAPI(WebApi.rqSendChallenge, rq.toJson()).then((data) {
          CommonView.showCircularProgress(false, context);

          if (data != null)
            Utils.showToast(
                Utils.getText(context, StringRes.alertUChallengeSent));
        }).catchError((e) {
          print("sendChallenge_" + e.toString());

          CommonView.showCircularProgress(false, context);
          Utils.showToast(e.toString());
        });
      }
    });
  }

  void getSearchFriends(String searchText) {
    Utils.isInternetConnectedWithAlert().then((isConnected) {
      if (isConnected) {
        SearchFriendRequest rq = SearchFriendRequest();
        rq.userId = Injector.userId.toString();
        rq.searchText = searchText;

        WebApi().callAPI(WebApi.rqSearchFriends, rq.toJson()).then((data) {
          if (data != null) {
            List<GetFriendsData> getFriendsData = List();

            data.forEach((v) {
              getFriendsData.add(GetFriendsData.fromJson(v));
            });

            getFriendsData.removeWhere(
                (friend) => friend.userId == Injector.userData.userId);

            arrFriends = getFriendsData;
            arrFriendsToShow = getFriendsData;

            if (arrFriendsToShow.length > 0) {
              selectedFriendId = arrFriends[0].userId;
              getBusinessSectors();
            } else {
              arrLearningModules.clear();
              selectedFriendId = null;
              selectedModuleIndex = -1;
              selectedRewardsIndex = 0;
            }

            if (mounted) setState(() {});
          }
        }).catchError((e) {
          print("searchFriends_" + e.toString());

          Utils.showToast(e.toString());
        });
      }
    });
  }

  Timer timeHandle;

  showSearchView() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 25,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, left: 10),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorRes.white,
            ),
            child: TextField(
              onChanged: (text) {
                searchText = text;
                arrSearchFriends.clear();

                if (timeHandle != null) {
                  timeHandle.cancel();
                }
                timeHandle = Timer(Duration(seconds: 1), () {
                  getSearchFriends(searchText);
                });

//                if (text.isEmpty) {
//                  arrSearchFriends = arrFriends;
//                  arrFriendsToShow = arrFriends;
//                  if (mounted)setState(() {});
//                } else {
//                  getSearchFriends(searchText);
//                }
              },
              textAlign: TextAlign.left,
              maxLines: 1,
              controller: searchController,
              style: TextStyle(
                fontSize: 14,
                color: ColorRes.hintColor,
              ),
              decoration: InputDecoration(
//                              contentPadding:  EdgeInsets.symmetric(horizontal: 5),
                hintText: Utils.getText(context, StringRes.searchForKeywords),
                hintStyle: TextStyle(color: ColorRes.hintColor, fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        InkResponse(
          onTap: () {
            getSearchFriends(searchText);
          },
          child: Icon(
            Icons.search,
            color: ColorRes.white,
          ),
        )
      ],
    );
  }
}
