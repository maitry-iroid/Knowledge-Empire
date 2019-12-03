// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_module_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningModuleData _$LearningModuleDataFromJson(Map<String, dynamic> json) {
  return LearningModuleData()
    ..moduleId = json['moduleId'] as String
    ..moduleName = json['moduleName'] as String
    ..moduleDescription = json['moduleDescription'] as String
    ..question = json['question'] as String
    ..isAssign = json['isAssign'] as String
    ..moduleStatus = json['moduleStatus'] as String
    ..companyId = json['companyId'] as String;
}

Map<String, dynamic> _$LearningModuleDataToJson(LearningModuleData instance) =>
    <String, dynamic>{
      'moduleId': instance.moduleId,
      'moduleName': instance.moduleName,
      'moduleDescription': instance.moduleDescription,
      'question': instance.question,
      'isAssign': instance.isAssign,
      'moduleStatus': instance.moduleStatus,
      'companyId': instance.companyId,

    };
