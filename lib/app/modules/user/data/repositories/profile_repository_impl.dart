import '../../../../core/error/errors.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local_profile_datasource.dart';
import '../datasources/profile_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final RemoteProfileDatasource remoteDatasource;
  final LocalProfileDatasource localDatasource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDatasource, 
    required this.localDatasource,
    required this.networkInfo,
  });
  @override
  Future<UserEntity> getUserDetail(String username) async {
    if (await networkInfo.isConnected) {
        try {
          final user = await remoteDatasource.getUser(username);
          
          localDatasource.cacheUser(user);
          
          return user.toEntity();
        } on ServerException {
          throw ServerFailure();
        }
    } else {
        try {
          final user = await localDatasource.getUser(username);
          return user.toEntity(); 
        } on CacheException {
          throw CacheFailure();
        }
    }
    
  }
}