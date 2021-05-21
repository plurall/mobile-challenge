import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String nickname;
  final String image;

  UserEntity({
    required this.nickname,
    required this.image,
  });

  @override
  List<Object?> get props => [
        nickname,
        image,
      ];
}
