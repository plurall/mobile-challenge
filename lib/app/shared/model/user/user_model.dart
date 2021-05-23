import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel{
  String login;
  int id;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;
  String location;
  String bio;
  String email;
  String name;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}