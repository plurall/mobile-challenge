import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/user_details/data/datasources/user_detail_local_data_source.dart';
import 'package:mobile_challenge/modules/user_details/data/datasources/user_detail_remote_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class GithubUserApiRepositoryProtocol {
  Future<User> getUser(String nickname);
}

class GithubUserApiRepository implements GithubUserApiRepositoryProtocol {
  final UserDetailRemoteDataSource remoteDataSource;
  final UserDetailLocalDataSource localDataSource;

  GithubUserApiRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<User> getUser(String nickname) async {
    User response = await remoteDataSource.getUser(nickname);
    return response;
  }
}
