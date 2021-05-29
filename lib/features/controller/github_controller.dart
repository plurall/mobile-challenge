import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../features/utils/routes.dart';
import '../data/model/profile.dart';
import '../data/repositories/database_repositories.dart';
import '../utils/globals.dart';

class GithubController extends GetxController {
  TextEditingController search = TextEditingController();
  Profile _githubProfile;

  var index = 0.obs;

  var listProfiles = [].obs;

  Profile get githubProfile => _githubProfile;

  setGithubProfileFromDatabase(Profile profile) => _githubProfile = profile;

  Future<dynamic> fetchProfileUser(http.Client client, String username) async {
    if (username != null && username.isNotEmpty) {
      var url = Uri.parse('$DOMAIN' + '$PATH_PROFILE_USER' + username);

      try {
        var response = await client.get(url, headers: {
          'Authorization': 'Bearer $TOKEN',
        });
        if (response.statusCode == 200) {
          Profile result = Profile.fromJson(jsonDecode(response.body));
          bool containUser = false;
          listProfiles.forEach((element) {
            if (element.login == result.login) containUser = true;
          });
          containUser
              ? throw Exception(userAlreadyExist)
              : listProfiles.add(result);
          return result;
        } else if (response.statusCode == 404) {
          throw Exception(userNotFound);
        }
      } catch (e) {
        return Get.showSnackbar(GetBar(
          message: e.toString(),
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  String pressedButtonNavigatonBottomBar(int indexPressed) {
    index.value = indexPressed;
    return index.value == 0 ? Routes.HOME : Routes.FAVORITE_PAGE;
  }

  void getDetailsOfProfile(int index) =>
      _githubProfile = listProfiles.elementAt(index);

  void changeFavoriteProfile(int index) {
    getDetailsOfProfile(index);

    _githubProfile.favorite = !_githubProfile.favorite;

    _githubProfile.favorite
        ? DatabaseRepositories.insertFavoriteProfile(_githubProfile)
        : DatabaseRepositories.removeFavoriteProfile(_githubProfile);

    listProfiles[index] = _githubProfile;
  }
}
