import 'package:flutter/material.dart';
import 'package:fashion_assistant/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomAdminNavBar extends StatefulWidget {
  const CustomAdminNavBar({
    super.key,
    required this.ontap,
    required this.activeScreen,
  });
  final void Function(int) ontap;
  final int activeScreen;

  @override
  State<CustomAdminNavBar> createState() => _CustomAdminNavBarState();
}

class _CustomAdminNavBarState extends State<CustomAdminNavBar> {
  double iconSize = Sizes.iconLg;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: widget.activeScreen, // Current selected index
      onTap: widget.ontap, // Handle tap on item
      type: BottomNavigationBarType.fixed, // Keeps all items visible
      backgroundColor: OurColors.backgroundColor, // Background color
      selectedItemColor: OurColors.primaryButtonBackgroundColor, // Active color
      unselectedItemColor: OurColors.iconPrimary, // Inactive color
      items: [
        BottomNavigationBarItem(
          icon: widget.activeScreen == 0
              ? const Icon(
                  Iconsax.home,
                  color: OurColors.primaryColor,
                )
              : const Icon(
                  Iconsax.home,
                  color: OurColors.iconPrimary,
                ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: widget.activeScreen == 1
              ? const Icon(
                  Iconsax.receipt_item,
                  color: OurColors.primaryColor,
                )
              : const Icon(
                  Iconsax.receipt_item,
                  color: OurColors.iconPrimary,
                ),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.profile_add,
            color: widget.activeScreen == 2
                ? OurColors.primaryColor
                : OurColors.iconPrimary,
          ),
          label: 'Brands',
        ),
        BottomNavigationBarItem(
          icon: widget.activeScreen == 3
              ? const Icon(
                  Iconsax.message_add,
                  color: OurColors.primaryColor,
                )
              : const Icon(
                  Iconsax.message_add,
                  color: OurColors.iconPrimary,
                ),
          label: 'Reviews',
        ),
        BottomNavigationBarItem(
          icon: widget.activeScreen == 4
              ? Image.asset('assets/icons/profilem.png',
                  width: iconSize.w, height: iconSize.h)
              : Image.asset('assets/icons/profile.png',
                  width: iconSize.w, height: iconSize.h),
          label: 'Profile',
        ),
      ],
    );
  }
}
