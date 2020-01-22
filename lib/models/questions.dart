class QuestionRequest {
  int userId;

  int moduleId;

  int type = 1;

  QuestionRequest();

  QuestionRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    moduleId = json['moduleId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['moduleId'] = this.moduleId;
    data['type'] = this.type;
    return data;
  }
}

class QuestionsResponse {
  String flag = "";
  String result = "";
  String msg = "";
  List<QuestionData> data = List();

  QuestionsResponse({this.flag, this.result, this.msg, this.data});

  QuestionsResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<QuestionData>();
      json['data'].forEach((v) {
        data.add(new QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionData {
  int questionId; // if question is from challenge
  int challengeId; // if question is from challenge
  String firstName; // if question is from challenge
  String lastName; // if question is from challenge
  String profileImage;
  String title;
  String question;
  String moduleName;
  int moduleId;
  int companyId;
  int daysInList;
  int counter;
  String description;
  String correctAnswerId;
  int loyalty;
  int value;
  String mediaLink;
  List<Answer> answer;
  String correctAnswerImage;
  String inCorrectAnswerImage;
  bool isAnsweredCorrect;
  int resources;
  String attemptTime;
  int videoPlay;
  int videoLoop;

  QuestionData(
      {this.questionId,
      this.challengeId,
      this.title,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.question,
      this.moduleName,
      this.moduleId,
      this.companyId,
      this.daysInList,
      this.counter,
      this.description,
      this.correctAnswerId,
      this.loyalty,
      this.value,
      this.mediaLink,
      this.answer,
      this.correctAnswerImage,
      this.inCorrectAnswerImage,
      this.videoPlay,
      this.videoLoop,
      this.attemptTime});

  QuestionData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    challengeId = json['challengeId'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileImage = json['profileImage'];
    question = json['question'];
    moduleName = json['moduleName'];
    moduleId = json['moduleId'];
    companyId = json['companyId'];
    daysInList = json['daysInlist'];
    counter = json['counter'];
    description = json['description'];
    correctAnswerId = json['correctAnswerId'];
    loyalty = json['loyalty'];
    value = json['value'];
    resources = json['resources'];
    mediaLink = json['mediaLink'];
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
    correctAnswerImage = json['correctAnswerImage'];
    inCorrectAnswerImage = json['inCorrectAnswerImage'];
    videoPlay = json['videoPlay'];
    videoLoop = json['videoLoop'];
    attemptTime = json['attemptTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['challengeId'] = this.challengeId;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profileImage'] = this.profileImage;
    data['question'] = this.question;
    data['moduleName'] = this.moduleName;
    data['moduleId'] = this.moduleId;
    data['companyId'] = this.companyId;
    data['daysInlist'] = this.daysInList;
    data['counter'] = this.counter;
    data['description'] = this.description;
    data['correctAnswerId'] = this.correctAnswerId;
    data['loyalty'] = this.loyalty;
    data['value'] = this.value;
    data['resources'] = this.resources;
    data['videoPlay'] = this.videoPlay;
    data['videoLoop'] = this.videoLoop;
    data['mediaLink'] = this.mediaLink;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    data['correctAnswerImage'] = this.correctAnswerImage;
    data['inCorrectAnswerImage'] = this.inCorrectAnswerImage;
    data['attemptTime'] = this.attemptTime;
    return data;
  }
}

class Answer {
  int answerId;
  String answer;
  int option;
  bool isSelected = false;

  Answer({this.answerId, this.answer});

  Answer.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
    answer = json['answer'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerId'] = this.answerId;
    data['answer'] = this.answer;
    data['option'] = this.option;
    return data;
  }
}
