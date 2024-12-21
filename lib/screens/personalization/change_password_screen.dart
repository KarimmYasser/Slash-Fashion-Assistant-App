import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../utils/helpers/validation.dart';
import 'controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller =
        Get.put(ChangePasswordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.oldPassword,
                validator: (value) =>
                    Validator.validateEmptyText('Old Password', value),
                decoration: const InputDecoration(
                  hintText: 'Old Password',
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwInputFields),
              TextFormField(
                validator: (value) => Validator.validatePassword(value),
                controller: controller.newPassword,
                expands: false,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'New Password',
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwInputFields),

              // confirm new password
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != controller.newPassword.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                controller: controller.confirmPassword,
                expands: false,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Confirm New Password',
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.changePassword,
                  child: const Text('Change Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
