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

  final _getQuestionSubject = PublishSubject<List<QuestionData>>();

  Observable<List<QuestionData>> get getQuestions => _getQuestionSubject.stream;

  getQuestion(QuestionRequest rq) async {
    bool isInternetConnected = await Utils.isInternetConnected();
    List<QuestionData> arrQuestions = List();
    if (isInternetConnected) {
      dynamic data = await Injector.webApi.callAPI(WebApi.rqGetQuestions_v2, rq.toJson());
      if (data != null) {
        data.forEach((v) {
          arrQuestions.add(QuestionData.fromJson(v));
        });

        if (rq.type == Const.getNewQueType) {
          for (int i = 0; i < arrQuestions.length; i++) {
            arrQuestions[i].value = Utils.getValue(arrQuestions[i]);
            arrQuestions[i].loyalty = Utils.getLoyalty(arrQuestions[i]);
            arrQuestions[i].resources = Utils.getResource(arrQuestions[i]);
          }
        }
      }

      _getQuestionSubject.sink.add(arrQuestions);
    }else {
      arrQuestions = Utils.getQuestionsLocally(Const.getExistingQueType);
      _getQuestionSubject.sink.add(arrQuestions);
      print(arrQuestions);
    }
  }

  updateQuestions(List<QuestionData> arrQuestions){
    _getQuestionSubject.sink.add(arrQuestions);
  }

  dispose() {
    _getQuestionSubject.close();
  }
}
