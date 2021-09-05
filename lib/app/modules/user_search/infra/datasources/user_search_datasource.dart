import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';

abstract class UserSearchDatasource {

  Future<UserSearch> getSearch(String searchText);

}