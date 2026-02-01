import 'package:get/get.dart';
import 'package:portfolio/app/modules/about/about_controller.dart';
import 'package:portfolio/app/modules/contact/contact_controller.dart';
import 'package:portfolio/app/modules/dashboard/dashboard_controller.dart';
import 'package:portfolio/app/modules/home/home_controller.dart';
import 'package:portfolio/app/modules/projects/projects_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AboutController>(() => AboutController());
    Get.lazyPut<ProjectsController>(() => ProjectsController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
