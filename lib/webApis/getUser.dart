import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_challenge/models/User.dart';

class GetGitUserAPI {
  static Future<User> getGitUser(String userName) async {
    var url = "https://api.github.com/users/$userName";

    var response;

    try {
      response = await http.get(url);
    } catch (e) {
      print(e.runtimeType);
      print("erro ${response.statusCode} || ${response.body}");
    }

    User user = User();
    if (response.statusCode == 200) {
      try {
        user = jsonDecode(response.body);
      } on TypeError catch (e) {
        print(e.runtimeType);
      }
    }

    return user;
  }
}
