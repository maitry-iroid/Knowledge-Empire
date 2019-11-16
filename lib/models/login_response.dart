import 'package:json_annotation/json_annotation.dart';
import 'package:ke_employee/models/login_response_data.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String flag = "";
  String result = "";
  String msg = "";
  LoginResponseData data ;

  LoginResponse();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory LoginResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
