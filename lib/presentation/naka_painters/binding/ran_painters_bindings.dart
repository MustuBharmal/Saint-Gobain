import 'package:get/get.dart';
import '../controller/ran_painter_controller.dart';

class RanPainterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RanPainterController());
  }
}
