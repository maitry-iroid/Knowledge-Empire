class GetFriendsRequest {
  int userId;
  int category;
  int searchBy;
  int filter;
  int groupId;

  GetFriendsRequest({this.userId, this.category, this.searchBy, this.filter});

  GetFriendsRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    category = json['category'];
    searchBy = json['searchBy'];
    filter = json['filter'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['category'] = this.category;
    data['searchBy'] = this.searchBy;
    data['filter'] = this.filter;
    data['groupId'] = this.groupId;
    return data;
  }
}

class GetFriendsResponse {
  String flag;
  String result;
  String msg;
  List<GetFriendsData> data;

  GetFriendsResponse({this.flag, this.result, this.msg, this.data});

  GetFriendsResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<GetFriendsData>();
      json['data'].forEach((v) {
        data.add(new GetFriendsData.fromJson(v));
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

class GetFriendsData {
  int userId;
  String name;
  int score;
  int isFriend;
//  bool isFriends = false;

  GetFriendsData({this.userId, this.name, this.score, this.isFriend});

  GetFriendsData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    score = json['score'];
    isFriend = json['isFriend'];
//    isFriends = json['isFriends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['score'] = this.score;
    data['isFriend'] = this.isFriend;
//    data['isFriends'] = this.isFriends;
    return data;
  }
}

