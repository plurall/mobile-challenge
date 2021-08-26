import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String? imageUrl;
  final String? location;
  final String? bio;
  final String? email;

  User({
    required this.username,
    this.imageUrl,
    this.location,
    this.bio,
    this.email,
  });

  @override
  List<Object?> get props => [username, imageUrl, location, bio, email];
}
