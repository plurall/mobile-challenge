import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/data/model/user_summary.dart';
import 'package:mobile_challenge/data/model/user_profile.dart';

class GithubAPI {
  final String domain = 'https://api.github.com';

  Future<List<UserSummary>> getUsers(String search) async {
    final String path = '/search/users';
    final response = await http.get(Uri.parse('$domain$path?q=$search'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('User summary from server: $jsonResponse');

      if (jsonResponse['items'] == null) {
        return throw Exception('Error loading users');
      }
      return (jsonResponse['items'] as List)
          .map((user) => UserSummary.fromJson(user))
          .toList();
    }
    return throw Exception(jsonDecode(response.body)['message']);
  }

  Future<UserProfile> getUser(String login) async {
    final String path = '/users/';
    final response = await http.get(Uri.parse('$domain$path$login'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('User profile from server: $jsonResponse');

      return UserProfile.fromJson(jsonResponse);
    }

    return throw Exception(jsonDecode(response.body)['message']);
    /*return UserProfile(
        name: 'teste',
        id: 10,
        login: 'teste',
        bio: 'teste',
        avatar: 'https://avatars.githubusercontent.com/u/1655785?v=4',
        email: 'teste@gmail.com',
        location: 'SP');*/
  }
}
