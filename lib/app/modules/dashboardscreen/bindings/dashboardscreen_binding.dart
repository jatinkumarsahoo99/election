import 'package:get/get.dart';

import '../controllers/dashboardscreen_controller.dart';

class DashboardscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardscreenController>(
      () => DashboardscreenController(),
    );
  }
}
