class User {
  final int id;
  final String? name;
  final String login;
  final String avatar;
  final String? location;
  final String? email;
  final String? bio;

  User({
    required this.name,
    required this.id,
    required this.login,
    required this.bio,
    required this.avatar,
    required this.email,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
      login: json['login'],
      bio: json['bio'],
      avatar: json['avatar_url'],
      email: json['email'],
      location: json['location'],
    );
  }

  Map<String, Object> toMap() => {
        'id': id,
        'login': login,
        'avatar': avatar,
        'name': name ?? '',
        'bio': bio ?? '',
        'location': location ?? '',
        'email': email ?? '',
      };
}
