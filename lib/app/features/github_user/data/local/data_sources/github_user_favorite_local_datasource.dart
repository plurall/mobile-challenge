import 'package:flutter/foundation.dart';

import '../../../../../core/services/local_storage_interface.dart';
import '../models/github_user_favorite_cache_model.dart';

abstract class GithubUserFavoriteLocalDataSource {
  /// Gets the cached [GithubUserFavoriteCacheModel] favorites users

  Future<void> cacheGithubUserFavorite(
      GithubUserFavoriteCacheModel githubUsersFavoriteToCache);
}

const CACHED_GITHUB_USER_FAVORITE = 'CACHED_GITHUB_USER_FAVORITE';

class GithubUserLocalDataSourceImpl
    implements GithubUserFavoriteLocalDataSource {
  final ILocaStorage shared;

  GithubUserLocalDataSourceImpl({@required this.shared});

  @override
  Future<void> cacheGithubUserFavorite(
      GithubUserFavoriteCacheModel githubUsers) async {
    var githubUsersFavoriteList = <GithubUserFavoriteCacheModel>[];
    githubUsersFavoriteList.add(githubUsers);
    var list = githubUsersFavoriteList.map((e) => e.toJson()).toList();

    var githubUserFavoriteCache =
        await shared.getStringList(CACHED_GITHUB_USER_FAVORITE);

    if (githubUserFavoriteCache != null) {
      githubUserFavoriteCache.forEach((element) {
        list = [...list, element];
      });
    }

    return shared.setStringList(CACHED_GITHUB_USER_FAVORITE, list);
  }
}
