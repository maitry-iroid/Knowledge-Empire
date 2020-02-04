import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/models/releaseResource.dart';

class Repository {
  WebApi webApi = WebApi();

  Future<LearningModuleResponse> fetchModule(int isChallenge) =>
      webApi.getLearningModule(Injector.userData.userId, isChallenge);

  Future<LoginResponse> assignUserToModule(
          int moduleId, String type, int companyId) =>
      webApi.assignUserToModule(moduleId, type, companyId);

  Future<GetCustomerValueResponse> getCustomerValue(CustomerValueRequest rq) =>
      webApi.getCustomerValue(rq);

  Future<GetCustomerValueResponse> bailOut(BailOutRequest rq) =>
      webApi.bailOut(rq);

  Future<GetCustomerValueResponse> releaseResource(ReleaseResourceRequest rq) =>
      webApi.releaseResource(rq);
}
