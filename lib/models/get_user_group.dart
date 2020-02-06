
class GetUserGroupRequest {
  int userId;

  GetUserGroupRequest({this.userId});

  GetUserGroupRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}

class GetUserGroupData {
  int groupId;
  String name;

  GetUserGroupData({this.groupId, this.name});

  GetUserGroupData.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['name'] = this.name;
    return data;
  }
}
