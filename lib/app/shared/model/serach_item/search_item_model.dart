import 'package:json_annotation/json_annotation.dart';

part 'search_item_model.g.dart';

@JsonSerializable(createToJson: false)
class SearchItemModel{
  String login;
  int id;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;

  SearchItemModel();

  factory SearchItemModel.fromJson(Map<String, dynamic> json) => _$SearchItemModelFromJson(json);
}