import 'package:connectivity/connectivity.dart';

class Connection{

  Future<bool>checkConnection()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    }else{
      return false;
    }
  }
}