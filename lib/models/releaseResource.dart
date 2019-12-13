class ReleaseResourceRequest {
  String userId;
  int questionId;
  int moduleId;
  int resources;
  int value;

  ReleaseResourceRequest(
      {this.userId,
        this.questionId,
        this.moduleId,
        this.resources,
        this.value});

  ReleaseResourceRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    questionId = json['questionId'];
    moduleId = json['moduleId'];
    resources = json['resources'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['questionId'] = this.questionId;
    data['moduleId'] = this.moduleId;
    data['resources'] = this.resources;
    data['value'] = this.value;
    return data;
  }
}


class ReleaseResourceResponse {
  String flag;
  String result;
  String msg;
  ReleaseResourceData data;

  ReleaseResourceResponse({this.flag, this.result, this.msg, this.data});

  ReleaseResourceResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null ? new ReleaseResourceData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ReleaseResourceData {
  int totalEmployeeCapacity;
  int remainingEmployeeCapacity;
  int totalBalance;
  int loyaltyBonus;
  int valueBonus;
  int resourceBonus;
  int totalAttemptedQuestion;
  List<Organization> organization;
  int totalAttemptedquestion;

  ReleaseResourceData(
      {this.totalEmployeeCapacity,
        this.remainingEmployeeCapacity,
        this.totalBalance,
        this.loyaltyBonus,
        this.valueBonus,
        this.resourceBonus,
        this.totalAttemptedQuestion,
        this.organization,
        this.totalAttemptedquestion});

  ReleaseResourceData.fromJson(Map<String, dynamic> json) {
    totalEmployeeCapacity = json['totalEmployeeCapacity'];
    remainingEmployeeCapacity = json['remainingEmployeeCapacity '];
    totalBalance = json['totalBalance'];
    loyaltyBonus = json['loyaltyBonus'];
    valueBonus = json['valueBonus'];
    resourceBonus = json['resourceBonus'];
    totalAttemptedQuestion = json['totalAttemptedQuestion'];
    if (json['organization'] != null) {
      organization = new List<Organization>();
      json['organization'].forEach((v) {
        organization.add(new Organization.fromJson(v));
      });
    }
    totalAttemptedquestion = json['totalAttemptedquestion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalEmployeeCapacity'] = this.totalEmployeeCapacity;
    data['remainingEmployeeCapacity '] = this.remainingEmployeeCapacity;
    data['totalBalance'] = this.totalBalance;
    data['loyaltyBonus'] = this.loyaltyBonus;
    data['valueBonus'] = this.valueBonus;
    data['resourceBonus'] = this.resourceBonus;
    data['totalAttemptedQuestion'] = this.totalAttemptedQuestion;
    if (this.organization != null) {
      data['organization'] = this.organization.map((v) => v.toJson()).toList();
    }
    data['totalAttemptedquestion'] = this.totalAttemptedquestion;
    return data;
  }
}

class Organization {
  int type;
  int remainingEmpCount;

  Organization({this.type, this.remainingEmpCount});

  Organization.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    remainingEmpCount = json['remainingEmpCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['remainingEmpCount'] = this.remainingEmpCount;
    return data;
  }
}
