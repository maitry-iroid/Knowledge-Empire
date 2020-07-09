class UpdateUserSetting {
  String userId;
  String type;
  String mode;
  String isSoundEnable;
  String language;
  int companyId;

  UpdateUserSetting(
      {this.userId,
        this.type,
        this.mode,
        this.isSoundEnable,
        this.language,
        this.companyId});

  UpdateUserSetting.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    type = json['type'];
    mode = json['mode'];
    isSoundEnable = json['isSoundEnable'];
    language = json['language'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['mode'] = this.mode;
    data['isSoundEnable'] = this.isSoundEnable;
    data['language'] = this.language;
    data['companyId'] = this.companyId;
    return data;
  }
}
