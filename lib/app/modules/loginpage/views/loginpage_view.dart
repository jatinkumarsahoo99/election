import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/validator.dart';
import '../../../Widgets/common_appbar_view.dart';
import '../../../Widgets/common_button.dart';
import '../../../Widgets/common_text_field_view.dart';
import '../../../Widgets/facebook_twitter_button_view.dart';
import '../../../Widgets/remove_focuse.dart';
import '../../../routes/app_pages.dart';
import '../controllers/loginpage_controller.dart';

class LoginpageView extends GetView<LoginpageController> {
  LoginpageView({Key? key}) : super(key: key);

  @override
  LoginpageController controller = Get.find<LoginpageController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: "Login",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: GetBuilder<LoginpageController>(
                    id: "all",
                    builder: (controller) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: FacebookTwitterButtonView(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "or Login With Email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme
                                .of(context)
                                .disabledColor,
                          ),
                        ),
                      ),
                      CommonTextFieldView(
                        controller: controller.emailController,
                        errorText: controller.errorEmail,
                        titleText: "Your Email",
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        hintText:
                        "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        titleText: "Password",
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        hintText: "Enter password",
                        isObscureText: true,
                        onChanged: (String txt) {},
                        errorText: controller.errorPassword,
                        controller: controller.passwordController,
                      ),
                      _forgotYourPasswordUI(),
                      CommonButton(
                        padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                        buttonText: "Login",
                        onTap: () {
                          if(allValidation()){
                            controller.callLoginApiCall();
                            // Get.toNamed(Routes.DASHBOARDSCREEN);
                          }
                          // NavigationServices(context).gotoTabScreen();
                        },
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _forgotYourPasswordUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 16, bottom: 8, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Forgot Your Password",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Theme
                      .of(Get.context!)
                      .disabledColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool allValidation() {
    bool isValid = true;
    if (controller.emailController.text
        .trim()
        .isEmpty) {
      controller.errorEmail = "Please enter email";
      isValid = false;
    } /*else if (!Validator.validateEmail(controller.emailController.text.trim())) {
      controller.errorEmail = "Please enter valid email";
      isValid = false;
    }*/ else {
      controller.errorEmail = '';
    }

    if (controller.passwordController.text
        .trim()
        .isEmpty) {
      controller.errorPassword = "Please enter password";
      isValid = false;
    } else if (controller.passwordController.text
        .trim()
        .length < 6) {
      controller.errorPassword = "Please enter valid password";
      isValid = false;
    } else {
      controller.errorPassword = '';
    }
    controller.update(['all']);
    return isValid;
  }
}
