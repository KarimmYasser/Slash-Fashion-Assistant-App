import 'package:fashion_assistant/utils/helpers/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'controllers/add_admin_controller.dart'; // Import your controller

class AddAdminScreen extends StatelessWidget {
  const AddAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddAdminController controller = Get.put(AddAdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Admin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.usernameController,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Username',
                  ),
                  validator: (value) =>
                      Validator.validateEmptyText('Username', value),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Email',
                  ),
                  validator: (value) => Validator.validateEmail(value),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                Obx(() => TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.all(.0),
                            child: Icon(controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !controller.isPasswordVisible.value,
                      validator: (value) => Validator.validatePassword(value),
                    )),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                DropdownButtonFormField<String>(
                  icon: const Icon(Icons.info_rounded),
                  items: const [
                    DropdownMenuItem(
                        value: 'CustomerService',
                        child: Center(child: Text('Customer Service'))),
                    DropdownMenuItem(
                        value: 'BrandManager',
                        child: Center(child: Text('Brand Manager'))),
                    DropdownMenuItem(
                        value: 'SystemAdmin',
                        child: Center(child: Text('System Admin'))),
                  ],
                  validator: (value) =>
                      Validator.validateEmptyText('Field', value),
                  onChanged: (value) {
                    controller.roleController = value;
                  },
                  hint: const Text('Admin Role'),
                ),
                const SizedBox(height: Sizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.addAdmin,
                    child: const Text('Add Admin'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
