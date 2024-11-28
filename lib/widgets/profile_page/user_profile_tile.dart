import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.isLoading,
    required this.avatarSvg,
    required this.name,
    required this.email,
    required this.editProfile,
  });

  final bool isLoading;
  final String? avatarSvg;
  final String name;
  final String email;
  final void Function()? editProfile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isLoading
          ? const SizedBox(
              width: 50,
              child: Center(
                child: CircularProgressIndicator(
                  color: OurColors.white,
                ),
              ),
            )
          : avatarSvg != null
              ? SvgPicture.string(
                  avatarSvg!,
                  width: 50,
                  height: 50,
                )
              : const FlutterLogo(size: 50),
      title: Text(name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
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
