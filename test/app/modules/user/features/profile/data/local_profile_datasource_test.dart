import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/error/errors.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/data/local_profile_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';
import 'package:mobile_challenge/app/shared/utils/prefs_key.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}
void main() {
  final String username = "joaoarmando";
  late SharedPreferencesMock prefs;
  late LocalProfileDatasourceImpl datasource;

  setUp(() {
    prefs = SharedPreferencesMock();
    datasource = LocalProfileDatasourceImpl(prefs);
  });
  
  group('Get User', () {
    test('Should return a cached user when the data is present in cache', () async {
      //arrange
      when(() => prefs.getString(PrefsKey.CACHED_USERS)).thenAnswer((_) => fixture("user_detail_list.json"));
      //act
      final user = await datasource.getUser(username);
      //assert
      verify(() => prefs.getString(PrefsKey.CACHED_USERS));
      expect(user, isA<UserDetailModel>());
      expect(user.login, username);
    });
    
    test('Should throws an CachedException when the data is not present in cache', () async {
      //arrange
      when(() => prefs.getString(PrefsKey.CACHED_USERS)).thenAnswer((_) => null);
      //act
      final future =  datasource.getUser(username);

      expect(future, throwsA(isA<CacheException>()));
    });
  });

  group('Cache User', () {
    test('Should store in cache the user', () async {
      //arrange
      when(() => prefs.setString(any(), any())).thenAnswer((_) async => true);
      final tUser = UserDetailModel(
        login: "joaoarmando", 
        bio: "oi", 
        name: "Joao Armando", 
        location: "Petrópolis", 
        email: "joaoaarmando@hotmail.com", 
        avatarUrl: "https://randompictureurl.com"
      );
      //act
      await datasource.cacheUser(tUser);
      //assert
      verify(() => prefs.setString(PrefsKey.CACHED_USERS, any()));
      expect(datasource.cachedUsers.length, equals(1));
      expect(datasource.cachedUsers[0], equals(tUser));
    });
  });
}