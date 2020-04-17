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





class UnreadBubbleCountData {
  String title;
  int type;
  int count;

  UnreadBubbleCountData({this.title, this.type, this.count});

  UnreadBubbleCountData.fromJson(Map<String, dynamic> json) {
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

