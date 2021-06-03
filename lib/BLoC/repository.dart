import 'package:knowledge_empire/helper/web_api.dart';
import 'package:knowledge_empire/models/bailout.dart';
import 'package:knowledge_empire/models/get_customer_value.dart';
import 'package:knowledge_empire/models/releaseResource.dart';
import 'package:knowledge_empire/helper/web_api.dart';

class Repository {
  WebApi webApi = WebApi();

  Future<dynamic> getCustomerValue(CustomerValueRequest rq) => webApi.callAPI(WebApi.rqGetCustomerValue, rq.toJson());

  Future<dynamic> bailOut(BailOutRequest rq) => webApi.callAPI(WebApi.rqBailOut, rq.toJson());

  Future<dynamic> releaseResource(ReleaseResourceRequest rq) => webApi.callAPI(WebApi.rqReleaseResource, rq.toJson());
}
