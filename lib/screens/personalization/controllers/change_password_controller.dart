import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/success_screen.dart';

class ChangePasswordController extends GetxController {
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    try {
      FullScreenLoader.openLoadingDialog('Changing your Password...',
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

      // Change Password
      await HttpHelper.post('api/auth/change-password', {
        'oldPassword': oldPassword.text.trim(),
        'newPassword': newPassword.text.trim()
      });

      // Stop Loading
      FullScreenLoader.stopLoading();

      Get.to(
        () => SuccessScreen(
          image: "assets/images/72462-check-register.json",
          title: "Your password has been changed successfully.",
          subtitle: "Your Account is ready to use.",
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
}
