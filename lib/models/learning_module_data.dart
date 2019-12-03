import 'package:json_annotation/json_annotation.dart';

part 'learning_module_data.g.dart';

@JsonSerializable()
class LearningModuleData {
  String moduleId = "";
  String moduleName = "";
  String moduleDescription = "";
  String question = "";
  String isAssign = "";
  String moduleStatus = "";
  String companyId = "";

  LearningModuleData();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory LearningModuleData.fromJson(Map<dynamic, dynamic> json) =>
      _$LearningModuleDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LearningModuleDataToJson(this);
}


/*class LearningModuleResponse {
  String _flag;
  String _result;
  String _msg;
  List<LearningModuleData> _learningModuleData;

  LearningModuleResponse(
      {String flag,
        String result,
        String msg,
        List<LearningModuleData> learningModuleData}) {
    this._flag = flag;
    this._result = result;
    this._msg = msg;
    this._learningModuleData = learningModuleData;
  }

  String get flag => _flag;
  set flag(String flag) => _flag = flag;
  String get result => _result;
  set result(String result) => _result = result;
  String get msg => _msg;
  set msg(String msg) => _msg = msg;
  List<LearningModuleData> get learningModuleData => _learningModuleData;
  set learningModuleData(List<LearningModuleData> learningModuleData) =>
      _learningModuleData = learningModuleData;

  LearningModuleResponse.fromJson(Map<String, dynamic> json) {
    _flag = json['flag'];
    _result = json['result'];
    _msg = json['msg'];
    if (json['LearningModuleData'] != null) {
      _learningModuleData = new List<LearningModuleData>();
      json['LearningModuleData'].forEach((v) {
        _learningModuleData.add(new LearningModuleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this._flag;
    data['result'] = this._result;
    data['msg'] = this._msg;
    if (this._learningModuleData != null) {
      data['LearningModuleData'] =
          this._learningModuleData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LearningModuleData {
  String _moduleId;
  String _moduleName;
  String _moduleDescription;
  int _question;
  String _isAssign;
  String _companyId;
  String _moduleStatus;

  LearningModuleData(
      {String moduleId,
        String moduleName,
        String moduleDescription,
        int question,
        String isAssign,
        String companyId,
        String moduleStatus}) {
    this._moduleId = moduleId;
    this._moduleName = moduleName;
    this._moduleDescription = moduleDescription;
    this._question = question;
    this._isAssign = isAssign;
    this._companyId = companyId;
    this._moduleStatus = moduleStatus;
  }

  String get moduleId => _moduleId;
  set moduleId(String moduleId) => _moduleId = moduleId;
  String get moduleName => _moduleName;
  set moduleName(String moduleName) => _moduleName = moduleName;
  String get moduleDescription => _moduleDescription;
  set moduleDescription(String moduleDescription) =>
      _moduleDescription = moduleDescription;
  int get question => _question;
  set question(int question) => _question = question;
  String get isAssign => _isAssign;
  set isAssign(String isAssign) => _isAssign = isAssign;
  String get companyId => _companyId;
  set companyId(String companyId) => _companyId = companyId;
  String get moduleStatus => _moduleStatus;
  set moduleStatus(String moduleStatus) => _moduleStatus = moduleStatus;

  LearningModuleData.fromJson(Map<String, dynamic> json) {
    _moduleId = json['moduleId'];
    _moduleName = json['moduleName'];
    _moduleDescription = json['moduleDescription'];
    _question = json['question'];
    _isAssign = json['isAssign'];
    _companyId = json['companyId'];
    _moduleStatus = json['moduleStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleId'] = this._moduleId;
    data['moduleName'] = this._moduleName;
    data['moduleDescription'] = this._moduleDescription;
    data['question'] = this._question;
    data['isAssign'] = this._isAssign;
    data['companyId'] = this._companyId;
    data['moduleStatus'] = this._moduleStatus;
    return data;
  }
}*/
