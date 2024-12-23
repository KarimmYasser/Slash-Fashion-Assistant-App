import 'dart:convert';
import 'dart:io';

import 'package:fashion_assistant/utils/popups/loaders.dart';
import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:fashion_assistant/widgets/common/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../data/authentication.repository/login_data.dart';
import '../../tap_map.dart';
import '../../utils/http/http_client.dart';
import '../../widgets/profile_page/profile_menu.dart';

class BrandInfoScreen extends StatefulWidget {
  const BrandInfoScreen({super.key});

  @override
  State<BrandInfoScreen> createState() => _BrandInfoScreenState();
}

class _BrandInfoScreenState extends State<BrandInfoScreen> {
  Future<void> _updateField(String title, String field, String currentValue,
      Function(String) onUpdate) async {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update $title'),
          content: field == 'description'
              ? TextField(
                  controller: controller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter new $title',
                  ),
                )
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter new $title',
                  ),
                ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      try {
        await HttpHelper.put('api/brand', {
          field: result,
        });
        onUpdate(result);
        switch (field) {
          case 'name':
            BrandData.brandData!.name = result;
            break;
          case 'description':
            BrandData.brandData!.description = result;
            break;
        }
        setState(() {});
        Loaders.successSnackBar(title: 'Success', message: 'Updated $title');
      } catch (e) {
        String errorMessage = e.toString();
        if (errorMessage.startsWith('Exception: ')) {
          errorMessage = errorMessage.replaceFirst('Exception: ', '');
        }
        Loaders.errorSnackBar(title: 'Error', message: errorMessage);
      }
    }
  }

  Future<void> _updateLogo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        // Assuming you have a method to upload the image and get the URL
        final logoUrl = await uploadImage(File(pickedFile.path));
        setState(() {
          BrandData.brandData!.logo = logoUrl;
        });
        Loaders.successSnackBar(title: 'Success', message: 'Logo updated');
      } catch (e) {
        String errorMessage = e.toString();
        if (errorMessage.startsWith('Exception: ')) {
          errorMessage = errorMessage.replaceFirst('Exception: ', '');
        }
        Loaders.errorSnackBar(title: 'Error', message: errorMessage);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        showBackButton: true,
        title: Text('Brand Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              // Profile Logo
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: BrandData.brandData!.logo != null
                          ? NetworkImage(BrandData.brandData!.logo!)
                          : null,
                      child: BrandData.brandData!.logo == null
                          ? const FlutterLogo(size: 50)
                          : null,
                    ),
                    TextButton(
                        onPressed: _updateLogo,
                        child: const Text('Change Logo'))
                  ],
                ),
              ),

              // Details
              const SizedBox(height: Sizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              const SectionHeading(
                  title: 'Brand Information', showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                title: 'Name',
                value: BrandData.brandData!.name!,
                onPressed: () => _updateField(
                  'Name',
                  'name',
                  BrandData.brandData!.name!,
                  (newValue) => BrandData.brandData!.name = newValue,
                ),
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Description',
                value: BrandData.brandData!.description!,
                onPressed: () => _updateField(
                  'Description',
                  'description',
                  BrandData.brandData!.description!,
                  (newValue) => BrandData.brandData!.description = newValue,
                ),
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Brand ID',
                value: BrandData.brandData!.id!,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: BrandData.brandData!.id!));
                  Loaders.hideSnackBar();
                  Loaders.successSnackBar(
                      title: 'Success', message: 'Copied to Clipboard');
                },
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                title: 'Email',
                value: BrandData.brandData!.email!,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: BrandData.brandData!.id!));
                  Loaders.hideSnackBar();
                  Loaders.successSnackBar(
                      title: 'Success', message: 'Copied to Clipboard');
                },
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: BrandData.brandData!.phone!,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: BrandData.brandData!.id!));
                  Loaders.hideSnackBar();
                  Loaders.successSnackBar(
                      title: 'Success', message: 'Copied to Clipboard');
                },
                icon: Iconsax.copy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
