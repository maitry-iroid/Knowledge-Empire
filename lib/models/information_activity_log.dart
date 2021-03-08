class InformationActivityLogModel{
  String userId;
  String dataId;
  String type;
  String informationType;

  InformationActivityLogModel({this.userId, this.dataId, this.type, this.informationType});

  InformationActivityLogModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    dataId = json['dataId'];
    type = json['type'];
    informationType = json['informationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['dataId'] = this.dataId;
    data['type'] = this.type;
    data['informationType'] = this.informationType;
    return data;
  }
}