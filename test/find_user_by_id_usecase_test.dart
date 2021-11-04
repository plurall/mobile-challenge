import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/home/data/models/user_model.dart';
import 'package:mobile_challenge/home/domain/usecases/find_user_by_id.dart';
import 'package:mockito/mockito.dart';

import 'mock_github_service.dart';

void main() {
  FindUserById usecase;
  MockGithubService mockGithubService;
  final _mockResult = {
    "login": "LilySny",
    "id": 33629714,
    "avatar_url": "https://avatars.githubusercontent.com/u/33629714?v=4",
    "location": "Campinas, São Paulo - Brazil",
    "email": null,
    "bio": null,
  };

  setUp(() {
    mockGithubService = MockGithubService();
    usecase = FindUserById(mockGithubService);
  });

  test(
    'should get user in the repository',
    () async {
      final response = UserModel.fromJson(_mockResult);
      when(mockGithubService.findById(33629714))
          .thenAnswer((_) async => response);

      final result = await usecase.execute(33629714);

      expect(result, response);
    },
  );
}
