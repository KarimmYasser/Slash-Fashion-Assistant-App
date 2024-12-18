import 'package:fashion_assistant/screens/authentication/login_screen.dart';
import 'package:fashion_assistant/screens/authentication/onboarding.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/brand_mode/brand_total_screens.dart';
import '../../screens/total_screen.dart';
import 'user_data.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();

  /// Called from main.dart on app launch
  @override
  void onReady() {
    super.onReady();
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  screenRedirect() async {
    // Local Storage
    if (kDebugMode) {
      print(
          '========================== GET STORAGE ===========================');
      print(deviceStorage.read('IsFirstTime'));
    }

    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.writeIfNull('IsLoggedIn', false);
    if (deviceStorage.read('IsFirstTime') == true) {
      Get.offAll(const OnBoardingScreen());
    } else if (deviceStorage.read('IsLoggedIn') != true) {
      Get.offAll(() => const LoginScreen());
    } else {
      try {
        HttpHelper.setToken(deviceStorage.read('TOKEN'));
        final response = await HttpHelper.get('api/auth/me');
        UserData.userData = UserData(response['user']);
        if (UserData.userData!.role == 'Brand') {
          Get.offAll(() => const BrandTotalScreens());
        } else {
          Get.offAll(() => const TotalScreens());
        }
      } catch (e) {
        deviceStorage.write('IsLoggedIn', false);
        Get.offAll(() => const LoginScreen());
      }
    }
  }
}
