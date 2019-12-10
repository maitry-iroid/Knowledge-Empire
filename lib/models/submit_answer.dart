class SubmitAnswerRequest {
  String userId;
  int totalQuestionAnswered;
  List<SubmitAnswer> answer;

  SubmitAnswerRequest(
      {this.userId,
        this.totalQuestionAnswered,
        this.answer});

  SubmitAnswerRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    totalQuestionAnswered = json['totalQuestionAnswered'];
    if (json['answer'] != null) {
      answer = new List<SubmitAnswer>();
      json['answer'].forEach((v) {
        answer.add(new SubmitAnswer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['totalQuestionAnswered'] = this.totalQuestionAnswered;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubmitAnswer {
  int questionId;
  int moduleId;
  int counter;
  int resource;
  int value;
  int loyalty;
  bool isAnsweredCorrect;
  String attemptTime;

  SubmitAnswer(
      {this.questionId,
        this.moduleId,
        this.counter,
        this.resource,
        this.value,
        this.loyalty,
        this.isAnsweredCorrect,
        this.attemptTime});

  SubmitAnswer.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    moduleId = json['moduleId'];
    counter = json['counter'];
    resource = json['resource'];
    value = json['value'];
    loyalty = json['loyalty'];
    isAnsweredCorrect = json['isAnsweredCorrect'];
    attemptTime = json['attemptTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['moduleId'] = this.moduleId;
    data['counter'] = this.counter;
    data['resource'] = this.resource;
    data['value'] = this.value;
    data['loyalty'] = this.loyalty;
    data['isAnsweredCorrect'] = this.isAnsweredCorrect;
    data['attemptTime'] = this.attemptTime;
    return data;
  }
}
