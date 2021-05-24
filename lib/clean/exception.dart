import 'package:flutter/material.dart';

abstract class AppExceptions implements Exception {
  AppExceptions({@required this.icon, @required this.message});

  final String message;
  final IconData icon;
}

class EmptyList extends AppExceptions {
  EmptyList() : super(icon: Icons.list, message: "No Results Found");
}

class ConnectionError extends AppExceptions {
  ConnectionError()
      : super(
            icon: Icons.signal_wifi_connected_no_internet_4_outlined,
            message: "Could not connect to Github, please try again later");
}

class ApiError extends AppExceptions {
  ApiError()
      : super(
            icon: Icons.signal_wifi_connected_no_internet_4_outlined,
            message: "Our servers returned an error, please try again later");
}

class ConversionError extends AppExceptions {
  ConversionError()
      : super(
            icon: Icons.signal_wifi_connected_no_internet_4_outlined,
            message: "Data could not be shown, please try again later");
}
