class ForceUpdateRequest {
  String appVersion;
  String deviceType;
  String language;

  ForceUpdateRequest({this.appVersion, this.deviceType, this.language});

  ForceUpdateRequest.fromJson(Map<String, dynamic> json) {
    appVersion = json['appVersion'];
    deviceType = json['deviceType'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appVersion'] = this.appVersion;
    data['deviceType'] = this.deviceType;
    data['language'] = this.language;
    return data;
  }
}
