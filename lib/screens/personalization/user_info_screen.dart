import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:fashion_assistant/widgets/common/circular_image.dart';
import 'package:fashion_assistant/widgets/common/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';
import '../../data/authentication.repository/user_data.dart';
import '../../widgets/profile_page/profile_menu.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

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
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircularImage(
                      image: UserData.userData!.image,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile Picture'))
                  ],
                ),
              ),

              // Details
              const SizedBox(height: Sizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
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
                onPressed: () {},
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
                onPressed: () {},
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
              ProfileMenu(
                title: 'Birth Date',
                value: '07/05/2003',
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {},
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
