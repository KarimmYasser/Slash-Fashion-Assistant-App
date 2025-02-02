import 'package:fashion_assistant/data/authentication.repository/login_data.dart';
import 'package:fashion_assistant/screens/create_avatar/male_or_female.dart';
import 'package:fashion_assistant/utils/helpers/network_manager.dart';
import 'package:fashion_assistant/utils/popups/full_screen_loader.dart';
import 'package:fashion_assistant/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/http/http_client.dart';
import '../success_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final isPasswordVisible = true.obs;
  final privacyPolicey = true.obs;
  String? gender;
  final localStorage = GetStorage();
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
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicey.value) {
        Loaders.warningSnackBar(
            title: 'Accept Privacy Policey ',
            message:
                'In order to create an account, you must have to read and accept the Privacy Policey & Terms of Use. ');
        return;
      }
      // Register User
      final response = await HttpHelper.post('api/auth/signup', {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'email': email.text.trim(),
        'username': userName.text.trim(),
        'password': password.text.trim(),
        "phone": phoneNumber!.trim(),
        "city": cityValue!.trim(),
        'gender': gender!.trim(),
        'age': 25,
      });
      HttpHelper.setToken(response['token']);
      localStorage.write('TOKEN', HttpHelper.token);

      // Save User Data
      UserData.userData = UserData(response['user']);
      UserData.userData!.email = email.text.trim();
      localStorage.write('IsLoggedIn', true);
      // Stop Loading
      FullScreenLoader.stopLoading();

      // Move to Next Screen
      Get.offAll(() => SuccessScreen(
            image: "assets/images/72462-check-register.json",
            title: "Your account has been created successfully.",
            subtitle: "Your Account is ready to use.",
            onPressed: () {
              Get.offAll(() => const MaleOrFemale());
            },
          ));
    } catch (e) {
      // Stop Loading
      FullScreenLoader.stopLoading();
      // Show Error Message
      Loaders.errorSnackBar(title: 'Oh Snap! ', message: e.toString());
    }
  }

  // Toggle Password Text Field
  void togglePassword() => isPasswordVisible.value = !isPasswordVisible.value;
  void togglePrivacyPolicey() => privacyPolicey.value = !privacyPolicey.value;
}

// final response = await HttpHelper.get('api/auth/me');