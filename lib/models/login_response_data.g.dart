// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) {
  return LoginResponseData()
    ..userId = json['userId'] as String
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..address = json['address'] as String
    ..createdAt = json['createdAt'] as String
    ..isPasswordChanged = json['isPasswordChanged'] as String
    ..profileImage = json['profileImage'] as String
    ..accessToken = json['accessToken'] as String
    ..activeCompany = json['activeCompany'] as String
    ..country = json['country'] as String
    ..companyName = json['companyName'] as String
    ..manager = json['manager'] as String;
}

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'createdAt': instance.createdAt,
      'isPasswordChanged': instance.isPasswordChanged,
      'profileImage': instance.profileImage,
      'accessToken': instance.accessToken,
      'activeCompany': instance.activeCompany,
      'country': instance.country,
      'companyName': instance.companyName,
      'manager': instance.manager,
    };
