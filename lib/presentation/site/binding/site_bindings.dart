import 'package:get/get.dart';
import '../controller/site_controller.dart';

class SiteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SitesController());
  }
}
