import 'dart:convert';
import 'package:http/http.dart' as http;


Future<ClassJson> jsonUrl(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return ClassJson.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao carregar');
  }
}

class ClassJson {
  int id;
  String login;
  String location;
  String bio;
  String name;
  String email;
  String avatarUrl;

  ClassJson({this.id, this.login, this.location, this.bio, this.name, this.email, this.avatarUrl});

  Map<String, dynamic> toMap(){
    return {
      'id'         : id,
      'login'      : login,
      'location'   : location,
      'bio'        : bio,
      'name'       : name,
      'email'      : email

    };
  }

  factory ClassJson.fromJson(Map<String, dynamic> json) {
    return ClassJson(
        id          : json['id'],
        login       : json['login'],
        location    : json['location'],
        bio         : json['bio'],
        name        : json['name'],
        email       : json['email'],
        avatarUrl  : json['avatar_url']
    );
  }
}
