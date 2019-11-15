// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) {
  return LoginResponseData()
    ..userId = json['userId'] as String
    ..name = json['name'] as String
    ..phone = json['phone'] as String
    ..address = json['address'] as String
    ..createdAt = json['createdAt'] as String
    ..isPasswordChanged = json['isPasswordChanged'] as String
    ..accessToken = json['accessToken'] as String;
}

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'createdAt': instance.createdAt,
      'isPasswordChanged': instance.isPasswordChanged,
      'accessToken': instance.accessToken,
    };
