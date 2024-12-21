import 'package:flutter/material.dart';
import 'package:fashion_assistant/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomCustomerAdminNavBar extends StatefulWidget {
  const CustomCustomerAdminNavBar({
    super.key,
    required this.ontap,
    required this.activeScreen,
  });
  final void Function(int) ontap;
  final int activeScreen;

  @override
  State<CustomCustomerAdminNavBar> createState() =>
      _CustomCustomerAdminNavBarState();
}

class _CustomCustomerAdminNavBarState extends State<CustomCustomerAdminNavBar> {
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
          icon: Icon(
            Iconsax.profile_2user,
            color: widget.activeScreen == 1
                ? OurColors.primaryColor
                : OurColors.iconPrimary,
          ),
          label: 'Users',
        ),
        BottomNavigationBarItem(
          icon: widget.activeScreen == 2
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
