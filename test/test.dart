import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/data/provider/provider.dart';

void main() {
  final provider = Provider();

  test('Should return the searched user', () async {
    final list = await provider.searchUsers(name: 'thomasodev');
    expect(list[0].login, 'thomasodev');
    expect(
      list[0].avatarUrl,
      'https://avatars.githubusercontent.com/u/48625749?v=4',
    );
  });

  test('Should return all user information correctly', () async {
    final user = await provider.getUser(name: 'thomasodev');

    expect(
      user.avatarUrl,
      'https://avatars.githubusercontent.com/u/48625749?v=4',
    );
    expect(user.bio, 'Desenvolvedor mobile em flutter');
    expect(user.email, null);
    expect(user.location, null);
    expect(user.login, 'thomasodev');
    expect(user.name, 'Thomas Queiroz');
  });
}
