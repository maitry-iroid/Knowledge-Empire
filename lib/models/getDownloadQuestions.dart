class DownloadQuestionsRequest {
  int userId;

  DownloadQuestionsRequest({this.userId});

  DownloadQuestionsRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}
