import 'package:ke_employee/models/questions.dart';

class GetChallengesRequest {
  int userId;
  int challengeId;

  GetChallengesRequest({this.userId, this.challengeId});

  GetChallengesRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    challengeId = json['challengeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['challengeId'] = this.challengeId;
    return data;
  }
}

class GetChallengesResponse {
  String flag;
  String result;
  String msg;
  List<QuestionData> data;

  GetChallengesResponse({this.flag, this.result, this.msg, this.data});

  GetChallengesResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<QuestionData>();
      json['data'].forEach((v) {
        data.add(new QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
