import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityDriver {
  StreamSubscription<ConnectivityResult> connectivitySubscription;
  Connectivity connectivity = Connectivity();

  Future<ConnectivityResult> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
      return result;
    } catch (e) {
      print(e.toString());
    } 
  }
}