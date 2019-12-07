class ManageOrganizationRequest {
  String userId;
  int type;
  int action;

  ManageOrganizationRequest({this.userId, this.type, this.action});

  ManageOrganizationRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    type = json['type'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['action'] = this.action;
    return data;
  }
}
