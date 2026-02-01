import 'package:get/get.dart';
// import 'package:portfolio/app/routes/app_pages.dart';
import 'package:portfolio/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    // TODO: Check auth state later
    // For now, go to Dashboard
    Get.offNamed(Routes.DASHBOARD);
  }
}
