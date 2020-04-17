import 'package:ke_employee/helper/web_api.dart';
import 'package:ke_employee/models/bailout.dart';
import 'package:ke_employee/models/get_customer_value.dart';
import 'package:ke_employee/models/releaseResource.dart';

class Repository {
  WebApi webApi = WebApi();

  Future<dynamic> getCustomerValue(CustomerValueRequest rq) =>
      webApi.callAPI(WebApi.rqGetCustomerValue, rq.toJson());

  Future<dynamic> bailOut(BailOutRequest rq) =>
      webApi.callAPI(WebApi.rqBailOut, rq.toJson());

  Future<dynamic> releaseResource(ReleaseResourceRequest rq) =>
      webApi.callAPI(WebApi.rqReleaseResource, rq.toJson());
}

