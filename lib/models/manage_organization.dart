import 'organization.dart';

class ManageOrganizationRequest {
  int userId;
  int type;
  int action;

  ManageOrganizationRequest({this.userId, this.type, this.action});

  ManageOrganizationRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    type = json['type'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['action'] = this.action;
    return data;
  }
}

class ManageOrgResponse {
  String flag;
  String result;
  String msg;
  ManageOrgData data;

  ManageOrgResponse({this.flag, this.result, this.msg, this.data});

  ManageOrgResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data =
        json['data'] != null ? new ManageOrgData.fromJson(json['data']) : null;
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

class ManageOrgData {
  int totalEmployeeCapacity;
  int remainingEmployeeCapacity;
  int totalCustomerCapacity;
  int remainingCustomerCapacity;
  int totalSalesPerson;
  int remainingSalesPerson;
  int totalBalance;
  List<Organization> organization;

  ManageOrgData(
      {this.totalEmployeeCapacity,
      this.remainingEmployeeCapacity,
      this.totalCustomerCapacity,
      this.remainingCustomerCapacity,
      this.totalSalesPerson,
      this.remainingSalesPerson,
      this.totalBalance,
      this.organization});

  ManageOrgData.fromJson(Map<String, dynamic> json) {
    totalEmployeeCapacity = json['totalEmployeeCapacity'];
    remainingEmployeeCapacity = json['remainingEmployeeCapacity'];
    totalCustomerCapacity = json['totalCustomerCapacity'];
    remainingCustomerCapacity = json['remainingCustomerCapacity'];
    totalSalesPerson = json['totalSalesPerson'];
    remainingSalesPerson = json['remainingSalesPerson'];
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
    data['totalCustomerCapacity'] = this.totalCustomerCapacity;
    data['remainingCustomerCapacity'] = this.remainingCustomerCapacity;
    data['totalSalesPerson'] = this.totalSalesPerson;
    data['remainingSalesPerson'] = this.remainingSalesPerson;
    data['totalBalance'] = this.totalBalance;
    if (this.organization != null) {
      data['organization'] = this.organization.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
