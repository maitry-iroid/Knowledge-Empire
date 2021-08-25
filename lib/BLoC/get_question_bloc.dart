import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:rxdart/rxdart.dart';

final getQuestionsBloc = GetQuestionsBloc();

class GetQuestionsBloc {
  Repository _repository = Repository();

  final getQuestionSubject = PublishSubject<List<QuestionData>>();

  Stream<List<QuestionData>> get getQuestions => getQuestionSubject.stream;

  Future<List<QuestionData>> getQuestion(QuestionRequest rq) async {
    bool isInternetConnected = await Utils.isInternetConnected();
    List<QuestionData> arrQuestions = [];
    if (isInternetConnected) {
      var data = await Injector.webApi.callAPI(WebApi.rqGetQuestions_v2, rq.toJson());
      if (data != null) {
        arrQuestions = (data as List).map((i) => QuestionData.fromJson(i)).toList();

        if (rq.type == Const.getNewQueType) {
          for (int i = 0; i < arrQuestions.length; i++) {
            arrQuestions[i].value = Utils.getValue(arrQuestions[i]);
            arrQuestions[i].loyalty = Utils.getLoyalty(arrQuestions[i]);
            arrQuestions[i].resources = Utils.getResource(arrQuestions[i]);
          }
        }
      }

      getQuestionSubject.sink.add(arrQuestions);
    } else {
      arrQuestions = Utils.getQuestionsLocally(Const.getExistingQueType);
      getQuestionSubject.sink.add(arrQuestions);
      print(arrQuestions);
    }
    print("=========");
    print(arrQuestions.length);
    return arrQuestions;
  }

  updateQuestions(List<QuestionData> arrQuestions) {
    getQuestionSubject.sink.add(arrQuestions);
  }

  dispose() {
    getQuestionSubject.close();
  }
}
