import 'dart:convert';
import 'dart:io';
import 'package:fashion_assistant/data/authentication.repository/login_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../tap_map.dart';
import '../../utils/helpers/network_manager.dart';
import '../../utils/helpers/validation.dart';
import '../../utils/http/http_client.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../../utils/popups/loaders.dart';
import '../brand_mode/brand_total_screens.dart';
import 'success_screen.dart';

class BrandSignupScreen extends StatelessWidget {
  const BrandSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brand Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a Brand Account',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: Sizes.spaceBtwInputFields),
              const BrandSignUpForm(),
              const SizedBox(height: Sizes.spaceBtwInputFields),
            ],
          ),
        ),
      ),
    );
  }
}

class BrandSignUpForm extends StatelessWidget {
  const BrandSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandSignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          GestureDetector(
            onTap: controller.pickLogoImage,
            child: Obx(() {
              return controller.logoImage.value == null
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('Add Logo'),
                      ),
                    )
                  : CircleAvatar(
                      radius: 52,
                      backgroundColor: OurColors.black,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          File(controller.logoImage.value!.path),
                        ),
                      ),
                    );
            }),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) =>
                Validator.validateEmptyText('Brand Name', value),
            controller: controller.brandName,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.business),
              hintText: 'Brand Name',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            maxLines: 3,
            validator: (value) =>
                Validator.validateEmptyText('Description', value),
            controller: controller.description,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Description',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.email,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.email_rounded),
              hintText: 'Email',
            ),
            validator: (value) => Validator.validateEmail(value!),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) => Validator.validatePassword(value!),
            controller: controller.password,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.lock),
              hintText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) => Validator.validateEmptyText('Phone', value),
            controller: controller.phone,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.phone),
              hintText: 'Phone',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.website,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.web),
              hintText: 'Website (optional)',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.facebook,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.facebook),
              hintText: 'Facebook (optional)',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.instagram,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.camera_alt),
              hintText: 'Instagram (optional)',
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.buttonHeight / 3),
                child: Text(
                  'Create Account',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrandSignupController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  final brandName = TextEditingController();
  final description = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final website = TextEditingController();
  final facebook = TextEditingController();
  final instagram = TextEditingController();
  final localStorage = GetStorage();
  var logoImage = Rx<XFile?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickLogoImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    logoImage.value = image;
  }

  Future<String?> uploadImage(File imageFile) async {
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse('$baseURL/api/brand/upload-image'),
    );
    imageUploadRequest.headers['Authorization'] = 'Bearer ${HttpHelper.token}';
    imageUploadRequest.files.add(await http.MultipartFile.fromPath(
      'image', // Key name for image in your backend
      imageFile.path,
    ));

    final imageResponse = await imageUploadRequest.send();

    if (imageResponse.statusCode < 400) {
      final imageResponseBody = await imageResponse.stream.bytesToString();
      final imageData = json.decode(imageResponseBody);
      return imageData['image']; // Assuming backend returns image URL
    } else {
      return null;
    }
  }

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
      final response = await HttpHelper.post('api/auth/brand-signup', {
        'name': brandName.text.trim(),
        'email': email.text.trim(),
        'password': password.text.trim(),
        'description': description.text.trim(),
        "phone": phone.text.trim(),
        "website": website.text.trim(),
        "facebook": facebook.text.trim(),
        "instagram": instagram.text.trim(),
      });
      HttpHelper.setToken(response['token']);
      localStorage.write('TOKEN', HttpHelper.token);
      // Save User Data
      BrandData.brandData = BrandData(response['user']);
      localStorage.write('IsLoggedIn', true);

      // Upload Logo Image if selected
      String? logoUrl;
      if (logoImage.value != null) {
        logoUrl = await uploadImage(File(logoImage.value!.path));
        if (logoUrl == null) {
          FullScreenLoader.stopLoading();
          Loaders.errorSnackBar(
              title: 'Image Upload Failed',
              message: 'Failed to upload logo image. Please try again later.');
          return;
        }
      }
      // Stop Loading
      FullScreenLoader.stopLoading();

      // Move to Next Screen
      Get.offAll(() => SuccessScreen(
          image: "assets/images/72462-check-register.json",
          title: "Your account has been created successfully.",
          subtitle: "Your Account is ready to use.",
          onPressed: () {
            Get.offAll(() => const BrandTotalScreens());
          }));
    } catch (e) {
      // Stop Loading
      FullScreenLoader.stopLoading();
      // Show Error Message
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
