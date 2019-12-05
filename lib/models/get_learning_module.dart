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
  String moduleId="";
  String moduleName="";
  String moduleDescription="";
  String question="";
  String isAssign="";
  String companyId="";
  String moduleStatus="";

  LearningModuleData();

  LearningModuleData.fromJson(Map<String, dynamic> json) {
    moduleId = json['moduleId'];
    moduleName = json['moduleName'];
    moduleDescription = json['moduleDescription'];
    question = json['question'];
    isAssign = json['isAssign'];
    companyId = json['companyId'];
    moduleStatus = json['moduleStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleId'] = this.moduleId;
    data['moduleName'] = this.moduleName;
    data['moduleDescription'] = this.moduleDescription;
    data['question'] = this.question;
    data['isAssign'] = this.isAssign;
    data['companyId'] = this.companyId;
    data['moduleStatus'] = this.moduleStatus;
    return data;
  }
}
