import 'package:json_annotation/json_annotation.dart';

part 'login_request_data.g.dart';

@JsonSerializable()
class LoginRequestData {
  String email = "";
  String password = "";
  String secret = "";

  LoginRequestData();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory LoginRequestData.fromJson(Map<dynamic, dynamic> json) =>
      _$LoginRequestDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LoginRequestDataToJson(this);
}
