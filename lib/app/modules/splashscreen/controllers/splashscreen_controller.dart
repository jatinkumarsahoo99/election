import 'package:get/get.dart';

import '../../../Utils/shared_preferences_keys.dart';
import '../../../routes/app_pages.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  moveToNextScreen() async {
    var isLogin = await SharedPreferencesKeys().getStringData(key: "isLogin");
    Future.delayed(const Duration(seconds: 3),() {
      if(isLogin.toString().contains("true")){
        Get.offAllNamed(Routes.DASHBOARDSCREEN);
      }else{
        Get.offAllNamed(Routes.LOGINPAGE);
      }

    },);
  }

  @override
  void onReady() {
    moveToNextScreen();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
