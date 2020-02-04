import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:ke_employee/models/login.dart';
import 'package:ke_employee/models/releaseResource.dart';
import 'package:rxdart/rxdart.dart';

final moduleBloc = ModuleBloc();
final customerValueBloc = CustomerValueBloc();

class ModuleBloc {
  Repository _repository = Repository();

  final _moduleFetcher = PublishSubject<LearningModuleResponse>();

  Observable<LearningModuleResponse> get modules => _moduleFetcher.stream;

  fetchModules(int isChallenge) async {
    LearningModuleResponse learningModuleResponse =
        await _repository.fetchModule(isChallenge);
    _moduleFetcher.sink.add(learningModuleResponse);
  }

  dispose() {
    _moduleFetcher.close();
  }
}

class CustomerValueBloc {
  Repository _repository = Repository();

  final _assignModuleSubject = PublishSubject<GetCustomerValueResponse>();

  Observable<GetCustomerValueResponse> get customerValue =>
      _assignModuleSubject.stream;

  getCustomerValue(CustomerValueRequest rq) async {
    GetCustomerValueResponse getCustomerValueResponse =
        await _repository.getCustomerValue(rq);
    _assignModuleSubject.sink.add(getCustomerValueResponse);
  }

  bailOut(BailOutRequest rq) async {
    GetCustomerValueResponse getCustomerValueResponse =
        await _repository.bailOut(rq);
    _assignModuleSubject.sink.add(getCustomerValueResponse);
  }

  releaseResource(ReleaseResourceRequest rq) async {
    GetCustomerValueResponse getCustomerValueResponse =
        await _repository.releaseResource(rq);

    if (getCustomerValueResponse.flag == "true") {
      if (getCustomerValueResponse.data != null)
        _assignModuleSubject.sink.add(getCustomerValueResponse);
      else
        Utils.showToast("Something went wrong");
    } else
      Utils.showToast(getCustomerValueResponse.msg ?? "");
  }

  dispose() {
    _assignModuleSubject.close();
  }
}
