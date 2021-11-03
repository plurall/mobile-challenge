import 'package:mobile_challenge/interfaces/http_client_interface.dart';

abstract class IRepository {
  final IHttpClient client;

  IRepository(this.client);
}
