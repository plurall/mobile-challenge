// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serach_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) {
  return SearchModel()
    ..totalCount = json['totalCount'] as int
    ..incompleteResults = json['incompleteResults'] as bool
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : SearchItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}
