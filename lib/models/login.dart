class LoginRequest {
  String email;
  String password;
  String secret;

  LoginRequest({this.email, this.password, this.secret});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    secret = json['secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['secret'] = this.secret;
    return data;
  }
}

class LoginResponse {
  String flag;
  String result;
  String msg;
  LoginResponseData data;

  LoginResponse({this.flag, this.result, this.msg, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null
        ? new LoginResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class LoginResponseData {
  String userId;
  String name;
  String email;
  String phone;
  String address;
  String country;
  String createdAt;
  String isPasswordChanged;
  String profileImage;
  String accessToken;
  String companyName;
  String manager;
  String activeCompany;
  int salesPersonCount = 0;
  bool isFirstTimeLogin = false;

  LoginResponseData();

  LoginResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    country = json['country'];
    createdAt = json['createdAt'];
    isPasswordChanged = json['isPasswordChanged'];
    profileImage = json['profileImage'];
    accessToken = json['accessToken'];
    companyName = json['companyName'];
    manager = json['manager'];
    activeCompany = json['activeCompany'];
    isFirstTimeLogin = json['isFirstTimeLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['isPasswordChanged'] = this.isPasswordChanged;
    data['profileImage'] = this.profileImage;
    data['accessToken'] = this.accessToken;
    data['companyName'] = this.companyName;
    data['manager'] = this.manager;
    data['activeCompany'] = this.activeCompany;
    data['isFirstTimeLogin'] = this.isFirstTimeLogin;
    return data;
  }
}
