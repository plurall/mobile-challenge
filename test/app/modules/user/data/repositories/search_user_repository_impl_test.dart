import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/error/errors.dart';
import 'package:mobile_challenge/app/core/error/failures.dart';
import 'package:mobile_challenge/app/core/network/network_info.dart';
import 'package:mobile_challenge/app/modules/user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/app/modules/user/data/datasources/search_user_datasource.dart';
import 'package:mobile_challenge/app/modules/user/data/models/searched_user_model.dart';
import 'package:mobile_challenge/app/modules/user/data/repositories/search_user_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class SearchUserDataSourceMock extends Mock implements SearchUserDataSource {}
class NetworkInfoMock extends Mock implements NetworkInfo {}
void main() {
  final searchText = "random_text";
  late SearchUserDataSourceMock datasource;
  late NetworkInfoMock networkInfo;
  late SearchUserRepositoryImpl repository;

  setUp(() {
    datasource = SearchUserDataSourceMock();
    networkInfo = NetworkInfoMock();
    repository = SearchUserRepositoryImpl(datasource: datasource, networkInfo: networkInfo);
  });

  group("SearchUser", () {
    test('Should check if the device is online', () async{
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => datasource.search(searchText)).thenAnswer((_) async => <SearchedUserModel>[]);

      repository.search(searchText);

      verify(() => networkInfo.isConnected);
    });
  });

  group('Device is online', () {
    setUp(() {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('Should return a list of SearchedUser when remoteDataSource is successful', () async {
      when(() => datasource.search(searchText)).thenAnswer((_) async => <SearchedUserModel>[]);

      final result = await repository.search(searchText);

      verify(() => datasource.search(searchText));
      expect(result, isA<List<UserEntity>>());
    });

    test('Should throws a Serverfailure when remoteDataSource is unsuccessful', () async {
      when(() => datasource.search(searchText)).thenThrow(ServerException());

      final future = repository.search(searchText);

      expect(future, throwsA(isA<ServerFailure>()));
    }); 
  });

  group('Device is offline', () {

    test('Should throws a CacheException when device is not connected to the internet', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = repository.search(searchText);

      verifyNever(() => datasource.search(searchText));
      expect(result, throwsA(isA<CacheException>()));
    }); 
  });

}