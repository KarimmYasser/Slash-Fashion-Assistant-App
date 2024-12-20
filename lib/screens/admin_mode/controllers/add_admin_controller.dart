import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/success_screen.dart';

class AddAdminController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? roleController = "SystemAdmin";
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> addAdmin() async {
    try {
      FullScreenLoader.openLoadingDialog('Adding your admin...',
          'assets/animations/141594-animation-of-docer.json');

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation

      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Add Admin
      // ignore: unused_local_variable
      final addResponse = await HttpHelper.post('api/admin', {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'adminRole': roleController!.trim(),
        'username': usernameController.text.trim(),
      });
      // HttpHelper.setToken(loginResponse['token']);

      // Stop Loading
      FullScreenLoader.stopLoading();

      Get.to(
        () => SuccessScreen(
          image: "assets/images/72462-check-register.json",
          title: "Admin Added Successfully.",
          subtitle: "You can login with your new admin.",
          onPressed: () {
            Get.back();
            Get.back();
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

  @override
  void onClose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
