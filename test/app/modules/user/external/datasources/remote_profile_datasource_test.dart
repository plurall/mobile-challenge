import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile_challenge/app/modules/user/external/datasources/remote_profile_datasource.dart';
import 'package:mobile_challenge/app/modules/user/domain/errors/profile_errors.dart';
import 'package:mobile_challenge/app/modules/user/data/models/user_detail_model.dart';
import 'package:mobile_challenge/app/shared/utils/endpoints.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';




class ClientMock extends Mock implements Client {}

void main() {
  final username = "joaoarmando";
  final userDetailEndpoint = Uri.parse(Endpoints.userDetail + username);
  late final client;
  late final datasource;

  setUpAll(() {
    client = ClientMock();
    datasource = RemoteProfileDatasourceImpl(client);
  });

  test('Should call get with correct endpoint', () async {
    when(() => client.get(userDetailEndpoint))
      .thenAnswer((_) async => Response(fixture("user_detail_response.json"), 200));

    await datasource.getUser(username);

    verify(() => client.get(userDetailEndpoint));
  });

  test('Should return a UserDetailModel', () async {
    when(() => client.get(userDetailEndpoint))
      .thenAnswer((_) async => Response(fixture("user_detail_response.json"), 200));

    final result = await datasource.getUser(username);

    expect(result, isA<UserDetailModel>());
  });

  test('Should throws an UnauthorizedError if status code is 401', () async {
    when(() => client.get(userDetailEndpoint))
      .thenAnswer((_) async => Response("{}", 401));

    final future = datasource.getUser(username);

    expect(future, throwsA(isA<UnauthorizedError>()));
  });

  
}
