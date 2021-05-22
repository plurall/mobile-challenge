class User {
  User();

  String nickname = '';
  String profilePhoto = '';
  String name = '';
  String location = '';
  String bio = '';
  String email = '';

  factory User.fromJson(Map<String, dynamic> json) {
    String _isJsonKeyAvailable(String json) {
      if (json == null || json.isEmpty) {
        return '';
      }
      return json;
    }

    User result = User()
      ..nickname = json['login']
      ..profilePhoto = json['avatar_url']
      ..name = _isJsonKeyAvailable(json['name'])
      ..location = _isJsonKeyAvailable(json['location'])
      ..bio = _isJsonKeyAvailable(json['bio'])
      ..email = _isJsonKeyAvailable(json['email']);

    return result;
  }
}
