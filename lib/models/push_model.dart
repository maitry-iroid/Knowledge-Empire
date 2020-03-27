class PushModel {
  String type;
  String bonus;
  String level;
  String achievementCategory;
  String achievementName;
  String achievementText;
  String achievementType;
  String notificationType;

  PushModel(
      {this.type,
        this.bonus,
        this.level,
        this.achievementCategory,
        this.achievementName,
        this.achievementText,
        this.achievementType,
        this.notificationType});

  PushModel.fromJson(Map json) {
    type = json['type'];
    bonus = json['bonus'];
    level = json['level'];
    achievementCategory = json['achievementCategory'];
    achievementName = json['achievementName'];
    achievementText = json['achievementText'];
    achievementType = json['achievementType'];
    notificationType = json['notificationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['bonus'] = this.bonus;
    data['level'] = this.level;
    data['achievementCategory'] = this.achievementCategory;
    data['achievementName'] = this.achievementName;
    data['achievementText'] = this.achievementText;
    data['achievementType'] = this.achievementType;
    data['notificationType'] = this.notificationType;
    return data;
  }
}
