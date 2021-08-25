class ConnectionProvider {
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  void setConnection(bool value) {
    this._isConnected = value;
  }
}
