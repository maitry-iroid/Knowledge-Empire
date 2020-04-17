import 'package:flutter/cupertino.dart';
import 'package:ke_employee/models/questions.dart';

import 'get_friends.dart';

class HomeData {
  Widget page;
  String initialPageType;
  QuestionData questionDataHomeScr;
  QuestionData questionDataSituation;
  QuestionData questionDataChallenge;
  int value;
  int friendId;
  bool isChallenge;
  bool isCameFromDashboard;
  bool isCameFromNewCustomer;
  List<GetFriendsData> arrFriends = List();

  HomeData({
    this.page,
    this.initialPageType,
    this.questionDataHomeScr,
    this.questionDataSituation,
    this.questionDataChallenge,
    this.value,
    this.friendId,
    this.isChallenge,
    this.isCameFromDashboard,
    this.isCameFromNewCustomer,
    this.arrFriends,
  });
}
