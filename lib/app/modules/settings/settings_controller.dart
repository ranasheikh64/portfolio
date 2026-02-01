import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme(bool val) {
    isDarkMode.value = val;
    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
  }
}
