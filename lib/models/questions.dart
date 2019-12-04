
class QuestionRequest {
  String userId="";
  String moduleId ="";

  QuestionRequest({this.userId, this.moduleId});

  QuestionRequest.fromJson(Map<String, dynamic> json) {
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


class QuestionsResponse {
  String flag="";
  String result="";
  String msg="";
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
  String questionId="";
  String title="";
  String question="";
  String moduleName="";
  String description="";
  String correctAnswerId="";
  String loyalty="";
  String resource="";
  String value="";
  String mediaLink="";
  List<Answer> answer = List();
  int counter=0;
  int daysInList=0;

  QuestionData();

  QuestionData.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    title = json['title'];
    question = json['question'];
    moduleName = json['moduleName'];
    description = json['description'];
    correctAnswerId = json['correctAnswerId'];
    loyalty = json['loyalty'];
    resource = json['resource'];
    value = json['value'];
    mediaLink = json['mediaLink'];
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['title'] = this.title;
    data['question'] = this.question;
    data['moduleName'] = this.moduleName;
    data['description'] = this.description;
    data['correctAnswerId'] = this.correctAnswerId;
    data['loyalty'] = this.loyalty;
    data['resource'] = this.resource;
    data['value'] = this.value;
    data['mediaLink'] = this.mediaLink;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  String answerId="";
  String answer="";
  bool isSelected = false;

  Answer({this.answerId, this.answer});

  Answer.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerId'] = this.answerId;
    data['answer'] = this.answer;
    return data;
  }
}
