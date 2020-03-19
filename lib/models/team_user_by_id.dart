class TeamUserByIdRequest {
  int userId;
  int teamUserId;

  TeamUserByIdRequest({this.userId, this.teamUserId});

  TeamUserByIdRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    teamUserId = json['teamUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['teamUserId'] = this.teamUserId;
    return data;
  }
}

class TeamUserByIdData {
  String name;
  String department;
  int resets;
  List<Modules> modules = List<Modules>();
  QStatus qStatus;
  List<QLevel> qLevel;

  TeamUserByIdData(
      {this.name,
      this.department,
      this.resets,
      this.modules,
      this.qStatus,
      this.qLevel});

  TeamUserByIdData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    department = json['department'];
    resets = json['resets'];
    if (json['modules'] != null) {
      modules = new List<Modules>();
      List dataList = json['modules'];
      if (dataList != null && dataList.length > 0)
        modules = dataList.map((c) => new Modules.fromJson(c)).toList();
    }

    qStatus = json['qStatus'] != null ? new QStatus.fromJson(json['qStatus']) : null;
//    Map data = json['qStatus'];
//    qStatus = new QStatus.fromJson(data);

    if (json['qLevel'] != null) {
      qLevel = new List<QLevel>();
      List dataList = json['qLevel'];
      if (dataList != null && dataList.length > 0)
        qLevel = dataList.map((c) => new QLevel.fromJson(c)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['department'] = this.department;
    data['resets'] = this.resets;
    if (this.modules != null) {
      data['modules'] = this.modules.map((v) => v.toJson()).toList();
    }
    if (this.qStatus != null) {
      data['qStatus'] = this.qStatus.toJson();
    }
    if (this.qLevel != null) {
      data['qLevel'] = this.qLevel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  int moduleId;
  String name;
  int level;
  int complete;

  Modules({this.moduleId, this.name, this.level, this.complete});

  Modules.fromJson(Map<String, dynamic> json) {
    moduleId = json['moduleId'];
    name = json['name'];
    level = json['level'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleId'] = this.moduleId;
    data['name'] = this.name;
    data['level'] = this.level;
    data['complete'] = this.complete;
    return data;
  }
}

class QStatus {
  int totalQStatusCount;
  int open;
  int closed;

  QStatus({this.totalQStatusCount, this.open, this.closed});

  QStatus.fromJson(Map<String, dynamic> json) {
    totalQStatusCount = json['totalQStatusCount'];
    open = json['open'];
    closed = json['closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalQStatusCount'] = this.totalQStatusCount;
    data['open'] = this.open;
    data['closed'] = this.closed;
    return data;
  }
}

class QLevel {
  int questionCount;
  int level;

  QLevel({this.questionCount, this.level});

  QLevel.fromJson(Map<String, dynamic> json) {
    questionCount = json['questionCount'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionCount'] = this.questionCount;
    data['level'] = this.level;
    return data;
  }
}
