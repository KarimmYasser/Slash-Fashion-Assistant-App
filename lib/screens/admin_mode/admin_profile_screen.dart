import 'package:fashion_assistant/data/authentication.repository/login_data.dart';
import 'package:fashion_assistant/screens/admin_mode/add_admin_screen.dart';
import 'package:fashion_assistant/screens/personalization/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';
import '../../utils/http/http_client.dart';
import '../../widgets/common/appbar.dart';
import '../../widgets/common/primary_header_container.dart';
import '../../widgets/common/section_heading.dart';
import '../../widgets/profile_page/admin_profile_tile.dart';
import '../../widgets/profile_page/setting_menu_tile.dart';
import '../authentication/login_screen.dart';
import 'delete_admin_screen.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---> Header
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  Appbar(
                    title: Text(
                      'Admin Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .apply(color: OurColors.white),
                    ),
                  ),

                  // User Profile Card
                  AdminUserProfileTile(
                      username: '${AdminData.adminData!.username}',
                      email: '${AdminData.adminData!.email}',
                      role: AdminData.adminData!.role!),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),

            // ---> Body
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Settings
                  const SectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  SettingMenuTile(
                      onTap: () => Get.to(() => const ChangePasswordScreen()),
                      icon: Iconsax.password_check,
                      title: 'Change Password',
                      subtitle: 'Change your account password'),

                  /// -- Adminstrative Settings
                  const SizedBox(height: Sizes.spaceBtwSections),
                  if (AdminData.adminData!.role == 'SuperAdmin')
                    const SectionHeading(
                        title: 'Adminstrative Settings',
                        showActionButton: false),
                  if (AdminData.adminData!.role == 'SuperAdmin')
                    const SizedBox(height: Sizes.spaceBtwItems),
                  if (AdminData.adminData!.role == 'SuperAdmin')
                    SettingMenuTile(
                        onTap: () => Get.to(() => const AddAdminScreen()),
                        icon: Iconsax.profile_add,
                        title: 'Add New Admin',
                        subtitle: 'Add a new Admin to database'),
                  if (AdminData.adminData!.role == 'SuperAdmin')
                    SettingMenuTile(
                        onTap: () => Get.to(() => const DeleteAdminScreen()),
                        icon: Iconsax.profile_delete,
                        title: 'Delete Admin',
                        subtitle: 'Delete an Admin from database'),

                  /// -- Log Out
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () async {
                          bool? confirmLogout = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                    'Are you sure you want to logout?'),
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
                                    child: const Text('Logout'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmLogout == true) {
                            // Logout
                            AdminData.adminData = null;
                            localStorage.write('IsLoggedIn', false);
                            HttpHelper.token = null;
                            localStorage.remove('TOKEN');
                            Get.offAll(() => const LoginScreen());
                          }
                        },
                        style: Theme.of(context)
                            .outlinedButtonTheme
                            .style!
                            .copyWith(
                              side: WidgetStateProperty.all(const BorderSide(
                                  color: OurColors.errorTextColor)),
                            ),
                        child: Text('Log Out',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: OurColors.errorTextColor))),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
