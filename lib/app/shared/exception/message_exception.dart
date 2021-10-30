class MessageException implements Exception {
  String message;
  dynamic previous;

  MessageException(this.message, {this.previous});

  String toString() {
    return message;
  }
}