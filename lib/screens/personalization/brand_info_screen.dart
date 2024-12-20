import 'package:fashion_assistant/utils/popups/loaders.dart';
import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:fashion_assistant/widgets/common/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';
import '../../data/authentication.repository/login_data.dart';
import '../../utils/http/http_client.dart';
import '../../widgets/profile_page/profile_menu.dart';
import '../authentication/login_screen.dart';

class BrandInfoScreen extends StatelessWidget {
  const BrandInfoScreen({super.key});

  void updateField(String field, String value) async {
    try {
      switch (field) {
        case 'firstName':
          UserData.userData!.firstName = value;
          break;
        case 'lastName':
          UserData.userData!.lastName = value;
          break;
        case 'email':
          UserData.userData!.email = value;
          break;
        case 'phone':
          UserData.userData!.phone = value;
          break;
        case 'gender':
          UserData.userData!.gender = value;
          break;
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
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
              // Profile Picture
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
                    // TextButton(
                    //     onPressed: () {},
                    //     child: const Text('Change Profile Picture'))
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
                title: 'Name',
                value: BrandData.brandData!.name!,
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Email',
                value: BrandData.brandData!.email!,
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),

              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                title: 'Phone Number',
                value: BrandData.brandData!.phone!,
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () async {
                        bool? confirmClose = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm'),
                              content: const Text(
                                  'Are you sure you want to close Account?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmClose == true) {
                          // Logout
                          final localStorage = GetStorage();
                          BrandData.brandData = null;
                          localStorage.write('IsLoggedIn', false);
                          HttpHelper.token = null;
                          localStorage.remove('TOKEN');
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      child: Text('Close Account',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .apply(color: OurColors.errorTextColor))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
