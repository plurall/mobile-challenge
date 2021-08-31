import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/data/errors/remote_exception.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/data/remote/search_remote_interface.dart';

class SearchRemote implements SearchRemoteInterface {
  final String domain = 'https://api.github.com';
  final String token = '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';

  getHeaders() => {
        HttpHeaders.authorizationHeader: 'token $token',
      };

  Future<List<User>> getUsers(String search) async {
    final String path = '/search/users';
    final response = await http.get(
      Uri.parse('$domain$path?q=$search'),
      headers: getHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //print('User summary from server: $jsonResponse');

      return (jsonResponse['items'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    }

    final remoteErrorMessage = jsonDecode(response.body)['message'];
    print(remoteErrorMessage);

    return throw RemoteException(
        'Não foi possível carregar os dados dos usuários.');
  }

  Future<User> getUser(String login) async {
    final String path = '/users/';
    final response = await http.get(
      Uri.parse('$domain$path$login'),
      headers: getHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //print('User profile from server: $jsonResponse');

      return User.fromJson(jsonResponse);
    }

    final remoteErrorMessage = jsonDecode(response.body)['message'];
    print(remoteErrorMessage);

    return throw RemoteException(
        'Não foi possível carregar os dados do usuário.');
  }
}
