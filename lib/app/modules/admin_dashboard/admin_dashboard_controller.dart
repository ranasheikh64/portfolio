import 'package:get/get.dart';
import 'package:portfolio/app/data/services/auth_service.dart';
import 'package:portfolio/app/routes/app_routes.dart';

class AdminDashboardController extends GetxController {
  final authService = Get.find<AuthService>();

  void logout() {
    authService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
