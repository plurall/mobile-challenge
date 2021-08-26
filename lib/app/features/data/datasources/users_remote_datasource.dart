import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/data/datasources/users_datasource.dart';
import 'package:mobile_challenge/app/features/data/models/user_model.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client.dart';

@Singleton(as: UsersDatasource)
class UsersRemoteDatasource implements UsersDatasource {
  final RestClient _restClient;

  UsersRemoteDatasource({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<User> getUser(String username) async {
    final response = await _restClient.get('users/$username');
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw DatasourceError(
        message: 'Ocorreu um erro ao buscar os dados do usuário',
      );
    }
  }
}
