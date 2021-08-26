import '../helpers/environments.dart';
import 'service_locator_config.dart';

class ApplicationStartConfig {
  Future<void> configureApp() async {
    await _loadEnvs();
    _configureDependecies();
  }

  void _configureDependecies() => configureDependencies();
  Future<void> _loadEnvs() => Environments.loadEnvs();
}
