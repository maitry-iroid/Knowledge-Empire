class ChangePasswordRequest {
  String userId;
  String oldPassword;
  String password;

  ChangePasswordRequest({this.userId, this.oldPassword, this.password});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    oldPassword = json['oldPassword'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['oldPassword'] = this.oldPassword;
    data['password'] = this.password;
    return data;
  }
}