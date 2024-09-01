import 'package:get/get.dart';
import '../controller/retail_outlet_controller.dart';

class RetailOutletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RetailOutletController());
  }
}
