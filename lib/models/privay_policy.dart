import 'package:ke_employee/helper/web_api.dart';

class PrivacyPolicyRequest {
  int userId;
  String type;
  int companyId;

  PrivacyPolicyRequest({this.userId, this.type, this.companyId});

  PrivacyPolicyRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    type = json['type'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['companyId'] = this.companyId;
    return data;
  }
}


class PrivacyPolicyResponse {
  String language;
  int isSeenPrivacyPolicy;
  String privacyPolicyTitle;
  String privacyPolicyContent;

  PrivacyPolicyResponse({this.language, this.isSeenPrivacyPolicy, this.privacyPolicyTitle, this.privacyPolicyContent});

  PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    isSeenPrivacyPolicy= json['isSeenPrivacyPolicy'];
    privacyPolicyTitle = json['privacyPolicyTitle'];
    privacyPolicyContent = json['privacyPolicyContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['isSeenPrivacyPolicy'] = this.isSeenPrivacyPolicy;
    data['privacyPolicyTitle'] = this.privacyPolicyTitle;
    data['privacyPolicyContent'] = this.privacyPolicyContent;
    return data;
  }
}

apiCallPrivacyPolicy(int userId, String type, int companyId, void Function(PrivacyPolicyResponse) completion){

  PrivacyPolicyRequest rq = PrivacyPolicyRequest();
  rq.userId = userId;
  rq.type = type;
  rq.companyId = companyId;

  WebApi().callAPI(WebApi.rqPrivacyPolicy, rq.toJson()).then((data) {

    if (data != null) {
      PrivacyPolicyResponse response = PrivacyPolicyResponse.fromJson(data);
      completion(response);
    }
  });
}