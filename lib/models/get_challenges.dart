import 'package:ke_employee/models/questions.dart';

class GetChallengesRequest {
  int userId;
//  int challengeId;

  GetChallengesRequest({this.userId});

  GetChallengesRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
//    challengeId = json['challengeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
//    data['challengeId'] = this.challengeId;
    return data;
  }
}


