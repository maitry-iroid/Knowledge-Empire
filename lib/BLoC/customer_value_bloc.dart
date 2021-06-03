import 'package:knowledge_empire/BLoC/repository.dart';
import 'package:knowledge_empire/helper/constant.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';
import 'package:knowledge_empire/models/get_customer_value.dart';
import 'package:knowledge_empire/models/releaseResource.dart';
import 'package:rxdart/rxdart.dart';

final customerValueBloc = CustomerValueBloc();

class CustomerValueBloc {
  Repository _repository = Repository();

  final _assignModuleSubject = PublishSubject<CustomerValueData>();

  Observable<CustomerValueData> get customerValue => _assignModuleSubject.stream;

  getCustomerValue(CustomerValueRequest rq) async {
    dynamic data = await _repository.getCustomerValue(rq);

    if (data != null) {
      CustomerValueData customerValueData = CustomerValueData.fromJson(data);
      await Injector.setCustomerValueData(customerValueData);

      if (customerValueData.isChallengeAvailable == 1) {
        Injector.homeStreamController?.add("${Const.openPendingChallengeDialog}");
      }

      _assignModuleSubject.add(customerValueData);
    }
  }

  setCustomerValue(CustomerValueData customerValueData) async {
    if (customerValueData != null) {
      await Injector.setCustomerValueData(customerValueData);
      _assignModuleSubject.sink.add(customerValueData);
    }
  }

  updateCustomerValue(CustomerValueData customerValueData) {
    _assignModuleSubject.sink.add(customerValueData);
  }

  releaseResource(ReleaseResourceRequest rq) async {
    dynamic data = await _repository.releaseResource(rq);

    if (data != null) {
      CustomerValueData customerValueData = CustomerValueData.fromJson(data);
      _assignModuleSubject.sink.add(customerValueData);
    }
  }

  dispose() {
    _assignModuleSubject.close();
  }
}
