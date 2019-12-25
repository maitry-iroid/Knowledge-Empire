import 'organization.dart';

class CustomerValueRequest {
  String userId;

  CustomerValueRequest({this.userId});

  CustomerValueRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}

class GetCustomerValueResponse {
  String flag;
  String result;
  String msg;
  CustomerValueData data;

  GetCustomerValueResponse({this.flag, this.result, this.msg, this.data});

  GetCustomerValueResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null
        ? new CustomerValueData.fromJson(json['data'])
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

class CustomerValueData {
  int totalEmployeeCapacity;
  String manager;
  int remainingEmployeeCapacity;
  int totalCustomerCapicity;
  int remainingCustomerCapicity;
  int totalBalance;
  int loyaltyBonus;
  int valueBonus;
  int resourceBonus;
  int totalAttemptedQuestion;
  List<Organization> organization;
  int correctAnswerCount;

  CustomerValueData(
      {this.totalEmployeeCapacity,
        this.manager,
        this.remainingEmployeeCapacity,
        this.totalCustomerCapicity,
        this.remainingCustomerCapicity,
        this.totalBalance,
        this.loyaltyBonus,
        this.valueBonus,
        this.resourceBonus,
        this.totalAttemptedQuestion,
        this.organization,
        this.correctAnswerCount});

  CustomerValueData.fromJson(Map<String, dynamic> json) {
    totalEmployeeCapacity = json['totalEmployeeCapacity'];
    manager = json['manager'];
    remainingEmployeeCapacity = json['remainingEmployeeCapacity'];
    totalCustomerCapicity = json['totalCustomerCapicity'];
    remainingCustomerCapicity = json['remainingCustomerCapicity'];
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
    correctAnswerCount = json['correctAnswerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalEmployeeCapacity'] = this.totalEmployeeCapacity;
    data['manager'] = this.manager;
    data['remainingEmployeeCapacity'] = this.remainingEmployeeCapacity;
    data['totalCustomerCapicity'] = this.totalCustomerCapicity;
    data['remainingCustomerCapicity'] = this.remainingCustomerCapicity;
    data['totalBalance'] = this.totalBalance;
    data['loyaltyBonus'] = this.loyaltyBonus;
    data['valueBonus'] = this.valueBonus;
    data['resourceBonus'] = this.resourceBonus;
    data['totalAttemptedQuestion'] = this.totalAttemptedQuestion;
    if (this.organization != null) {
      data['organization'] = this.organization.map((v) => v.toJson()).toList();
    }
    data['correctAnswerCount'] = this.correctAnswerCount;
    return data;
  }
}

//class Organization {
//  int type;
//  int level;
//  String description;
//  int nextLevelCost;
//  String subtractLevelConfirmMessage;
//  String addLevelConfirmMessage;
//  int employeeCount;
//
//  Organization(
//      );
//
//  Organization.fromJson(Map<String, dynamic> json) {
//    type = json['type'];
//    level = json['level'];
//    description = json['description'];
//    nextLevelCost = json['nextLevelCost'];
//    subtractLevelConfirmMessage = json['subtractLevelConfirmMessage'];
//    addLevelConfirmMessage = json['addLevelConfirmMessage'];
//    employeeCount = json['employeeCount'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['type'] = this.type;
//    data['level'] = this.level;
//    data['description'] = this.description;
//    data['nextLevelCost'] = this.nextLevelCost;
//    data['subtractLevelConfirmMessage'] = this.subtractLevelConfirmMessage;
//    data['addLevelConfirmMessage'] = this.addLevelConfirmMessage;
//    data['employeeCount'] = this.employeeCount;
//    return data;
//  }
//}


