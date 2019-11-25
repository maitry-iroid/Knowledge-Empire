// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_module_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningModuleResponse _$LearningModuleResponseFromJson(
    Map<String, dynamic> json) {
  return LearningModuleResponse()
    ..flag = json['flag'] as String
    ..result = json['result'] as String
    ..msg = json['msg'] as String
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : LearningModuleData.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$LearningModuleResponseToJson(
        LearningModuleResponse instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'result': instance.result,
      'msg': instance.msg,
      'data': instance.data,
    };
