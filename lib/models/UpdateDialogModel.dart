class UpdateDialogModel {
  String status;
  String appUrl;
  String message;

  UpdateDialogModel({this.status, this.appUrl, this.message});

  UpdateDialogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    appUrl = json['appUrl'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['appUrl'] = this.appUrl;
    data['message'] = this.message;
    return data;
  }
}
