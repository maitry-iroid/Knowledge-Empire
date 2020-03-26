import 'package:flutter/cupertino.dart';
import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_friends.dart';
import 'package:ke_employee/models/get_user_group.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/models/releaseResource.dart';
import 'package:rxdart/rxdart.dart';

final getRankingDataBloc = GetRankingDataBloc();

class GetRankingDataBloc {
  Repository _repository = Repository();

  final _getGroupSubject = PublishSubject<List<GetUserGroupData>>();
  final _getFriendsSubject = PublishSubject<List<GetFriendsData>>();

  Observable<List<GetUserGroupData>> get getGroups => _getGroupSubject.stream;
  Observable<List<GetFriendsData>> get getFriends => _getFriendsSubject.stream;
//
//  getFriendsData(GetFriendsRequest rq) async {
//    bool isInternetConnected = await Utils.isInternetConnectedWithAlert();
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
    bool isInternetConnected = await Utils.isInternetConnectedWithAlert();
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
      dynamic data =
          await Injector.webApi.callAPI(WebApi.rqGetUserGroups, rq.toJson());

      if (data != null) {
        data.forEach((v) {
          arrGroups.add(GetUserGroupData.fromJson(v));
        });
      }
    }
    if (arrGroups != null && arrGroups.isNotEmpty)
      _getGroupSubject.sink.add(arrGroups);
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
