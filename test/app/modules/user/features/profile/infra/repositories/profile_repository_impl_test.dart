import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/error/errors.dart';
import 'package:mobile_challenge/app/core/error/failures.dart';
import 'package:mobile_challenge/app/core/network/network_info.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/datasources/local_profile_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/datasources/profile_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/repositories/profile_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class RemoteProfileDatasourceMock extends Mock implements RemoteProfileDatasource {}
class LocalProfileDatasourceMock extends Mock implements LocalProfileDatasource {}

class NetworkInfoMock extends Mock implements NetworkInfo {}

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
  late RemoteProfileDatasourceMock remoteDatasource;
  late LocalProfileDatasourceMock localDatasource;
  late ProfileRepositoryImpl repository;
  late NetworkInfoMock networkInfo;

  setUpAll(() {
    remoteDatasource = RemoteProfileDatasourceMock();
    localDatasource = LocalProfileDatasourceMock();
    networkInfo = NetworkInfoMock();
    repository = ProfileRepositoryImpl(
      remoteDatasource: remoteDatasource, 
      localDatasource: localDatasource, 
      networkInfo: networkInfo
    );
  });
  
  void _mockRemoteUserResponse() {
    when(() => remoteDatasource.getUser(username)).thenAnswer((_) async => user);
  }

  void _mockLocalUserResponse() {
    when(() => localDatasource.getUser(username)).thenAnswer((_) async => user);
  }

  void _mockHasInternet() {
    when(() => networkInfo.isConnected).thenAnswer((_) async => true);
  }
  void _mockHasNoInternet() {
    when(() => networkInfo.isConnected).thenAnswer((_) async => false);
  }

  test('Should verify if device is online', () async {
    //arrange
    _mockHasInternet();
    _mockRemoteUserResponse();
    _mockLocalUserResponse();
    when(() => localDatasource.cacheUser(user)).thenAnswer((async) async => null);
    //act
    repository.getUserDetail(username);
    //assert
    verify(() => networkInfo.isConnected);
  });

  group('Device is online', () {

    setUp(() {
      _mockHasInternet();
      _mockRemoteUserResponse();
    });
    
    test('Should return a UserDetailEntity an cache the user', () async {
      when(() => localDatasource.cacheUser(user)).thenAnswer((async) async => null);
      final result = await repository.getUserDetail(username);

      verify(() => remoteDatasource.getUser(username));
      verify(() => localDatasource.cacheUser(user));
      expect(result, isA<UserDetailEntity>());
    });
    
    test('Should throws an ServerFailure if remote data is unsuccessful', () async {
      //arrange
      when(() => remoteDatasource.getUser(username)).thenThrow(ServerException());
      //act
      final future = repository.getUserDetail(username);
      //assert
      expect(future, throwsA(isA<ServerFailure>()));
    });
  });

  group('Device is offLine', () {

    setUp(() {
      _mockHasNoInternet();
      _mockLocalUserResponse();
    });
    
    test('Should return last locally cached data when the cached data is present', () async {
      final result = await repository.getUserDetail(username);

      verify(() => localDatasource.getUser(username));
      expect(result, isA<UserDetailEntity>());
    });
    
    test('Should throws an CacheFailure when there is no cached data present', () async {
      //arrange
      when(() => localDatasource.getUser(username)).thenThrow(CacheException());
      //act
      final future = repository.getUserDetail(username);
      //assert
      expect(future, throwsA(isA<CacheFailure>()));
    });
  });
}