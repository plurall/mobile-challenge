import 'dart:io';

class ConnectionProvider {
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  void setConnection(bool value) {
    _isConnected = value;
  }

  Future<bool> checkConnection() async {
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
