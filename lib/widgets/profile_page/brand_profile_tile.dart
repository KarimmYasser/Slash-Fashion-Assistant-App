import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';

class BrandUserProfileTile extends StatelessWidget {
  const BrandUserProfileTile({
    super.key,
    required this.imageURL,
    required this.name,
    required this.email,
    required this.editProfile,
  });

  final String? imageURL;
  final String name;
  final String email;
  final void Function()? editProfile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: imageURL != null ? NetworkImage(imageURL!) : null,
        child: imageURL == null ? const FlutterLogo(size: 50) : null,
      ),
      title: Text(name,
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
