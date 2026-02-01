import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  String get title {
    switch (tabIndex.value) {
      case 0:
        return 'Home';
      case 1:
        return 'About Me';
      case 2:
        return 'Projects';
      case 3:
        return 'CV Builder';
      case 4:
        return 'Contact';
      default:
        return 'Portfolio';
    }
  }
}
