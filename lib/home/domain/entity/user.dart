class User {
  User({
    this.login,
    this.id,
    this.avatarUrl,
    this.location,
    this.email,
    this.bio,
  });

  final String login;
  final int id;
  final String avatarUrl;
  final String email;
  final String location;
  final String bio;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatarUrl': avatarUrl,
      'location': location,
      'email': email,
      'bio': bio,
    };
  }
}
