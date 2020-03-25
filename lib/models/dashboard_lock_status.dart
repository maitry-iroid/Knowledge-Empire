class DashboardLockStatusRequest {
  int userId;
  int mode;

  DashboardLockStatusRequest({this.userId, this.mode});

  DashboardLockStatusRequest.fromJson(Map<String, dynamic> json) {
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

class DashboardLockStatusData {
  int achievement;
  int organization;
  int pl;
  int ranking;
  int challenge;

  DashboardLockStatusData(
      {this.achievement,
        this.organization,
        this.pl,
        this.ranking,
        this.challenge});

  DashboardLockStatusData.fromJson(Map<String, dynamic> json) {
    achievement = json['achievement'];
    organization = json['organization'];
    pl = json['pl'];
    ranking = json['ranking'];
    challenge = json['challenge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['achievement'] = this.achievement;
    data['organization'] = this.organization;
    data['pl'] = this.pl;
    data['ranking'] = this.ranking;
    data['challenge'] = this.challenge;
    return data;
  }
}
