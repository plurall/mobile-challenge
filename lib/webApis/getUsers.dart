import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_challenge/models/Users.dart';

class GetGitUsersAPI {
  static Future<List<Users>> getGitUsers() async {
    var url = "https://api.github.com/users";

    var response;
    try {
      response = await http.get(url);
    } catch (e) {
      print(e.runtimeType);
      print("erro ${response.statusCode} || ${response.body}");
    }

    final userList = List<Users>();

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      for (Map map in responseJson) {
        Users i = Users.fromJson(map);
        userList.add(i);
      }
    }
    return userList;
  }
}
