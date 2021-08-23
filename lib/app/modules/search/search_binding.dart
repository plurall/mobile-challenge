import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/provider/provider.dart';
import 'package:mobile_challenge/app/data/repository/repository.dart';
import 'package:mobile_challenge/app/modules/search/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SearchController(
        repository: Repository(
          provider: Provider(),
        ),
      ),
    );
  }
}
