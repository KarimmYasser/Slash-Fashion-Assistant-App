import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/screens/personalization/order_screen.dart';
import 'package:fashion_assistant/screens/personalization/user_info_screen.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:fashion_assistant/widgets/common/section_heading.dart';
import 'package:fashion_assistant/widgets/profile_page/setting_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:convert';

import '../../data/authentication.repository/user_data.dart';
import '../../widgets/common/primary_header_container.dart';
import '../../widgets/profile_page/user_profile_tile.dart';
import '../authentication/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? avatarSvg;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAvatarFromBackend();
  }

  Future<void> loadAvatarFromBackend() async {
    try {
      const String apiUrl = 'api/user/get-avatar';

      final response = await HttpHelper.get(apiUrl);

      if (response['id'] != null) {
        Map<String, dynamic> avatarData = {
          "topType": response["topType"] ?? 0,
          "accessoriesType": response["accessoriesType"] ?? 0,
          "hairColor": response["hairColor"] ?? 0,
          "facialHairType": response["facialHairType"] ?? 0,
          "facialHairColor": response["facialHairColor"] ?? 0,
          "clotheType": response["clotheType"] ?? 0,
          "eyeType": response["eyeType"] ?? 0,
          "eyebrowType": response["eyebrowType"] ?? 0,
          "mouthType": response["mouthType"] ?? 0,
          "skinColor": response["skinColor"] ?? 0,
          "clotheColor": response["clotheColor"] ?? 0,
          "style": response["style"] ?? 0,
          "graphicType": response["graphicType"] ?? 0
        };

        String avatarJson = json.encode(avatarData);
        avatarSvg =
            FluttermojiFunctions().decodeFluttermojifromString(avatarJson);
      } else {
        throw Exception("Invalid avatar data received from backend.");
      }
    } catch (error) {
      print("Error fetching avatar: $error");
      avatarSvg = null;
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .apply(color: OurColors.white),
                    ),
                  ),

                  // User Profile Card
                  UserProfileTile(
                    isLoading: isLoading,
                    avatarSvg: avatarSvg,
                    name: (UserData.userData != null)
                        ? '${UserData.userData!.firstName} ${UserData.userData!.lastName}'
                        : 'Guest',
                    email: (UserData.userData != null)
                        ? '${UserData.userData!.email}'
                        : '',
                    editProfile: () {
                      if (UserData.userData != null) {
                        Get.to(() => const UserInfoScreen());
                      } else {
                        Get.to(() => const LoginScreen());
                      }
                    },
                  ),

                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),

            // ---> Body
            if (UserData.userData != null)
              Padding(
                padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: Column(
                  children: [
                    /// -- Account Settings
                    const SectionHeading(
                        title: 'Account Settings', showActionButton: false),
                    const SizedBox(height: Sizes.spaceBtwItems),
                    SettingMenuTile(
                        icon: Iconsax.bag_tick,
                        title: 'My Orders',
                        subtitle: 'In-progress and Completed Orders',
                        onTap: () => Get.to(() => const OrderScreen())),
                    const SettingMenuTile(
                        icon: Iconsax.security_card,
                        title: 'Change Password',
                        subtitle: 'Manage data security'),

                    /// -- App Settings
                    const SizedBox(height: Sizes.spaceBtwSections),
                    const SectionHeading(
                        title: 'App Settings', showActionButton: false),
                    const SizedBox(height: Sizes.spaceBtwItems),
                    const SettingMenuTile(
                        icon: Iconsax.document_download,
                        title: 'Load Data',
                        subtitle:
                            'Manually Load Data from your Cloud Database'),
                    const SettingMenuTile(
                        icon: Iconsax.document_upload,
                        title: 'Save Data',
                        subtitle: 'Manually Save Data to your Cloud Database'),
                    // SettingMenuTile(
                    //   icon: Iconsax.location,
                    //   title: 'Geolocation',
                    //   subtitle: 'Set recommendation based on location',
                    //   trailing: Switch(value: true, onChanged: (value) {}),
                    // ),
                    // SettingMenuTile(
                    //   icon: Iconsax.security_user,
                    //   title: 'Safe Mode',
                    //   subtitle: 'Search result is safe for all ages',
                    //   trailing: Switch(value: false, onChanged: (value) {}),
                    // ),
                    // SettingMenuTile(
                    //   icon: Iconsax.image,
                    //   title: 'HD Image Quality',
                    //   subtitle: 'Set image quality to be seen',
                    //   trailing: Switch(value: false, onChanged: (value) {}),
                    // ),

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
                              UserData.userData = null;
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
            if (UserData.userData == null)
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: Sizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.defaultSpace),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          style: Theme.of(context)
                              .outlinedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: const WidgetStatePropertyAll(
                                      OurColors.darkerGrey),
                                  foregroundColor: const WidgetStatePropertyAll(
                                      OurColors.light)),
                          onPressed: () =>
                              Get.offAll(() => const LoginScreen()),
                          child: const Text('Sign in to access your account')),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
