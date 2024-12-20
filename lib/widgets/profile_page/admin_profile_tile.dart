import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';

class AdminUserProfileTile extends StatelessWidget {
  const AdminUserProfileTile({
    super.key,
    required this.username,
    required this.email,
    required this.role,
    required this.editProfile,
  });

  final String username;
  final String email;
  final String role;
  final void Function()? editProfile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SizedBox(width: Sizes.spaceBtwItems),
      title: Text(username,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: OurColors.white)),
      subtitle: Text(email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: OurColors.white)),
      trailing: IconButton(
        onPressed: editProfile,
        icon: const Icon(
          Iconsax.edit,
          color: OurColors.white,
        ),
      ),
    );
  }
}
