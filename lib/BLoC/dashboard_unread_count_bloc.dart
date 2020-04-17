import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/get_dashboard_value.dart';
import 'package:ke_employee/models/questions.dart';
import 'package:ke_employee/models/releaseResource.dart';
import 'package:rxdart/rxdart.dart';

final dashboardUnreadCountBloc = DashboardUnreadCount();

class DashboardUnreadCount {
  final _getDashboardCountSubject = PublishSubject<List<UnreadBubbleCountData>>();

  Observable<List<UnreadBubbleCountData>> get getDashboardUnreadCount =>
      _getDashboardCountSubject.stream;

  getDashboardUnreadCountData(DashboardRequest rq) async {
    dynamic data =
        await Injector.webApi.callAPI(WebApi.rqUnreadBubbleCount, rq.toJson());

    if (data != null) {
      List<UnreadBubbleCountData> arrData = List();

      data.forEach((v) {
        arrData.add(UnreadBubbleCountData.fromJson(v));
      });

      _getDashboardCountSubject.sink.add(arrData);
    }
  }

  updateQuestions(List<UnreadBubbleCountData> arrQuestions) async {
    if (arrQuestions != null && arrQuestions.isNotEmpty) {
      _getDashboardCountSubject.sink.add(arrQuestions);
    }
  }

  dispose() {
    _getDashboardCountSubject.close();
  }
}
