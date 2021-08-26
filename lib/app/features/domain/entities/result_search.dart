import 'package:equatable/equatable.dart';

class ResultSearch extends Equatable {
  final String? username;
  final String? imageUrl;

  ResultSearch({this.username, this.imageUrl});

  @override
  List<Object?> get props => [username, imageUrl];
}
