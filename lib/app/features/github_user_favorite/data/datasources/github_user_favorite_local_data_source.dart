import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/local_storage_interface.dart';
import '../models/github_user_favorite_model.dart';

abstract class GithubUserFavotireLocalDataSource {
  /// Gets the cached [GithubUserFavoriteModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<GithubUserFavoriteModel>> getGithubUserFavorites();
}

const CACHED_GITHUB_USER_FAVORITE = 'CACHED_GITHUB_USER_FAVORITE';

class GithubUserFavoriteDataSourceImpl
    implements GithubUserFavotireLocalDataSource {
  final ILocaStorage shared;

  GithubUserFavoriteDataSourceImpl(this.shared);

  @override
  Future<List<GithubUserFavoriteModel>> getGithubUserFavorites() async {
    final jsonString = await shared.getStringList(CACHED_GITHUB_USER_FAVORITE);
    if (jsonString != null) {
      return Future.value(jsonString
          .map((e) => GithubUserFavoriteModel.fromMap(jsonDecode(e)))
          .toList());
    } else {
      throw CacheException();
    }
  }
}
