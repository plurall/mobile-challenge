final String tableFavorites = 'FavoritesModels';

class FavoritesFields {
  static final List<String> values = [
    // Adicone todas as fields
    id,
    login,
    email,
    location,
    bio,
    time,
  ];

  static final String id = '_id';
  static final String time = 'time';
  static final String login = 'login';
  static final String email = 'email';
  static final String location = 'location';
  static final String bio = 'bio';
}

class FavoritesModel {
  final int id;
  final String login;
  final String email;
  final String location;
  final String bio;
  // final DateTime createdTime;

  const FavoritesModel({
    this.id,
    this.login,
    this.email,
    this.location,
    // this.createdTime,
    this.bio,
  });

  FavoritesModel copy({
    int id,
    bool login,
    String email,
    String location,
    // DateTime createdTime,
    String bio,
  }) =>
      FavoritesModel(
        id: id ?? this.id,
        login: login ?? this.login,
        email: email ?? this.email,
        location: location ?? this.location,
        // createdTime: createdTime ?? this.createdTime,
        bio: bio ?? this.bio,
      );

  static FavoritesModel fromJson(Map<String, Object> json) => FavoritesModel(
        id: json[FavoritesFields.id] as int,
        login: json[FavoritesFields.login] as String,
        email: json[FavoritesFields.email] as String,
        location: json[FavoritesFields.location] as String,
        // createdTime: DateTime.parse(json[FavoritesFields.time] as String),
        bio: json[FavoritesFields.bio] as String,
      );

  Map<String, Object> toJson() => {
        FavoritesFields.id: id,
        FavoritesFields.login: login,
        FavoritesFields.email: email,
        FavoritesFields.location: location,
        FavoritesFields.bio: bio,
        // FavoritesFields.time: createdTime.toIso8601String(),
      };
}
