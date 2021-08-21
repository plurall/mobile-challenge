import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/errors/profile_errors.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/repositories/profile_repository.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/usecases/user_profile.dart';
import 'package:mocktail/mocktail.dart';

class ProfileRepositoryMock extends Mock implements ProfileRepository {}
void main() {

  final username = "joaoarmando";
  late final repository;
  late final UserProfileImpl usecase;

  setUpAll(() {
    repository = ProfileRepositoryMock();
    usecase = UserProfileImpl(repository);
  });

  test('Should return a UserDetailEntity', () async {
    final user = UserDetailEntity(
      login: username,
      avatarUrl: "https://randomurl.com/",
      name: "João Aramndo",
      location: "Petrópolis - RJ",
      email: "joaoaarmando@hotmail.com",
      bio: "Olá, Plurall!! ;)"
    );
    when(() => repository.getUserDetail(username)).thenAnswer((_) async => user);

    final result = await usecase(username);

    expect(result, user);
  });

  test('Should throws an exception if username is invalid', () async {
    final invalidUserName = "";
    when(() => repository.getUserDetail(invalidUserName)).thenThrow((_) async => InvalidUserName());

    final future =  usecase(invalidUserName);

    expect(future, throwsA(isA<InvalidUserName>()));
  });
}