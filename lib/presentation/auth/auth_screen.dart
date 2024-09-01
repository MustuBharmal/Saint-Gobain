import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/style/app_color.dart';
import '../../widgets/general_widgets.dart';
import 'controller/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  static const routeName = '/loginScreen';

  LoginView({super.key});

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.09),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.15,
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: AppColors.white,
                child: Image.asset('assets/logo/Saint_Gobain_Logo.png'),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                child: myText(
                  text: 'Welcome back, Please Sign in.',
                  style: GoogleFonts.roboto(
                    letterSpacing: 0,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                width: Get.width,
                // height: Get.height * 0.7,
                child: Form(
                  key: formKey,
                  child: loginWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              myTextField(
                prefixIcon: 'assets/images/mail.png',
                text: 'Name',
                validator: (String input) {
                  if (input.isEmpty) {
                    Get.snackbar('Warning', 'Username is required.',
                        colorText: Colors.white, backgroundColor: Colors.blue);
                    return '';
                  }
                },
                controller: usernameController,
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              myPasswordTextField(
                  obscure: true,
                  prefixIcon: 'assets/images/lock.png',
                  text: 'Password',
                  suffixIcon: true,
                  validator: (String input) {
                    if (input.isEmpty) {
                      Get.snackbar('Warning', 'Password is required.',
                          colorText: Colors.white,
                          backgroundColor: Colors.blue);
                      return '';
                    }

                    if (input.length < 6) {
                      Get.snackbar(
                          'Warning', 'Password should be 6+ characters.',
                          colorText: Colors.white,
                          backgroundColor: Colors.blue);
                      return '';
                    }
                  },
                  controller: passwordController),
            ],
          ),
          Obx(
            () => Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: Get.height * 0.04),
              width: Get.width,
              child: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : elevatedButton(
                      text: 'Login',
                      onPress: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        controller.login(
                            username: usernameController.text.trim(),
                            password: passwordController.text.trim());
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
