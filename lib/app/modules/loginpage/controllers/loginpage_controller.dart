import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ApiService/ApiFactory.dart';
import '../../../ApiService/ConnectorController.dart';
import '../../../Utils/shared_preferences_keys.dart';
import '../../../Widgets/MyWidget.dart';
import '../../../routes/app_pages.dart';

class LoginpageController extends GetxController {
  //TODO: Implement LoginpageController

  final count = 0.obs;

  String errorEmail = '';
  TextEditingController emailController = TextEditingController();
  String errorPassword = '';
  TextEditingController passwordController = TextEditingController();

  callLoginApiCall(){
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL(
        api: "${ApiFactory.LOGIN}a_email=${emailController.text}&a_password=${passwordController.text}",
        // json: sendData,
        fun: (map) async {
          Get.back();
          if(map is List && map.isNotEmpty){
            await SharedPreferencesKeys().setStringData(key: "userName", text:map[0]["user_name"]??"");
            await SharedPreferencesKeys().setStringData(key: "isLogin", text:"true");
            await SharedPreferencesKeys().setStringData(key: "election_date", text:map[0]["election_date"]??"");
            Get.toNamed(Routes.DASHBOARDSCREEN);
          }else{
            Get.snackbar("Error", "Something went wrong");
          }
          print(">>>>>" + map.toString());
        });
  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
