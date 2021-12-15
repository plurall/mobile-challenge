import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/repositories/apigithub_repository.dart';
import 'package:mobile_challenge/app/services/client_http_service.dart';
import 'package:mobile_challenge/app/viewmodels/apigithub_viewmodel.dart';

main() {
  test('ApiGithubViewModel findAll Error', () async {
    final apiGithubViewModel = ApiGithubViewModel(
      ApiGithubRepository(
        ClientHttpService(),
      ),
    );

    await apiGithubViewModel.findAll('ZaunSupremoXV');
    expect(apiGithubViewModel.userModel.value, null);
  });
}
