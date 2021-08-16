import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile_challenge/app/modules/profile/data/remote_profile_datasource.dart';
import 'package:mobile_challenge/app/modules/profile/domain/models/user_detail_model.dart';
import 'package:mobile_challenge/app/shared/utils/endpoints.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class ClientMock extends Mock implements Client {}

void main() {
  test('Should return a UserDetailModel', () async {
    final username = "joaoarmando";
    final client = ClientMock();
    final datasource = RemoteProfileDatasource(client);

    when(() => client.get(Uri.parse(Endpoints.userDetail + username)))
      .thenAnswer((_) async => Response(fixture("user_detail_response.json"), 200));

    final result = await datasource.getUser(username);

    expect(result, isA<UserDetailModel>());
  });
}