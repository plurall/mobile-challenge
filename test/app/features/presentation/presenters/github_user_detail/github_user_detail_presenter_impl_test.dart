import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/data/models/user_model.dart';
import 'package:mobile_challenge/app/features/domain/usecases/get_user_data_by_username.dart';
import 'package:mobile_challenge/app/features/presentation/presenters/github_user_detail/github_user_detail_presenter_impl.dart';
import 'package:mocktail/mocktail.dart';

class GetUserDataByUsernameMock extends Mock implements GetUserDataByUsername {}

void main() {
  final getUserDataByUsername = GetUserDataByUsernameMock();
  final presenter = GithubUserDetailPresenterImpl(getUserDataByUsername);

  final userParams = UserParams(username: 'AlexOliveira123');
  final user = UserModel(
    username: 'AlexOliveira123',
    imageUrl: 'any_url',
    email: 'any_email',
    bio: 'any_bio',
    location: 'any_location',
  );

  tearDown(() {
    presenter.user = null;
  });

  test('Should get user data by username with success', () async {
    when(() => getUserDataByUsername(userParams))
        .thenAnswer((_) async => Right(user));
    expect(presenter.user, isNull);
    await presenter.getUserData('AlexOliveira123');
    expect(presenter.user, equals(user));
    verify(() => getUserDataByUsername(userParams)).called(1);
  });

  test('Should occurs an error when get user data by username', () async {
    when(() => getUserDataByUsername(UserParams(username: ''))).thenAnswer(
        (_) async => Left(InvalidUsernameFailure(message: 'invalid_username')));
    expect(presenter.user, isNull);
    expect(presenter.error, isNull);
    await presenter.getUserData('');
    expect(presenter.user, isNull);
    expect(presenter.error, equals('invalid_username'));
    verify(() => getUserDataByUsername(UserParams(username: ''))).called(1);
  });
}
