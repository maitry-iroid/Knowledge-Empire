import 'package:json_annotation/json_annotation.dart';

part 'login_response_data.g.dart';

@JsonSerializable()
class LoginResponseData {
  String userId = "";
  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  String createdAt = "";
  String isPasswordChanged = "";
  String profileImage = "";
  String accessToken = "";
  String activeCompany = "";
  String country = "";
  String companyName = "";
  String manager = "";

  LoginResponseData();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory LoginResponseData.fromJson(Map<dynamic, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
