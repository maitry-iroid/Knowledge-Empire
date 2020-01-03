
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


class GetUserGroupResponse {
  String flag;
  String result;
  String msg;
  List<GetUserGroupData> data;

  GetUserGroupResponse({this.flag, this.result, this.msg, this.data});

  GetUserGroupResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<GetUserGroupData>();
      json['data'].forEach((v) {
        data.add(new GetUserGroupData.fromJson(v));
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
