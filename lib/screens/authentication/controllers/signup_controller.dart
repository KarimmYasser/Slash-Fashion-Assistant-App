import 'package:fashion_assistant/utils/helpers/network_manager.dart';
import 'package:fashion_assistant/utils/popups/full_screen_loader.dart';
import 'package:fashion_assistant/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/http/http_client.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final isPasswordVisible = true.obs;
  final PrivacyPolicey = true.obs;
  String? phoneNumber;
  String? countryValue;
  String? stateValue;
  String? cityValue;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  // final country = TextEditingController();
  // final city = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SIGN UP
  Future<void> signUp() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          'assets/animations/141594-animation-of-docer.json');

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy Check
      if (!PrivacyPolicey.value) {
        Loaders.warningSnackBar(
            title: 'Accept Privacy Policey ',
            message:
                'In order to create an account, you must have to read and accept the Privacy Policey & Terms of Use. ');
        return;
      }

      // Register User
      // final response = await HttpHelper.post('api/auth/signup', {
      //   'firstName': firstName.text.trim(),
      //   'lastName': lastName.text.trim(),
      //   'email': email.text.trim(),
      //   'username': userName.text.trim(),
      //   'password': password.text.trim(),
      //   "phone": phoneNumber!.trim(),
      //   "city": cityValue!.trim(),
      //   'gender': "male",
      //   'age': 25,
      // });
      // Save User Data
      final loginResponse = await HttpHelper.post('api/auth/login', {
        'email': email.text.trim(),
        'password': password.text.trim(),
      });
      HttpHelper.setToken(loginResponse['token']);

      final response = await HttpHelper.get('api/auth/me');

      // Show Success Message

      // Move to Next Screen
    } catch (e) {
      // Show Error Message
      Loaders.errorSnackBar(title: 'Oh Snap! ', message: e.toString());
    } finally {
      // Stop Loading
      FullScreenLoader.stopLoading();
    }
  }

  // Toggle Password Text Field
  void togglePassword() => isPasswordVisible.value = !isPasswordVisible.value;
  void togglePrivacyPolicey() => PrivacyPolicey.value = !PrivacyPolicey.value;
}


// final response = await HttpHelper.post('api/auth/signup', {
//                   'email': 'karim@example.com',
//                   'username': 'karimmyasserr',
//                   'password': 'k01234444',
//                   "role": "SHOPPER",
//                   "phone": "+201144432284",
//                   "image": "http://karim.com/image.jpg",
//                   "city": "ASWAN",
//                   "preferences": {
//                     "preference1": "bahb elbahr",
//                     "preference2": "amoot ana w a3eed elsana",
//                   }
//                 });
//                 Get.off(() => const VerifyEmailScreen());