import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/provider/provider.dart';
import 'package:mobile_challenge/app/data/repository/repository.dart';
import 'package:mobile_challenge/app/modules/favorites/favorites_controller.dart';

class FavoritesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FavoritesController(
        repository: Repository(
          provider: Provider(),
        ),
      ),
    );
  }
}
