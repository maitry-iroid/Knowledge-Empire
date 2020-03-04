
class GetLearningModuleRequest {
  int userId;
  int isChallenge;

  GetLearningModuleRequest({this.userId, this.isChallenge});

  GetLearningModuleRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isChallenge = json['isChallenge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['isChallenge'] = this.isChallenge;
    return data;
  }
}


class LearningModuleResponse {
  String flag="";
  String result="";
  String msg="";
  List<LearningModuleData> data;

  LearningModuleResponse({this.flag, this.result, this.msg, this.data});

  LearningModuleResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<LearningModuleData>();
      json['data'].forEach((v) {
        data.add(new LearningModuleData.fromJson(v));
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

class LearningModuleData {
  int moduleId;
  String moduleName="";
  String moduleDescription="";
  String question="";
  int isAssign;
  int companyId;
  int isDownloadEnable;
  int moduleProgress;
  int isSubscribedFromBackend;
  var fileSize;
  bool isDownloading = false;
  int index;


  LearningModuleData();

  LearningModuleData.fromJson(Map<String, dynamic> json) {
    moduleId = json['moduleId'];
    moduleName = json['moduleName'];
    moduleDescription = json['moduleDescription'];
    question = json['question'];
    isAssign = json['isAssign'];
    companyId = json['companyId'];
    isDownloadEnable = json['isDownloadEnable'];
    moduleProgress = json['moduleProgress'];
    isSubscribedFromBackend = json['isSubscribedFromBackend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleId'] = this.moduleId;
    data['moduleName'] = this.moduleName;
    data['moduleDescription'] = this.moduleDescription;
    data['question'] = this.question;
    data['isAssign'] = this.isAssign;
    data['companyId'] = this.companyId;
    data['isDownloadEnable'] = this.isDownloadEnable;
    data['moduleProgress'] = this.moduleProgress;
    data['isSubscribedFromBackend'] = this.isSubscribedFromBackend;
    return data;
  }
}

class AssignModuleRequest {
  int userId;
  int companyId;
  int moduleId;
  int type;

  AssignModuleRequest({this.userId, this.companyId, this.moduleId, this.type});

  AssignModuleRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    companyId = json['companyId'];
    moduleId = json['moduleId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['companyId'] = this.companyId;
    data['moduleId'] = this.moduleId;
    data['type'] = this.type;
    return data;
  }
}

