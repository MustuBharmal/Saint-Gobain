import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
