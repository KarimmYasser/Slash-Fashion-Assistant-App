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

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

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
        title: Text('Profile Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              const SectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                title: 'First Name',
                value: UserData.userData!.firstName!,
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Last Name',
                value: UserData.userData!.lastName!,
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'UserName',
                value: UserData.userData!.username!,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: UserData.userData!.id!));
                  Loaders.hideSnackBar();
                  Loaders.successSnackBar(
                      title: 'Success', message: 'Copied to Clipboard');
                },
                icon: Iconsax.copy,
              ),

              const SizedBox(height: Sizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),

              const SectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                title: 'User ID',
                value: UserData.userData!.id!,
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: UserData.userData!.id!));
                  Loaders.hideSnackBar();
                  Loaders.successSnackBar(
                      title: 'Success', message: 'Copied to Clipboard');
                },
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                title: 'E-mail',
                value: UserData.userData!.email!,
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: UserData.userData!.phone!,
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Gender',
                value: UserData.userData!.gender!,
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
                          UserData.userData = null;
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
