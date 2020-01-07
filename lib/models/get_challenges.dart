class GetChallengesRequest {
  String userId;
  String challengeId;

  GetChallengesRequest({this.userId, this.challengeId});

  GetChallengesRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    challengeId = json['challengeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['challengeId'] = this.challengeId;
    return data;
  }
}


class GetChallengesResponse {
  String flag;
  String result;
  String msg;
  List<GetChallengeData> data;

  GetChallengesResponse({this.flag, this.result, this.msg, this.data});

  GetChallengesResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<GetChallengeData>();
      json['data'].forEach((v) {
        data.add(new GetChallengeData.fromJson(v));
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

class GetChallengeData {
  String firstName;
  String lastName;
  String profileImage;
  List<Challenge> challenge;

  GetChallengeData({this.firstName, this.lastName, this.profileImage, this.challenge});

  GetChallengeData.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileImage = json['profileImage'];
    if (json['challenge'] != null) {
      challenge = new List<Challenge>();
      json['challenge'].forEach((v) {
        challenge.add(new Challenge.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profileImage'] = this.profileImage;
    if (this.challenge != null) {
      data['challenge'] = this.challenge.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Challenge {
  int questionId;
  String title;
  String question;
  String correctAnswerId;
  String description;
  String mediaLink;
  String correctAnswerImage;
  String inCorrectAnswerImage;
  String supportFileType;
  int videoPlay;
  int videoLoop;
  List<Answer> answer;

  Challenge(
      {this.questionId,
        this.title,
        this.question,
        this.correctAnswerId,
        this.description,
        this.mediaLink,
        this.correctAnswerImage,
        this.inCorrectAnswerImage,
        this.supportFileType,
        this.videoPlay,
        this.videoLoop,
        this.answer});

  Challenge.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    title = json['title'];
    question = json['question'];
    correctAnswerId = json['correctAnswerId'];
    description = json['description'];
    mediaLink = json['mediaLink'];
    correctAnswerImage = json['correctAnswerImage'];
    inCorrectAnswerImage = json['inCorrectAnswerImage'];
    supportFileType = json['supportFileType'];
    videoPlay = json['videoPlay'];
    videoLoop = json['videoLoop'];
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
    data['correctAnswerId'] = this.correctAnswerId;
    data['description'] = this.description;
    data['mediaLink'] = this.mediaLink;
    data['correctAnswerImage'] = this.correctAnswerImage;
    data['inCorrectAnswerImage'] = this.inCorrectAnswerImage;
    data['supportFileType'] = this.supportFileType;
    data['videoPlay'] = this.videoPlay;
    data['videoLoop'] = this.videoLoop;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  int option;
  String answerId;
  String answer;

  Answer({this.option, this.answerId, this.answer});

  Answer.fromJson(Map<String, dynamic> json) {
    option = json['option'];
    answerId = json['answerId'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option'] = this.option;
    data['answerId'] = this.answerId;
    data['answer'] = this.answer;
    return data;
  }
}
