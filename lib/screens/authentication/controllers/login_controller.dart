import 'package:fashion_assistant/screens/brand_mode/brand_mode_screen.dart';
import 'package:fashion_assistant/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/authentication.repository/user_data.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/popups/loaders.dart';
import '../../total_screen.dart';
import '../success_screen.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginBrandFormKey = GlobalKey<FormState>();

  Future<void> login(String role) async {
    try {
      FullScreenLoader.openLoadingDialog('Logging you in...',
          'assets/animations/141594-animation-of-docer.json');

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (role == 'Brand') {
        if (!loginBrandFormKey.currentState!.validate()) {
          FullScreenLoader.stopLoading();
          return;
        }
      } else {
        if (!loginFormKey.currentState!.validate()) {
          FullScreenLoader.stopLoading();
          return;
        }
      }

      // Save Data if Remember Me is Checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login
      final loginResponse = await HttpHelper.post('api/auth/login', {
        'email': email.text.trim(),
        'password': password.text.trim(),
        'role': role.trim()
      });
      HttpHelper.setToken(loginResponse['token']);
      localStorage.write('TOKEN', HttpHelper.token);

      //final response = await HttpHelper.get('api/order');

      // Save User Data
      UserData.userData = UserData(loginResponse['user']);
      if (rememberMe.value) {
        localStorage.write('IsLoggedIn', true);
      }

      // Stop Loading
      FullScreenLoader.stopLoading();

      Get.offAll(() => SuccessScreen(
          image: "assets/images/72462-check-register.json",
          title: "Your account has been logged in successfully.",
          subtitle: "Your Account is ready to use.",
          onPressed: () {
            if (role == 'Brand') {
              Get.offAll(() => const BrandModeScreen());
            } else {
              Get.offAll(() => const TotalScreens());
            }
          }
          //() => Get.offAll(() => const BrandTotalScreens()),
          ));
    } catch (e) {
      // Stop Loading
      FullScreenLoader.stopLoading();
      // Show Error Message
      Loaders.errorSnackBar(title: 'Oh Snap! ', message: e.toString());
    }
  }
}
