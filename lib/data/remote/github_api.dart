import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/data/model/user.dart';

class GithubAPI {
  final String domain = 'https://api.github.com';

  Future<List<User>> getUsers(String search) async {
    final String path = '/search/users';
    final response = await http.get(Uri.parse('$domain$path?q=$search'));

    //debug - dados server
    Map mapRes = jsonDecode(response.body);
    print('Response from server: $mapRes');
    //

    if (response.statusCode == 200) {
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['items'] == null) {
        return throw Exception('Error loading users');
      }
      return (jsonResponse['items'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    }

    return throw Exception('Error loading users');
  }
}
