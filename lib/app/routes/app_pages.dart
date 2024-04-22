import 'package:get/get.dart';

import '../modules/bluetoothprintscreen/bindings/bluetoothprintscreen_binding.dart';
import '../modules/bluetoothprintscreen/views/bluetoothprintscreen_view.dart';
import '../modules/dashboardscreen/bindings/dashboardscreen_binding.dart';
import '../modules/dashboardscreen/views/dashboardscreen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/loginpage/bindings/loginpage_binding.dart';
import '../modules/loginpage/views/loginpage_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGINPAGE,
      page: () => LoginpageView(),
      binding: LoginpageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARDSCREEN,
      page: () => DashboardscreenView(),
      binding: DashboardscreenBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTHPRINTSCREEN,
      page: () => const BluetoothprintscreenView(),
      binding: BluetoothprintscreenBinding(),
    ),
  ];
}
