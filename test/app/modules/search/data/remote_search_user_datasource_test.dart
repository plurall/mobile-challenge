import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mobile_challenge/app/modules/search/data/remote_search_user_datasource.dart';
import 'package:mobile_challenge/app/modules/search/domain/errors/search_errors.dart';
import 'package:mobile_challenge/app/modules/search/infra/models/searched_user_model.dart';
import 'package:mobile_challenge/app/shared/utils/endpoints.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class ClientMock extends Mock implements Client {}

void main() {
  late final Client http; 
  late final RemoteSearchUserDataSource datasource;
  final String searchText = "random_text";
  final searchEndpoint = Uri.parse(Endpoints.searchUser + searchText);

  setUpAll(() {
    http = ClientMock();
    datasource = RemoteSearchUserDataSource(http);
  });
  
  test('Should return a List of SearchedUserModel if status code is 200', () async {
    when(() => http.get(searchEndpoint))
      .thenAnswer((_) async => Response(fixture("search_user_response.json"), 200));

    final result = await datasource.search(searchText);

    expect(result, isA<List<SearchedUserModel>>());
  });

  test('Should return a UnavailableServiceError if status code is 503', () async {    
    when(() => http.get(searchEndpoint))
      .thenAnswer((_) async => Response("{}", 503));

    final future = datasource.search(searchText);

    expect(future, throwsA(isA<UnavailableServiceError>()));
  });

  test('Should return an Exception if status code is different from 200 and 503', () async {    
    when(() => http.get(searchEndpoint))
      .thenAnswer((_) async => Response("{}", 403));

    final future = datasource.search(searchText);

    expect(future, throwsA(isA<Exception>()));
  });
}