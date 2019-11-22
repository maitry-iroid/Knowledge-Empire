import 'package:json_annotation/json_annotation.dart';
import 'package:ke_employee/models/learning_module_data.dart';
import 'package:ke_employee/models/login_response_data.dart';

part 'learning_module_response.g.dart';

@JsonSerializable()
class LearningModuleResponse {
  String flag = "";
  String result = "";
  String msg = "";
  List<LearningModuleData> data ;

  LearningModuleResponse();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory LearningModuleResponse.fromJson(Map<dynamic, dynamic> json) =>
      _$LearningModuleResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LearningModuleResponseToJson(this);
}
