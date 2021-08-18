import 'package:flutter/cupertino.dart';
import 'package:knowledge_empire/BLoC/repository.dart';
import 'package:knowledge_empire/helper/Utils.dart';
import 'package:knowledge_empire/helper/string_res.dart';
import 'package:knowledge_empire/helper/web_api.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:knowledge_empire/models/get_friends.dart';
import 'package:knowledge_empire/models/get_user_group.dart';
import 'package:rxdart/rxdart.dart';

final getRankingDataBloc = GetRankingDataBloc();

class GetRankingDataBloc {
  Repository _repository = Repository();

  final _getGroupSubject = PublishSubject<List<GetUserGroupData>>();
  final _getFriendsSubject = PublishSubject<List<GetFriendsData>>();

  Stream<List<GetUserGroupData>> get getGroups => _getGroupSubject.stream;
  Stream<List<GetFriendsData>> get getFriends => _getFriendsSubject.stream;
//
//  getFriendsData(GetFriendsRequest rq) async {
//    bool isInternetConnected = await Utils.isInternetConnectedWithAlert(context);
//
//    List<GetUserGroupData> arrGroups = List();
//
//    if (isInternetConnected) {
//      dynamic data =
//      await Injector.webApi.callAPI(WebApi., rq.toJson());
//
//      if (data != null) {
//        data.forEach((v) {
//          arrGroups.add(GetUserGroupData.fromJson(v));
//        });
//      }
//    }
//    if (arrGroups != null && arrGroups.isNotEmpty)
//      _getGroupSubject.sink.add(arrGroups);
//  }

  getUserGroupData(GetUserGroupRequest rq, BuildContext context) async {
    bool isInternetConnected = await Utils.isInternetConnectedWithAlert(context);
    List<GetUserGroupData> arrGroups = List();

    GetUserGroupData grp1 = GetUserGroupData();
    grp1.groupId = 1;
    grp1.name = Utils.getText(context, StringRes.world);
    GetUserGroupData grp2 = GetUserGroupData();
    grp2.groupId = 2;
    grp2.name = Utils.getText(context, StringRes.country);
    GetUserGroupData grp3 = GetUserGroupData();
    grp3.groupId = 3;
    grp3.name = Utils.getText(context, StringRes.friends);

    arrGroups.add(grp1);
    arrGroups.add(grp2);
    arrGroups.add(grp3);

    if (isInternetConnected) {
      dynamic data = await Injector.webApi.callAPI(WebApi.rqGetUserGroups, rq.toJson());

      if (data != null) {
        data.forEach((v) {
          arrGroups.add(GetUserGroupData.fromJson(v));
        });
      }
    }
    if (arrGroups != null && arrGroups.isNotEmpty) _getGroupSubject.sink.add(arrGroups);
  }

//  updateQuestions(List<QuestionData> arrQuestions) async {
//    if (arrQuestions != null && arrQuestions.isNotEmpty) {
//      _getQuestionSubject.sink.add(arrQuestions);
//    }
//  }

  dispose() {
    _getGroupSubject.close();
    _getFriendsSubject.close();
  }
}
