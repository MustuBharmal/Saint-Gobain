import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}
