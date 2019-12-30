class ChangePasswordRequest {
  int userId;
  String password;
  String oldPassword;
  bool isOldPasswordRequired;

  ChangePasswordRequest({this.userId, this.password});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    password = json['password'];
    oldPassword = json['oldPassword'];
    isOldPasswordRequired = json['isOldPasswordRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['password'] = this.password;
    data['oldPassword'] = this.oldPassword;
    data['isOldPasswordRequired'] = this.isOldPasswordRequired;
    return data;
  }
}
