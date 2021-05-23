// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel()
    ..login = json['login'] as String
    ..id = json['id'] as int
    ..avatarUrl = json['avatar_url'] as String
    ..location = json['location'] as String
    ..bio = json['bio'] as String
    ..email = json['email'] as String
    ..name = json['name'] as String;
}
