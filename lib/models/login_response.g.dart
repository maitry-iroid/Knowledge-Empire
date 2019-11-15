// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse()
    ..flag = json['flag'] as String
    ..result = json['result'] as String
    ..msg = json['msg'] as String
    ..data = json['data'] == null
        ? null
        : LoginResponseData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'result': instance.result,
      'msg': instance.msg,
      'data': instance.data,
    };
