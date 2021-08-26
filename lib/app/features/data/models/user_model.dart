import '../../domain/entities/user.dart';

class UserModel extends User {
  final String username;
  final String? imageUrl;
  final String? location;
  final String? bio;
  final String? email;

  UserModel({
    required this.username,
    this.imageUrl,
    this.location,
    this.bio,
    this.email,
  }) : super(username: username);

  Map<String, dynamic> toJson() {
    return {
      'login': username,
      'avatar_url': imageUrl,
      'location': location,
      'bio': bio,
      'email': email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      username: map['login'],
      imageUrl: map['avatar_url'],
      location: map['location'],
      bio: map['bio'],
      email: map['email'],
    );
  }
}
