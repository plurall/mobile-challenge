import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/datasources/profile_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/repositories/profile_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class ProfileDatasourceMock extends Mock implements ProfileDatasource {}
void main() {
  final String username = "joaoarmando";
  final user = UserDetailModel(
    login: username,
    avatarUrl: "https://randomurl.com/",
    name: "João Aramndo",
    location: "Petrópolis - RJ",
    email: "joaoaarmando@hotmail.com",
    bio: "Olá, Plurall!! ;)"
  );
  late ProfileDatasourceMock datasource;
  late  ProfileRepositoryImpl repository;

  setUpAll(() {
    datasource = ProfileDatasourceMock();
    repository = ProfileRepositoryImpl(datasource);
  });  

  test('Should return a UserDetailEntity', () async {
    
    when(() => datasource.getUser(username)).thenAnswer((_) async => user);

    final result = await repository.getUserDetail(username);

    expect(result, isA<UserDetailEntity>());
    expect(result.name, user.name);
    expect(result.login, user.login);
    expect(result.location, user.location);
    expect(result.bio, user.bio);
    expect(result.email, user.email);
  });
}