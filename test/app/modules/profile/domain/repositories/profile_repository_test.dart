import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/profile/domain/models/user_detail_model.dart';
import 'package:mobile_challenge/app/modules/profile/infra/datasources/profile_datasource.dart';
import 'package:mobile_challenge/app/modules/profile/infra/repositories/profile_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class ProfileDatasourceMock extends Mock implements ProfileDatasource {}
void main() {
  test('Should return a UserDetailEntity', () async {
    final String username = "joaoarmando";
    final user = UserDetailModel(
      login: username,
      avatarUrl: "https://randomurl.com/",
      name: "João Aramndo",
      bio: "Olá, Plurall!! ;)"
    );
    final datasource = ProfileDatasourceMock();
    final repository = ProfileRepositoryImpl(datasource);
    when(() => datasource.getUser(username)).thenAnswer((_) async => user);

    final result = await repository.getUserDetail(username);

    expect(result, isA<UserDetailEntity>());
  });
}