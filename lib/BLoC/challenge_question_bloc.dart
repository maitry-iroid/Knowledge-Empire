import 'dart:ui';

import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/commonview/challenge_header.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/models/releaseResource.dart';
import 'package:rxdart/rxdart.dart';

final getChallengeQueBloc = GetChallengeQueBloc();

class GetChallengeQueBloc {
  final _getChallengeQuestion = PublishSubject<List<QuestionCountWithData>>();

  Observable<List<QuestionCountWithData>> get getChallenge =>
      _getChallengeQuestion.stream;

  Future getChallengeQuestion() {
    _getChallengeQuestion.sink.add(Injector.countList);
    return Future.value(_getChallengeQuestion);
  }

  updateQuestions(int index, bool isCorrect) async {
    int newIndex = 0;
    if (index != null) {
      newIndex = index;
      Injector.countList[newIndex].isCorrect = isCorrect;
    }
    _getChallengeQuestion.sink.add(Injector.countList);
  }

  dispose() {
    _getChallengeQuestion.close();
  }
}
