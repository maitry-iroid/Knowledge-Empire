class SubmitAnswerRequest {
  String userId;
  int totalQuestionAnswered;
  int isChallenge;
  int challengeId;
  String timezone;
  List<SubmitAnswer> answer;

  SubmitAnswerRequest(
      {this.userId,
        this.totalQuestionAnswered,
        this.answer, this.timezone});

  SubmitAnswerRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isChallenge = json['isChallenge'];
    challengeId = json['challengeId'];
    totalQuestionAnswered = json['totalQuestionAnswered'];
    timezone = json['timezone'];
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
    data['isChallenge'] = this.isChallenge;
    data['challengeId'] = this.challengeId;
    data['timezone'] = this.timezone;
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
  int resources;
  int value;
  int loyalty;
  bool isAnsweredCorrect;
  String attemptTime;

  SubmitAnswer(
      {this.questionId,
        this.moduleId,
        this.counter,
        this.resources,
        this.value,
        this.loyalty,
        this.isAnsweredCorrect,
        this.attemptTime});

  SubmitAnswer.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    moduleId = json['moduleId'];
    counter = json['counter'];
    resources = json['resources'];
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
    data['resources'] = this.resources;
    data['value'] = this.value;
    data['loyalty'] = this.loyalty;
    data['isAnsweredCorrect'] = this.isAnsweredCorrect;
    data['attemptTime'] = this.attemptTime;
    return data;
  }
}
