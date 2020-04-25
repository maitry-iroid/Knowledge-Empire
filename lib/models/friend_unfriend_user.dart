class GetFriendsUnfriendReuest {
  int userId;
  int requestedTo;
  int action;

  GetFriendsUnfriendReuest({this.userId, this.requestedTo, this.action});

  GetFriendsUnfriendReuest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    requestedTo = json['requestedTo'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['requestedTo'] = this.requestedTo;
    data['action'] = this.action;
    return data;
  }
}

class GetFriendsUnFriendResponse {
  String flag;
  String result;
  String msg;
//  List<GetFriendsUnfriendResponse> data;

  GetFriendsUnFriendResponse({this.flag, this.result, this.msg  });

  GetFriendsUnFriendResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
//    if (json['data'] != null) {
//      data = new List<GetFriendsData>();
//      json['data'].forEach((v) {
//        data.add(new GetFriendsData.fromJson(v));
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
//    if (this.data != null) {
//      data['data'] = this.data.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}