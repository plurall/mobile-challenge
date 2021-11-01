import 'package:mobile_challenge/app/utils/mock_utils.dart';
import 'package:mobile_challenge/app/core/erros/failures.dart';
import 'package:mobile_challenge/app/modules/users_search/data/model/user_search_model.dart';

abstract class IUserSearchDataSource {
  Future<List<UserModel>> userSearch(
    String searchTerm,
  );
}

class UserSearchDataSource implements IUserSearchDataSource {
  @override
  Future<List<UserModel>> userSearch(String searchTerm) async {
    final mockFile = 'users_search';
    final mockData = await Future.delayed(
      const Duration(seconds: 3),
      () => MockUtils.getMock(mockFile),
    );

    if (mockData != null) {
      return [UserModel.fromJson(mockData)];
    } else {
      throw ServerFailure(message: 'Error datasource');
    }
  }
}
