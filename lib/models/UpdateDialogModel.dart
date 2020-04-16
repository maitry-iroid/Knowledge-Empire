class UpdateDialogModel {
  String status;
  String appUrl;
  String message;
  String headlineText;

  UpdateDialogModel(
      {this.status, this.appUrl, this.message, this.headlineText});

  UpdateDialogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    appUrl = json['appUrl'];
    message = json['message'];
    headlineText = json['headlineText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['appUrl'] = this.appUrl;
    data['message'] = this.message;
    data['headlineText'] = this.headlineText;
    return data;
  }
}
