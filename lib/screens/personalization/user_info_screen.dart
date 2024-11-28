import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:fashion_assistant/widgets/common/circular_image.dart';
import 'package:fashion_assistant/widgets/common/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';

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
                  title: 'First Name', value: 'Karim', onPressed: () {}),
              ProfileMenu(
                  title: 'Last Name', value: 'Yasser', onPressed: () {}),
              ProfileMenu(
                  title: 'UserName', value: 'Karimmyasser', onPressed: () {}),

              const SizedBox(height: Sizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),

              const SectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                  title: 'User ID', value: '123e4567-e89b-12d3-a456-426614174000', onPressed: () {},icon: Iconsax.copy),
              ProfileMenu(
                  title: 'E-mail', value: 'kemoyasso66@gmail.com', onPressed: () {}),
              ProfileMenu(
                  title: 'Phone Number', value: '+201144432284', onPressed: () {}),
              ProfileMenu(
                  title: 'Gender', value: 'Male', onPressed: () {}),
              ProfileMenu(
                  title: 'Birth Date', value: '07/05/2003', onPressed: () {}),
              Center(
                child: TextButton(
                    onPressed: () {},
                    child: const Text('Close Account',
                        style: TextStyle(color: OurColors.errorTextColor))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Sizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis),
            ),
            Expanded(
              flex: 5,
              child: Text(value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis),
            ),
            Expanded(child: Icon(icon, size: 18))
          ],
        ),
      ),
    );
  }
}
