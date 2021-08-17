class UserDetailEntity {
  final String login;
  final String? bio;
  final String? name;
  final String? location;
  final String? email;
  final String avatarUrl;

  UserDetailEntity({required this.login, required this.bio, required this.name, 
  required this.location, required this.email, required this.avatarUrl});
}