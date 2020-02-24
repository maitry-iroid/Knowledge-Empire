class DownloadQuestionsRequest {
  int userId;
  int moduleId;

  DownloadQuestionsRequest({this.userId});

  DownloadQuestionsRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    moduleId = json['moduleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['moduleId'] = this.moduleId;
    return data;
  }
}
