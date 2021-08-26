import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/features/data/drivers/users_driver.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/infra/cache/local_storage/local_storage.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/users_driver.dart';

class LocalStorageMock extends Mock implements LocalStorage {}

void main() {
  final localStorage = LocalStorageMock();
  final driver = UsersDriverImpl(localStorage);
  test('Should get the users favorite on cache', () async {
    when(() => localStorage.read(any()))
        .thenAnswer((_) async => getUsersFavoriteResponse);
    final result = await driver.getFavoritesUsers();
    expect(result, isA<List<User>>());
    expect(result[0].username, equals('AlexOliveira123'));
  });
}
