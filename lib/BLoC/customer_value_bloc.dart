import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/releaseResource.dart';
import 'package:rxdart/rxdart.dart';

final customerValueBloc = CustomerValueBloc();

class CustomerValueBloc {
  Repository _repository = Repository();

  final _assignModuleSubject = PublishSubject<CustomerValueData>();

  Observable<CustomerValueData> get customerValue =>
      _assignModuleSubject.stream;

  getCustomerValue(CustomerValueRequest rq) async {
    dynamic data = await _repository.getCustomerValue(rq);

    if (data != null) {
      CustomerValueData customerValueData = CustomerValueData.fromJson(data);
      await Injector.setCustomerValueData(customerValueData);

      if (customerValueData.isChallengeAvailable == 1) {
        Injector.homeStreamController
            ?.add("${Const.openPendingChallengeDialog}");
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
