class LogoutRequest {
  String userId;
  String deviceType;
  String deviceToken;

  LogoutRequest({this.userId, this.deviceType, this.deviceToken});

  LogoutRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    deviceType = json['deviceType'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['deviceType'] = this.deviceType;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}
