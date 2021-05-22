import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_challenge/app/shared/model/serach_item/search_item_model.dart';

part 'serach_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: true)
class SearchModel {
  @JsonValue('total_count')
  int totalCount;
  @JsonValue('incomplete_results')
  bool incompleteResults;
  List<SearchItemModel> items;

  SearchModel();

  factory SearchModel.fromJson(Map<String, dynamic> json) => _$SearchModelFromJson(json);
}