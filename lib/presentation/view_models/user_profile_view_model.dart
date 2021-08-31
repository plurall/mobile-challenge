import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/data/remote/search_remote.dart';

class UserProfileViewModel {
  final searchRemote = GetIt.instance<SearchRemote>();

  Future<User> getUser(String login) async {
    final response = await searchRemote.getUser(login);
    return response;
  }
}
