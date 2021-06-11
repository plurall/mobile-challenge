import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/users/data/datasource/get_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/data/repositories/get_users.repository.impl.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_users.repository.dart';
import 'package:mockito/mockito.dart';

class GetUsersDatasourceMock extends Mock implements GetUsersDatasource {}

main() {
  final GetUsersDatasource _datasource = GetUsersDatasourceMock();
  GetUsersRepository _repository;
  int input = 1;
  var resultSuccess = [UserModel(id: 11, avatarUrl: "", login: "")];
  var resultError = Exception(null);

  setUp(() {
    _repository = GetUsersRepositoryImpl(_datasource);
  });

  test('Should datasource is call when repository call', () async {
    when(_datasource(input)).thenAnswer((_) async => resultSuccess);
    await _repository(input);
    verify(_datasource(input)).called(1);
  });

  test('Should repository return entity', () async {
    when(_datasource(input)).thenAnswer((_) async => resultSuccess);
    var result = await _repository(input);
    var resultResponse = [];
    var responseSuccess = [UserEntity(id: 11, login: "", avatarUrl: "")];
    result.fold((l) => null, (r) => resultResponse = r);

    expect(result is Right, true);
    expect(resultResponse.length, responseSuccess.length);
    expect(resultResponse.first, responseSuccess.first);
  });

  test('Should repository return error', () async {
    var errorResponse = Left<Exception, List<UserEntity>>(resultError);
    when(_datasource(input)).thenAnswer((_) async => throw resultError);
    var result = await _repository(input);
    expect(result, errorResponse);
  });
}
