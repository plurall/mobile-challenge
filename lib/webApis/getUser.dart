import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_challenge/models/User.dart';

class GetGitUserAPI {
  static Future<User> getGitUser(String userName) async {
    String url = "https://api.github.com/users/$userName";
    var headers = {"Accept": "application/vnd.github.v3+json"};

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        try {
          return User.fromJson(jsonDecode(response.body));
        } catch (e) {
          print(e.runtimeType);
          print("erro ${response.statusCode} || ${response.body}");
          throw Exception('Falhou por ${e.hashCode}');
        }
      } else {
        throw Exception('Falhou');
      }
    } catch (e) {
      print(e.runtimeType);
      throw Exception('Falhou por ${e.hashCode}');
    }
  }
}
