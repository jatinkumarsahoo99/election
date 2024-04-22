import 'package:get/get.dart';

import '../controllers/bluetoothprintscreen_controller.dart';

class BluetoothprintscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BluetoothprintscreenController>(
      () => BluetoothprintscreenController(),
    );
  }
}
