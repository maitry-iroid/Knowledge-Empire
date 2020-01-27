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

class OrganizationResponse {
  String flag;
  String result;
  String msg;
  OrganizationData data;

  OrganizationResponse({this.flag, this.result, this.msg, this.data});

  OrganizationResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null ? new OrganizationData.fromJson(json['data']) : null;
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
  int totalEmployeeCapacity;
  int remainingEmployeeCapacity;
  int totalCustomerCapicity;
  int remainingCustomerCapicity;
  int remianingSalesPerson;
  int totalSalesPerson;
  int totalBalance;
  List<Organization> organization;

  OrganizationData(
      {this.totalEmployeeCapacity,
        this.remainingEmployeeCapacity,
        this.totalCustomerCapicity,
        this.remainingCustomerCapicity,
        this.remianingSalesPerson,
        this.totalBalance,
        this.organization});

  OrganizationData.fromJson(Map<String, dynamic> json) {
    totalEmployeeCapacity = json['totalEmployeeCapacity'];
    remainingEmployeeCapacity = json['remainingEmployeeCapacity'];
    totalCustomerCapicity = json['totalCustomerCapicity'];
    remainingCustomerCapicity = json['remainingCustomerCapicity'];
    remianingSalesPerson = json['remianingSalesPerson'];
    totalSalesPerson= json[' int totalSalesPerson;'];
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
    data['totalEmployeeCapacity'] = this.totalEmployeeCapacity;
    data['remainingEmployeeCapacity'] = this.remainingEmployeeCapacity;
    data['totalCustomerCapicity'] = this.totalCustomerCapicity;
    data['remainingCustomerCapicity'] = this.remainingCustomerCapicity;
    data['remianingSalesPerson'] = this.remianingSalesPerson;
    data[' int totalSalesPerson;'] = this.totalSalesPerson;
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
  int nextLevelCost;
  String subtractLevelConfirmMessage;
  String addLevelConfirmMessage;
  int employeeCount;

  Organization(
      {this.type,
        this.name,
        this.level,
        this.description,
        this.nextLevelCost,
        this.subtractLevelConfirmMessage,
        this.addLevelConfirmMessage,
        this.employeeCount});

  Organization.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    level = json['level'];
    description = json['description'];
    nextLevelCost = json['nextLevelCost'];
    subtractLevelConfirmMessage = json['subtractLevelConfirmMessage'];
    addLevelConfirmMessage = json['addLevelConfirmMessage'];
    employeeCount = json['employeeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['level'] = this.level;
    data['description'] = this.description;
    data['nextLevelCost'] = this.nextLevelCost;
    data['subtractLevelConfirmMessage'] = this.subtractLevelConfirmMessage;
    data['addLevelConfirmMessage'] = this.addLevelConfirmMessage;
    data['employeeCount'] = this.employeeCount;
    return data;
  }
}

