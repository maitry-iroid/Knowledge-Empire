import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/get_learning_module.dart';

class Repository {
  WebApi webApi = WebApi();

  Future<LearningModuleResponse> fetchModule(int isChallenge) =>
      webApi.getLearningModule(Injector.userData.userId, isChallenge);
}
