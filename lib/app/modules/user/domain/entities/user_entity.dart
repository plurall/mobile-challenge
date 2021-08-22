class UserEntity {
  final String login;
  final String? bio;
  final String? name;
  final String? location;
  final String? email;
  final String avatarUrl;

  UserEntity({required this.login, this.bio, this.name, 
  this.location, this.email, required this.avatarUrl});
}