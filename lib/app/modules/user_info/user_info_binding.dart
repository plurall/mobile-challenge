import 'package:get/get.dart';
import 'package:mobile_challenge/app/data/provider/provider.dart';
import 'package:mobile_challenge/app/data/repository/repository.dart';
import 'package:mobile_challenge/app/modules/user_info/user_info_controller.dart';

class UserInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => UserInfoController(repository: Repository(provider: Provider())),
    );
  }
}
