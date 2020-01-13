class RegisterForPushRequest {
  int userId;
  String deviceId;
  String deviceToken;
  String deviceType;

  RegisterForPushRequest(
      {this.userId, this.deviceId, this.deviceToken, this.deviceType});

  RegisterForPushRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    deviceId = json['deviceId'];
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['deviceId'] = this.deviceId;
    data['deviceToken'] = this.deviceToken;
    data['deviceType'] = this.deviceType;
    return data;
  }
}

class RegisterForPushResponse {
  String flag;
  String result;
  String msg;
  Data data;

  RegisterForPushResponse({this.flag, this.result, this.msg, this.data});

  RegisterForPushResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Data();

  Data.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
