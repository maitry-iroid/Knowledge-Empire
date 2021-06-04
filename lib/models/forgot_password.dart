class ForgotPasswordRequest {
  String email;
  String companyCode;

  ForgotPasswordRequest({this.email, this.companyCode});

  ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    companyCode = json['companyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['companyCode'] = this.companyCode;
    return data;
  }
}