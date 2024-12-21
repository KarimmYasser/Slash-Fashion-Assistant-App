import 'package:fashion_assistant/screens/admin_mode/admin_total_screens.dart';
import 'package:fashion_assistant/screens/brand_mode/brand_total_screens.dart';
import 'package:fashion_assistant/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/authentication.repository/login_data.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/popups/loaders.dart';
import '../../admin_mode/brand_manager_total_screens.dart';
import '../../admin_mode/customer_admin_total_screens.dart';
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

  Future<void> login() async {
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

      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is Checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login
      final loginResponse = await HttpHelper.post('api/auth/login',
          {'email': email.text.trim(), 'password': password.text.trim()});
      HttpHelper.setToken(loginResponse['token']);
      localStorage.write('TOKEN', HttpHelper.token);

      // Save User Data
      if (loginResponse['role'] == 'BRAND') {
        BrandData.brandData = BrandData(loginResponse['user']);
      } else if (loginResponse['role'] == 'USER') {
        UserData.userData = UserData(loginResponse['user']);
      } else if (loginResponse['role'] == 'ADMIN') {
        AdminData.adminData = AdminData(loginResponse['user']);
      }
      if (rememberMe.value) {
        localStorage.write('IsLoggedIn', true);
      }

      // Stop Loading
      FullScreenLoader.stopLoading();

      Get.offAll(
        () => SuccessScreen(
          image: "assets/images/72462-check-register.json",
          title: "Your account has been logged in successfully.",
          subtitle: "Your Account is ready to use.",
          onPressed: () {
            if (loginResponse['role'] == 'BRAND') {
              Get.offAll(() => const BrandTotalScreens());
            } else if (loginResponse['role'] == 'USER') {
              Get.offAll(() => const TotalScreens());
            } else if (loginResponse['role'] == 'ADMIN') {
              switch (AdminData.adminData!.role) {
                case 'CustomerService':
                  Get.offAll(() => const CustomerAdminTotalScreens());
                  break;
                case 'SuperAdmin':
                  Get.offAll(() => const SuperAdminTotalScreens());
                  break;
                case 'SystemAdmin':
                  Get.offAll(() => const SuperAdminTotalScreens());
                  break;
                case 'BrandManager':
                  Get.offAll(() => const BrandAdminTotalScreens());
                  break;

                default:
                  Get.offAll(() => const CustomerAdminTotalScreens());
              }
            }
          },
        ),
      );
    } catch (e) {
      // Stop Loading
      FullScreenLoader.stopLoading();

      // Prepare the error message
      String errorMessage = e.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }

      // Show Error Message
      Loaders.errorSnackBar(title: 'Oh Snap! ', message: errorMessage);
    }
  }
}
