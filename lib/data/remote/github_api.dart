import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/data/model/user.dart';

class GithubAPI {
  static final String domain = 'https://api.github.com';

  static Future<List<User>> getUsers(String search) async {
    final String path = '/search/users';
    final response = await http.get(Uri.parse('$domain$path?q=$search'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //print('User summary from server: $jsonResponse');

      if (jsonResponse['items'] == null) {
        return throw Exception('Error loading users');
      }
      return (jsonResponse['items'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    }
    return throw Exception(jsonDecode(response.body)['message']);
  }

  static Future<User> getUser(String login) async {
    final String path = '/users/';
    final response = await http.get(Uri.parse('$domain$path$login'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //print('User profile from server: $jsonResponse');

      return User.fromJson(jsonResponse);
    }

    return throw Exception(jsonDecode(response.body)['message']);
  }
}
