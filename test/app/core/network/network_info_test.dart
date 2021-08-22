
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_challenge/app/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}
void main() {

  late MockInternetConnectionChecker internetConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
     internetConnectionChecker = MockInternetConnectionChecker();
     networkInfo = NetworkInfoImpl(internetConnectionChecker);
  });
  
  group('isConnected', () {
    test('Should forward the call to InternetConnectionChecker.hasConnection', () async {
      //arrange
      when(() => internetConnectionChecker.hasConnection).thenAnswer((_) async => true);
      //act
      final result = await networkInfo.isConnected;
      //assert
      verify(() => internetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}