import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_challenge/models/Users.dart';

class GetGitUsersAPI {
  static Future<List<Users>> getGitUsers() async {
    var url = "https://api.github.com/users";

    final response = await http.get(url);

    var responseJson = jsonDecode(response.body);

    final userList = List<Users>();
    
    if (response.statusCode == 200) {
      for (Map map in responseJson) {
        Users i = Users.fromJson(map);
        userList.add(i);
      }
    } else {
      print("erro");
    }
    return userList;
  }
}
