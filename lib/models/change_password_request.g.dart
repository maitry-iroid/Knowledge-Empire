// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
    Map<String, dynamic> json) {
  return ChangePasswordRequest()
    ..userId = json['userId'] as String
    ..password = json['password'] as String
    ..oldPassword = json['oldPassword'] as String;
}

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'password': instance.password,
      'oldPassword': instance.oldPassword,
    };
