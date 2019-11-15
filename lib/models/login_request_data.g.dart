// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestData _$LoginRequestDataFromJson(Map<String, dynamic> json) {
  return LoginRequestData()
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..secret = json['secret'] as String;
}

Map<String, dynamic> _$LoginRequestDataToJson(LoginRequestData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'secret': instance.secret,
    };
