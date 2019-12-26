
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
  int totalCustomerCapacity;
  int remainingCustomerCapacity;
  int remainingSalesPerson;
  int totalBalance;
  int loyaltyBonus;
  int valueBonus;
  int resourceBonus;
  int totalAttemptedQuestion;
  int correctAnswerCount;
  int totalSalesPerson;

  CustomerValueData(
      {this.totalEmployeeCapacity,
        this.manager,
        this.remainingEmployeeCapacity,
        this.totalCustomerCapacity,
        this.remainingCustomerCapacity,
        this.remainingSalesPerson,
        this.totalBalance,
        this.loyaltyBonus,
        this.valueBonus,
        this.resourceBonus,
        this.totalAttemptedQuestion,
        this.correctAnswerCount,
        this.totalSalesPerson});

  CustomerValueData.fromJson(Map<String, dynamic> json) {
    totalEmployeeCapacity = json['totalEmployeeCapacity'];
    manager = json['manager'];
    remainingEmployeeCapacity = json['remainingEmployeeCapacity'];
    totalCustomerCapacity = json['totalCustomerCapacity'];
    remainingCustomerCapacity = json['remainingCustomerCapacity'];
    remainingSalesPerson = json['remainingSalesPerson'];
    totalBalance = json['totalBalance'];
    loyaltyBonus = json['loyaltyBonus'];
    valueBonus = json['valueBonus'];
    resourceBonus = json['resourceBonus'];
    totalAttemptedQuestion = json['totalAttemptedQuestion'];
    correctAnswerCount = json['correctAnswerCount'];
    totalSalesPerson = json['totalSalesPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalEmployeeCapacity'] = this.totalEmployeeCapacity;
    data['manager'] = this.manager;
    data['remainingEmployeeCapacity'] = this.remainingEmployeeCapacity;
    data['totalCustomerCapacity'] = this.totalCustomerCapacity;
    data['remainingCustomerCapacity'] = this.remainingCustomerCapacity;
    data['remainingSalesPerson'] = this.remainingSalesPerson;
    data['totalBalance'] = this.totalBalance;
    data['loyaltyBonus'] = this.loyaltyBonus;
    data['valueBonus'] = this.valueBonus;
    data['resourceBonus'] = this.resourceBonus;
    data['totalAttemptedQuestion'] = this.totalAttemptedQuestion;
    data['correctAnswerCount'] = this.correctAnswerCount;
    data['totalSalesPerson'] = this.totalSalesPerson;
    return data;
  }
}

