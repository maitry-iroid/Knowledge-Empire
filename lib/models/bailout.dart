class BailOutRequest {
  String userId;
//  String mode;

  BailOutRequest({this.userId});

  BailOutRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
//    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
//    data['mode'] = this.mode;
    return data;
  }
}
