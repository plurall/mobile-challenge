import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/users/data/datasource/get_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/external/get_users.datasource.impl.dart';
import 'package:mobile_challenge/app/shared/failures/failure_system.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final Dio _dio = DioMock();
  final String route = "/users";
  GetUsersDatasource _datasource;
  String input = "a";
  var successDioResponse = Response(data: [
    {"id": 11, "login": "", "avatar_url": ""}
  ], statusCode: 200);

  var errorDioResponse = Response(data: [
    {"id": 11, "login": "", "avatar_url": ""}
  ], statusCode: 400);

  setUp(() {
    _datasource = GetUsersDatasourceImpl(_dio);
  });

  test('Should call dio method when datasource is call', () async {
    when(_dio.get(route + "/$input"))
        .thenAnswer((_) async => successDioResponse);
    await _datasource(input);
    verify(_dio.get(route + "/$input")).called(1);
  });

  test('Should datasource return UserModel', () async {
    when(_dio.get(route + "/$input"))
        .thenAnswer((_) async => successDioResponse);
    var result = await _datasource(input);
    var responseSuccess = [UserModel(id: 11, login: "", avatarUrl: "")];

    expect(result is List<UserModel>, true);
    expect(result.length, responseSuccess.length);
    expect(result.first, responseSuccess.first);
  });

  test('Should datasource return error', () async {
    when(_dio.get(route + "/$input"))
        .thenAnswer((_) async => throw Response(data: null));
    try {
      await _datasource(input);
    } catch (e) {
      expect((e as FailureSystem).type, ErrorSystem.CONNECTION);
    }
  });

  test('Should datasource return error when status code diferent 200',
      () async {
    when(_dio.get(route + "/$input"))
        .thenAnswer((_) async => throw errorDioResponse);
    try {
      await _datasource(input);
    } catch (e) {
      expect((e as FailureSystem).type, ErrorSystem.CONNECTION);
    }
  });
}
