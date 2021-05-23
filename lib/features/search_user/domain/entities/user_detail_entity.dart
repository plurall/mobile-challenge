import 'package:equatable/equatable.dart';

class UserDetailEntity extends Equatable {
  final String image;
  final String? location;
  final String? bio;
  final String nickname;
  final String? email;

  UserDetailEntity({
    required this.image,
    this.location,
    this.bio,
    required this.nickname,
    this.email,
  });

  @override
  List<Object?> get props => [
        image,
        location,
        bio,
        nickname,
        email,
      ];
}
