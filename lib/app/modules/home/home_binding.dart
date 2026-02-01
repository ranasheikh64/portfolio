import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
