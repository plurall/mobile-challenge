import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/repositories/user_repository.dart';
import 'package:mobile_challenge/services/dio_http_service.dart';

void main() {
  final clientHttp = DioService();
  final repository = UserRepository(clientHttp);

  group('Caso de Teste: Pesquisar os Usuários no Github', () {
    test('Pesquisa com resultados', () async {
      var response = await repository.searchAUser('alexandre', 1);

      expect(response.users.length, isNot(0));
      expect(response.users, isNot([]));
    });

    test('Pesquisa com resultados de inexistente', () async {
      var response = await repository.searchAUser('alexandre12323232', 1);

      expect(response.totalCount, 0);
      expect(response.users, isEmpty);
    });
  });
}
