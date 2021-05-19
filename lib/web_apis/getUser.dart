import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_challenge/models/User.dart';

class GetGitUserAPI {
  static Future<User> getGitUser(userName) async {
    var url = "https://api.github.com/users/$userName";

    final response = await http.get(url);
    print(response.body);
    
    var map = json.decode(response.body);
    print(map);

    return map;
  }
}
