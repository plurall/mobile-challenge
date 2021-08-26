import '../../domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String? username;
  final String? imageUrl;

  ResultSearchModel({
    this.username,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': username,
      'avatar_url': imageUrl,
    };
  }

  factory ResultSearchModel.fromJson(Map<String, dynamic> map) {
    return ResultSearchModel(
      username: map['login'],
      imageUrl: map['avatar_url'],
    );
  }
}
