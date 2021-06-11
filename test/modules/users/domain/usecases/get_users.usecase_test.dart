import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_users.repository.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.impl.dart';
import 'package:mockito/mockito.dart';

class GetUsersRepositoryMock extends Mock implements GetUsersRepository {}

main() {
  final GetUsersRepository _repository = GetUsersRepositoryMock();
  GetUsersUsecase _usecase;
  var input = 1;
  var resultSuccess = Right<Exception, List<UserEntity>>(
      [UserEntity(id: 1, avatarUrl: "", login: "")]);
  var resultError = Left<Exception, List<UserEntity>>(Exception(null));

  setUp(() {
    _usecase = GetUsersUsecaseImpl(_repository);
  });

  test('Should usecase call repository', () async {
    await _usecase(input);
    verify(_repository(input)).called(1);
  });

  test('Should return UserEntity when call usecase', () async {
    when(_repository(input)).thenAnswer((_) async => resultSuccess);
    var result = await _usecase(input);
    expect(result, resultSuccess);
  });

  test('Should return Excption when usecase is call', () async {
    when(_repository(input)).thenAnswer((_) async => resultError);
    var result = await _usecase(input);
    expect(result, resultError);
  });
}
