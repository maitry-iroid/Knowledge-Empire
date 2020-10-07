import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ke_employee/commonview/background.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/friend_unfriend_user.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/models/search_friend.dart';
import 'package:ke_employee/models/send_challenge.dart';
import 'package:ke_employee/screens/profile.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../helper/Utils.dart';
import '../helper/string_res.dart';
import '../helper/web_api.dart';
import '../models/get_friends.dart';

/*
*   created by Riddhi
*
*   - This class will fetch all the Friends and his scores in different Business module so that
*   - User can SEND CHALLENGE any of his friend in any module by different rewards category.
*
* */

class ChallengesPage extends StatefulWidget {
  final HomeData homeData;

  ChallengesPage({Key key, this.homeData}) : super(key: key);

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  int friendId;

  List<GetFriendsData> arrFriends = List();

  List<GetFriendsData> arrFriendsToShow = List();
  List<GetFriendsData> arrSearchFriends = List();

  List<LearningModuleData> arrLearningModules = List();

  List<int> arrRewards = [2, 4, 6, 8, 10];
  int selectedFriendId = -1;
  var selectedModuleIndex = -1;
  int selectedFriendIndex = -1;

  int selectedRewardsIndex = 0;
  int currentIndex = 0;

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          print("---------------------- APP Resumed---------------------");
          Injector.isSoundEnable && Injector.isBusinessMode ? Injector.audioPlayerBg.resume() : Injector.audioPlayerBg.stop();
        }))
    );

    arrFriends = widget.homeData.arrFriends;
    friendId = widget.homeData.friendId;

    showIntroDialog();

    getSearchFriends(searchText);

    if (arrFriends != null) {
      arrSearchFriends = arrFriends;
      if (arrSearchFriends.length > 0) if (mounted) setState(() {});
    }
  }

  Future showIntroDialog() async {
    if (Injector.introData != null && Injector.introData.challenge1 == 0)
      await DisplayDialogs.showIntroChallenge1(context);
  }

  TextEditingController searchController = TextEditingController();
  String searchText = "";
  bool isLoading = false;

  @override
  void dispose() {
    timeHandle?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (friendId != null) selectedFriendId = friendId;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CommonView.showBackground(context),
          Column(
            children: <Widget>[
              SizedBox(
                height: Utils.getHeaderHeight(context) + 10,
              ),
              showTitle(context, StringRes.challenges),
              Expanded(
                child: showMainBody(),
              ),
            ],
          ),
          CommonView.showLoderView(isLoading)
        ],
      ),
    );
  }

  showTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Stack(
        fit: StackFit.loose,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkResponse(
            child: Image(
              image: AssetImage(Utils.getAssetsImg(
                  Injector.isBusinessMode ? "back" : 'back_prof')),
              width: 30,
            ),
            onTap: () {
              Utils.playClickSound();
              Utils.performBack(context);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: Utils.getDeviceWidth(context) / 4,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: title == StringRes.challenges
                  ? EdgeInsets.only(right: 60)
                  : EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.circular(20),
                  border: Injector.isBusinessMode
                      ? null
                      : Border.all(width: 1, color: ColorRes.white),
                  color:
                      Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: showSendChallengeButton(),
          )
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
      flex: 4,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 6),
        color: ColorRes.bgProf,
        shape: getBorderShape(),
        child: Container(
          height: double.infinity,
          decoration: getBoxDecoration(),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 28,
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
                  style: TextStyle(color: ColorRes.white, fontSize: 19),
                ),
              ),
              showSearchView(),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: arrFriendsToShow.length,
                itemBuilder: (BuildContext context, int index) {
                  return showFriendItem(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showBusinessSectors() {
    return Expanded(
      flex: 5,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 6),
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
                  style: TextStyle(color: ColorRes.white, fontSize: 19),
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
      flex: 5,
      child: Card(
        elevation: 10,
        shape: getBorderShape(),
        margin: EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          height: double.infinity,
          decoration: getBoxDecoration(),
          child: ListView(
            shrinkWrap: true,
            primary: false,
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
                  style: TextStyle(color: ColorRes.white, fontSize: 19),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${Utils.getText(context, StringRes.my)} ${!Injector.isBusinessMode ? Utils.getText(context, StringRes.strKp) : "\$"}",
                      style: TextStyle(
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.fontGrey,
                          fontSize: 19),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "# ${Utils.getText(context, StringRes.question)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Injector.isBusinessMode
                                  ? ColorRes.white
                                  : ColorRes.fontGrey,
                              fontSize: 19),
                        ),
                      ),
                    ),
                    Text(
                      "${Utils.getText(context, StringRes.mHis)} ${!Injector.isBusinessMode ? Utils.getText(context, StringRes.strKp) : "\$"}",
                      style: TextStyle(
                          color: Injector.isBusinessMode
                              ? ColorRes.white
                              : ColorRes.fontGrey,
                          fontSize: 19),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: arrRewards.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  currentIndex = index;
                  return showRewardItem(index);
                },
              ),
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your friend will have to answer ${(arrRewards.length - currentIndex)} questions. Ifhe wins then he will earn ${arrRewards[arrRewards.length - (currentIndex + 1)].toString()}% of his total value. If you win then you will earn ${arrRewards[currentIndex]}% of your total value.",
                  style: TextStyle(color: ColorRes.white, fontSize: 19),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  _onSelectedFriend(int index) {
    if (mounted)
      setState(() {
        selectedFriendIndex = index;

        selectedFriendId = arrFriends[selectedFriendIndex].userId;

        getBusinessSectors();
      });
  }

  _onSelectedRewards(int index) {
    String message = Utils.challengeString(arrRewards.length - index,
        arrRewards[arrRewards.length - (index + 1)], arrRewards[index]);
    Utils.showLockReasonDialog(message, context, true);
    if (mounted) setState(() => selectedRewardsIndex = index);
  }

  getSelectedItemColor(int type, int index) {
    if (type == 1) {
      if (arrFriendsToShow[index].userId == selectedFriendId) {
        return Injector.isBusinessMode ? Colors.blue : ColorRes.titleBlueProf;
      } else {
        return Injector.isBusinessMode ? ColorRes.greyText : ColorRes.white;
      }
    } else {
      if (selectedRewardsIndex == index) {
        return Injector.isBusinessMode ? Colors.blue : ColorRes.titleBlueProf;
      } else {
        return Injector.isBusinessMode ? ColorRes.greyText : ColorRes.white;
      }
    }
  }

  isSelectedFriend(int index) {
    return arrFriendsToShow[index].userId == selectedFriendId;
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
          color: getSelectedItemColor(1, index),
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
                        : (isSelectedFriend(index)
                            ? ColorRes.white
                            : ColorRes.fontGrey),
                    fontSize: 17),
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
                  width: 25,
                )),
          ],
        ),
      ),
    );
  }

  _showUnFriend(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        Utils.getText(context, StringRes.no),
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        Utils.getText(context, StringRes.yes),
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.pop(context);
        arrFriendsToShow[index].isFriend = 0;
        friendUnFriendUser(index, 2);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Utils.getText(context, StringRes.alert)),
      content: Text(Utils.getText(context, StringRes.alertUnFriend),
          style: TextStyle(color: ColorRes.textProf, fontSize: 20)),
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

  showRewardItem(int index) {
    return GestureDetector(
      onTap: () {
        Utils.playClickSound();
        _onSelectedRewards(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          alignment: Alignment.center,
          width: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Injector.isBusinessMode
                ? getSelectedItemColor(2, index)
                : getSelectedItemColor(2, index),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                arrRewards[index].toString() + "%",
                style: TextStyle(
                    color: Injector.isBusinessMode
                        ? ColorRes.white
                        : isRewardSelected(index)
                            ? ColorRes.white
                            : ColorRes.fontGrey,
                    fontSize: 19),
              ),
              Expanded(
                child: Text(
                  (arrRewards.length - index).toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Injector.isBusinessMode
                          ? ColorRes.white
                          : isRewardSelected(index)
                              ? ColorRes.white
                              : ColorRes.fontGrey,
                      fontSize: 19),
                ),
              ),
              Text(
                arrRewards[arrRewards.length - (index + 1)].toString() + "%",
                style: TextStyle(
                    color: Injector.isBusinessMode
                        ? ColorRes.white
                        : isRewardSelected(index)
                            ? ColorRes.white
                            : ColorRes.fontGrey,
                    fontSize: 19),
              ),
            ],
          ),
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
            border: (selectedModuleIndex != null &&
                    selectedModuleIndex == index &&
                    !Injector.isBusinessMode)
                ? Border.all(color: ColorRes.titleBlueProf)
                : null,
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
                          fontSize: 18)),
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
                    arrLearningModules[index]
                            .moduleProgress
                            .toStringAsFixed(2) +
                        "%",
                    style: TextStyle(color: ColorRes.white, fontSize: 18),
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

  void friendUnFriendUser(int index, int action) {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    GetFriendsUnfriendReuest rq = GetFriendsUnfriendReuest();
    rq.userId = Injector.userData.userId;
    rq.requestedTo = arrFriendsToShow[index].userId;
    rq.action = action;

    WebApi().callAPI(WebApi.rqFriendUnFriendUser, rq.toJson()).then((data) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
            } else
              selectedModuleIndex = -1;
            if (mounted) setState(() {});
          }
        }).catchError((e) {
//          CommonView.showCircularProgress(false, context);
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  void sendChallenges() {
    Utils.isInternetConnectedWithAlert(context).then((isConnected) {
      if (isConnected) {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }

        SendChallengesRequest rq = SendChallengesRequest();
        rq.userId = Injector.userData.userId;
        rq.friendId = selectedFriendId;
        rq.moduleId = arrLearningModules[selectedModuleIndex].moduleId;
        rq.rewards = arrRewards[selectedRewardsIndex];

        WebApi().callAPI(WebApi.rqSendChallenge, rq.toJson()).then((data) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          if (data != null)
            Utils.showToast(
                Utils.getText(context, StringRes.alertUChallengeSent));
        }).catchError((e) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          // Utils.showToast(e.toString());
        });
      }
    });
  }

  void getSearchFriends(String searchText) {
    Utils.isInternetConnectedWithAlert(context).then((isConnected) {
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

          // Utils.showToast(e.toString());
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
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 13, left: 10),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorRes.white,
            ),
            child: Theme(
              data: ThemeData(accentColor: ColorRes.colorPrimary),
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
                  fontSize: 16,
                  color: ColorRes.hintColor,
                ),
                decoration: InputDecoration(
//                              contentPadding:  EdgeInsets.symmetric(horizontal: 5),
                  hintText: Utils.getText(context, StringRes.searchForKeywords),
                  hintStyle: TextStyle(color: ColorRes.hintColor, fontSize: 16),
                  border: InputBorder.none,
                ),
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

  showSendChallengeButton() {
    return InkResponse(
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Utils.getAssetsImg("bg_switch_to_prfsnl")),
                fit: BoxFit.fill)),
        child: Text(
          Utils.getText(context, StringRes.sendChallenge),
          style: TextStyle(color: ColorRes.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
//                  unFriend(context);
        if (selectedModuleIndex != null && selectedModuleIndex != -1)
          sendChallenges();
        else {
          Utils.showToast(Utils.getText(context, StringRes.alertNoModuleFound));
        }
      },
    );
  }
}
