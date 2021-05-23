import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/models/Users.dart';

void main() {
  test('Teste da função de favorito', () {
    Users user;
    final users = user.returnIsFavorited(true);
    expect(users, false);
  });
}
