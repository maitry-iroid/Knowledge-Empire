class SubmitAnswerRequest {
  String userId;
  int totalQuestionAnswered;
  int remainingSalesPerson;
  List<Answer> answer;

  SubmitAnswerRequest(
      {this.userId,
        this.totalQuestionAnswered,
        this.remainingSalesPerson,
        this.answer});

  SubmitAnswerRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    totalQuestionAnswered = json['totalQuestionAnswered'];
    remainingSalesPerson = json['remainingSalesPerson'];
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['totalQuestionAnswered'] = this.totalQuestionAnswered;
    data['remainingSalesPerson'] = this.remainingSalesPerson;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  int questionId;
  int counter;
  int resourceBonus;
  int valueBonus;
  int loyaltyBonus;
  bool isAnsweredCorrect;
  String attemptTime;

  Answer(
      {this.questionId,
        this.counter,
        this.resourceBonus,
        this.valueBonus,
        this.loyaltyBonus,
        this.isAnsweredCorrect,
        this.attemptTime});

  Answer.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    counter = json['counter'];
    resourceBonus = json['resourceBonus'];
    valueBonus = json['valueBonus'];
    loyaltyBonus = json['loyaltyBonus'];
    isAnsweredCorrect = json['isAnsweredCorrect'];
    attemptTime = json['attemptTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['counter'] = this.counter;
    data['resourceBonus'] = this.resourceBonus;
    data['valueBonus'] = this.valueBonus;
    data['loyaltyBonus'] = this.loyaltyBonus;
    data['isAnsweredCorrect'] = this.isAnsweredCorrect;
    data['attemptTime'] = this.attemptTime;
    return data;
  }
}
