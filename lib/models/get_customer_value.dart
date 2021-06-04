import 'package:knowledge_empire/helper/constant.dart';
import 'package:knowledge_empire/injection/dependency_injection.dart';

class CustomerValueRequest {
  int userId;

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
  String introText;
  int isSwitchEnable = 1;
  int isEnableSound = 1;
  int mode = Const.businessMode;
  int isChallengeAvailable = 0;
  String name;
  String nickName;

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
      this.introText,
      this.totalSalesPerson,
      this.isSwitchEnable,
      this.isEnableSound,
      this.mode,
      this.isChallengeAvailable,
      this.name,
      this.nickName});

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
    introText = json['introText'];
    isSwitchEnable = json['isSwitchEnable'];
    isEnableSound = json['isEnableSound'];
    mode = json['mode'];
    isChallengeAvailable = json['isChallengeAvailable'];
    name = json['name'];
    nickName = json['nickName'];
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
    data['introText'] = this.introText;
    data['isSwitchEnable'] = this.isSwitchEnable;
    data['isEnableSound'] = this.isEnableSound;
    data['mode'] = this.mode;
    data['isChallengeAvailable'] = this.isChallengeAvailable;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    return data;
  }
}
