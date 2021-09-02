import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/core/errors/remote_exception.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/domain/repositories/search_remote_interface.dart';
import 'package:dartz/dartz.dart';

class SearchRemoteRepository implements SearchRemoteInterface {
  final String domain = 'https://api.github.com';
  final String token = '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';

  getHeaders() => {
        HttpHeaders.authorizationHeader: 'token $token',
      };

  Future<Either<RemoteException, List<User>>> searchUsers(String search) async {
    final String path = '/search/users';
    final response = await http.get(
      Uri.parse('$domain$path?q=$search'),
      headers: getHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //print('User summary from server: $jsonResponse');

      final userList = (jsonResponse['items'] as List)
          .map((user) => User.fromJson(user))
          .toList();

      return Right(userList);
    }

    final remoteErrorMessage = jsonDecode(response.body)['message'];
    print(remoteErrorMessage);

    return Left(
      RemoteException('Não foi possível carregar os dados dos usuários.'),
    );
  }

  Future<Either<RemoteException, User>> getUser(String login) async {
    final String path = '/users/';
    final response = await http.get(
      Uri.parse('$domain$path$login'),
      headers: getHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //print('User profile from server: $jsonResponse');

      final user = User.fromJson(jsonResponse);
      return Right(user);
    }

    final remoteErrorMessage = jsonDecode(response.body)['message'];
    print(remoteErrorMessage);

    return Left(
      RemoteException('Não foi possível carregar os dados do usuário.'),
    );
  }
}
