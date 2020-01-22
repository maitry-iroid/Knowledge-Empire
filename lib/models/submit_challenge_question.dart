class SubmitChallengesRequest {
  int userId;
  int challengeId;
  int questionId;
  int isAnsweredCorrect;

  SubmitChallengesRequest(
      {this.userId, this.challengeId, this.questionId, this.isAnsweredCorrect});

  SubmitChallengesRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    challengeId = json['challengeId'];
    questionId = json['questionId'];
    isAnsweredCorrect = json['isAnsweredCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['challengeId'] = this.challengeId;
    data['questionId'] = this.questionId;
    data['isAnsweredCorrect'] = this.isAnsweredCorrect;
    return data;
  }
}
