class DashboardRequest {
  int userId;
  int mode;

  DashboardRequest({this.userId, this.mode});

  DashboardRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['mode'] = this.mode;
    return data;
  }
}

class DashboardResponse {
  String flag;
  String result;
  String msg;
  List<GetDashboardData> data;

  DashboardResponse({this.flag, this.result, this.msg, this.data});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<GetDashboardData>();
      json['data'].forEach((v) {
        data.add(new GetDashboardData.fromJson(v));
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

class GetDashboardData {
  String title;
  int type;
  int count;

  GetDashboardData({this.title, this.type, this.count});

  GetDashboardData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['count'] = this.count;
    return data;
  }
}

