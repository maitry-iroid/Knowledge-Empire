import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/commonview/challenge_header.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
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

  getChallengeQuestion() {
    _getChallengeQuestion.sink.add(Injector.countList);
  }

  updateQuestions(List<QuestionData> arrQuestions) async {
    _getChallengeQuestion.sink.add(Injector.countList);
  }

  dispose() {
    _getChallengeQuestion.close();
  }
}
