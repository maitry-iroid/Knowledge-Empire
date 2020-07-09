import 'package:flutter/material.dart';
import 'package:ke_employee/BLoC/navigation_bloc.dart';
import 'package:ke_employee/BLoC/ranking_bloc.dart';
import 'package:ke_employee/dialogs/display_dailogs.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/listItem/group_item.dart';
import 'package:ke_employee/listItem/time_item.dart';
import 'package:ke_employee/models/homedata.dart';
import 'package:ke_employee/screens/home.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/friendUnfriendUser.dart';
import 'package:ke_employee/models/get_friends.dart';
import 'package:ke_employee/models/get_user_group.dart';
import '../commonview/background.dart';
import '../helper/constant.dart';

/*
*   created by Riddhi
*
*   All the users will be displayed here By Rank based on different categories here
*   User can send friend Request and can send challenge to other users. an can see the scores
*
* */


class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  int selectedLeftCategory = 0;
  int selectedGroup = 0;
  int selectedTime = 0;

  List<GetFriendsData> arrFriends = List();
  List<GetUserGroupData> arrGroups = List();

  List<String> allCategoryList = List();

  int selectedUser = -1;

  bool isCheckFriend = false;

  ScrollController _scrollController = new ScrollController();

  int present = 1;

  String searchText = "";
  int lastUserId = 0;

  var arrTime;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        present++;

        getFriends(true, true);
      } else if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        present--;

        getFriends(false, true);
      }
    });

    getData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    arrTime = [
      Utils.getText(context, StringRes.day),
      Utils.getText(context, StringRes.month),
      Utils.getText(context, StringRes.year)
    ];
    return Scaffold(
      key: _scaffoldKey,
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
        ],
      ),
    );
  }

  selectGroup(index) {
    if (index != selectedGroup) {
      if (mounted)
        setState(() {
          selectedGroup = index;
          print(selectGroup.toString());
        });
      getFriends(true, false);
    }
  }

  selectTime(index) {
    if (selectedTime != index) {
      if (mounted)
        setState(() {
          selectedTime = index;
          print(selectedTime.toString());
        });
      getFriends(true, false);
    }
  }

  showFirstColumn() {
    return Container(
      color: Injector.isBusinessMode
          ? Colors.transparent
          : ColorRes.rankingBackGround,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          showLeftItem(0, StringRes.revenue),
          showLeftItem(1, StringRes.profit),
          showLeftItem(2, StringRes.hashCustomers),
          showLeftItem(3, StringRes.brand),
        ],
      ),
    );
  }

  var arrCategory = ['World', 'Country', 'Friends'];

  final _height = 100.0;

  showSecondColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: Injector.isBusinessMode ? 50 : 30,
              child: Row(
                children: <Widget>[
                  showBack(),
                  Expanded(
                    child: StreamBuilder(
                        stream: getRankingDataBloc?.getGroups,
                        builder: (context,
                            AsyncSnapshot<List<GetUserGroupData>> snapshot) {
                          if (snapshot.hasData) {
                            arrGroups = snapshot.data;
                            return showGroups();
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return CommonView.showShimmer();
                        }),
                  ),
                  arrGroups.length > 4
                      ? Icon(
                          Icons.chevron_right,
                          color: Injector.isBusinessMode
                              ? Colors.white
                              : ColorRes.titleBlueProf,
                          size: 22.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        )
                      : Container(),
                  arrGroups.length > 4
                      ? Container(
                          height: 20,
                          width: 1,
                          color: ColorRes.fontGrey,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                        )
                      : Container(),
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
                InkResponse(
                  child: Container(
                      width: 35,
                      height: 35,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
//        padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Utils.getAssetsImg(
                                  Injector.isBusinessMode
                                      ? "bg_you"
                                      : "bg_pro_you")),
                              fit: BoxFit.fill)),
                      child: Text(
                        Utils.getText(context, StringRes.you),
                        style: TextStyle(color: ColorRes.white, fontSize: 15),
                      )),
                  onTap: () {
                    int index = arrFriends.indexOf(arrFriends.firstWhere(
                        (friend) => friend.userId == Injector.userData.userId));

                    _scrollController.animateTo(_height * index,
                        duration: Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn);
                  },
                ),
                Expanded(
                  flex: 15,
                  child: Container(
                    height: 30,
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Utils.getAssetsImg(
                                Injector.isBusinessMode
                                    ? "bg_ranking_header"
                                    : "bg_pro_ranking_header")),
                            fit: BoxFit.fill)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              Utils.getText(context, StringRes.name),
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                              Utils.getText(context, StringRes.companyName),
                              style: TextStyle(
                                  color: ColorRes.white, fontSize: 15),
                              maxLines: 1,
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(Utils.getText(context, StringRes.score),
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
                    padding: EdgeInsets.only(left: 3, right: 3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Utils.getAssetsImg(
                                Injector.isBusinessMode
                                    ? "bg_ranking_header_1"
                                    : "bg_pro_ranking_header_1")),
                            fit: BoxFit.fill)),
                    child: Text(
                      Utils.getText(context, StringRes.challenges),
                      style: TextStyle(color: ColorRes.white, fontSize: 15),
                      maxLines: 1,
                      textAlign: TextAlign.center,
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
                            image: AssetImage(Utils.getAssetsImg(
                                Injector.isBusinessMode
                                    ? "bg_ranking_header_1"
                                    : "bg_pro_ranking_header_1")),
                            fit: BoxFit.fill)),
                    child: Text(
                      Utils.getText(context, StringRes.friend),
                      style: TextStyle(color: ColorRes.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: showFriends(),
          )
        ],
      ),
    );
  }

  showBack() {
    return InkResponse(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Image(
          image: AssetImage(Utils.getAssetsImg("back")),
          width: 22,
        ),
      ),
      onTap: () {
        Utils.playClickSound();
        Utils.performBack(context);
      },
    );
  }

  showFriendItem(int index) {
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
    return AssetImage(Utils.getAssetsImg(Injector.isBusinessMode
        ? selectedLeftCategory != index ? "ranking_bg_gray" : "rankinf_bg_blue"
        : selectedLeftCategory != index
            ? "ranking_bg_pro_deselected"
            : "ranking_bg_pro_selected"));
  }

  showLeftItem(int index, String title) {
    return Expanded(
      flex: 1,
      child: InkResponse(
        onTap: () {
          if (selectedLeftCategory != index) {
            if (mounted)
              setState(() {
                Utils.playClickSound();
                selectedLeftCategory = index;
              });

            getFriends(true, false);
          }
        },
        child: Container(
//          width: Utils.getDeviceHeight(context)/5,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: <Widget>[
              Container(
                height: Utils.getDeviceHeight(context) / 7,
                width: Utils.getDeviceHeight(context) / 7,
                padding: Injector.isBusinessMode
                    ? EdgeInsets.all(15)
                    : EdgeInsets.all(15),
                margin: Injector.isBusinessMode
                    ? EdgeInsets.all(0)
                    : EdgeInsets.all(2),
                decoration: BoxDecoration(
                    image: DecorationImage(image: getBgImage(index))),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Image(
                      image:
                          AssetImage(Utils.getAssetsImg(getInnerImage(index))),
                    )),
                    Container()
                  ],
                ),
              ),
              Text(
                Utils.getText(context, title),
                style: TextStyle(color: ColorRes.white, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              )
            ],
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

  getUserGroups() async {
    GetUserGroupRequest rq = GetUserGroupRequest();
    rq.userId = Injector.userData.userId;

    await getRankingDataBloc.getUserGroupData(rq, context);
  }

  getFriends(bool isScrollDown, bool isToAddData) async {
    print("present__" + present.toString());

    if (await Utils.isInternetConnectedWithAlert()) {
      CommonView.showCircularProgress(true, _scaffoldKey.currentContext);

      if (!isToAddData) arrFriends.clear();

      GetFriendsRequest rq = GetFriendsRequest();
      rq.userId = Injector.userData.userId;
      rq.category = selectedLeftCategory + 1;
      rq.scrollType = isScrollDown ? 1 : 0;
      rq.searchBy = selectedGroup >= 0 && selectedGroup <= 1
          ? selectedGroup + 1
          : arrGroups[selectedGroup].groupId;
      rq.filter = selectedTime + 1;
      rq.lastUserId = arrFriends.length > 0
          ? isScrollDown ? arrFriends.last.userId : arrFriends.first.userId
          : 0;

      await WebApi().callAPI(WebApi.rqGetFriends, rq.toJson()).then((data) {
        CommonView.showCircularProgress(false, _scaffoldKey.currentContext);
        if (data != null) {
          List<GetFriendsData> arrFriendsData = List();

          data.forEach((v) {
            arrFriendsData.add(GetFriendsData.fromJson(v));
          });

          if (arrFriendsData.isNotEmpty) {
            if (isToAddData) {
              arrFriends.addAll(arrFriendsData);
            } else
              arrFriends = arrFriendsData;
            if (mounted) setState(() {});
          }
        }
      }).catchError((e) {
        CommonView.showCircularProgress(false, _scaffoldKey.currentContext);
      });
    }
  }

  void friendUnFriendUser(int index, int i) async {
    if (await Utils.isInternetConnectedWithAlert()) {
//    CommonView.showCircularProgress(true, _scaffoldKey.currentContext);

      GetFriendsUnfriendReuest rq = GetFriendsUnfriendReuest();
      rq.userId = Injector.userId;
      rq.requestedTo = arrFriends[index].userId;
      rq.action = i;

      WebApi()
          .callAPI(WebApi.rqFriendUnFriendUser, rq.toJson())
          .then((response) {
//      CommonView.showCircularProgress(false, _scaffoldKey.currentContext);

        if (response != null) {
          if (i == 1) {
            Utils.showToast(Utils.getText(context, StringRes.addFriend));
          } else {
            Utils.showToast(Utils.getText(context, StringRes.unFriend));
          }
        }
      }).catchError((e) {
//      CommonView.showCircularProgress(false, _scaffoldKey.currentContext);
      });
    }
  }

  showChallengeButton(int index) {
    return Expanded(
      flex: 3,
      child: InkResponse(
        child: Image(
            height: Utils.getDeviceWidth(context) / 20,
            width: Utils.getDeviceWidth(context) / 20,
            image: AssetImage(Utils.getAssetsImg(isCurrentUser(index)
                ? "ic_challenge_disable"
                : (arrFriends[index].isFriend == 0
                    ? 'ic_challenge_disable'
                    : 'ic_challenge')))),
        onTap: () {
          if (!isCurrentUser(index)) {
            if (arrFriends[index].isFriend == 1) {
              HomeData homeData = HomeData(
                  arrFriends: arrFriends,
                  initialPageType: Const.typeChallenges,
                  friendId: arrFriends[index].userId);

//              Navigator.push(context, FadeRouteHome(homeData: homeData));
navigationBloc.updateNavigation(homeData);
              print(arrFriends[index].isFriend);
            }
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
          Utils.playClickSound();

          if (!isCurrentUser(index)) {
            if (mounted)
              setState(() {
                if (arrFriends[index].isFriend == 0) {
                  arrFriends[index].isFriend = 1;
                  friendUnFriendUser(index, 1);
                } else {
//                  unFriend(context, index);

                  _showUnFriend(context, index);
                }
              });
          }
        },
        child: Image(
            height: Utils.getDeviceWidth(context) / 20,
            width: Utils.getDeviceWidth(context) / 20,
            image: AssetImage(Utils.getAssetsImg(isCurrentUser(index)
                ? "add_frnd_disable"
                : selectedUser != null && arrFriends[index].isFriend == 0
                    ? 'add_emplyee'
                    : 'remove_friend'))),
      ),
    );
  }

  showUserDetails(int index) {
    return Expanded(
      flex: 16,
      child: Container(
        padding: EdgeInsets.only(top: isCurrentUser(index) ? 0 : 8, left: 4),
        margin: EdgeInsets.only(
            top: isCurrentUser(index) ? 4 : 0, left: 4, bottom: 0),
        decoration: BoxDecoration(
            image: isCurrentUser(index)
                ? DecorationImage(
                    image: AssetImage(Utils.getAssetsImg("bg_ranking_header")),
                    fit: BoxFit.fill)
                : null),
        /*  decoration: isCurrentUser(index)
            ? BoxDecoration(
                border: Border.all(
                    color: Injector.isBusinessMode
                        ? ColorRes.white
                        : ColorRes.titleBlueProf),
                borderRadius: BorderRadius.circular(20),
              )
            : null,*/
        child: Container(
          width: Utils.getDeviceWidth(context) / 12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCurrentUser(index)
                ? Injector.isBusinessMode ? null : null
                : Injector.isBusinessMode ? ColorRes.white : ColorRes.white,
            borderRadius: BorderRadius.circular(30),
          ),
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
                    RotatedBox(
                        quarterTurns: arrFriends[index].rate == "down" ? 2 : 4,
                        child: Image(
                          image: AssetImage(Utils.getAssetsImg('arrow_green')),
                          width: 15,
                          color: arrFriends[index].rate == "down"
                              ? ColorRes.red
                              : ColorRes.greenDot,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 25,
                      child: Text((index + 1).toString() + ".",
                          maxLines: 1,
                          style: TextStyle(
                            color: isCurrentUser(index)
                                ? ColorRes.white
                                : ColorRes.textBlue,
                            fontSize: 17,
                          )),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: currentUserProfileShow(index),
                            fit: BoxFit.cover
//                                AssetImage(Utils.getAssetsImg('add_emplyee'))

                            ),
                      ),
                    ),
                    Expanded(
                      child: Text(arrFriends[index].name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: isCurrentUser(index)
                                  ? ColorRes.white
                                  : ColorRes.textBlue,
                              fontSize: 17),
                          textAlign: TextAlign.left),
                    ),
                  ],
                ),
              ),
              Container(
                color:
                    isCurrentUser(index) ? ColorRes.white : ColorRes.greyText,
                width: 1,
                margin: EdgeInsets.only(
                    top: isCurrentUser(index) ? 10 : 6,
                    bottom: isCurrentUser(index) ? 10 : 6),
              ),
              Expanded(
                flex: 3,
                child: Text(arrFriends[index].companyName ?? "",
                    maxLines: 1,
                    style: TextStyle(
                        color: isCurrentUser(index)
                            ? ColorRes.white
                            : ColorRes.greyText,
                        fontSize: 17),
                    textAlign: TextAlign.center),
              ),
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(
                  top: isCurrentUser(index) ? 2 : 0,
                  bottom: isCurrentUser(index) ? 0 : 0,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      Injector.isBusinessMode ? null : ColorRes.titleBlueProf,
                  borderRadius: Injector.isBusinessMode
                      ? null
                      : BorderRadius.all(Radius.circular(25)),
                  border: Injector.isBusinessMode
                      ? null
                      : Border.all(width: 2, color: ColorRes.rankingProValueBg),
                  image: DecorationImage(
                      image: AssetImage(Utils.getAssetsImg(
                          Injector.isBusinessMode ? 'value' : '')),
                      fit: BoxFit.fill),
                ),
                child: Text(
                  arrFriends[index].score != null
                      ? arrFriends[index].score.toString()
                      : "0",
                  style: TextStyle(
                    color: ColorRes.white,
                    fontSize: 17,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  currentUserProfileShow(int index) {
    /* if (isCurrentUser(index)) {
      if (Injector.userData == null ||
          Injector.userData.profileImage == null ||
          Injector.userData.profileImage.isEmpty) {
        return AssetImage(Utils.getAssetsImg('add_emplyee'));
      } else {
        return Utils.getCacheNetworkImage(Injector.userData.profileImage);
      }
    } else {
      return AssetImage(Utils.getAssetsImg('add_emplyee'));
    }*/

//    arrFriends

    if (Injector.userData == null ||
        Injector.userData.profileImage.isEmpty ||
        arrFriends[index].profileImage == null ||
        arrFriends[index].profileImage.isEmpty) {
      return AssetImage(Utils.getAssetsImg('add_emplyee'));
    } else {
      return Utils.getCacheNetworkImage(arrFriends[index].profileImage);
    }
  }

  isCurrentUser(int index) {
    return arrFriends.length > 0 &&
        arrFriends[index].userId == Injector.userData.userId;
  }

  void getData() async {
    if (Injector.introData == null || Injector.introData.ranking1 == 0)
      await DisplayDialogs.showMarketingAndCommunications(context);

    bool isConnected = await Utils.isInternetConnectedWithAlert();

    if (isConnected) {
      await getUserGroups();
      await getFriends(true, false);
    }
  }

  _showUnFriend(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(Utils.getText(context, StringRes.no)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(Utils.getText(context, StringRes.yes)),
      onPressed: () {
        arrFriends[index].isFriend = 0;
        friendUnFriendUser(index, 2);
        setState(() {});
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Utils.getText(context, StringRes.alert)),
      content: Text(
        Utils.getText(context, StringRes.alertUnFriend),
        style: TextStyle(color: ColorRes.textProf),
      ),
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

  showGroups() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: arrGroups.length,
      itemBuilder: (BuildContext context, int index) {
        return GroupItem(
          selectGroup,
          index: index,
          isSelected: selectedGroup == index ? true : false,
          title: arrGroups[index].name != null ? arrGroups[index].name : "",
        );
      },
    );
  }

  showFriends() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: arrFriends.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        return showFriendItem(index);
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
//                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                    arrFriends[index].isFriend = 0;
                                    friendUnFriendUser(index, 2);
                                    setState(() {
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
//                            Padding(padding: EdgeInsets.only(top: 13)),
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

}
