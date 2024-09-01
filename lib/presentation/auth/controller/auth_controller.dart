import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/util/log_util.dart';
import '../../../core/util/storage_util.dart';
import '../../home/home_page.dart';
import '../auth_screen.dart';
import '../models/user_model.dart';
import '../repo/auth_repo.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find<AuthController>();
  RxBool isLoading = RxBool(false);
  var authToken = ''.obs;
  RxBool isObscure = RxBool(false);
  UserModel? user;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  checkLogin() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(LoginView.routeName);

     if (StorageUtil.getToken() != null) {
      user = UserModel.fromJson(jsonDecode(StorageUtil.getUserData()!));
      Get.offNamed(HomePage.routeName);
      isLoading(false);
    } else {
      Get.offNamed(LoginView.routeName);
      isLoading(false);
    }
    isLoading(false);
  }

  void login({required String username, required String password}) async {
    isLoading(true);
    try {
      user = await AuthRepo.login(username, password);
      if (user != null) {
        update();
        isLoading(false);
        Get.offNamed(HomePage.routeName);
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "$e");

      ///Error occurred
    }
  }

  void logout({String? email, String? password}) async {
    isLoading(true);
    try {
      StorageUtil.deleteToken();
      StorageUtil.deleteUserData();
      user = null;
      Get.offAll(() => LoginView());
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "$e");

      ///Error occurred
    }
    isLoading(false);
  }

  void toggle() {
    isObscure.value = !isObscure.value;
  }
}
