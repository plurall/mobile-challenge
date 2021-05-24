import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_api/controller/githubController.dart';
import 'package:github_api/model/profile.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Client])
void main() {
  group('Search Profile Should', () {
    test('return a profile from Github with status code = 200', () async {
      final client = MockClient((request) async {
        var jsonMap = {
          'login': 'test',
          'email': null,
          'nickname': null,
          'bio': null,
          'avatar_url': null,
          'location': null,
        };

        return Response(jsonEncode(jsonMap), 200);
      });

      expect(await GithubController().fetchProfileUser(client, 'test'),
          isA<Profile>());
    });
    test('launch an exception with status code = 404', () async {
      final client = MockClient((request) async {
        var jsonMap = {'login': null};
        return Response(jsonEncode(jsonMap), 404);
      });

      expect(
          GithubController().fetchProfileUser(client, 'test'), throwsException);
    });
  });
}
