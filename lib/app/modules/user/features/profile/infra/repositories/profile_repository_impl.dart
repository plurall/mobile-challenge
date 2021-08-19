import '../../domain/entities/user_detail_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource datasource;

  ProfileRepositoryImpl(this.datasource);
  @override
  Future<UserDetailEntity> getUserDetail(String username) async {
    final user = await datasource.getUser(username);
    return user.toEntity();
  }
}