
class TeamUserRequest {
  int userId;

  TeamUserRequest({this.userId});

  TeamUserRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}



class TeamUserData {
  List<Users> users = List();
  QStatus qStatus = QStatus();
  List<QLevel> qLevel = List();

  TeamUserData({this.users, this.qStatus, this.qLevel});

  TeamUserData.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
    qStatus =
    json['qStatus'] != null ? new QStatus.fromJson(json['qStatus']) : null;
    if (json['qLevel'] != null) {
      qLevel = new List<QLevel>();
      json['qLevel'].forEach((v) {
        qLevel.add(new QLevel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
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

class Users {
  int userId;
  String name;
  int points;
  int correct;
  int lastLog;

  Users({this.userId, this.name, this.points, this.correct, this.lastLog});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    points = json['points'];
    correct = json['correct'];
    lastLog = json['lastLog'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['points'] = this.points;
    data['correct'] = this.correct;
    data['lastLog'] = this.lastLog;
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
