import 'package:flutter/cupertino.dart';
import 'package:knowledge_empire/models/questions.dart';

import 'get_friends.dart';

class HomeData {
  Widget page;
  String initialPageType;
  QuestionData questionHomeData;
  int value;
  int friendId;
  bool isChallenge;
  bool isCameFromNewCustomer;
  bool isReadyForChallenge;
  List<GetFriendsData> arrFriends = List();

  HomeData({
    this.page,
    this.initialPageType,
    this.questionHomeData,
    this.value,
    this.friendId,
    this.isChallenge,
    this.isReadyForChallenge,
    this.isCameFromNewCustomer,
    this.arrFriends,
  });
}
