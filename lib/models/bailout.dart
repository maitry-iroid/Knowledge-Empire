class BailOutRequest {
  int userId;
  int mode;
  int teamUserId;

  BailOutRequest({this.userId});

  BailOutRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    mode = json['mode'];
    mode = json['teamUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['mode'] = this.mode;
    data['teamUserId'] = this.teamUserId;
    return data;
  }

}
