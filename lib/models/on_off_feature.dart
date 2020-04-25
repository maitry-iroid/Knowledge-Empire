
class DashboardStatusRequest {
  int userId;

  DashboardStatusRequest({this.userId});

  DashboardStatusRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}
class DashboardStatusResponse {
  String flag;
  String result;
  String msg;
  List<OnOffFeatureData> data;

  DashboardStatusResponse({this.flag, this.result, this.msg, this.data});

  DashboardStatusResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<OnOffFeatureData>();
      json['data'].forEach((v) {
        data.add(new OnOffFeatureData.fromJson(v));
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

class OnOffFeatureData {
  int type;
  int isFeatureOn;
  int isLocked;
  int unreadCount;

  OnOffFeatureData({this.type, this.isFeatureOn,this.isLocked,this.unreadCount});

  OnOffFeatureData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    isFeatureOn = json['isFeatureOn'];
    isLocked = json['isLocked'];
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['isFeatureOn'] = this.isFeatureOn;
    data['isLocked'] = this.isLocked;
    data['unreadCount'] = this.unreadCount;
    return data;
  }
}
