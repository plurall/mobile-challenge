import 'dart:io';

import 'package:mobile_challenge/data/model/user.dart';

class Utils {
  static bool isFavoriteUser(List<User> favoriteUsers, User user) =>
      favoriteUsers.where((current) => current.id == user.id).isNotEmpty;

  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('www.plurall.com.br');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
