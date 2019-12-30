class GetOrganizationRequest {
  int userId;
  int mode;

  GetOrganizationRequest({this.userId});

  GetOrganizationRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['mode'] = this.mode;
    return data;
  }
}

class GetOrganizationResponse {
  String flag;
  String result;
  String msg;
  OrganizationData data;

  GetOrganizationResponse({this.flag, this.result, this.msg, this.data});

  GetOrganizationResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null
        ? new OrganizationData.fromJson(json['data'])
        : null;
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

class OrganizationData {
  int totalEmpCount;
  int totalBalance;
  List<Organization> organization;

  OrganizationData({this.totalEmpCount, this.totalBalance, this.organization});

  OrganizationData.fromJson(Map<String, dynamic> json) {
    totalEmpCount = json['totalEmpCount'];
    totalBalance = json['totalBalance'];
    if (json['organization'] != null) {
      organization = new List<Organization>();
      json['organization'].forEach((v) {
        organization.add(new Organization.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalEmpCount'] = this.totalEmpCount;
    data['totalBalance'] = this.totalBalance;
    if (this.organization != null) {
      data['organization'] = this.organization.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Organization {
  int type;
  String name;
  int level;
  String description;
  String subtractLevelConfirmMessage;
  String addLevelConfirmMessage;
  int employeeCount;
  int nextLevelCost;

  Organization(
      {this.type,
        this.name,
        this.level,
        this.description,
        this.subtractLevelConfirmMessage,
        this.addLevelConfirmMessage,
        this.employeeCount,
        this.nextLevelCost});

  Organization.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    level = json['level'];
    description = json['description'];
    subtractLevelConfirmMessage = json['subtractLevelConfirmMessage'];
    addLevelConfirmMessage = json['addLevelConfirmMessage'];
    employeeCount = json['employeeCount'];
    nextLevelCost = json['nextLevelCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['level'] = this.level;
    data['description'] = this.description;
    data['subtractLevelConfirmMessage'] = this.subtractLevelConfirmMessage;
    data['addLevelConfirmMessage'] = this.addLevelConfirmMessage;
    data['employeeCount'] = this.employeeCount;
    data['nextLevelCost'] = this.nextLevelCost;
    return data;
  }
}
