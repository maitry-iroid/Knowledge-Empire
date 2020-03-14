class LanguageRequest {
  String userId;
  String language;

  LanguageRequest({this.userId, this.language});

  LanguageRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['language'] = this.language;
    return data;
  }
}
