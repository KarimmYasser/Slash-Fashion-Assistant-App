import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:fashion_assistant/widgets/common/circular_image.dart';
import 'package:fashion_assistant/widgets/common/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';
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
                    const CircularImage(
                      image: 'assets/images/category.png',
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
                value: 'Karim',
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Last Name',
                value: 'Yasser',
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'UserName',
                value: 'Karimmyasser',
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
                value: '123e4567-e89b-12d3-a456-426614174000',
                onPressed: () {},
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                title: 'E-mail',
                value: 'kemoyasso66@gmail.com',
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: '+201144432284',
                onPressed: () {},
                icon: Iconsax.arrow_right_34,
              ),
              ProfileMenu(
                title: 'Gender',
                value: 'Male',
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
