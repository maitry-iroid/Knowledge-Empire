class UpdateSoundAndModeRequest {
  int userId;
  int companyId;
  int type;
  int isEnable;

  UpdateSoundAndModeRequest({this.userId, this.companyId,this.type,this.isEnable});

  UpdateSoundAndModeRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    companyId = json['companyId'];
    type = json['type'];
    isEnable = json['isEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['companyId'] = this.companyId;
    data['type'] = this.type;
    data['isEnable'] = this.isEnable;
    return data;
  }
}
