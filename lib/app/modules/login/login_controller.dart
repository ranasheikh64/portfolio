import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/data/services/auth_service.dart';
import 'package:portfolio/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isObscure = true.obs;
  var isSignUp = false.obs;

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleAuthMode() {
    isSignUp.value = !isSignUp.value;
  }

  void submit() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    bool success;
    if (isSignUp.value) {
      success = await _authService.signUp(
        emailController.text,
        passwordController.text,
      );
    } else {
      success = await _authService.login(
        emailController.text,
        passwordController.text,
      );
    }
    isLoading.value = false;

    if (success) {
      Get.offAllNamed(Routes.ADMIN_DASHBOARD);
    } else {
      Get.snackbar(
        "Error",
        "Authentication failed",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}
