import 'package:knowledge_empire/commonview/challenge_header.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:rxdart/rxdart.dart';

final getChallengeQueBloc = GetChallengeQueBloc();

class GetChallengeQueBloc {
  final _getChallengeQuestion = PublishSubject<List<QuestionCountWithData>>();

  Stream<List<QuestionCountWithData>> get getChallenge => _getChallengeQuestion.stream;

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
