class SwitchCompanyRequest {
  String userId;
  String companyId;

  SwitchCompanyRequest({this.userId, this.companyId});

  SwitchCompanyRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['companyId'] = this.companyId;
    return data;
  }
}
