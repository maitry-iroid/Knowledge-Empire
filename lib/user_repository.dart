import 'package:ke_employee/helper/web_api.dart';

import 'models/get_learning_module.dart';

class UserRepository{
  WebApi _apiProvider = WebApi();

  Future<LearningModuleResponse> getUser(){
    return _apiProvider.getLearningModule();
  }
}