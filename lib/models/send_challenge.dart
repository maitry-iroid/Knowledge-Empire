class SendChallengesRequest {
  int userId;
  int friendId;
  int moduleId;
  int rewards;

  SendChallengesRequest(
      {this.userId, this.friendId, this.moduleId, this.rewards});

  SendChallengesRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    friendId = json['friendId'];
    moduleId = json['moduleId'];
    rewards = json['rewards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['friendId'] = this.friendId;
    data['moduleId'] = this.moduleId;
    data['rewards'] = this.rewards;
    return data;
  }
}

class SendChallengesResponse {
  String flag;
  String result;
  String msg;
  List<dynamic> data;

  SendChallengesResponse({this.flag, this.result, this.msg, this.data});

  SendChallengesResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<dynamic>();
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
