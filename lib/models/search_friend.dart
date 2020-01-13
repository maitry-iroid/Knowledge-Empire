import 'get_friends.dart';

class SearchFriendRequest {
  String userId;
  String searchText;

  SearchFriendRequest({this.userId, this.searchText});

  SearchFriendRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    searchText = json['searchText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['searchText'] = this.searchText;
    return data;
  }
}

class SearchFriendResponse {
  String flag;
  String result;
  String msg;
  List<GetFriendsData> data;

  SearchFriendResponse({this.flag, this.result, this.msg, this.data});

  SearchFriendResponse.fromJson(Map<String, dynamic> json) {
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
