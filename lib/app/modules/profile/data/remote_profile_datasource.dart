import 'package:mobile_challenge/app/modules/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/profile/infra/datasources/profile_datasource.dart';

class RemoteProfileDatasource implements ProfileDatasource {
  @override
  Future<UserDetailEntity> getUser(String username) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  
}